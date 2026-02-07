import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"
import OpenAI from "https://esm.sh/openai@4"

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

// Pipeline step tracking
interface PipelineStep {
  name: string
  status: 'success' | 'skipped' | 'failed'
  durationMs: number
  detail?: string
}

// Google Cloud Vision OCR
async function extractTextWithGoogleVision(imageBase64: string): Promise<{ text: string; confidence: number }> {
  const apiKey = Deno.env.get('GOOGLE_CLOUD_API_KEY')
  if (!apiKey) {
    console.log('Google Cloud API key not configured, skipping cloud OCR')
    return { text: '', confidence: 0 }
  }

  try {
    const response = await fetch(
      `https://vision.googleapis.com/v1/images:annotate?key=${apiKey}`,
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          requests: [{
            image: { content: imageBase64 },
            features: [{ type: 'TEXT_DETECTION', maxResults: 1 }],
            imageContext: {
              languageHints: ['en', 'ko', 'ja', 'zh']
            }
          }]
        })
      }
    )

    if (!response.ok) {
      const errorText = await response.text()
      console.error('Google Vision API error:', response.status, errorText)
      return { text: '', confidence: 0 }
    }

    const data = await response.json()
    const textAnnotations = data.responses?.[0]?.textAnnotations

    if (!textAnnotations || textAnnotations.length === 0) {
      console.log('Google Vision: No text detected')
      return { text: '', confidence: 0 }
    }

    const fullText = textAnnotations[0].description || ''
    console.log('Google Vision extracted:', fullText.length, 'chars')

    return {
      text: fullText,
      confidence: 0.9
    }
  } catch (error) {
    console.error('Google Vision error:', error)
    return { text: '', confidence: 0 }
  }
}

// Current analysis version
const CURRENT_ANALYSIS_VERSION = 1

const CACHE_TTL_DAYS = {
  high: 90,
  medium: 30,
  low: 7,
}

interface AnalyzeRequest {
  text?: string
  imageBase64?: string
  ocrSource: 'device' | 'cloud' | 'ai-mini' | 'ai-vision'
  ocrConfidence?: number
  barcode?: string
  userId?: string
  forceRefresh?: boolean
  clientSteps?: PipelineStep[]
  language?: string
  store?: string
}

const LANGUAGE_NAMES: Record<string, string> = {
  en: 'English',
  es: 'Spanish',
  fr: 'French',
  zh: 'Chinese',
  ja: 'Japanese',
  ko: 'Korean',
  ar: 'Arabic',
  hi: 'Hindi',
}

interface CachedProduct {
  id: string
  name: string
  brand: string
  category: string
  score: number
  verdict: string
  summary: string
  dads_take: string
  analysis: any
  last_analyzed_at: string
  analysis_version: number
  cache_ttl_days: number
  embedding: number[] | null
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  const requestStart = Date.now()
  const pipelineSteps: PipelineStep[] = []

