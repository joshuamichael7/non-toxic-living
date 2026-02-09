import { createServiceClient } from '@/lib/supabase/server';
import { FeaturedForm } from '@/components/featured-form';

export default async function NewFeaturedPage({
  searchParams,
}: {
  searchParams: Promise<{ swap_id?: string; from_coupon?: string }>;
}) {
  const params = await searchParams;
  const swapId = params.swap_id || null;
  const couponId = params.from_coupon || null;

  let initialData = undefined;
  let linkedSwapName: string | null = null;
  let subtitle = 'Create a coupon, affiliate product, or sponsored post';
  let existingDeal: { id: string; title: string } | null = null;

  if (swapId) {
    const supabase = await createServiceClient();
    const { data: swap } = await supabase
      .from('swaps')
      .select('id, name, brand, category, image_url, affiliate_url, available_stores')
      .eq('id', swapId)
      .single();

    if (swap) {
      linkedSwapName = `${swap.name} (${swap.brand})`;
      subtitle = `Pre-filled from swap: ${swap.name}`;

      // Check if a deal already exists for this swap
      const { data: existing } = await supabase
        .from('featured_items')
        .select('id, title')
        .eq('swap_id', swap.id)
        .limit(1)
        .maybeSingle();
      existingDeal = existing;

      initialData = {
        type: 'product' as const,
        title: swap.name,
        subtitle: '',
        brand_name: swap.brand || '',
        description: '',
        image_url: swap.image_url || '',
        action_url: swap.affiliate_url || '',
        action_label: 'Shop Now',
        coupon_code: '',
        discount_text: '',
        badge_text: 'FEATURED',
        redemption_type: 'online',
        barcode_image_url: '',
        store_name: (swap.available_stores as string[])?.[0] || '',
        sort_order: 100,
        starts_at: new Date().toISOString().slice(0, 16),
        expires_at: '',
        is_active: true,
        swap_id: swap.id,
        product_id: null,
      };
    }
  } else if (couponId) {
    const supabase = await createServiceClient();
    const { data: coupon } = await supabase
      .from('coupons')
      .select('id, brand_name, title, description, coupon_code, discount_type, discount_value, category, redemption_url, redemption_type, barcode_image_url, store_name, expires_at')
      .eq('id', couponId)
      .single();

    if (coupon) {
      subtitle = `Pre-filled from coupon: ${coupon.brand_name} — ${coupon.coupon_code}`;

      let discountText = '';
      if (coupon.discount_type === 'percent' && coupon.discount_value) {
        discountText = `${coupon.discount_value}% OFF`;
      } else if (coupon.discount_type === 'fixed' && coupon.discount_value) {
        discountText = `$${(coupon.discount_value / 100).toFixed(2)} OFF`;
      } else if (coupon.discount_type === 'free_shipping') {
        discountText = 'FREE SHIPPING';
      } else if (coupon.discount_type === 'bogo') {
        discountText = 'BUY ONE GET ONE';
      }

      const formatDatetimeLocal = (isoString: string | null) => {
        if (!isoString) return '';
        return new Date(isoString).toISOString().slice(0, 16);
      };

      initialData = {
        type: 'coupon' as const,
        title: coupon.title,
        subtitle: '',
        brand_name: coupon.brand_name || '',
        description: coupon.description || '',
        image_url: '',
        action_url: coupon.redemption_url || '',
        action_label: 'Redeem Now',
        coupon_code: coupon.coupon_code || '',
        discount_text: discountText,
        badge_text: 'PARTNER DEAL',
        redemption_type: coupon.redemption_type || 'online',
        barcode_image_url: coupon.barcode_image_url || '',
        store_name: coupon.store_name || '',
        sort_order: 100,
        starts_at: new Date().toISOString().slice(0, 16),
        expires_at: formatDatetimeLocal(coupon.expires_at),
        is_active: true,
        swap_id: null,
        product_id: null,
      };
    }
  }

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Add Featured Item</h1>
        <p className="text-sm text-gray-500 mt-1">{subtitle}</p>
      </div>
      {existingDeal && (
        <div className="mb-4 bg-amber-50 border border-amber-200 rounded-lg px-4 py-3 text-sm text-amber-800">
          A featured item already exists for this product:{' '}
          <a href={`/dashboard/featured/${existingDeal.id}`} className="font-medium underline">
            {existingDeal.title}
          </a>
          . Creating another will result in a duplicate.
        </div>
      )}
      <FeaturedForm initialData={initialData} linkedSwapName={linkedSwapName} />
    </div>
  );
}
