import { supabase } from '@/lib/supabase';
import AsyncStorage from '@react-native-async-storage/async-storage';
import type { OcrSource, PipelineStep, PipelineTrace } from '@/services/ocr/types';
import type { Database } from '@/types/database';

type ProductRow = Database['public']['Tables']['products']['Row'];
type ScanUpdate = Database['public']['Tables']['scans']['Update'];

export interface Concern {
  ingredient: string;
  severity: 'low' | 'medium' | 'high';
  description: string;
  category: string;
}

export interface Swap {
  id: string;
  name: string;
  brand: string;
  score: number;
  image_url?: string;
  affiliate_url?: string;
  badges?: string[];
  why_better?: string;
  similarity?: number;
  available_stores?: string[];
}

export interface AnalysisResult {
  productName: string;
  brand: string;
  category: string;
  score: number;
  verdict: 'safe' | 'caution' | 'toxic';
  summary: string;
  dadsTake: string;
  concerns: Concern[];
  positives: string[];
  swaps: Swap[];
  ocrSource: OcrSource;
  model: string;
  cached?: boolean;
  cachedAt?: string;
  pipelineTrace?: PipelineTrace;
}

export interface AnalyzeRequest {
  text?: string;
  imageBase64?: string;
  ocrSource: OcrSource;
  ocrConfidence?: number;
  barcode?: string;
  userId?: string;
  forceRefresh?: boolean;
  clientSteps?: PipelineStep[];
  language?: string;
  store?: string;
}

/**
 * Call the analyze-ingredients Edge Function
 *
 * Smart caching:
 * - If barcode provided, checks cache first
 * - Only calls AI if cache miss or stale
 * - Caches results for future scans
 */
export async function analyzeIngredients(request: AnalyzeRequest): Promise<AnalysisResult> {
  console.log('Calling analyze-ingredients with:', {
    hasText: !!request.text,
    textLength: request.text?.length ?? 0,
    hasImage: !!request.imageBase64,
    ocrSource: request.ocrSource,
    ocrConfidence: request.ocrConfidence,
    barcode: request.barcode,
    forceRefresh: request.forceRefresh,
  });

  const { data, error } = await supabase.functions.invoke('analyze-ingredients', {
    body: request,
  });

  if (error) {
    console.error('Edge Function error:', error);
    throw new Error(error.message || 'Analysis failed');
  }

  if (data.error) {
    console.error('Analysis error:', data.error);
    throw new Error(data.error);
  }

  console.log('Analysis result:', {
    productName: data.productName,
    score: data.score,
    verdict: data.verdict,
    concernCount: data.concerns?.length ?? 0,
    swapCount: data.swaps?.length ?? 0,
    cached: data.cached,
    model: data.model,
  });

  // Save scan log for debugging (persists across sessions)
  saveScanLog(data).catch(() => {});

  return data as AnalysisResult;
}

/**
 * Search products by text query
 * Uses vector similarity search for natural language queries
 */
export async function searchProducts(query: string, limit = 20): Promise<any[]> {
  // First, try to generate an embedding for the query
  // Note: This would need a separate endpoint or client-side embedding
  // For now, fall back to text search

  const { data, error } = await supabase
    .from('products')
    .select('id, name, brand, category, score, verdict, summary')
    .or(`name.ilike.%${query}%,brand.ilike.%${query}%`)
    .order('scan_count', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('Product search error:', error);
    throw error;
  }

  return data || [];
}

/**
 * Get product by barcode
 * Quick lookup without AI analysis
 */
export async function getProductByBarcode(barcode: string): Promise<AnalysisResult | null> {
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .eq('barcode', barcode)
    .single();

  if (error || !data) {
    return null;
  }

  const product = data as ProductRow;

  // Parse analysis JSON for concerns/positives
  const analysis = product.analysis as { concerns?: Concern[]; positives?: string[] } | null;

  // Transform to AnalysisResult format
  return {
    productName: product.name,
    brand: product.brand || '',
    category: product.category,
    score: product.score,
    verdict: product.verdict,
    summary: product.summary || '',
    dadsTake: product.dads_take || '',
    concerns: analysis?.concerns || [],
    positives: analysis?.positives || [],
    swaps: [],
    ocrSource: 'device',
    model: 'cached',
    cached: true,
    cachedAt: product.last_analyzed_at,
  };
}

/**
 * Get user's scan history
 */
export async function getUserScans(userId: string, limit = 50): Promise<any[]> {
  const { data, error } = await supabase
    .from('scans')
    .select(`
      id,
      product_name,
      brand,
      score,
      verdict,
      ocr_source,
      was_cached,
      created_at,
      saved_to_list,
      product_id
    `)
    .eq('user_id', userId)
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('Get scans error:', error);
    throw error;
  }

  return data || [];
}

/**
 * Save scan to favorites or avoid list
 */
export async function saveScanToList(
  scanId: string,
  list: 'favorites' | 'avoid' | null
): Promise<void> {
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { error } = await (supabase as any)
    .from('scans')
    .update({ saved_to_list: list })
    .eq('id', scanId);

  if (error) {
    console.error('Save to list error:', error);
    throw error;
  }
}

const SCAN_LOG_KEY = '@scan_logs';
const MAX_LOGS = 20;

async function saveScanLog(result: any) {
  try {
    const existing = await AsyncStorage.getItem(SCAN_LOG_KEY);
    const logs = existing ? JSON.parse(existing) : [];
    logs.unshift({
      timestamp: new Date().toISOString(),
      productName: result.productName,
      brand: result.brand,
      score: result.score,
      verdict: result.verdict,
      ocrSource: result.ocrSource,
      model: result.model,
      cached: result.cached,
      concerns: result.concerns,
      positives: result.positives,
      pipelineTrace: result.pipelineTrace,
    });
    // Keep last N logs
    await AsyncStorage.setItem(SCAN_LOG_KEY, JSON.stringify(logs.slice(0, MAX_LOGS)));
  } catch (e) {
    // Silent fail
  }
}

export async function getScanLogs(): Promise<any[]> {
  try {
    const data = await AsyncStorage.getItem(SCAN_LOG_KEY);
    return data ? JSON.parse(data) : [];
  } catch {
    return [];
  }
}
