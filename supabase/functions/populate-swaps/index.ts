/**
 * populate-swaps
 *
 * Runs on a cron schedule. For every subcategory that has 3+ swap misses
 * and hasn't been auto-populated yet:
 *   1. Ask GPT-4o to suggest 5 specific safe products (with EWG score ≤ 3)
 *   2. Score each product's ingredients through our own analyzer
 *   3. Add products that pass both checks (EWG ≤ 3 AND our score ≥ 75) to the swaps table
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import OpenAI from 'https://esm.sh/openai@4'

const MIN_MISS_COUNT = 3   // only auto-populate after this many misses
const MIN_SCORE = 75       // minimum score from our own analyzer
const MAX_EWG_SCORE = 3    // maximum EWG score (1 = best, 10 = worst)
const PRODUCTS_PER_SUB = 5 // how many products to suggest per subcategory

Deno.serve(async (req) => {
  // Allow manual trigger via POST, or cron trigger
  const supabaseUrl = Deno.env.get('SUPABASE_URL')!
  const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  const openaiKey  = Deno.env.get('OPENAI_API_KEY')!

  const supabase = createClient(supabaseUrl, supabaseKey)
  const openai   = new OpenAI({ apiKey: openaiKey })

  // Fetch subcategories that need populating
  const { data: misses, error } = await supabase
    .from('swap_misses')
    .select('subcategory, category, example_product')
    .gte('miss_count', MIN_MISS_COUNT)
    .is('auto_populated_at', null)
    .order('miss_count', { ascending: false })
    .limit(10) // process max 10 per run to stay within function timeout

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 })
  }

  if (!misses || misses.length === 0) {
    return new Response(JSON.stringify({ message: 'No subcategories to populate' }), { status: 200 })
  }

  const results: Record<string, any> = {}

  for (const miss of misses) {
    const { subcategory, category, example_product } = miss
    console.log(`Populating: ${subcategory} (example: ${example_product})`)

    try {
      // Step 1: Ask GPT to suggest safe products
      const suggestions = await suggestSafeProducts(openai, subcategory, category, example_product)

      // Step 2: Score each suggestion with our own analyzer
      const added: string[] = []
      for (const product of suggestions) {
        if (!product.ewg_score || product.ewg_score > MAX_EWG_SCORE) {
          console.log(`  Skipping ${product.name} — EWG score ${product.ewg_score} > ${MAX_EWG_SCORE}`)
          continue
        }

        const score = await scoreIngredients(openai, product)
        if (score < MIN_SCORE) {
          console.log(`  Skipping ${product.name} — our score ${score} < ${MIN_SCORE}`)
          continue
        }

        // Skip duplicates (same name+brand already in db)
        const { data: dupe } = await supabase
          .from('swaps')
          .select('id')
          .ilike('name', product.name)
          .ilike('brand', product.brand)
          .limit(1)
        if (dupe && dupe.length > 0) {
          console.log(`  Skipping ${product.name} — duplicate`)
          continue
        }

        // Step 3: Insert into swaps table
        const { error: insertErr } = await supabase.from('swaps').insert({
          name:              product.name,
          brand:             product.brand,
          category:          category || subcategory,
          subcategory:       subcategory,
          score:             score,
          why_better:        product.why_better,
          available_stores:  product.available_stores || [],
          affiliate_url:     null,
          is_active:         true,
          source:            'auto_populated',
        })

        if (insertErr) {
          console.log(`  Error inserting ${product.name}:`, insertErr.message)
        } else {
          added.push(product.name)
          console.log(`  ✓ Added ${product.name} (score: ${score}, EWG: ${product.ewg_score})`)
        }
      }

      // Mark this subcategory as populated (even if 0 passed — prevents re-trying every run)
      await supabase
        .from('swap_misses')
        .update({ auto_populated_at: new Date().toISOString() })
        .eq('subcategory', subcategory)

      results[subcategory] = { added, attempted: suggestions.length }

    } catch (err) {
      console.error(`Error populating ${subcategory}:`, err)
      results[subcategory] = { error: String(err) }
    }
  }

  return new Response(JSON.stringify({ populated: results }), {
    headers: { 'Content-Type': 'application/json' }
  })
})

// ─── GPT: suggest safe products ──────────────────────────────────────────────

async function suggestSafeProducts(
  openai: OpenAI,
  subcategory: string,
  category: string | null,
  exampleProduct: string | null
): Promise<any[]> {
  const context = exampleProduct
    ? `The user was looking for a safer alternative to "${exampleProduct}".`
    : ''

  const prompt = `You are a non-toxic product researcher. Suggest ${PRODUCTS_PER_SUB} specific real products for the subcategory "${subcategory}"${category ? ` (category: ${category})` : ''}.

${context}

Requirements — ONLY suggest products that meet ALL of these:
1. EWG score of 1, 2, or 3 on EWG Skin Deep (personal care) or EWG Food Scores (food) — OR are EWG Verified certified
2. Clean, minimal ingredients with no known toxins, endocrine disruptors, or carcinogens
3. Actually available to buy (Amazon, Whole Foods, Target, etc.)
4. Specific branded products (not generic descriptions)

Respond with a JSON object: { "products": [ { "name": "...", "brand": "...", "ewg_score": 1-3 or "verified", "why_better": "...", "key_ingredients": "...", "available_stores": ["Amazon", "Whole Foods"] } ] }

Be conservative — if you are not confident a product meets EWG score ≤ 3, do not include it.`

  const response = await openai.chat.completions.create({
    model: 'gpt-4o-mini',
    messages: [{ role: 'user', content: prompt }],
    response_format: { type: 'json_object' },
    temperature: 0.3,
  })

  try {
    const parsed = JSON.parse(response.choices[0].message.content || '{}')
    const products = parsed.products || []
    // Normalize ewg_score to a number (handle "verified" → 1)
    return products.map((p: any) => ({
      ...p,
      ewg_score: p.ewg_score === 'verified' ? 1 : Number(p.ewg_score),
    }))
  } catch {
    return []
  }
}

// ─── Score ingredients with our own analyzer ─────────────────────────────────

async function scoreIngredients(openai: OpenAI, product: any): Promise<number> {
  const prompt = `You are a toxicologist. Rate the safety of this product's ingredients on a scale of 0-100 (100 = completely safe, 0 = very toxic).

Product: ${product.name} by ${product.brand}
Key ingredients: ${product.key_ingredients}

Consider: carcinogens, endocrine disruptors, allergens, synthetic fragrances, parabens, phthalates, heavy metals, PFAS.

Respond with ONLY a JSON object: { "score": <number 0-100>, "reason": "<brief reason>" }`

  const response = await openai.chat.completions.create({
    model: 'gpt-4o-mini',
    messages: [{ role: 'user', content: prompt }],
    response_format: { type: 'json_object' },
    temperature: 0,
  })

  try {
    const parsed = JSON.parse(response.choices[0].message.content || '{}')
    return Math.round(Number(parsed.score) || 0)
  } catch {
    return 0
  }
}
