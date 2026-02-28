import { createServiceClient } from '@/lib/supabase/server';
import { CouponForm } from '@/components/coupon-form';

export default async function NewCouponPage({
  searchParams,
}: {
  searchParams: Promise<{ swap_id?: string }>;
}) {
  const params = await searchParams;
  let prefill = undefined;

  if (params.swap_id) {
    const supabase = await createServiceClient();
    const { data: swap } = await supabase
      .from('swaps')
      .select('id, name, brand, category')
      .eq('id', params.swap_id)
      .single();

    if (swap) {
      const mappedCategory = swap.category.replace(/ /g, '_').toLowerCase();
      prefill = {
        product_id: swap.id,
        brand_name: swap.brand,
        category: mappedCategory,
      };
    }
  }

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Add Coupon</h1>
        <p className="text-sm text-gray-500 mt-1">Create a new partner coupon deal</p>
      </div>
      <CouponForm prefill={prefill} />
    </div>
  );
}
