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

export interface Coupon {
  id: string;
  brand_name: string;
  title: string;
  description?: string;
  coupon_code: string;
  discount_type?: string;
  discount_value?: number;
  category: string;
  redemption_url?: string;
  badge_text?: string;
  expires_at?: string;
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
  coupons?: Coupon[];
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

export interface QuotaExceededError {
  type: 'quota_exceeded';
  scansUsed: number;
  scansLimit: number;
  resetsAt: string;
}

export function isQuotaExceededError(error: unknown): error is QuotaExceededError {
  return (
    typeof error === 'object' &&
    error !== null &&
    'type' in error &&
    (error as any).type === 'quota_exceeded'
  );
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

  if (data.error === 'quota_exceeded') {
    console.log('Quota exceeded:', data);
    throw {
      type: 'quota_exceeded',
      scansUsed: data.scansUsed,
      scansLimit: data.scansLimit,
      resetsAt: data.resetsAt,
    } as QuotaExceededError;
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

export interface CombinedSearchResult {
  id: string;
  name: string;
  brand: string | null;
  score: number;
  verdict: string;
  summary: string | null;
  source: 'product' | 'swap';
  category?: string;
  why_better?: string | null;
  affiliate_url?: string | null;
  available_stores?: string[];
  badges?: string[];
}

/**
 * Search both products and swaps tables for a combined result set.
 * Products are scanned products cached in the DB.
 * Swaps are pre-seeded safe alternative recommendations.
 *
 * When `categories` is provided, filters by exact category match.
 * Otherwise does text search on name, brand, and category fields.
 */
export async function searchCombined(
  query: string,
  limit = 20,
  categories?: string[],
): Promise<CombinedSearchResult[]> {
  // Build queries with either category filter or text search
  let productsQuery = supabase
    .from('products')
    .select('id, name, brand, category, score, verdict, summary');

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let swapsQuery = (supabase as any)
    .from('swaps')
    .select('id, name, brand, category, score, why_better, affiliate_url, available_stores, badges')
    .eq('is_active', true);

  if (categories && categories.length > 0) {
    productsQuery = productsQuery.in('category', categories);
    swapsQuery = swapsQuery.in('category', categories);
  } else {
    productsQuery = productsQuery.or(
      `name.ilike.*${query}*,brand.ilike.*${query}*,category.ilike.*${query}*`,
    );
    swapsQuery = swapsQuery.or(
      `name.ilike.*${query}*,brand.ilike.*${query}*,category.ilike.*${query}*`,
    );
  }

  const [productsResult, swapsResult] = await Promise.all([
    productsQuery.order('scan_count', { ascending: false }).limit(limit),
    swapsQuery.order('score', { ascending: false }).limit(limit),
  ]);

  const products: CombinedSearchResult[] = (productsResult.data || []).map((p: any) => ({
    id: p.id,
    name: p.name,
    brand: p.brand,
    score: p.score,
    verdict: p.verdict,
    summary: p.summary,
    source: 'product' as const,
    category: p.category,
  }));

  const swaps: CombinedSearchResult[] = (swapsResult.data || []).map((s: any) => ({
    id: s.id,
    name: s.name,
    brand: s.brand,
    score: s.score,
    verdict: s.score >= 67 ? 'safe' : s.score >= 34 ? 'caution' : 'toxic',
    summary: s.why_better,
    source: 'swap' as const,
    category: s.category,
    why_better: s.why_better,
    affiliate_url: s.affiliate_url,
    available_stores: s.available_stores,
    badges: s.badges,
  }));

  // Interleave: products first (sorted by scan_count), then swaps (sorted by score)
  // Deduplicate by name+brand
  const seen = new Set<string>();
  const combined: CombinedSearchResult[] = [];

  for (const item of [...products, ...swaps]) {
    const key = `${(item.name || '').toLowerCase()}|${(item.brand || '').toLowerCase()}`;
    if (!seen.has(key)) {
      seen.add(key);
      combined.push(item);
    }
  }

  return combined.slice(0, limit);
}

/**
 * Get a product by its ID from the products cache table.
 * Used when viewing a product from search results.
 */
export async function getProductById(productId: string): Promise<AnalysisResult | null> {
  const { data, error } = await supabase
    .from('products')
    .select('*')
    .eq('id', productId)
    .single();

  if (error || !data) {
    return null;
  }

  const product = data as ProductRow;
  const analysis = product.analysis as { concerns?: Concern[]; positives?: string[] } | null;

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

/**
 * Get user's scans filtered by saved_to_list
 */
export async function getFilteredScans(
  userId: string,
  filter: 'all' | 'favorites' | 'avoid',
  limit = 50
): Promise<any[]> {
  let query = supabase
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

  if (filter === 'favorites') {
    query = query.eq('saved_to_list', 'favorites');
  } else if (filter === 'avoid') {
    query = query.eq('saved_to_list', 'avoid');
  }

  const { data, error } = await query;

  if (error) {
    console.error('Get filtered scans error:', error);
    throw error;
  }

  return data || [];
}

/**
 * Get a single scan by ID with full analysis data
 */
export async function getScanById(scanId: string): Promise<any> {
  const { data, error } = await supabase
    .from('scans')
    .select(`
      id,
      user_id,
      product_id,
      product_name,
      brand,
      score,
      verdict,
      analysis,
      ocr_source,
      ocr_confidence,
      was_cached,
      ai_model_used,
      saved_to_list,
      created_at
    `)
    .eq('id', scanId)
    .single();

  if (error) {
    console.error('Get scan by ID error:', error);
    throw error;
  }

  return data;
}

/**
 * Get swap recommendations for a product by its product_id
 * Used as fallback when viewing past scans that don't have swaps saved
 */
export async function getSwapsForProduct(productId: string, store?: string | null): Promise<Swap[]> {
  // Get product category
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  const { data: product, error: productError } = await (supabase as any)
    .from('products')
    .select('category')
    .eq('id', productId)
    .single();

  if (productError || !product?.category) return [];

  // Build base query
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  let query = (supabase as any)
    .from('swaps')
    .select('id, name, brand, score, affiliate_url, why_better, available_stores')
    .eq('category', product.category)
    .eq('is_active', true)
    .gte('score', 70)
    .order('score', { ascending: false })
    .limit(5);

  // Filter by store if provided
  if (store) {
    query = query.contains('available_stores', [store]);
  }

  const { data: swaps, error: swapError } = await query;

  // If store filter returned no results, fall back to unfiltered
  if (store && (!swaps || swaps.length === 0)) {
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const { data: unfilteredSwaps } = await (supabase as any)
      .from('swaps')
      .select('id, name, brand, score, affiliate_url, why_better, available_stores')
      .eq('category', product.category)
      .eq('is_active', true)
      .gte('score', 70)
      .order('score', { ascending: false })
      .limit(5);
    return (unfilteredSwaps || []) as Swap[];
  }

  if (swapError || !swaps) return [];

  return swaps as Swap[];
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
