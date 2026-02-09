'use client';

import { useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

const CATEGORIES = [
  'food', 'beverage', 'snack', 'condiment', 'dairy', 'baby_food',
  'personal_care', 'skincare', 'sunscreen', 'haircare', 'oral_care', 'deodorant', 'soap',
  'makeup', 'nail_care',
  'cleaning', 'laundry', 'fragrance',
  'cookware', 'storage', 'supplement',
  'baby', 'toys',
  'household', 'furniture', 'mattress', 'paint', 'garden',
  'pet', 'clothing', 'other',
];

interface Swap {
  id: string;
  name: string;
  brand: string;
  category: string;
  score: number;
  price_cents: number | null;
  is_active: boolean;
  featured: boolean;
  affiliate_url: string | null;
  affiliate_source: string | null;
  available_stores: string[];
  created_at: string;
}

interface Props {
  swaps: Swap[];
  totalPages: number;
  currentPage: number;
  search: string;
  category: string;
  activeFilter: string;
}

export function SwapsTable({ swaps, totalPages, currentPage, search, category, activeFilter }: Props) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [searchInput, setSearchInput] = useState(search);
  const [togglingId, setTogglingId] = useState<string | null>(null);
  const [blockingId, setBlockingId] = useState<string | null>(null);

  const updateUrl = (params: Record<string, string>) => {
    const sp = new URLSearchParams(searchParams.toString());
    Object.entries(params).forEach(([key, value]) => {
      if (value) sp.set(key, value);
      else sp.delete(key);
    });
    router.push(`/dashboard/swaps?${sp.toString()}`);
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    updateUrl({ search: searchInput, page: '' });
  };

  const toggleActive = async (id: string, currentActive: boolean) => {
    setTogglingId(id);
    const supabase = createClient();
    await supabase.from('swaps').update({ is_active: !currentActive }).eq('id', id);
    setTogglingId(null);
    router.refresh();
  };

  const blockProduct = async (swap: Swap) => {
    if (!confirm(`Block "${swap.name}"? This will deactivate it and add it to the blocklist so the AI never recommends it.`)) return;
    setBlockingId(swap.id);
    const supabase = createClient();
    // Deactivate the swap
    await supabase.from('swaps').update({ is_active: false }).eq('id', swap.id);
    // Add to blocked_products
    await supabase.from('blocked_products').insert({
      name: swap.name,
      brand: swap.brand || null,
      reason: `Blocked from swaps list`,
    });
    setBlockingId(null);
    router.refresh();
  };

  const scoreColor = (score: number) => {
    if (score >= 67) return 'bg-emerald-100 text-emerald-800';
    if (score >= 34) return 'bg-amber-100 text-amber-800';
    return 'bg-red-100 text-red-800';
  };

  const formatPrice = (cents: number | null) => {
    if (cents === null || cents === 0) return null;
    return `$${(cents / 100).toFixed(2)}`;
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
            placeholder="Search products..."
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
            <option key={cat} value={cat}>{cat.replace(/_/g, ' ')}</option>
          ))}
        </select>
        <select
          value={activeFilter}
          onChange={(e) => updateUrl({ active: e.target.value, page: '' })}
          className="px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
        >
          <option value="">All Status</option>
          <option value="true">Active</option>
          <option value="false">Inactive</option>
        </select>
      </div>

      {/* Table */}
      <div className="overflow-x-auto">
        <table className="w-full">
          <thead>
            <tr className="border-b border-gray-100">
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Product</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
              <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Score</th>
              <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Ref. Price</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Affiliate Link</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Stores</th>
              <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Active</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {swaps.length === 0 && (
              <tr>
                <td colSpan={8} className="px-4 py-12 text-center text-gray-400 text-sm">
                  No swaps found. Add your first affiliate product!
                </td>
              </tr>
            )}
            {swaps.map((swap) => (
              <tr key={swap.id} className="hover:bg-gray-50 transition-colors">
                <td className="px-4 py-3">
                  <div className="text-sm font-medium text-gray-900">{swap.name}</div>
                  <div className="text-xs text-gray-400">{swap.brand}</div>
                </td>
                <td className="px-4 py-3">
                  <span className="inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-700">
                    {swap.category.replace(/_/g, ' ')}
                  </span>
                </td>
                <td className="px-4 py-3 text-center">
                  <span className={`inline-flex px-2.5 py-1 rounded-full text-xs font-bold ${scoreColor(swap.score)}`}>
                    {swap.score}
                  </span>
                </td>
                <td className="px-4 py-3 text-center text-sm text-gray-400">
                  {formatPrice(swap.price_cents) || '—'}
                </td>
                <td className="px-4 py-3">
                  {swap.affiliate_url ? (
                    <div className="flex items-center gap-1.5">
                      <span className="inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-violet-50 text-violet-700">
                        {swap.affiliate_source || 'link'}
                      </span>
                      <a
                        href={swap.affiliate_url}
                        target="_blank"
                        rel="noopener noreferrer"
                        className="text-sky-500 hover:text-sky-700"
                        title={swap.affiliate_url}
                      >
                        <svg className="w-3.5 h-3.5" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                          <path strokeLinecap="round" strokeLinejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                        </svg>
                      </a>
                    </div>
                  ) : (
                    <a
                      href={`/dashboard/swaps/${swap.id}`}
                      className="text-xs text-amber-500 hover:text-amber-700"
                    >
                      Add link
                    </a>
                  )}
                </td>
                <td className="px-4 py-3">
                  <div className="flex flex-wrap gap-1 max-w-[150px]">
                    {swap.available_stores.slice(0, 2).map((store, i) => (
                      <span key={i} className="inline-flex px-1.5 py-0.5 rounded text-xs bg-sky-50 text-sky-600 truncate max-w-[70px]">
                        {store}
                      </span>
                    ))}
                    {swap.available_stores.length > 2 && (
                      <span className="text-xs text-gray-400">+{swap.available_stores.length - 2}</span>
                    )}
                  </div>
                </td>
                <td className="px-4 py-3 text-center">
                  <button
                    onClick={() => toggleActive(swap.id, swap.is_active)}
                    disabled={togglingId === swap.id}
                    className={`relative inline-flex h-5 w-9 items-center rounded-full transition-colors ${
                      swap.is_active ? 'bg-emerald-500' : 'bg-gray-300'
                    }`}
                  >
                    <span
                      className={`inline-block h-3.5 w-3.5 transform rounded-full bg-white transition-transform ${
                        swap.is_active ? 'translate-x-4.5' : 'translate-x-0.5'
                      }`}
                    />
                  </button>
                </td>
                <td className="px-4 py-3 text-right">
                  <div className="flex items-center justify-end gap-3">
                    <a
                      href={`/dashboard/swaps/${swap.id}`}
                      className="text-sky-600 hover:text-sky-800 text-xs font-medium"
                    >
                      Edit
                    </a>
                    <a
                      href={`/dashboard/featured/new?swap_id=${swap.id}`}
                      className="text-violet-600 hover:text-violet-800 text-xs font-medium"
                    >
                      Create Deal
                    </a>
                    <button
                      onClick={() => blockProduct(swap)}
                      disabled={blockingId === swap.id}
                      className="text-red-400 hover:text-red-600 text-xs font-medium"
                    >
                      {blockingId === swap.id ? '...' : 'Block'}
                    </button>
                  </div>
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
