/**
 * EWG Score Verification via Serper (Google Search API)
 *
 * Searches Google for the product on ewg.org and parses the actual score/grade
 * from search result snippets and titles.
 *
 * EWG uses two grading systems:
 *   Skin Deep / Food Scores: numeric 1–10 (1 = safest)
 *   Healthy Cleaning Guide:  letter A–F  (A = safest)
 */

const SERPER_URL = 'https://google.serper.dev/search'

export interface EwgVerifyResult {
  passed: boolean
  ewgScore: string | number | null  // actual score found (e.g. 1, 2, "A", "verified")
  ewgUrl: string | null             // link to EWG product page if found
  reason: string                    // human-readable reason for logging
}

const CLEANING_CATEGORIES = new Set(['cleaning', 'laundry', 'home', 'kitchen'])

/**
 * Returns true if the normalized EWG score is within the acceptable range:
 *   Numeric: 1, 2, or 3
 *   Letter:  A or B
 *   Special: "verified" (EWG Verified)
 */
function scoreIsAcceptable(score: string | number | null): boolean {
  if (score === null) return false
  if (score === 'verified') return true
  if (score === 'A' || score === 'B') return true
  if (typeof score === 'number') return score >= 1 && score <= 3
  return false
}

/**
 * Try to extract an EWG score or grade from a block of text (title + snippet).
 * Returns the parsed score or null if nothing recognizable was found.
 */
function parseScoreFromText(text: string, isCleaningProduct: boolean): string | number | null {
  const t = text.toLowerCase()

  // EWG Verified (highest trust)
  if (t.includes('ewg verified') || t.includes('ewg-verified')) return 'verified'

  if (isCleaningProduct) {
    // Letter grade patterns: "Grade: A", "grade A", "A grade", standalone "A" near relevant words
    const letterMatch = t.match(/\bgrade[:\s]+([a-f])\b|\b([a-f])\s+grade\b|rated\s+([a-f])\b/)
    if (letterMatch) {
      return (letterMatch[1] || letterMatch[2] || letterMatch[3]).toUpperCase()
    }
    // In EWG Cleaning Guide titles, grade sometimes appears as just " | A |" or "(A)"
    const bracketMatch = text.match(/[|((\s]([A-F])[)|\s]/)
    if (bracketMatch) return bracketMatch[1]
  } else {
    // Numeric score patterns: "Score: 2", "EWG score 1", "rated 3 out of 10", "hazard score 2"
    const numMatch = t.match(
      /\bscore[:\s]+([1-9]|10)\b|ewg\s+score[:\s]+([1-9]|10)\b|hazard[:\s]+([1-9]|10)\b|rated\s+([1-9]|10)\b|([1-9]|10)\s+out\s+of\s+10\b/
    )
    if (numMatch) {
      const val = numMatch[1] || numMatch[2] || numMatch[3] || numMatch[4] || numMatch[5]
      return Number(val)
    }
    // Fallback: lone digit 1-3 near "low hazard" or "safe"
    if (t.includes('low hazard') || t.includes('low concern')) {
      const digit = t.match(/\b([1-3])\b/)
      if (digit) return Number(digit[1])
    }
  }

  return null
}

export async function verifyEwgScore(
  productName: string,
  brand: string,
  category: string,
  serperApiKey: string,
): Promise<EwgVerifyResult> {
  const isCleaningProduct = CLEANING_CATEGORIES.has(category)

  // Primary query: exact product + brand on EWG
  const primaryQuery = `site:ewg.org "${productName}" "${brand}"`
  // Fallback: broader search if exact match returns nothing
  const fallbackQuery = `site:ewg.org ${productName} ${brand}`

  for (const query of [primaryQuery, fallbackQuery]) {
    try {
      const response = await fetch(SERPER_URL, {
        method: 'POST',
        headers: {
          'X-API-KEY': serperApiKey,
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ q: query, num: 5 }),
      })

      if (!response.ok) {
        console.error(`Serper error: ${response.status}`)
        return { passed: false, ewgScore: null, ewgUrl: null, reason: `Serper API error ${response.status}` }
      }

      const data = await response.json()
      const results: any[] = data.organic || []

      // Only look at results that are actually EWG product pages
      const ewgResults = results.filter(r =>
        (r.link || '').includes('ewg.org') &&
        !(r.link || '').includes('ewg.org/news') &&
        !(r.link || '').includes('ewg.org/research')
      )

      for (const result of ewgResults) {
        const fullText = `${result.title || ''} ${result.snippet || ''}`
        const score = parseScoreFromText(fullText, isCleaningProduct)

        if (score !== null) {
          const passed = scoreIsAcceptable(score)
          return {
            passed,
            ewgScore: score,
            ewgUrl: result.link,
            reason: passed
              ? `EWG verified: ${score}`
              : `EWG score ${score} did not meet threshold (found on ${result.link})`,
          }
        }
      }

      // EWG results found but score not parseable from snippet — product exists but we can't confirm score
      if (ewgResults.length > 0 && query === primaryQuery) {
        return {
          passed: false,
          ewgScore: null,
          ewgUrl: ewgResults[0].link,
          reason: `Found on EWG (${ewgResults[0].link}) but could not parse score from snippet`,
        }
      }
    } catch (err) {
      console.error('Serper fetch error:', err)
      return { passed: false, ewgScore: null, ewgUrl: null, reason: `Network error: ${String(err)}` }
    }
  }

  return { passed: false, ewgScore: null, ewgUrl: null, reason: 'Not found on EWG' }
}
