export type Verdict = 'safe' | 'caution' | 'toxic';
export type OcrSource = 'device' | 'ai-mini' | 'ai-vision';
export type ConcernSeverity = 'low' | 'medium' | 'high';
export type ConcernCategory = 'carcinogen' | 'endocrine' | 'allergen' | 'irritant' | 'environmental';

export interface Concern {
  ingredient: string;
  severity: ConcernSeverity;
  description: string;
  category?: ConcernCategory;
}

export interface ToxicityAnalysis {
  productName: string;
  brand?: string;
  category: string;
  score: number;
  verdict: Verdict;
  summary: string;
  dadsTake?: string;
  concerns: Concern[];
  positives: string[];
  ingredients?: string[];
  materials?: string[];
}

export interface ScanResult {
  id: string;
  analysis: ToxicityAnalysis;
  ocrSource: OcrSource;
  model: string;
  swaps: SwapSuggestion[];
  timestamp: Date;
}

export interface SwapSuggestion {
  id: string;
  name: string;
  brand: string;
  score: number;
  price?: number;
  imageUrl?: string;
  affiliateUrl?: string;
  badges?: string[];
  whyBetter?: string;
}
