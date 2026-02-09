import { performDeviceOcr } from './DeviceOcr';
import type { OcrResult, OcrSource, PipelineStep } from './types';

// Confidence thresholds for routing decisions
const HIGH_CONFIDENCE_THRESHOLD = 0.7;
const LOW_CONFIDENCE_THRESHOLD = 0.3;
const MIN_TEXT_LENGTH = 10;
const MIN_PARTIAL_TEXT_LENGTH = 5;

export interface ProcessImageResult {
  ocrResult: OcrResult;
  shouldSendImage: boolean;
  suggestedModel: 'gpt-4o-mini';
  clientSteps: PipelineStep[];
}

/**
 * Hybrid OCR Pipeline
 *
 * 1. Try device OCR first (FREE)
 * 2. If good text found, send text only to AI (CHEAP)
 * 3. If low/no text, send image to server for cloud OCR fallback
 */
export async function processImage(imageUri: string): Promise<ProcessImageResult> {
  console.log('=== OCR Pipeline Start ===');

  // Step 1: Try device OCR first (FREE)
  const deviceResult = await performDeviceOcr(imageUri);
  const clientSteps: PipelineStep[] = [...deviceResult.steps];

  console.log('Pipeline decision:', {
    textLength: deviceResult.text.length,
    confidence: deviceResult.confidence,
    bestScript: deviceResult.bestScript,
  });

  // High confidence + enough text = send text only (cheapest path)
  if (
    deviceResult.confidence >= HIGH_CONFIDENCE_THRESHOLD &&
    deviceResult.text.length >= MIN_TEXT_LENGTH
  ) {
    console.log('=== Pipeline: HIGH confidence → text only ===');
    clientSteps.push({
      name: 'Pipeline Decision',
      status: 'success',
      durationMs: 0,
      detail: `High confidence (${deviceResult.confidence.toFixed(2)}) — sending text only`,
    });

    return {
      ocrResult: { ...deviceResult, source: 'device' },
      shouldSendImage: false,
      suggestedModel: 'gpt-4o-mini',
      clientSteps,
    };
  }

  // Partial text found = still send text only for AI cleanup
  if (
    deviceResult.confidence >= LOW_CONFIDENCE_THRESHOLD &&
    deviceResult.text.length >= MIN_PARTIAL_TEXT_LENGTH
  ) {
    console.log('=== Pipeline: PARTIAL confidence → text only (AI cleanup) ===');
    clientSteps.push({
      name: 'Pipeline Decision',
      status: 'success',
      durationMs: 0,
      detail: `Partial confidence (${deviceResult.confidence.toFixed(2)}) — sending text for AI cleanup`,
    });

    return {
      ocrResult: { ...deviceResult, source: 'ai-mini' },
      shouldSendImage: false,
      suggestedModel: 'gpt-4o-mini',
      clientSteps,
    };
  }

  // No usable text — send image to server for cloud OCR fallback
  // IMPORTANT: Still pass through any partial text (don't discard it)
  console.log('=== Pipeline: LOW/NO confidence → sending image for server OCR ===');
  clientSteps.push({
    name: 'Pipeline Decision',
    status: 'failed',
    durationMs: 0,
    detail: deviceResult.text.length > 0
      ? `Low confidence (${deviceResult.confidence.toFixed(2)}, ${deviceResult.text.length} chars) — sending image + partial text`
      : 'No text detected — sending image for cloud OCR',
  });

  return {
    ocrResult: {
      text: deviceResult.text, // Preserve partial text — don't discard!
      confidence: deviceResult.confidence,
      source: 'ai-vision',
    },
    shouldSendImage: true,
    suggestedModel: 'gpt-4o-mini',
    clientSteps,
  };
}