  try {
    console.log('=== Edge Function: Starting analysis ===')

    const openaiKey = Deno.env.get('OPENAI_API_KEY')
    if (!openaiKey) {
      throw new Error('OPENAI_API_KEY not configured')
    }

    const openai = new OpenAI({ apiKey: openaiKey })

    const supabaseUrl = Deno.env.get('SUPABASE_URL')!
    const supabaseKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
    const supabase = createClient(supabaseUrl, supabaseKey)

    // Fetch blocked products list
    const { data: blockedProducts } = await supabase
      .from('blocked_products')
      .select('name, brand, reason')
    const blocklist = (blockedProducts || [])
      .map(p => `- ${p.name}${p.brand ? ` (${p.brand})` : ''}: ${p.reason}`)
      .join('\n')

    const body = await req.json() as AnalyzeRequest
    const { text, imageBase64, ocrSource, ocrConfidence = 0.8, barcode, userId, forceRefresh, clientSteps, language = 'en', store } = body
    const responseLang = LANGUAGE_NAMES[language] || 'English'

    // Merge client-side pipeline steps
    if (clientSteps) {
      pipelineSteps.push(...clientSteps)
    }

    console.log('Request:', {
      hasText: !!text,
      textLength: text?.length || 0,
      hasImage: !!imageBase64,
      imageSize: imageBase64 ? `${(imageBase64.length / 1024).toFixed(0)}KB` : 'none',
      ocrSource,
      ocrConfidence,
      barcode,
      forceRefresh
    })

    // =========================================================================
    // STEP 1: Check for cached product
    // =========================================================================
    let cachedProduct: CachedProduct | null = null

    if (!forceRefresh && barcode) {
      const cacheStart = Date.now()
      const { data } = await supabase
        .from('products')
        .select('*')
        .eq('barcode', barcode)
        .single()

      if (data) {
        cachedProduct = data as CachedProduct
        const isFresh = checkCacheFreshness(cachedProduct)

        if (isFresh) {
          pipelineSteps.push({
            name: 'Cache Lookup',
            status: 'success',
            durationMs: Date.now() - cacheStart,
            detail: `Found cached: "${cachedProduct.name}" (score: ${cachedProduct.score})`,
          })

          console.log('Returning cached result:', cachedProduct.name)

          if (userId) {
            await trackScan(supabase, userId, cachedProduct, ocrSource, ocrConfidence, true)
          }

          return new Response(JSON.stringify({
            productName: cachedProduct.name,
            brand: cachedProduct.brand,
            category: cachedProduct.category,
            score: cachedProduct.score,
            verdict: cachedProduct.verdict,
            summary: cachedProduct.summary,
            dadsTake: cachedProduct.dads_take,
            concerns: cachedProduct.analysis?.concerns || [],
            positives: cachedProduct.analysis?.positives || [],
            swaps: await getSwapRecommendations(supabase, cachedProduct, store),
            ocrSource,
            model: 'cached',
            cached: true,
            cachedAt: cachedProduct.last_analyzed_at,
            pipelineTrace: {
              steps: pipelineSteps,
              extractedText: '',
              totalDurationMs: Date.now() - requestStart,
              ocrSource,
              analysisModel: 'cached',
            },
          }), {
            headers: { ...corsHeaders, 'Content-Type': 'application/json' }
          })
        } else {
          pipelineSteps.push({
            name: 'Cache Lookup',
            status: 'failed',
            durationMs: Date.now() - cacheStart,
            detail: 'Cache stale, re-analyzing',
          })
          cachedProduct = null
        }
      } else {
        pipelineSteps.push({
          name: 'Cache Lookup',
          status: 'failed',
          durationMs: Date.now() - cacheStart,
          detail: 'No cached product found for barcode',
        })
      }
    }

    // =========================================================================
    // STEP 2: Ensure we have ingredient text
    // This is strictly OCR/extraction — NO analysis here
    // =========================================================================
    let ingredientText = text || ''
    let actualOcrSource = ocrSource
    let extractionModel: string | null = null

    // Log what the client sent
    if (ingredientText) {
      pipelineSteps.push({
        name: 'Client OCR Text',
        status: 'success',
        durationMs: 0,
        detail: `Received ${ingredientText.length} chars from device OCR`,
      })
      console.log('Using client-provided text:', ingredientText.substring(0, 200))
    }

    // If device OCR failed or returned no text, try Google Cloud Vision
    if (!ingredientText && imageBase64) {
      console.log('No text from device — trying Google Cloud Vision...')
      const gcvStart = Date.now()
      const visionResult = await extractTextWithGoogleVision(imageBase64)
      const gcvDuration = Date.now() - gcvStart

      if (visionResult.text) {
        ingredientText = visionResult.text
        actualOcrSource = 'cloud'
        pipelineSteps.push({
          name: 'Google Cloud Vision',
          status: 'success',
          durationMs: gcvDuration,
          detail: `Detected ${visionResult.text.length} chars`,
        })
        console.log('Cloud Vision found text:', ingredientText.substring(0, 200))
      } else {
        pipelineSteps.push({
          name: 'Google Cloud Vision',
          status: 'failed',
          durationMs: gcvDuration,
          detail: Deno.env.get('GOOGLE_CLOUD_API_KEY')
            ? 'No text detected in image'
            : 'API key not configured',
        })
        console.log('Cloud Vision: no text found')
      }
    } else if (!imageBase64 && !ingredientText) {
      pipelineSteps.push({
        name: 'Google Cloud Vision',
        status: 'skipped',
        durationMs: 0,
        detail: 'No image provided for cloud OCR',
      })
    }

    // Last resort: GPT-4o vision EXTRACTION ONLY (not analysis)
    let extractedInfo: { productName?: string; brand?: string; ingredients?: string[]; category?: string; language?: string } = {}

    if (!ingredientText && imageBase64) {
      console.log('No text from Cloud Vision — falling back to GPT-4o extraction...')
      const extractStart = Date.now()
      extractionModel = 'gpt-4o'

      try {
        const visionResponse = await openai.chat.completions.create({
          model: 'gpt-4o',
          messages: [
            {
              role: 'system',
              content: `You are an ingredient extraction expert. Your PRIMARY job is to extract the INGREDIENT LIST from product labels.

CRITICAL RULES:
1. FOCUS ON INGREDIENTS - The ingredient list is the most important thing. Look for text starting with "Ingredients:", "성분:", "成分", or similar.
2. DO NOT GUESS the product name if you cannot clearly read it. Use "Unknown Product" instead of guessing.
3. If the label is in Korean, Chinese, Japanese, or another non-Latin script:
   - Try to transliterate or translate the product name if you CAN read it
   - For ingredients, provide the English name if you recognize the chemical/ingredient
   - If you can't identify an ingredient, include it as-is
4. NEVER assume what product it is based on partial information.

Category classification:
- "personal_care" = soap, shampoo, lotion, cosmetics, skincare, body wash
- "cleaning" = household cleaners, dish soap, laundry detergent (NOT body soap)
- "food" = edible products
- "baby" = baby-specific products
- "household" = general home items
- "cookware" = kitchen items

Return JSON:
{
  "productName": "exact name from label, or 'Unknown Product' if unreadable",
  "brand": "brand if visible, or 'Unknown'",
  "category": "food|personal_care|household|baby|cookware|cleaning",
  "language": "detected language",
  "ingredients": ["ingredient1", "ingredient2", ...],
  "readabilityNote": "any issues reading the label"
}

PRIORITY: Extract as many ingredients as possible, even if you can't identify the product name.`
            },
            {
              role: 'user',
              content: [
                {
                  type: 'image_url',
                  image_url: { url: `data:image/jpeg;base64,${imageBase64}`, detail: 'high' }
                },
                { type: 'text', text: 'Extract the ingredient list from this product label. Focus on finding and reading ALL ingredients. If you cannot read the product name clearly, say "Unknown Product" - do not guess.' }
              ]
            }
          ],
          response_format: { type: 'json_object' },
          max_tokens: 2000
        })

        extractedInfo = JSON.parse(visionResponse.choices[0].message.content!)
        ingredientText = (extractedInfo.ingredients || []).join(', ')
        actualOcrSource = 'ai-vision'
        const extractDuration = Date.now() - extractStart

        pipelineSteps.push({
          name: 'GPT-4o Vision Extraction',
          status: ingredientText ? 'success' : 'failed',
          durationMs: extractDuration,
          detail: ingredientText
            ? `Extracted ${extractedInfo.ingredients?.length || 0} ingredients (${extractedInfo.language || 'unknown'} label)`
            : 'Could not extract ingredients',
        })
        console.log('GPT-4o extracted:', extractedInfo.productName, '-', ingredientText.substring(0, 100))
      } catch (visionErr) {
        const extractDuration = Date.now() - extractStart
        pipelineSteps.push({
          name: 'GPT-4o Vision Extraction',
          status: 'failed',
          durationMs: extractDuration,
          detail: `Error: ${visionErr instanceof Error ? visionErr.message : 'Unknown'}`,
        })
        console.error('Vision API error:', visionErr)
      }
    } else if (ingredientText) {
      pipelineSteps.push({
        name: 'GPT-4o Vision Extraction',
        status: 'skipped',
        durationMs: 0,
        detail: 'Text already available from earlier OCR step',
      })
    }

    if (!ingredientText) {
      return new Response(JSON.stringify({
        error: 'No ingredients found to analyze',
        suggestion: 'Try scanning the ingredient label more clearly',
        pipelineTrace: {
          steps: pipelineSteps,
          extractedText: '',
          totalDurationMs: Date.now() - requestStart,
          ocrSource: actualOcrSource,
          analysisModel: 'none',
          extractionModel,
        },
      }), {
        status: 400,
        headers: { ...corsHeaders, 'Content-Type': 'application/json' }
      })
    }

    // =========================================================================
    // STEP 3: Analyze ingredients with GPT-4o-mini (ALWAYS)
    // This is ALWAYS gpt-4o-mini regardless of how we got the text
    // =========================================================================
    const analysisModel = 'gpt-4o-mini'
    console.log(`Analyzing ingredients with ${analysisModel}...`)
    const analysisStart = Date.now()

    // Build context from extracted info
    const productContext = []
    if (extractedInfo.productName) {
      productContext.push(`Product: "${extractedInfo.productName}"`)
    }
    if (extractedInfo.brand) {
      productContext.push(`Brand: ${extractedInfo.brand}`)
    }
    if (extractedInfo.category) {
      productContext.push(`Category: ${extractedInfo.category}`)
    }
    if (extractedInfo.language && extractedInfo.language !== 'English') {
      productContext.push(`Label Language: ${extractedInfo.language}`)
    }
    if (store) {
      productContext.push(`User is shopping at: ${store}`)
    }

    const analysisResponse = await openai.chat.completions.create({
      model: analysisModel,
      temperature: 0,
      messages: [
        {
          role: 'system',
          content: `You are an ingredient safety analyst aligned with the Non-Toxic Dad methodology — an approach developed by an environmental scientist who specializes in identifying heavy metals, endocrine disruptors, and hidden industrial chemicals in everyday products.

ANALYSIS PRINCIPLES:
1. FOCUS ON INGREDIENTS, not product name. If product name is unknown, infer product TYPE from ingredients (soap, shampoo, lotion, food, etc.)
2. GREENWASHING SKEPTICISM: "Organic" does not mean non-toxic. "Natural" is unregulated. "X-free" claims (paraben-free, sulfate-free) are often marketing — the replacements may be equally or more concerning.
3. HEAVY METALS AWARENESS: Always flag potential heavy metal contamination in foods (baby food, rice products, chocolate, spices), cosmetics (color cosmetics, foundations), and cookware. This is a priority concern.
4. ENDOCRINE DISRUPTORS: Flag phthalates, BPA/BPS, parabens, synthetic fragrances, and other hormone-disrupting chemicals. Note that "fragrance" or "parfum" on a label can hide dozens of undisclosed chemicals.
5. FAMILY SAFETY: Children, infants, and pregnant women are more vulnerable. Weight-adjust your concern level — what may be acceptable for occasional adult use can be risky with daily exposure on small bodies.
6. EVIDENCE-BASED: Reference specific concerns backed by research (IARC classifications, EWG data, FDA warnings, EU bans). Do not fearmonger about ingredients with only weak evidence.
7. PRACTICAL, NOT ALARMIST: The goal is informed choices, not panic. For products scoring 34-66, be specific about WHEN it matters (daily use vs occasional, skin contact vs ingestion, adults vs children).
8. PREFER NATURAL WHEN POSSIBLE: But acknowledge that some synthetic ingredients are well-studied and safe. The issue is unnecessary synthetic chemicals when safer options exist.
9. For personal care: evaluate for SKIN CONTACT and absorption, not ingestion.

SCORING:
- 0-33 (TOXIC): Known carcinogens, banned substances, high heavy metal risk, multiple endocrine disruptors, or ingredients with strong evidence of harm
- 34-66 (CAUTION): Moderate concerns, greenwashing marketing, occasional-use-only chemicals, or ingredients where evidence is mixed but caution is warranted
- 67-100 (SAFE): Clean ingredient list, well-studied safe ingredients, transparent labeling, minimal unnecessary additives

LANGUAGE: ALWAYS respond in ${responseLang}. All field values must be in ${responseLang}:
- productName: translate to ${responseLang} if the original is in another language
- ingredient names in concerns: use standard English/INCI names for the "ingredient" field, but write the "description" in ${responseLang}
- summary, dadsTake, positives: write in ${responseLang}

THE "dadsTake" FIELD: Write this as a dad talking to another parent — direct, practical, opinionated but not preachy. Examples of the right tone:
- "I wouldn't use this on my kids. The synthetic fragrance alone could contain dozens of undisclosed chemicals, and there are better options at the same price."
- "This is actually solid. Straightforward ingredients, nothing hidden. I'd feel good about my family using this daily."
- "It's marketed as 'natural' but those PEGs and synthetic colors tell a different story. Fine for occasional use, but I'd swap it out for something cleaner for everyday."

${blocklist ? `BLOCKED PRODUCTS — NEVER recommend these as alternatives, they have been flagged as unsafe or misleading:
${blocklist}

` : ''}Return JSON:
{
  "productName": "product name in ${responseLang} (translate if needed)",
  "brand": "from input or 'Unknown'",
  "category": "food|personal_care|household|baby|cookware|cleaning",
  "score": 0-100 (higher = safer),
  "verdict": "safe|caution|toxic",
  "summary": "Brief analysis highlighting key concerns or positives",
  "dadsTake": "Dad-to-parent practical take — direct, specific, actionable",
  "concerns": [{"ingredient": "English/INCI name", "severity": "low|medium|high", "description": "why this matters", "category": "type"}],
  "positives": ["positive aspects of this product"]
}`
        },
        {
          role: 'user',
          content: `${productContext.length > 0 ? productContext.join('\n') + '\n\n' : ''}Analyze these ingredients:

${ingredientText}`
        }
      ],
      response_format: { type: 'json_object' },
      max_tokens: 1500
    })

    const analysis = JSON.parse(analysisResponse.choices[0].message.content!)
    const analysisDuration = Date.now() - analysisStart

    pipelineSteps.push({
      name: `Analysis (${analysisModel})`,
      status: 'success',
      durationMs: analysisDuration,
      detail: `Score: ${analysis.score}, Verdict: ${analysis.verdict}, Concerns: ${analysis.concerns?.length || 0}`,
    })

    console.log('Analysis complete:', { score: analysis.score, verdict: analysis.verdict, model: analysisModel })

    // =========================================================================
    // STEP 4: Generate embedding for semantic search
    // =========================================================================
    let embedding: number[] | null = null

    try {
      const embeddingResponse = await openai.embeddings.create({
        model: 'text-embedding-3-small',
        input: `${analysis.productName} ${analysis.brand} ${analysis.category} ${ingredientText}`.substring(0, 8000)
      })
      embedding = embeddingResponse.data[0].embedding
    } catch (embErr) {
      console.warn('Failed to generate embedding:', embErr)
    }

    // =========================================================================
    // STEP 5: Cache the product
    // =========================================================================
    const cacheTtl = ocrConfidence > 0.8 ? CACHE_TTL_DAYS.high :
                     ocrConfidence > 0.5 ? CACHE_TTL_DAYS.medium :
                     CACHE_TTL_DAYS.low

    const productData = {
      name: analysis.productName,
      brand: analysis.brand,
      category: analysis.category,
      barcode: barcode || null,
      score: analysis.score,
      verdict: analysis.verdict,
      summary: analysis.summary,
      dads_take: analysis.dadsTake,
      analysis: {
        concerns: analysis.concerns,
        positives: analysis.positives,
      },
      ingredients_raw: ingredientText,
      ingredient_hash: hashString(ingredientText),
      analysis_version: CURRENT_ANALYSIS_VERSION,
      last_analyzed_at: new Date().toISOString(),
      confidence_score: ocrConfidence,
      cache_ttl_days: cacheTtl,
      embedding: embedding,
      scan_count: 1,
    }

    const { data: savedProduct, error: saveError } = await supabase
      .from('products')
      .upsert(productData, {
        onConflict: barcode ? 'barcode' : undefined,
        ignoreDuplicates: false
      })
      .select('id')
      .single()

    if (saveError) {
      console.warn('Failed to cache product:', saveError)
    } else {
      console.log('Product cached:', savedProduct?.id)
    }

    // =========================================================================
    // STEP 6: Track the scan
    // =========================================================================
    if (userId) {
      await trackScan(supabase, userId, {
        id: savedProduct?.id,
        ...analysis,
        analysis: { concerns: analysis.concerns, positives: analysis.positives }
      }, actualOcrSource, ocrConfidence, false)
    }

    // =========================================================================
    // STEP 7: Get swap recommendations
    // =========================================================================
    const swaps = analysis.score < 67
      ? await getSwapRecommendations(supabase, { category: analysis.category, score: analysis.score, embedding }, store)
      : []

    const totalDuration = Date.now() - requestStart
    console.log(`=== Edge Function Complete (${totalDuration}ms) ===`)

    return new Response(JSON.stringify({
      ...analysis,
      swaps,
      ocrSource: actualOcrSource,
      model: analysisModel,
      cached: false,
      pipelineTrace: {
        steps: pipelineSteps,
        extractedText: ingredientText.substring(0, 500),
        totalDurationMs: totalDuration,
        ocrSource: actualOcrSource,
        analysisModel,
        extractionModel,
      },
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })

  } catch (error) {
    console.error('=== Analysis error ===', error)

    return new Response(JSON.stringify({
      error: error instanceof Error ? error.message : 'Analysis failed',
      errorType: error?.constructor?.name,
      pipelineTrace: {
        steps: pipelineSteps,
        extractedText: '',
        totalDurationMs: Date.now() - requestStart,
        ocrSource: 'unknown',
        analysisModel: 'none',
      },
    }), {
      status: 500,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' }
    })
  }
})

