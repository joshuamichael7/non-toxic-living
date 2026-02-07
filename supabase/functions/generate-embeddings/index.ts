import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import OpenAI from "https://esm.sh/openai@4"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

type SupportedTable = 'ingredients' | 'products' | 'swaps'

function buildEmbeddingText(table: SupportedTable, row: any): string {
  switch (table) {
    case 'ingredients':
      return [
        `${row.name}`,
        row.aliases?.length ? `(${row.aliases.join(', ')})` : '',
        `: ${row.category}.`,
        row.concerns?.length ? `Concerns: ${row.concerns.join(', ')}.` : '',
        row.commonly_found_in?.length ? `Found in: ${row.commonly_found_in.join(', ')}.` : '',
        row.safe_alternatives?.length ? `Alternatives: ${row.safe_alternatives.join(', ')}.` : '',
      ].filter(Boolean).join(' ')

    case 'products':
      return [
        row.name,
        row.brand ? `by ${row.brand}` : '',
        `(${row.category}).`,
        row.ingredients_raw ? row.ingredients_raw.substring(0, 500) : '',
      ].filter(Boolean).join(' ')

    case 'swaps':
      return [
        `${row.name} by ${row.brand}`,
        `(${row.category}).`,
        row.why_better || '',
        row.replaces_ingredients?.length ? `Replaces: ${row.replaces_ingredients.join(', ')}.` : '',
        row.badges?.length ? `Badges: ${row.badges.join(', ')}.` : '',
      ].filter(Boolean).join(' ')

    default:
      return row.name || ''
  }
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const openaiKey = Deno.env.get('OPENAI_API_KEY')
    if (!openaiKey) {
      throw new Error('OPENAI_API_KEY not configured')
    }

    const openai = new OpenAI({ apiKey: openaiKey })
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!

    console.log('Supabase URL:', supabaseUrl)
    console.log('Service key present:', !!supabaseKey, 'length:', supabaseKey?.length)

    if (!supabaseKey) {
      throw new Error('SUPABASE_SERVICE_ROLE_KEY not configured')
    }

    const supabase = createClient(supabaseUrl, supabaseKey, {
      auth: { persistSession: false },
    })

    const body = await req.json()
    const table: SupportedTable = body.table || 'ingredients'
    const batchSize: number = Math.min(body.batchSize || 100, 2000)

    if (!['ingredients', 'products', 'swaps'].includes(table)) {
      throw new Error(`Unsupported table: ${table}. Must be ingredients, products, or swaps.`)
    }

    console.log(`=== Generating embeddings for ${table} (batch size: ${batchSize}) ===`)

    // Get rows without embeddings
    const { data: rows, error: queryError } = await supabase
      .from(table)
      .select('*')
      .is('embedding', null)
      .limit(batchSize)

    if (queryError) {
      throw new Error(`Query error: ${queryError.message}`)
    }

    if (!rows || rows.length === 0) {
      return new Response(JSON.stringify({
        message: `No rows in ${table} need embeddings`,
        processed: 0,
        skipped: 0,
      }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    console.log(`Found ${rows.length} rows without embeddings`)

    // Build embedding inputs
    const inputs = rows.map(row => buildEmbeddingText(table, row))

    console.log('Sample embedding text:', inputs[0]?.substring(0, 200))

    // Single batch call to OpenAI
    const embeddingResponse = await openai.embeddings.create({
      model: 'text-embedding-3-small',
      input: inputs,
    })

    console.log(`Generated ${embeddingResponse.data.length} embeddings`)

    // Update each row with its embedding
    let updated = 0
    let errors = 0
    const errorDetails: string[] = []

    for (let i = 0; i < rows.length; i++) {
      const { error: updateError } = await supabase
        .from(table)
        .update({ embedding: embeddingResponse.data[i].embedding })
        .eq('id', rows[i].id)

      if (updateError) {
        errors++
        errorDetails.push(`${rows[i].name || rows[i].id}: ${updateError.message}`)
        console.warn(`Failed to update ${rows[i].name}:`, updateError.message)
      } else {
        updated++
      }
    }

    console.log(`=== Done: ${updated} updated, ${errors} errors ===`)

    return new Response(JSON.stringify({
      table,
      processed: updated,
      errors,
      errorDetails: errorDetails.length > 0 ? errorDetails : undefined,
      totalTokens: embeddingResponse.usage?.total_tokens,
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  } catch (error) {
    console.error('Generate embeddings error:', error)
    return new Response(JSON.stringify({
      error: error instanceof Error ? error.message : 'Unknown error',
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})
