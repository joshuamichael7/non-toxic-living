import { createServiceClient } from '@/lib/supabase/server';

export default async function DashboardPage() {
  const supabase = await createServiceClient();

  const [
    { count: ingredientCount },
    { count: swapCount },
    { count: productCount },
    { count: scanCount },
  ] = await Promise.all([
    supabase.from('ingredients').select('*', { count: 'exact', head: true }),
    supabase.from('swaps').select('*', { count: 'exact', head: true }).eq('is_active', true),
    supabase.from('products').select('*', { count: 'exact', head: true }),
    supabase.from('scans').select('*', { count: 'exact', head: true }),
  ]);

  const stats = [
    { label: 'Ingredients', value: ingredientCount ?? 0, color: 'bg-emerald-50 text-emerald-700' },
    { label: 'Active Swaps', value: swapCount ?? 0, color: 'bg-sky-50 text-sky-700' },
    { label: 'Products Cached', value: productCount ?? 0, color: 'bg-violet-50 text-violet-700' },
    { label: 'Total Scans', value: scanCount ?? 0, color: 'bg-amber-50 text-amber-700' },
  ];

  return (
    <div>
      <h1 className="text-2xl font-bold text-gray-900 mb-6">Dashboard</h1>

      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4 mb-8">
        {stats.map((stat) => (
          <div key={stat.label} className="bg-white rounded-xl border border-gray-200 p-5">
            <p className="text-sm text-gray-500 mb-1">{stat.label}</p>
            <p className="text-3xl font-bold text-gray-900">{stat.value.toLocaleString()}</p>
          </div>
        ))}
      </div>

      <div className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Quick Actions</h2>
        <div className="flex flex-wrap gap-3">
          <a
            href="/dashboard/ingredients"
            className="inline-flex items-center gap-2 px-4 py-2 bg-emerald-50 text-emerald-700 rounded-lg text-sm font-medium hover:bg-emerald-100 transition-colors"
          >
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
              <path strokeLinecap="round" strokeLinejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
            </svg>
            Manage Ingredients
          </a>
          <a
            href="/dashboard/swaps/new"
            className="inline-flex items-center gap-2 px-4 py-2 bg-sky-50 text-sky-700 rounded-lg text-sm font-medium hover:bg-sky-100 transition-colors"
          >
            <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
              <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
            </svg>
            Add Affiliate Product
          </a>
        </div>
      </div>
    </div>
  );
}
