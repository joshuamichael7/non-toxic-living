/**
 * discover-subcategories
 *
 * Runs weekly (Sunday 2am). Asks GPT-4o-mini to identify product types that
 * real users scan in a non-toxic living app that aren't covered yet.
 * Inserts new subcategories into the `subcategories` table.
 * seed-swaps automatically picks them up on its next run.
 */

import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import OpenAI from 'https://esm.sh/openai@4'

Deno.serve(async (_req) => {
  const supabaseUrl = Deno.env.get('SUPABASE_URL')!
  const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  const openaiKey  = Deno.env.get('OPENAI_API_KEY')!

  const supabase = createClient(supabaseUrl, supabaseKey)
  const openai   = new OpenAI({ apiKey: openaiKey })

  // Fetch existing subcategories so GPT knows what we already have
  const { data: existing, error } = await supabase
    .from('subcategories')
    .select('name, category')
    .order('name')

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 })
  }

  const existingNames = (existing || []).map(s => s.name)

  const prompt = `You are helping build a non-toxic living app that scans everyday products (food, personal care, cleaning, supplements, baby products, cookware, home goods, clothing, pet products, etc.) and recommends safer alternatives.

We already track these product subcategories:
${existingNames.join(', ')}

Your task: Identify 15 specific product subcategories that everyday consumers commonly buy and scan for safety but that are NOT in our list above.

Focus on:
- Specific product types (e.g. "lip liner" not "cosmetics")
- Products people actually scan at stores or research for safety
- Categories where toxic ingredients are a real concern
- Use snake_case naming consistent with the existing list

Respond with a JSON object:
{
  "subcategories": [
    { "name": "lip_liner", "category": "makeup", "reason": "common cosmetic with heavy metal pigment concerns" },
    ...
  ]
}

Valid category values: food, beverages, snacks, personal_care, makeup, cleaning, baby, supplements, kitchen, home, clothing, pet`

  const response = await openai.chat.completions.create({
    model: 'gpt-4o-mini',
    messages: [{ role: 'user', content: prompt }],
    response_format: { type: 'json_object' },
    temperature: 0.5,
  })

  let suggestions: Array<{ name: string; category: string; reason: string }> = []
  try {
    const parsed = JSON.parse(response.choices[0].message.content || '{}')
    suggestions = parsed.subcategories || []
  } catch {
    return new Response(JSON.stringify({ error: 'Failed to parse GPT response' }), { status: 500 })
  }

  // Filter out any that already exist
  const newOnes = suggestions.filter(s =>
    s.name &&
    s.category &&
    !existingNames.includes(s.name) &&
    /^[a-z][a-z0-9_]*$/.test(s.name) // validate snake_case
  )

  if (newOnes.length === 0) {
    return new Response(JSON.stringify({ message: 'No new subcategories found', suggestions }), { status: 200 })
  }

  const { data: inserted, error: insertErr } = await supabase
    .from('subcategories')
    .insert(newOnes.map(s => ({ name: s.name, category: s.category, source: 'discovered' })))
    .select('name, category')

  if (insertErr) {
    return new Response(JSON.stringify({ error: insertErr.message }), { status: 500 })
  }

  console.log(`Discovered ${inserted?.length || 0} new subcategories:`, inserted?.map(s => s.name).join(', '))

  return new Response(JSON.stringify({
    discovered: inserted?.length || 0,
    added: inserted,
    allSuggestions: suggestions,
  }), { headers: { 'Content-Type': 'application/json' } })
})
