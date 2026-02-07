export type OcrSource = 'device' | 'cloud' | 'ai-mini' | 'ai-vision' | 'manual';

export interface BoundingBox {
  x: number;
  y: number;
  width: number;
  height: number;
}

export interface OcrResult {
  text: string;
  confidence: number;
  source: OcrSource;
  boundingBoxes?: BoundingBox[];
}

export interface OcrBlock {
  text: string;
  confidence: number;
  frame: BoundingBox;
}

export interface PipelineStep {
  name: string;
  status: 'success' | 'skipped' | 'failed';
  durationMs: number;
  detail?: string;
}

export interface PipelineTrace {
  steps: PipelineStep[];
  extractedText: string;
  totalDurationMs: number;
  ocrSource: OcrSource;
  analysisModel: string;
  extractionModel?: string;
}
