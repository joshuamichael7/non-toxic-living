import { createServiceClient } from '@/lib/supabase/server';
import { FeaturedTable } from '@/components/featured-table';

export default async function FeaturedPage({
  searchParams,
}: {
  searchParams: Promise<{ page?: string; search?: string; type?: string; active?: string }>;
}) {
  const params = await searchParams;
  const page = parseInt(params.page || '1');
  const search = params.search || '';
  const typeFilter = params.type || '';
  const activeFilter = params.active || '';
  const pageSize = 25;
  const offset = (page - 1) * pageSize;

  const supabase = await createServiceClient();

  let query = supabase
    .from('featured_items')
    .select('id, type, brand_name, title, badge_text, is_active, expires_at, created_at, impressions, clicks', { count: 'exact' })
    .order('sort_order', { ascending: true })
    .range(offset, offset + pageSize - 1);

  if (search) {
    query = query.or(`brand_name.ilike.%${search}%,title.ilike.%${search}%`);
  }
  if (typeFilter) {
    query = query.eq('type', typeFilter);
  }
  if (activeFilter === 'true') {
    query = query.eq('is_active', true);
  } else if (activeFilter === 'false') {
    query = query.eq('is_active', false);
  }

  const { data: items, count, error } = await query;

  if (error) {
    return <div className="text-red-500">Error loading featured items: {error.message}</div>;
  }

  const totalPages = Math.ceil((count || 0) / pageSize);

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Featured</h1>
          <p className="text-sm text-gray-500 mt-1">{count?.toLocaleString()} items in database</p>
        </div>
        <a
          href="/dashboard/featured/new"
          className="inline-flex items-center gap-2 px-4 py-2 bg-sky-600 text-white rounded-lg text-sm font-medium hover:bg-sky-700 transition-colors"
        >
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M12 4v16m8-8H4" />
          </svg>
          Add Item
        </a>
      </div>

      <FeaturedTable
        items={items || []}
        totalPages={totalPages}
        currentPage={page}
        search={search}
        typeFilter={typeFilter}
        activeFilter={activeFilter}
      />
    </div>
  );
}
