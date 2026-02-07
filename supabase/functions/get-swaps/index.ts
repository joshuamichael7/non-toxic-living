import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

interface GetSwapsRequest {
  category?: string
  concerns?: string[]
  limit?: number
}

Deno.serve(async (req) => {
  // Handle CORS preflight
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL')!,
      Deno.env.get('SUPABASE_ANON_KEY')!
    )

    const { category, concerns, limit = 5 } = await req.json() as GetSwapsRequest

    let query = supabase
      .from('swaps')
      .select('*')
      .eq('is_active', true)
      .gte('score', 70)
      .order('score', { ascending: false })
      .limit(Math.min(limit, 20)) // Cap at 20 max

    if (category) {
      query = query.eq('category', category)
    }

    // If specific concerns, prioritize swaps that address them
    if (concerns && concerns.length > 0) {
      query = query.overlaps('replaces_ingredients', concerns)
    }

    const { data, error } = await query

    if (error) {
      console.error('Swaps query error:', error)
      return new Response(JSON.stringify({ error: error.message }), {
        status: 500,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    return new Response(JSON.stringify(data || []), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error) {
    console.error('Get swaps error:', error)
    return new Response(JSON.stringify({
      error: error instanceof Error ? error.message : 'Failed to fetch swaps'
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})
