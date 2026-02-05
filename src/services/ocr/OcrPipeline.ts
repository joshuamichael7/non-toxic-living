import { performDeviceOcr } from './DeviceOcr';
import type { OcrResult, OcrSource } from './types';

// Confidence thresholds for routing decisions
const HIGH_CONFIDENCE_THRESHOLD = 0.8;
const LOW_CONFIDENCE_THRESHOLD = 0.5;
const MIN_TEXT_LENGTH = 20;
const MIN_PARTIAL_TEXT_LENGTH = 10;

export interface ProcessImageResult {
  ocrResult: OcrResult;
  shouldSendImage: boolean;
  suggestedModel: 'gpt-4o-mini' | 'gpt-4o';
}

/**
 * Hybrid OCR Pipeline
 *
 * 1. Try device OCR first (FREE)
 * 2. If high confidence text found, send text only to AI (CHEAP)
 * 3. If low/no confidence, send image to AI (EXPENSIVE)
 */
export async function processImage(imageUri: string): Promise<ProcessImageResult> {
  // Step 1: Try device OCR first (FREE)
  const deviceResult = await performDeviceOcr(imageUri);

  // High confidence + enough text = send text only (cheapest)
  if (
    deviceResult.confidence > HIGH_CONFIDENCE_THRESHOLD &&
    deviceResult.text.length > MIN_TEXT_LENGTH
  ) {
    return {
      ocrResult: { ...deviceResult, source: 'device' },
      shouldSendImage: false,
      suggestedModel: 'gpt-4o-mini',
    };
  }

  // Partial text found = send text to AI for cleanup (cheap)
  if (
    deviceResult.confidence > LOW_CONFIDENCE_THRESHOLD &&
    deviceResult.text.length > MIN_PARTIAL_TEXT_LENGTH
  ) {
    return {
      ocrResult: { ...deviceResult, source: 'ai-mini' },
      shouldSendImage: false,
      suggestedModel: 'gpt-4o-mini',
    };
  }

  // Poor/no text = need full vision API (expensive but necessary)
  return {
    ocrResult: { text: '', confidence: 0, source: 'ai-vision' },
    shouldSendImage: true,
    suggestedModel: 'gpt-4o',
  };
}

/**
 * Determine which AI model to use based on OCR result
 */
export function selectModel(ocrSource: OcrSource): 'gpt-4o-mini' | 'gpt-4o' {
  return ocrSource === 'ai-vision' ? 'gpt-4o' : 'gpt-4o-mini';
}

/**
 * Extract ingredients from OCR text
 * Looks for common patterns like "Ingredients:", "Contains:", etc.
 */
export function extractIngredients(text: string): string[] {
  // Find ingredients section
  const patterns = [
    /ingredients?:?\s*([\s\S]*?)(?=\n\n|nutrition|contains|allergen|$)/i,
    /contains?:?\s*([\s\S]*?)(?=\n\n|nutrition|allergen|$)/i,
  ];

  for (const pattern of patterns) {
    const match = text.match(pattern);
    if (match && match[1]) {
      return parseIngredientList(match[1]);
    }
  }

  // If no clear section found, try to parse the whole text
  return parseIngredientList(text);
}

/**
 * Parse a comma/semicolon separated ingredient list
 */
function parseIngredientList(text: string): string[] {
  return text
    .split(/[,;.]/)
    .map(i => i.trim().toLowerCase())
    .filter(i => i.length > 2 && i.length < 50)
    .filter(i => !i.match(/^\d+$/)); // Remove pure numbers
}
