'use client';

import { useState, useEffect, useRef } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

interface AvoidProduct {
  id: string;
  name: string;
  brand: string | null;
  score: number | null;
  verdict: string | null;
  category: string | null;
  avoid_reason: string | null;
  created_at: string;
}

interface SearchResult {
  id: string;
  name: string;
  brand: string | null;
  score: number | null;
  category: string | null;
}

interface Props {
  products: AvoidProduct[];
}

const verdictColors: Record<string, string> = {
  safe: 'bg-emerald-100 text-emerald-700',
  caution: 'bg-amber-100 text-amber-700',
  toxic: 'bg-red-100 text-red-700',
};

export function AvoidListTable({ products }: Props) {
  const router = useRouter();
  const [showForm, setShowForm] = useState(false);
  const [searchQuery, setSearchQuery] = useState('');
  const [searchResults, setSearchResults] = useState<SearchResult[]>([]);
  const [selectedProduct, setSelectedProduct] = useState<SearchResult | null>(null);
  const [reason, setReason] = useState('');
  const [saving, setSaving] = useState(false);
  const [removingId, setRemovingId] = useState<string | null>(null);
  const [searching, setSearching] = useState(false);
  const searchTimeout = useRef<NodeJS.Timeout | null>(null);

  // Debounced product search
  useEffect(() => {
    if (searchTimeout.current) clearTimeout(searchTimeout.current);
    if (!searchQuery.trim() || selectedProduct) {
      setSearchResults([]);
      return;
    }

    searchTimeout.current = setTimeout(async () => {
      setSearching(true);
      const supabase = createClient();
      const { data } = await supabase
        .from('products')
        .select('id, name, brand, score, category')
        .eq('on_avoid_list', false)
        .ilike('name', `%${searchQuery.trim()}%`)
        .order('name')
        .limit(10);

      setSearchResults(data || []);
      setSearching(false);
    }, 300);

    return () => {
      if (searchTimeout.current) clearTimeout(searchTimeout.current);
    };
  }, [searchQuery, selectedProduct]);

  const handleAdd = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!selectedProduct || !reason.trim()) return;

    setSaving(true);
    const supabase = createClient();
    await supabase
      .from('products')
      .update({ on_avoid_list: true, avoid_reason: reason.trim() })
      .eq('id', selectedProduct.id);

    setSearchQuery('');
    setSelectedProduct(null);
    setReason('');
    setShowForm(false);
    setSaving(false);
    router.refresh();
  };

  const handleRemove = async (id: string) => {
    if (!confirm('Remove this product from the avoid list?')) return;
    setRemovingId(id);
    const supabase = createClient();
    await supabase
      .from('products')
      .update({ on_avoid_list: false, avoid_reason: null })
      .eq('id', id);
    setRemovingId(null);
    router.refresh();
  };

  const selectProduct = (product: SearchResult) => {
    setSelectedProduct(product);
    setSearchQuery(product.name + (product.brand ? ` (${product.brand})` : ''));
    setSearchResults([]);
  };

  return (
    <div className="space-y-4">
      {/* Add button / Form */}
      {showForm ? (
        <form onSubmit={handleAdd} className="bg-white rounded-xl border border-gray-200 p-6">
          <h3 className="text-sm font-semibold text-gray-900 mb-4">Add Product to Avoid List</h3>
          <div className="space-y-4 mb-4">
            {/* Product search */}
            <div className="relative">
              <label className="block text-xs font-medium text-gray-500 mb-1">Search Product *</label>
              <input
                type="text"
                value={searchQuery}
                onChange={(e) => {
                  setSearchQuery(e.target.value);
                  setSelectedProduct(null);
                }}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-500"
                placeholder="Start typing a product name..."
                autoFocus
              />
              {searching && (
                <div className="absolute right-3 top-8 text-xs text-gray-400">Searching...</div>
              )}
              {searchResults.length > 0 && (
                <div className="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                  {searchResults.map((p) => (
                    <button
                      key={p.id}
                      type="button"
                      onClick={() => selectProduct(p)}
                      className="w-full text-left px-4 py-3 hover:bg-gray-50 border-b border-gray-50 last:border-0"
                    >
                      <div className="text-sm font-medium text-gray-900">{p.name}</div>
                      <div className="text-xs text-gray-400">
                        {[p.brand, p.category, p.score != null ? `Score: ${p.score}` : null].filter(Boolean).join(' · ')}
                      </div>
                    </button>
                  ))}
                </div>
              )}
              {selectedProduct && (
                <div className="mt-2 inline-flex items-center gap-2 px-3 py-1.5 bg-amber-50 text-amber-700 rounded-lg text-xs font-medium">
                  Selected: {selectedProduct.name}
                  <button type="button" onClick={() => { setSelectedProduct(null); setSearchQuery(''); }} className="hover:text-amber-900">×</button>
                </div>
              )}
            </div>

            {/* Reason */}
            <div>
              <label className="block text-xs font-medium text-gray-500 mb-1">Reason *</label>
              <input
                type="text"
                value={reason}
                onChange={(e) => setReason(e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-amber-500"
                placeholder="e.g. Contains harmful artificial dyes and preservatives"
              />
            </div>
          </div>
          <div className="flex gap-2">
            <button
              type="submit"
              disabled={saving || !selectedProduct || !reason.trim()}
              className="px-4 py-2 bg-amber-600 text-white rounded-lg text-sm font-medium hover:bg-amber-700 transition-colors disabled:opacity-50"
            >
              {saving ? 'Adding...' : 'Add to Avoid List'}
            </button>
            <button
              type="button"
              onClick={() => { setShowForm(false); setSelectedProduct(null); setSearchQuery(''); setReason(''); }}
              className="px-4 py-2 border border-gray-300 text-gray-700 rounded-lg text-sm font-medium hover:bg-gray-50 transition-colors"
            >
              Cancel
            </button>
          </div>
        </form>
      ) : (
        <button
          onClick={() => setShowForm(true)}
          className="inline-flex items-center gap-2 px-4 py-2 bg-amber-50 text-amber-700 rounded-lg text-sm font-medium hover:bg-amber-100 transition-colors"
        >
          <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
          </svg>
          Add Product to Avoid List
        </button>
      )}

      {/* Table */}
      <div className="bg-white rounded-xl border border-gray-200">
        <div className="overflow-x-auto">
          <table className="w-full">
            <thead>
              <tr className="border-b border-gray-100">
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Product</th>
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Score</th>
                <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Reason</th>
                <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-gray-50">
              {products.length === 0 && (
                <tr>
                  <td colSpan={4} className="px-4 py-12 text-center text-gray-400 text-sm">
                    No products on the avoid list yet. Add products that users should stay away from.
                  </td>
                </tr>
              )}
              {products.map((p) => (
                <tr key={p.id} className="hover:bg-gray-50 transition-colors">
                  <td className="px-4 py-3">
                    <div className="text-sm font-medium text-gray-900">{p.name}</div>
                    {p.brand && <div className="text-xs text-gray-400">{p.brand}</div>}
                    {p.category && <div className="text-xs text-gray-300 mt-0.5">{p.category}</div>}
                  </td>
                  <td className="px-4 py-3">
                    {p.score != null && p.verdict ? (
                      <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-semibold ${verdictColors[p.verdict] || 'bg-gray-100 text-gray-600'}`}>
                        {p.score}
                      </span>
                    ) : (
                      <span className="text-xs text-gray-300">—</span>
                    )}
                  </td>
                  <td className="px-4 py-3">
                    <span className="text-sm text-gray-600">{p.avoid_reason || '—'}</span>
                  </td>
                  <td className="px-4 py-3 text-right">
                    <button
                      onClick={() => handleRemove(p.id)}
                      disabled={removingId === p.id}
                      className="text-red-500 hover:text-red-700 text-xs font-medium"
                    >
                      {removingId === p.id ? '...' : 'Remove'}
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}
