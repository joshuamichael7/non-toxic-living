import { supabase } from '@/lib/supabase';

export interface FeaturedItem {
  id: string;
  type: 'coupon' | 'product' | 'sponsored';
  title: string;
  subtitle: string | null;
  brand_name: string | null;
  description: string | null;
  image_url: string | null;
  action_url: string | null;
  action_label: string | null;
  coupon_code: string | null;
  discount_text: string | null;
  badge_text: string | null;
  redemption_type: string;
  barcode_image_url: string | null;
  store_name: string | null;
  sort_order: number;
  expires_at: string | null;
}

/**
 * Fetch active featured items for the home screen carousel.
 * RLS policy filters to active, non-expired, started items.
 */
export async function getActiveFeaturedItems(limit = 10): Promise<FeaturedItem[]> {
  const { data, error } = await (supabase as any)
    .from('featured_items')
    .select('id, type, title, subtitle, brand_name, description, image_url, action_url, action_label, coupon_code, discount_text, badge_text, redemption_type, barcode_image_url, store_name, sort_order, expires_at')
    .order('sort_order', { ascending: true })
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('[Featured] Failed to fetch:', error);
    return [];
  }
  return data || [];
}

/**
 * Increment impressions counter for a featured item.
 */
export async function trackImpression(itemId: string): Promise<void> {
  try {
    await (supabase as any).rpc('increment_featured_impressions', { item_id: itemId });
  } catch (error) {
    console.error('[Featured] Failed to track impression:', error);
  }
}

/**
 * Increment clicks counter for a featured item.
 */
export async function trackClick(itemId: string): Promise<void> {
  try {
    await (supabase as any).rpc('increment_featured_clicks', { item_id: itemId });
  } catch (error) {
    console.error('[Featured] Failed to track click:', error);
  }
}
