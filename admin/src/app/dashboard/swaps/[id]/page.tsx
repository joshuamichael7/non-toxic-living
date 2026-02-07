import { createServiceClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import { SwapForm } from '@/components/swap-form';

export default async function EditSwapPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createServiceClient();

  const { data: swap, error } = await supabase
    .from('swaps')
    .select('*')
    .eq('id', id)
    .single();

  if (error || !swap) {
    notFound();
  }

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
    </div>
  );
}
