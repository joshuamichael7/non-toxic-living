import type { OcrResult, OcrBlock } from './types';

/**
 * Device OCR using react-native-mlkit-ocr
 * iOS: Uses Apple Vision framework
 * Android: Uses Google ML Kit
 */

// Note: react-native-mlkit-ocr needs to be installed and linked
// For now, this is a placeholder that will be implemented when the native module is available

export async function performDeviceOcr(imageUri: string): Promise<OcrResult> {
  try {
    // TODO: Implement with actual ML Kit OCR
    // const MlkitOcr = require('react-native-mlkit-ocr').default;
    // const result = await MlkitOcr.detectFromUri(imageUri);

    // Placeholder - will be replaced with actual implementation
    console.log('Device OCR called for:', imageUri);

    // Simulate no text found to trigger AI fallback during development
    return {
      text: '',
      confidence: 0,
      source: 'device',
    };
  } catch (error) {
    console.warn('Device OCR failed:', error);
    return {
      text: '',
      confidence: 0,
      source: 'device',
    };
  }
}

/**
 * Parse ML Kit OCR result blocks into our format
 */
export function parseOcrBlocks(blocks: OcrBlock[]): OcrResult {
  if (!blocks || blocks.length === 0) {
    return { text: '', confidence: 0, source: 'device' };
  }

  // Calculate average confidence
  const totalConfidence = blocks.reduce((sum, block) => sum + block.confidence, 0);
  const avgConfidence = totalConfidence / blocks.length;

  // Combine all text
  const fullText = blocks.map(block => block.text).join('\n');

  return {
    text: fullText,
    confidence: avgConfidence,
    source: 'device',
    boundingBoxes: blocks.map(b => b.frame),
  };
}
