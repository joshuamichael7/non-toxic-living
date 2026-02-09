import { createServiceClient } from '@/lib/supabase/server';
import { CouponsTable } from '@/components/coupons-table';

export default async function CouponsPage({
  searchParams,
}: {
  searchParams: Promise<{ page?: string; search?: string; category?: string; active?: string }>;
}) {
  const params = await searchParams;
  const page = parseInt(params.page || '1');
  const search = params.search || '';
  const category = params.category || '';
  const activeFilter = params.active || '';
  const pageSize = 25;
  const offset = (page - 1) * pageSize;

  const supabase = await createServiceClient();

  let query = supabase
    .from('coupons')
    .select('id, brand_name, title, coupon_code, category, discount_type, discount_value, is_active, expires_at, created_at, impressions, clicks, redemption_type', { count: 'exact' })
    .order('sort_order', { ascending: true })
    .range(offset, offset + pageSize - 1);

  if (search) {
    query = query.or(`brand_name.ilike.%${search}%,title.ilike.%${search}%,coupon_code.ilike.%${search}%`);
  }
  if (category) {
    query = query.eq('category', category);
  }
  if (activeFilter === 'true') {
    query = query.eq('is_active', true);
  } else if (activeFilter === 'false') {
    query = query.eq('is_active', false);
  }

  const { data: coupons, count, error } = await query;

  if (error) {
    return <div className="text-red-500">Error loading coupons: {error.message}</div>;
  }

  const totalPages = Math.ceil((count || 0) / pageSize);

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Coupons</h1>
          <p className="text-sm text-gray-500 mt-1">{count?.toLocaleString()} coupons in database</p>
        </div>
        <a
          href="/dashboard/coupons/new"
          className="inline-flex items-center gap-2 px-4 py-2 bg-sky-600 text-white rounded-lg text-sm font-medium hover:bg-sky-700 transition-colors"
        >
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
          </svg>
          Add Coupon
        </a>
      </div>

      <CouponsTable
        coupons={coupons || []}
        totalPages={totalPages}
        currentPage={page}
        search={search}
        category={category}
        activeFilter={activeFilter}
      />
    </div>
  );
}
