import { createServiceClient } from '@/lib/supabase/server';
import { SwapForm } from '@/components/swap-form';

export default async function NewSwapPage() {
  const supabase = await createServiceClient();
  const { data: subcategoryRows } = await supabase
    .from('subcategories')
    .select('name, category')
    .order('name');

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Add Affiliate Product</h1>
        <p className="text-sm text-gray-500 mt-1">Create a new swap recommendation with affiliate link</p>
      </div>
      <SwapForm subcategories={subcategoryRows || []} />
    </div>
  );
}
