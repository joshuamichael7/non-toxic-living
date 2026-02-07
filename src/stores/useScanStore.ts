import { create } from 'zustand';
import type { AnalysisResult } from '@/services/api/analyze';

interface ScanState {
  // Current scan result
  currentResult: AnalysisResult | null;

  // Loading and error states
  isAnalyzing: boolean;
  error: string | null;

  // Image URI from camera
  imageUri: string | null;

  // Actions
  setCurrentResult: (result: AnalysisResult) => void;
  setIsAnalyzing: (isAnalyzing: boolean) => void;
  setError: (error: string | null) => void;
  setImageUri: (uri: string | null) => void;
  clearScan: () => void;
}

export const useScanStore = create<ScanState>((set) => ({
  currentResult: null,
  isAnalyzing: false,
  error: null,
  imageUri: null,

  setCurrentResult: (result) => set({ currentResult: result, error: null }),
  setIsAnalyzing: (isAnalyzing) => set({ isAnalyzing }),
  setError: (error) => set({ error, isAnalyzing: false }),
  setImageUri: (imageUri) => set({ imageUri }),
  clearScan: () => set({ currentResult: null, error: null, imageUri: null, isAnalyzing: false }),
}));
