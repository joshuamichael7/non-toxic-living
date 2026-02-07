import TextRecognition, { TextRecognitionScript } from '@react-native-ml-kit/text-recognition';
import type { OcrResult, PipelineStep } from './types';

/**
 * Device OCR using @react-native-ml-kit/text-recognition
 *
 * iOS: Uses Apple Vision framework (excellent multilingual support)
 * Android: Uses Google ML Kit with script-specific models
 */

const SCRIPTS_TO_TRY = [
  { script: TextRecognitionScript.KOREAN, label: 'Korean' },
  { script: TextRecognitionScript.LATIN, label: 'Latin' },
  { script: TextRecognitionScript.JAPANESE, label: 'Japanese' },
  { script: TextRecognitionScript.CHINESE, label: 'Chinese' },
] as const;

export interface DeviceOcrResult extends OcrResult {
  steps: PipelineStep[];
  bestScript?: string;
}

export async function performDeviceOcr(imageUri: string): Promise<DeviceOcrResult> {
  const overallStart = Date.now();
  const steps: PipelineStep[] = [];

  try {
    console.log('=== Device OCR Start ===');
    console.log('Image URI:', imageUri);

    let bestResult: { text: string; script: string } | null = null;

    for (const { script, label } of SCRIPTS_TO_TRY) {
      const stepStart = Date.now();
      try {
        const result = await TextRecognition.recognize(imageUri, script);
        const textLength = result?.text?.trim().length ?? 0;
        const durationMs = Date.now() - stepStart;

        if (textLength > 0) {
          console.log(`  ${label}: ${textLength} chars in ${durationMs}ms`);
          console.log(`  Preview: "${result.text.trim().substring(0, 80)}"`);

          steps.push({
            name: `Device OCR (${label})`,
            status: 'success',
            durationMs,
            detail: `Detected ${textLength} chars`,
          });

          if (!bestResult || result.text.length > bestResult.text.length) {
            bestResult = { text: result.text, script: label };
          }
        } else {
          console.log(`  ${label}: no text (${durationMs}ms)`);
          steps.push({
            name: `Device OCR (${label})`,
            status: 'failed',
            durationMs,
            detail: 'No text detected',
          });
        }
      } catch (scriptError) {
        const durationMs = Date.now() - stepStart;
        console.log(`  ${label}: error (${durationMs}ms):`, scriptError);
        steps.push({
          name: `Device OCR (${label})`,
          status: 'failed',
          durationMs,
          detail: `Error: ${scriptError instanceof Error ? scriptError.message : 'Unknown'}`,
        });
      }
    }

    const totalMs = Date.now() - overallStart;

    if (!bestResult) {
      console.log(`=== Device OCR: No text found (${totalMs}ms) ===`);
      return { text: '', confidence: 0, source: 'device', steps };
    }

    const fullText = bestResult.text;
    const confidence = estimateConfidence(fullText);

    console.log(`=== Device OCR Complete (${totalMs}ms) ===`);
    console.log(`  Best script: ${bestResult.script}`);
    console.log(`  Text length: ${fullText.length}`);
    console.log(`  Confidence: ${confidence}`);
    console.log(`  Full text: "${fullText.substring(0, 200)}"`);

    return {
      text: fullText,
      confidence,
      source: 'device',
      steps,
      bestScript: bestResult.script,
    };
  } catch (error) {
    const totalMs = Date.now() - overallStart;
    console.warn(`=== Device OCR Failed (${totalMs}ms) ===`, error);
    steps.push({
      name: 'Device OCR',
      status: 'failed',
      durationMs: totalMs,
      detail: `Error: ${error instanceof Error ? error.message : 'Unknown'}`,
    });
    return { text: '', confidence: 0, source: 'device', steps };
  }
}

/**
 * Estimate OCR confidence based on text quantity.
 * Language-agnostic — just measures how much text was found.
 */
function estimateConfidence(fullText: string): number {
  let confidence = 0.6;

  if (fullText.length >= 30) confidence += 0.15;
  if (fullText.length >= 80) confidence += 0.15;
  if (fullText.length >= 150) confidence += 0.05;

  return Math.min(confidence, 0.95);
}
