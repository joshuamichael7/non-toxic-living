import { createServiceClient } from '@/lib/supabase/server';
import { BlockedProductsTable } from '@/components/blocked-products-table';

export default async function BlockedProductsPage() {
  const supabase = await createServiceClient();

  const { data: blockedProducts, error } = await supabase
    .from('blocked_products')
    .select('*')
    .order('created_at', { ascending: false });

  if (error) {
    return <div className="text-red-500">Error loading blocked products: {error.message}</div>;
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Blocked Products</h1>
          <p className="text-sm text-gray-500 mt-1">
            Products the AI will never recommend. {blockedProducts?.length || 0} blocked.
          </p>
        </div>
      </div>

      <BlockedProductsTable products={blockedProducts || []} />
    </div>
  );
}
