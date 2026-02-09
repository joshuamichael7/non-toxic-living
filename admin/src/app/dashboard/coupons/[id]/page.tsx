import { createServiceClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import { CouponForm } from '@/components/coupon-form';

export default async function EditCouponPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createServiceClient();

  const { data: coupon, error } = await supabase
    .from('coupons')
    .select('*')
    .eq('id', id)
    .single();

  if (error || !coupon) {
    notFound();
  }

  // Convert timestamps to datetime-local format
  const formatDatetimeLocal = (isoString: string | null) => {
    if (!isoString) return '';
    return new Date(isoString).toISOString().slice(0, 16);
  };

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Edit Coupon</h1>
        <p className="text-sm text-gray-500 mt-1">{coupon.brand_name} — {coupon.coupon_code}</p>
      </div>
      <CouponForm
        isEditing
        initialData={{
          id: coupon.id,
          brand_name: coupon.brand_name,
          title: coupon.title,
          description: coupon.description || '',
          coupon_code: coupon.coupon_code,
          discount_type: coupon.discount_type || 'percent',
          discount_value: coupon.discount_value,
          category: coupon.category,
          redemption_url: coupon.redemption_url || '',
          badge_text: coupon.badge_text || 'PARTNER DEAL',
          starts_at: formatDatetimeLocal(coupon.starts_at),
          expires_at: formatDatetimeLocal(coupon.expires_at),
          max_redemptions: coupon.max_redemptions,
          is_active: coupon.is_active,
        }}
      />
    </div>
  );
}
