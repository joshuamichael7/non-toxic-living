export const config = {
  // App info
  appName: 'Non-Toxic Living',
  appVersion: '1.0.0',

  // API endpoints
  supabaseUrl: process.env.EXPO_PUBLIC_SUPABASE_URL || '',
  supabaseAnonKey: process.env.EXPO_PUBLIC_SUPABASE_ANON_KEY || '',

  // OCR thresholds
  ocr: {
    highConfidenceThreshold: 0.8,
    lowConfidenceThreshold: 0.5,
    minTextLength: 20,
    minPartialTextLength: 10,
  },

  // Score thresholds
  scores: {
    safeThreshold: 67,
    cautionThreshold: 34,
  },

  // Cache settings
  cache: {
    productStaleTime: 1000 * 60 * 60 * 24, // 24 hours
    scanHistoryLimit: 100,
  },

  // Free tier limits
  freeTier: {
    dailyScans: 10,
  },
} as const;
