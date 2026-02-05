export type OcrSource = 'device' | 'ai-mini' | 'ai-vision';

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
