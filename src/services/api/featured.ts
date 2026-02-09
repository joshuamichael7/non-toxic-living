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
  swap_id: string | null;
  product_id: string | null;
}

export interface FeaturedDeal extends FeaturedItem {
  linked_swap?: { id: string; name: string; brand: string; score: number; category: string } | null;
  linked_product?: { id: string; name: string; brand: string; score: number; category: string } | null;
}

const FEATURED_FIELDS = 'id, type, title, subtitle, brand_name, description, image_url, action_url, action_label, coupon_code, discount_text, badge_text, redemption_type, barcode_image_url, store_name, sort_order, expires_at, swap_id, product_id';

/**
 * Fetch active featured items for the home screen carousel.
 * RLS policy filters to active, non-expired, started items.
 */
export async function getActiveFeaturedItems(limit = 10): Promise<FeaturedItem[]> {
  const { data, error } = await (supabase as any)
    .from('featured_items')
    .select(FEATURED_FIELDS)
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
 * Fetch active featured deals with linked swap/product data.
 * Used by the "Deals & Discounts" search category.
 */
export async function getFeaturedDeals(limit = 20): Promise<FeaturedDeal[]> {
  const { data, error } = await (supabase as any)
    .from('featured_items')
    .select(`
      ${FEATURED_FIELDS},
      linked_swap:swaps!swap_id(id, name, brand, score, category),
      linked_product:products!product_id(id, name, brand, score, category)
    `)
    .order('sort_order', { ascending: true })
    .order('created_at', { ascending: false })
    .limit(limit);

  if (error) {
    console.error('[Featured] Failed to fetch deals:', error);
    return [];
  }
  return data || [];
}

/**
 * Fetch deals relevant to a specific product.
 * Checks direct product links AND category-matched swap links.
 */
export async function getDealsForProduct(
  productId: string,
  category: string
): Promise<FeaturedDeal[]> {
  // Run both queries in parallel
  const [directResult, categoryResult] = await Promise.all([
    // Deals directly linked to this product
    productId
      ? (supabase as any)
          .from('featured_items')
          .select(`${FEATURED_FIELDS}, linked_swap:swaps!swap_id(id, name, brand, score, category)`)
          .eq('product_id', productId)
          .limit(5)
      : { data: [], error: null },
    // Deals linked to swaps in the same category
    (supabase as any)
      .from('featured_items')
      .select(`${FEATURED_FIELDS}, linked_swap:swaps!swap_id(id, name, brand, score, category)`)
      .not('swap_id', 'is', null)
      .limit(20),
  ]);

  const directDeals: FeaturedDeal[] = directResult.data || [];
  const allCategoryDeals: FeaturedDeal[] = categoryResult.data || [];

  // Filter category deals to matching category
  const categoryDeals = allCategoryDeals.filter(
    (d: FeaturedDeal) => d.linked_swap?.category === category
  );

  // Deduplicate by featured item ID
  const seen = new Set<string>();
  const combined: FeaturedDeal[] = [];
  for (const deal of [...directDeals, ...categoryDeals]) {
    if (!seen.has(deal.id)) {
      seen.add(deal.id);
      combined.push(deal);
    }
  }
  return combined.slice(0, 5);
}

/**
 * Check which swap IDs have active deals.
 * Returns a map of swap_id → deal info for annotating search results.
 */
export async function getDealsForSwapIds(
  swapIds: string[]
): Promise<Map<string, { discount_text: string | null; badge_text: string | null; coupon_code: string | null }>> {
  const map = new Map<string, { discount_text: string | null; badge_text: string | null; coupon_code: string | null }>();
  if (swapIds.length === 0) return map;

  const { data, error } = await (supabase as any)
    .from('featured_items')
    .select('id, swap_id, discount_text, badge_text, coupon_code')
    .in('swap_id', swapIds);

  if (error) {
    console.error('[Featured] Failed to fetch deals for swaps:', error);
    return map;
  }

  for (const item of data || []) {
    if (item.swap_id) {
      map.set(item.swap_id, {
        discount_text: item.discount_text,
        badge_text: item.badge_text,
        coupon_code: item.coupon_code,
      });
    }
  }
  return map;
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
