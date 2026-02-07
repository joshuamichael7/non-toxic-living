import { createServiceClient } from '@/lib/supabase/server';
import { notFound } from 'next/navigation';
import { IngredientForm } from '@/components/ingredient-form';

export default async function EditIngredientPage({
  params,
}: {
  params: Promise<{ id: string }>;
}) {
  const { id } = await params;
  const supabase = await createServiceClient();

  const { data: ingredient, error } = await supabase
    .from('ingredients')
    .select('*')
    .eq('id', id)
    .single();

  if (error || !ingredient) {
    notFound();
  }

  return (
    <div>
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-900">Edit Ingredient</h1>
        <p className="text-sm text-gray-500 mt-1">{ingredient.name}</p>
      </div>
      <IngredientForm
        initialData={{
          id: ingredient.id,
          name: ingredient.name,
          slug: ingredient.slug,
          aliases: ingredient.aliases || [],
          category: ingredient.category,
          toxicity_score: ingredient.toxicity_score,
          concerns: ingredient.concerns || [],
          safe_alternatives: ingredient.safe_alternatives || [],
          commonly_found_in: ingredient.commonly_found_in || [],
          sources: ingredient.sources || [],
        }}
      />
    </div>
  );
}
