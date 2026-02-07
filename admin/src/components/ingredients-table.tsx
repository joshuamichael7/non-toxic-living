'use client';

import { useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

const CATEGORIES = [
  'additive', 'preservative', 'sweetener', 'color', 'flavor',
  'fragrance', 'surfactant', 'solvent', 'emulsifier',
  'pesticide', 'heavy_metal', 'plastic', 'other',
];

interface Ingredient {
  id: string;
  name: string;
  slug: string;
  aliases: string[];
  category: string;
  toxicity_score: number;
  concerns: string[];
  safe_alternatives: string[];
  sources: string[];
  last_reviewed_at: string | null;
  updated_at: string;
}

interface Props {
  ingredients: Ingredient[];
  totalPages: number;
  currentPage: number;
  search: string;
  category: string;
}

export function IngredientsTable({ ingredients, totalPages, currentPage, search, category }: Props) {
  const router = useRouter();
  const searchParams = useSearchParams();

  const [editingId, setEditingId] = useState<string | null>(null);
  const [editValue, setEditValue] = useState<number>(0);
  const [saving, setSaving] = useState(false);
  const [searchInput, setSearchInput] = useState(search);

  const updateUrl = (params: Record<string, string>) => {
    const sp = new URLSearchParams(searchParams.toString());
    Object.entries(params).forEach(([key, value]) => {
      if (value) sp.set(key, value);
      else sp.delete(key);
    });
    router.push(`/dashboard/ingredients?${sp.toString()}`);
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    updateUrl({ search: searchInput, page: '' });
  };

  const handleSaveScore = async (id: string) => {
    setSaving(true);
    const supabase = createClient();
    const { error } = await supabase
      .from('ingredients')
      .update({ toxicity_score: editValue })
      .eq('id', id);

    if (error) {
      alert(`Failed to save: ${error.message}`);
    }
    setSaving(false);
    setEditingId(null);
    router.refresh();
  };

  const scoreColor = (score: number) => {
    if (score <= 3) return 'bg-emerald-100 text-emerald-800';
    if (score <= 6) return 'bg-amber-100 text-amber-800';
    return 'bg-red-100 text-red-800';
  };

  return (
    <div className="bg-white rounded-xl border border-gray-200">
      {/* Filters */}
      <div className="p-4 border-b border-gray-100 flex gap-3 flex-wrap">
        <form onSubmit={handleSearch} className="flex gap-2 flex-1 min-w-[200px]">
          <input
            type="text"
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            placeholder="Search ingredients..."
            className="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          />
          <button type="submit" className="px-3 py-2 bg-gray-100 rounded-lg text-sm font-medium hover:bg-gray-200 transition-colors">
            Search
          </button>
        </form>
        <select
          value={category}
          onChange={(e) => updateUrl({ category: e.target.value, page: '' })}
          className="px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
        >
          <option value="">All Categories</option>
          {CATEGORIES.map((cat) => (
            <option key={cat} value={cat}>{cat.replace('_', ' ')}</option>
          ))}
        </select>
      </div>

      {/* Table */}
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead>
            <tr className="border-b border-gray-100">
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Name</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
              <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Toxicity</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Concerns</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Sources</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {ingredients.map((ing) => (
              <tr key={ing.id} className="hover:bg-gray-50 transition-colors">
                <td className="px-4 py-3">
                  <div className="text-sm font-medium text-gray-900">{ing.name}</div>
                  {ing.aliases.length > 0 && (
                    <div className="text-xs text-gray-400 mt-0.5 truncate max-w-xs">
                      {ing.aliases.slice(0, 3).join(', ')}
                      {ing.aliases.length > 3 && ` +${ing.aliases.length - 3}`}
                    </div>
                  )}
                </td>
                <td className="px-4 py-3">
                  <span className="inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-700">
                    {ing.category.replace('_', ' ')}
                  </span>
                </td>
                <td className="px-4 py-3 text-center">
                  {editingId === ing.id ? (
                    <div className="flex items-center justify-center gap-1">
                      <input
                        type="number"
                        min={1}
                        max={10}
                        value={editValue}
                        onChange={(e) => setEditValue(parseInt(e.target.value) || 1)}
                        className="w-14 px-2 py-1 border border-sky-300 rounded text-sm text-center focus:outline-none focus:ring-2 focus:ring-sky-500"
                        autoFocus
                        onKeyDown={(e) => {
                          if (e.key === 'Enter') handleSaveScore(ing.id);
                          if (e.key === 'Escape') setEditingId(null);
                        }}
                      />
                      <button
                        onClick={() => handleSaveScore(ing.id)}
                        disabled={saving}
                        className="text-sky-600 hover:text-sky-800 text-xs font-medium"
                      >
                        {saving ? '...' : 'Save'}
                      </button>
                    </div>
                  ) : (
                    <button
                      onClick={() => { setEditingId(ing.id); setEditValue(ing.toxicity_score); }}
                      className={`inline-flex px-2.5 py-1 rounded-full text-xs font-bold cursor-pointer hover:opacity-80 ${scoreColor(ing.toxicity_score)}`}
                      title="Click to edit"
                    >
                      {ing.toxicity_score}/10
                    </button>
                  )}
                </td>
                <td className="px-4 py-3">
                  <div className="flex flex-wrap gap-1 max-w-xs">
                    {ing.concerns.slice(0, 2).map((c, i) => (
                      <span key={i} className="inline-flex px-1.5 py-0.5 rounded text-xs bg-red-50 text-red-600 truncate max-w-[150px]">
                        {c}
                      </span>
                    ))}
                    {ing.concerns.length > 2 && (
                      <span className="text-xs text-gray-400">+{ing.concerns.length - 2}</span>
                    )}
                  </div>
                </td>
                <td className="px-4 py-3">
                  <span className="text-xs text-gray-400">{ing.sources.length} sources</span>
                </td>
                <td className="px-4 py-3 text-right">
                  <a
                    href={`/dashboard/ingredients/${ing.id}`}
                    className="text-sky-600 hover:text-sky-800 text-xs font-medium"
                  >
                    Edit
                  </a>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="p-4 border-t border-gray-100 flex items-center justify-between">
          <p className="text-sm text-gray-500">
            Page {currentPage} of {totalPages}
          </p>
          <div className="flex gap-2">
            <button
              onClick={() => updateUrl({ page: String(currentPage - 1) })}
              disabled={currentPage <= 1}
              className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Previous
            </button>
            <button
              onClick={() => updateUrl({ page: String(currentPage + 1) })}
              disabled={currentPage >= totalPages}
              className="px-3 py-1.5 text-sm border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
            >
              Next
            </button>
          </div>
        </div>
      )}
    </div>
  );
}
