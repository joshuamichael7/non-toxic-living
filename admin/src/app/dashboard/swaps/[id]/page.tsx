import { createServiceClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import { SwapForm } from '@/components/swap-form';

interface LinkedCoupon {
  id: string;
  brand_name: string;
  title: string;
  coupon_code: string | null;
  discount_type: string;
  discount_value: number | null;
  is_active: boolean;
  expires_at: string | null;
  redeemable_online: boolean;
  redeemable_in_store: boolean;
  redeemable_ibotta: boolean;
}

interface LinkedFeaturedItem {
  id: string;
  title: string;
  type: string;
  badge_text: string | null;
  discount_text: string | null;
  is_active: boolean;
  expires_at: string | null;
}

function formatDiscount(type: string, value: number | null) {
  if (!type || type === 'other') return 'Other';
  if (type === 'free_shipping') return 'Free Shipping';
  if (type === 'bogo') return 'BOGO';
  if (type === 'percent' && value) return `${value}% off`;
  if (type === 'fixed' && value) return `$${(value / 100).toFixed(2)} off`;
  return type;
}

function isExpired(expiresAt: string | null) {
  if (!expiresAt) return false;
  return new Date(expiresAt) < new Date();
}

export default async function EditSwapPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createServiceClient();

  const [swapResult, couponsResult, featuredResult] = await Promise.all([
    supabase.from('swaps').select('*').eq('id', id).single(),
    supabase
      .from('coupons')
      .select('id, brand_name, title, coupon_code, discount_type, discount_value, is_active, expires_at, redeemable_online, redeemable_in_store, redeemable_ibotta')
      .eq('product_id', id)
      .order('sort_order', { ascending: true }),
    supabase
      .from('featured_items')
      .select('id, title, type, badge_text, discount_text, is_active, expires_at')
      .eq('swap_id', id)
      .order('sort_order', { ascending: true }),
  ]);

  const swap = swapResult.data;
  if (swapResult.error || !swap) {
    notFound();
  }

  const linkedCoupons: LinkedCoupon[] = couponsResult.data || [];
  const linkedFeatured: LinkedFeaturedItem[] = featuredResult.data || [];

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Edit Swap</h1>
        <p className="text-sm text-gray-500 mt-1">{swap.name} — {swap.brand}</p>
      </div>
      <SwapForm
        isEditing
        initialData={{
          id: swap.id,
          name: swap.name,
          brand: swap.brand,
          category: swap.category,
          description: swap.description || '',
          score: swap.score,
          why_better: swap.why_better || '',
          badges: swap.badges || [],
          replaces_ingredients: swap.replaces_ingredients || [],
          replaces_products: swap.replaces_products || [],
          price_cents: swap.price_cents,
          affiliate_url: swap.affiliate_url || '',
          affiliate_source: swap.affiliate_source || '',
          affiliate_commission_percent: swap.affiliate_commission_percent,
          available_stores: swap.available_stores || [],
          image_url: swap.image_url || '',
          is_active: swap.is_active,
          featured: swap.featured,
        }}
      />

      {/* Linked Deals & Coupons */}
      <div className="mt-10 max-w-3xl">
        <div className="flex items-center justify-between mb-4">
          <div>
            <h2 className="text-lg font-semibold text-gray-900">Linked Deals & Coupons</h2>
            <p className="text-sm text-gray-500 mt-0.5">Coupons and featured deals associated with this product.</p>
          </div>
          <div className="flex gap-2">
            <a
              href={`/dashboard/coupons/new?swap_id=${swap.id}`}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-sky-600 text-white rounded-lg text-xs font-medium hover:bg-sky-700 transition-colors"
            >
              <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
              </svg>
              Create Coupon
            </a>
            <a
              href={`/dashboard/featured/new?swap_id=${swap.id}`}
              className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-violet-600 text-white rounded-lg text-xs font-medium hover:bg-violet-700 transition-colors"
            >
              <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
              </svg>
              Create Featured Deal
            </a>
          </div>
        </div>

        {linkedCoupons.length === 0 && linkedFeatured.length === 0 ? (
          <div className="bg-white rounded-xl border border-gray-200 p-8 text-center">
            <p className="text-sm text-gray-400">No deals or coupons linked to this product yet.</p>
          </div>
        ) : (
          <div className="space-y-3">
            {linkedCoupons.map((coupon) => (
              <div key={coupon.id} className="bg-white rounded-xl border border-gray-200 px-5 py-4 flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="flex items-center gap-1.5">
                    <span className={`w-2 h-2 rounded-full ${coupon.is_active && !isExpired(coupon.expires_at) ? 'bg-emerald-500' : 'bg-gray-300'}`} />
                    <span className="text-xs text-gray-400 uppercase font-medium">Coupon</span>
                  </div>
                  <div>
                    <div className="flex items-center gap-2">
                      <span className="text-sm font-medium text-gray-900">{coupon.title}</span>
                      {coupon.coupon_code && (
                        <code className="px-1.5 py-0.5 bg-gray-100 rounded text-xs font-mono text-gray-600">{coupon.coupon_code}</code>
                      )}
                    </div>
                    <div className="flex items-center gap-2 mt-1">
                      <span className="text-xs text-gray-500">{formatDiscount(coupon.discount_type, coupon.discount_value)}</span>
                      <span className="text-gray-300">·</span>
                      <div className="flex gap-1">
                        {coupon.redeemable_online && <span className="text-xs text-blue-600">Online</span>}
                        {coupon.redeemable_in_store && <span className="text-xs text-amber-600">In-Store</span>}
                        {coupon.redeemable_ibotta && <span className="text-xs text-orange-600">Ibotta</span>}
                      </div>
                      {isExpired(coupon.expires_at) && (
                        <>
                          <span className="text-gray-300">·</span>
                          <span className="text-xs text-red-500">Expired</span>
                        </>
                      )}
                    </div>
                  </div>
                </div>
                <a
                  href={`/dashboard/coupons/${coupon.id}`}
                  className="text-sky-600 hover:text-sky-800 text-xs font-medium"
                >
                  Edit
                </a>
              </div>
            ))}
            {linkedFeatured.map((item) => (
              <div key={item.id} className="bg-white rounded-xl border border-gray-200 px-5 py-4 flex items-center justify-between">
                <div className="flex items-center gap-4">
                  <div className="flex items-center gap-1.5">
                    <span className={`w-2 h-2 rounded-full ${item.is_active && !isExpired(item.expires_at) ? 'bg-emerald-500' : 'bg-gray-300'}`} />
                    <span className="text-xs text-violet-500 uppercase font-medium">Featured</span>
                  </div>
                  <div>
                    <span className="text-sm font-medium text-gray-900">{item.title}</span>
                    <div className="flex items-center gap-2 mt-1">
                      {item.badge_text && <span className="text-xs text-gray-500">{item.badge_text}</span>}
                      {item.discount_text && (
                        <>
                          <span className="text-gray-300">·</span>
                          <span className="text-xs text-sky-600 font-medium">{item.discount_text}</span>
                        </>
                      )}
                      {isExpired(item.expires_at) && (
                        <>
                          <span className="text-gray-300">·</span>
                          <span className="text-xs text-red-500">Expired</span>
                        </>
                      )}
                    </div>
                  </div>
                </div>
                <a
                  href={`/dashboard/featured/${item.id}`}
                  className="text-violet-600 hover:text-violet-800 text-xs font-medium"
                >
                  Edit
                </a>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
