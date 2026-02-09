import { supabase } from '@/lib/supabase';

export interface CouponCard {
  id: string;
  brand_name: string;
  title: string;
  description: string | null;
  coupon_code: string;
  discount_type: string | null;
  discount_value: number | null;
  category: string;
  redemption_url: string | null;
  badge_text: string | null;
  expires_at: string | null;
  sort_order: number;
  redemption_type: string;
  barcode_image_url: string | null;
  store_name: string | null;
}

/**
 * Fetch active, non-expired coupons for the home screen carousel.
 * Ordered by sort_order (ascending) then created_at (descending).
 * RLS policy already filters to active, non-expired coupons.
 */
export async function getActiveCoupons(limit = 10): Promise<CouponCard[]> {
  const { data, error } = await (supabase as any)
    .from('coupons')
    .select('id, brand_name, title, description, coupon_code, discount_type, discount_value, category, redemption_url, badge_text, expires_at, sort_order, redemption_type, barcode_image_url, store_name')
    .eq('is_active', true)
    .or(`expires_at.is.null,expires_at.gt.${new Date().toISOString()}`)
    .order('sort_order', { ascending: true })
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('[Coupons] Failed to fetch:', error);
    return [];
  }
  return data || [];
}

/**
 * Increment impressions counter for a coupon.
 * Called when a deal card becomes visible in the viewport.
 */
export async function trackImpression(couponId: string): Promise<void> {
  try {
    await (supabase as any).rpc('increment_coupon_impressions', { coupon_id: couponId });
  } catch (error) {
    console.error('[Coupons] Failed to track impression:', error);
  }
}

/**
 * Increment clicks counter for a coupon.
 * Called when user taps the Redeem/Shop button.
 */
export async function trackClick(couponId: string): Promise<void> {
  try {
    await (supabase as any).rpc('increment_coupon_clicks', { coupon_id: couponId });
  } catch (error) {
    console.error('[Coupons] Failed to track click:', error);
  }
}