// Helper: Check if cached product is still fresh
function checkCacheFreshness(product: CachedProduct): boolean {
  if (product.analysis_version < CURRENT_ANALYSIS_VERSION) {
    return false
  }
  const analyzedAt = new Date(product.last_analyzed_at)
  const expiresAt = new Date(analyzedAt.getTime() + product.cache_ttl_days * 24 * 60 * 60 * 1000)
  return expiresAt > new Date()
}

// Helper: Get swap recommendations
async function getSwapRecommendations(
  supabase: any,
  product: { category?: string; score?: number; embedding?: number[] | null },
  store?: string
): Promise<any[]> {
  try {
    if (product.embedding) {
      const { data, error } = await supabase.rpc('get_swap_recommendations', {
        product_category: product.category,
        product_embedding: product.embedding,
        min_score: 70,
        match_count: 5,
        filter_store: store || null,
      })
      if (!error && data?.length > 0) return data

      // If store filter returned no results, try without store filter
      if (!error && store && (!data || data.length === 0)) {
        const { data: unfilteredData } = await supabase.rpc('get_swap_recommendations', {
          product_category: product.category,
          product_embedding: product.embedding,
          min_score: 70,
          match_count: 5,
          filter_store: null,
        })
        if (unfilteredData?.length > 0) return unfilteredData
      }
    }

    let query = supabase
      .from('swaps')
      .select('id, name, brand, score, price_cents, affiliate_url, why_better, available_stores')
      .eq('category', product.category)
      .eq('is_active', true)
      .gte('score', 70)
      .order('score', { ascending: false })
      .limit(5)

    if (store) {
      query = query.contains('available_stores', [store])
    }

    const { data } = await query

    // If store filter returned no results, fall back to unfiltered
    if (store && (!data || data.length === 0)) {
      const { data: unfilteredData } = await supabase
        .from('swaps')
        .select('id, name, brand, score, price_cents, affiliate_url, why_better, available_stores')
        .eq('category', product.category)
        .eq('is_active', true)
        .gte('score', 70)
        .order('score', { ascending: false })
        .limit(5)
      return unfilteredData || []
    }

    return data || []
  } catch (err) {
    console.warn('Failed to get swaps:', err)
    return []
  }
}

// Helper: Track scan in database
async function trackScan(
  supabase: any,
  userId: string,
  product: any,
  ocrSource: string,
  ocrConfidence: number,
  wasCached: boolean
) {
  try {
    await supabase.from('scans').insert({
      user_id: userId,
      product_id: product.id || null,
      product_name: product.productName || product.name,
      brand: product.brand,
      score: product.score,
      verdict: product.verdict,
      analysis: product.analysis || {},
      ocr_source: ocrSource,
      ocr_confidence: ocrConfidence,
      was_cached: wasCached,
      ai_model_used: wasCached ? 'cached' : 'gpt-4o-mini',
    })
    console.log('Scan tracked for user:', userId)
  } catch (err) {
    console.warn('Failed to track scan:', err)
  }
}

// Helper: Simple string hash
function hashString(str: string): string {
  let hash = 0
  for (let i = 0; i < str.length; i++) {
    const char = str.charCodeAt(i)
    hash = ((hash << 5) - hash) + char
    hash = hash & hash
  }
  return hash.toString(16)
}
