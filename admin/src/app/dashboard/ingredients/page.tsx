import { createServiceClient } from '@/lib/supabase/server';
import { IngredientsTable } from '@/components/ingredients-table';

export default async function IngredientsPage({
  searchParams,
}: {
  searchParams: Promise<{ page?: string; search?: string; category?: string }>;
}) {
  const params = await searchParams;
  const page = parseInt(params.page || '1');
  const search = params.search || '';
  const category = params.category || '';
  const pageSize = 25;
  const offset = (page - 1) * pageSize;

  const supabase = await createServiceClient();

  let query = supabase
    .from('ingredients')
    .select('id, name, slug, aliases, category, toxicity_score, concerns, safe_alternatives, sources, last_reviewed_at, updated_at', { count: 'exact' })
    .order('name')
    .range(offset, offset + pageSize - 1);

  if (search) {
    query = query.or(`name.ilike.%${search}%,slug.ilike.%${search}%`);
  }
  if (category) {
    query = query.eq('category', category);
  }

  const { data: ingredients, count, error } = await query;

  if (error) {
    return <div className="text-red-500">Error loading ingredients: {error.message}</div>;
  }

  const totalPages = Math.ceil((count || 0) / pageSize);

  return (
    <div>
      <div className="flex items-center justify-between mb-6">
        <div>
          <h1 className="text-2xl font-bold text-gray-900">Ingredients</h1>
          <p className="text-sm text-gray-500 mt-1">{count?.toLocaleString()} ingredients in database</p>
        </div>
      </div>

      <IngredientsTable
        ingredients={ingredients || []}
        totalPages={totalPages}
        currentPage={page}
        search={search}
        category={category}
      />
    </div>
  );
}
