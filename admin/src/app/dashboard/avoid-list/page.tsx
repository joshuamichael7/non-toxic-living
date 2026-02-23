import { createServiceClient } from '@/lib/supabase/server';
import { AvoidListTable } from '@/components/avoid-list-table';

export default async function AvoidListPage() {
  const supabase = await createServiceClient();

  const { data: avoidProducts, error } = await supabase
    .from('products')
    .select('id, name, brand, score, verdict, category, avoid_reason, created_at')
    .eq('on_avoid_list', true)
    .order('created_at', { ascending: false });

  if (error) {
    return <div className="text-red-500">Error loading avoid list: {error.message}</div>;
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Avoid List</h1>
          <p className="text-sm text-gray-500 mt-1">
            Products users should avoid. Shown to all app users. {avoidProducts?.length || 0} products.
          </p>
        </div>
      </div>

      <AvoidListTable products={avoidProducts || []} />
    </div>
  );
}
