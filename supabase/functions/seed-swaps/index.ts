/**
 * seed-swaps
 *
 * Proactive swap database filler. Runs every 6 hours.
 * Picks the 5 subcategories with the fewest active swaps (from the subcategories table),
 * asks GPT-4o-mini to suggest safe products, and adds ones that pass both
 * EWG score ≤ 3 AND our ingredient scorer ≥ 75.
 *
 * New subcategories are added by discover-subcategories (weekly), which feeds into
 * this function automatically — no code changes needed.
 *
 * On/Off: toggle in Supabase Dashboard → Database → Cron Jobs.
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import OpenAI from 'https://esm.sh/openai@4'

const PRODUCTS_PER_SUB = 5   // GPT suggestions per subcategory
const MIN_SCORE        = 75  // minimum score from our own analyzer
const MAX_EWG_SCORE    = 3   // maximum EWG score (1 = best, 10 = worst)
const SUBS_PER_RUN     = 5   // subcategories per run (stays within 150s timeout)

Deno.serve(async (_req) => {
  const supabaseUrl = Deno.env.get('SUPABASE_URL')!
  const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  const openaiKey  = Deno.env.get('OPENAI_API_KEY')!

  const supabase = createClient(supabaseUrl, supabaseKey)
  const openai   = new OpenAI({ apiKey: openaiKey })

  // Fetch all known subcategories
  const { data: allSubs, error: subErr } = await supabase
    .from('subcategories')
    .select('name, category')

  if (subErr || !allSubs) {
    return new Response(JSON.stringify({ error: subErr?.message || 'No subcategories' }), { status: 500 })
  }

  // Count active swaps per subcategory
  const { data: existing } = await supabase
    .from('swaps')
    .select('subcategory')
    .eq('is_active', true)
    .not('subcategory', 'is', null)

  const countMap: Record<string, number> = {}
  for (const row of existing || []) {
    if (row.subcategory) countMap[row.subcategory] = (countMap[row.subcategory] || 0) + 1
  }

  // Sort all subcategories by swap count ascending — always fill the least-covered ones first
  const sorted = allSubs
    .map(s => ({ ...s, swapCount: countMap[s.name] || 0 }))
    .sort((a, b) => a.swapCount - b.swapCount)
    .slice(0, SUBS_PER_RUN)

  const results: Record<string, any> = {}

  for (const { name: subcategory, category, swapCount } of sorted) {
    console.log(`Seeding: ${subcategory} (has ${swapCount} swaps)`)

    try {
      const suggestions = await suggestSafeProducts(openai, subcategory, category)
      const added: string[] = []

      for (const product of suggestions) {
        if (!ewgPasses(product.ewg_score)) {
          console.log(`  Skip ${product.name} — EWG ${product.ewg_score}`)
          continue
        }

        const score = await scoreIngredients(openai, product)
        if (score < MIN_SCORE) {
          console.log(`  Skip ${product.name} — score ${score}`)
          continue
        }

        // Skip duplicates
        const { data: dupe } = await supabase
          .from('swaps')
          .select('id')
          .ilike('name', product.name)
          .ilike('brand', product.brand)
          .limit(1)

        if (dupe && dupe.length > 0) {
          console.log(`  Skip ${product.name} — duplicate`)
          continue
        }

        const { error: insertErr } = await supabase.from('swaps').insert({
          name:             product.name,
          brand:            product.brand,
          category:         category,
          subcategory:      subcategory,
          score:            score,
          why_better:       product.why_better,
          available_stores: product.available_stores || [],
          affiliate_url:    null,
          is_active:        true,
          source:           'auto_seeded',
        })

        if (insertErr) {
          console.log(`  Error inserting ${product.name}:`, insertErr.message)
        } else {
          added.push(product.name)
          console.log(`  ✓ ${product.name} (score: ${score}, EWG: ${product.ewg_score})`)
        }
      }

      results[subcategory] = { added, swapsBefore: swapCount, attempted: suggestions.length }
    } catch (err) {
      console.error(`Error seeding ${subcategory}:`, err)
      results[subcategory] = { error: String(err) }
    }
  }

  const totalAdded = Object.values(results).reduce((n: number, r: any) => n + (r.added?.length || 0), 0)

  return new Response(JSON.stringify({ totalAdded, subcategoriesProcessed: sorted.length, results }), {
    headers: { 'Content-Type': 'application/json' }
  })
})

// ─── EWG grade helpers ────────────────────────────────────────────────────────
// EWG uses two grading systems:
//   Skin Deep / Food Scores: numeric 1–10 (1 = best)
//   Healthy Cleaning Guide:  letter A–F  (A = best)
// We accept: 1, 2, 3, A, B, or "verified". Anything else fails.

function normalizeEwg(raw: any): number | null {
  if (raw === 'verified' || raw === 'EWG Verified') return 1
  if (raw === 'A') return 1
  if (raw === 'B') return 2
  if (raw === 'C' || raw === 'D' || raw === 'F') return 99 // fail
  const n = Number(raw)
  return isNaN(n) ? null : n
}

function ewgPasses(raw: any): boolean {
  const n = normalizeEwg(raw)
  return n !== null && n <= MAX_EWG_SCORE
}

async function suggestSafeProducts(openai: OpenAI, subcategory: string, category: string): Promise<any[]> {
  const prompt = `You are a non-toxic product researcher. Suggest ${PRODUCTS_PER_SUB} specific real products for the subcategory "${subcategory}" (category: ${category}).

EWG uses TWO different rating systems depending on product type:
- Personal care & food: NUMERIC score 1–10 on EWG Skin Deep or EWG Food Scores (1 = safest)
- Cleaning products: LETTER grade A–F on EWG's Guide to Healthy Cleaning (A = safest)

Requirements — ONLY suggest products that meet ALL of these:
1. EWG rating of 1, 2, or 3 (numeric) OR grade A or B (letter) — OR are EWG Verified certified
2. You are highly confident this specific product exists on EWG with that rating (do NOT guess)
3. Clean, minimal ingredients — no known toxins, endocrine disruptors, or carcinogens
4. Actually available to buy (Amazon, Whole Foods, Target, etc.)
5. Specific branded products with exact product names as they appear on EWG

For the "ewg_score" field use: a number (1-3), a letter ("A" or "B"), or "verified".
If you are not certain of the EWG rating, do NOT include the product.
It is better to return fewer products than to include ones with uncertain ratings.

Respond with a JSON object: { "products": [ { "name": "...", "brand": "...", "ewg_score": 1-3 or "A"/"B" or "verified", "why_better": "...", "key_ingredients": "...", "available_stores": ["Amazon", "Whole Foods"] } ] }`

  const response = await openai.chat.completions.create({
    model: 'gpt-4o-mini',
    messages: [{ role: 'user', content: prompt }],
    response_format: { type: 'json_object' },
    temperature: 0.2,
  })

  try {
    const parsed = JSON.parse(response.choices[0].message.content || '{}')
    return (parsed.products || []).map((p: any) => ({
      ...p,
      ewg_score_raw: p.ewg_score,
      ewg_score: normalizeEwg(p.ewg_score),
    }))
  } catch {
    return []
  }
}

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
