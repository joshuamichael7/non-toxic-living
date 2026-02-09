import { createServiceClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import { FeaturedForm } from '@/components/featured-form';

export default async function EditFeaturedPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createServiceClient();

  const { data: item, error } = await supabase
    .from('featured_items')
    .select('*')
    .eq('id', id)
    .single();

  if (error || !item) {
    notFound();
  }

  let linkedSwapName: string | null = null;
  if (item.swap_id) {
    const { data: swap } = await supabase
      .from('swaps')
      .select('name, brand')
      .eq('id', item.swap_id)
      .single();
    if (swap) linkedSwapName = `${swap.name} (${swap.brand})`;
  }

  const formatDatetimeLocal = (isoString: string | null) => {
    if (!isoString) return '';
    return new Date(isoString).toISOString().slice(0, 16);
  };

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Edit Featured Item</h1>
        <p className="text-sm text-gray-500 mt-1">{item.brand_name || item.type} — {item.title}</p>
      </div>
      <FeaturedForm
        isEditing
        linkedSwapName={linkedSwapName}
        initialData={{
          id: item.id,
          type: item.type,
          title: item.title,
          subtitle: item.subtitle || '',
          brand_name: item.brand_name || '',
          description: item.description || '',
          image_url: item.image_url || '',
          action_url: item.action_url || '',
          action_label: item.action_label || '',
          coupon_code: item.coupon_code || '',
          discount_text: item.discount_text || '',
          badge_text: item.badge_text || 'FEATURED',
          redemption_type: item.redemption_type || 'online',
          barcode_image_url: item.barcode_image_url || '',
          store_name: item.store_name || '',
          sort_order: item.sort_order ?? 100,
          starts_at: formatDatetimeLocal(item.starts_at),
          expires_at: formatDatetimeLocal(item.expires_at),
          is_active: item.is_active,
          swap_id: item.swap_id || null,
          product_id: item.product_id || null,
        }}
      />
    </div>
  );
}
