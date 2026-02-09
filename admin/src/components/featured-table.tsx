'use client';

import { useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

const TYPES = ['coupon', 'product', 'sponsored'] as const;

interface FeaturedItem {
  id: string;
  type: string;
  brand_name: string | null;
  title: string;
  badge_text: string | null;
  is_active: boolean;
  expires_at: string | null;
  created_at: string;
  impressions: number;
  clicks: number;
}

interface Props {
  items: FeaturedItem[];
  totalPages: number;
  currentPage: number;
  search: string;
  typeFilter: string;
  activeFilter: string;
}

export function FeaturedTable({ items, totalPages, currentPage, search, typeFilter, activeFilter }: Props) {
  const router = useRouter();
  const searchParams = useSearchParams();
  const [searchInput, setSearchInput] = useState(search);
  const [togglingId, setTogglingId] = useState<string | null>(null);

  const updateUrl = (params: Record<string, string>) => {
    const sp = new URLSearchParams(searchParams.toString());
    Object.entries(params).forEach(([key, value]) => {
      if (value) sp.set(key, value);
      else sp.delete(key);
    });
    router.push(`/dashboard/featured?${sp.toString()}`);
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    updateUrl({ search: searchInput, page: '' });
  };

  const toggleActive = async (id: string, currentActive: boolean) => {
    setTogglingId(id);
    const supabase = createClient();
    await supabase.from('featured_items').update({ is_active: !currentActive }).eq('id', id);
    setTogglingId(null);
    router.refresh();
  };

  const formatExpires = (expiresAt: string | null) => {
    if (!expiresAt) return 'No expiration';
    const date = new Date(expiresAt);
    const now = new Date();
    const isExpired = date < now;
    const dateStr = date.toLocaleDateString();
    return isExpired ? `Expired ${dateStr}` : dateStr;
  };

  const isExpired = (expiresAt: string | null) => {
    if (!expiresAt) return false;
    return new Date(expiresAt) < new Date();
  };

  const typeBadge = (type: string) => {
    const styles: Record<string, string> = {
      coupon: 'bg-sky-50 text-sky-700',
      product: 'bg-emerald-50 text-emerald-700',
      sponsored: 'bg-violet-50 text-violet-700',
    };
    return styles[type] || 'bg-gray-50 text-gray-700';
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
            placeholder="Search featured items..."
            className="flex-1 px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          />
          <button type="submit" className="px-3 py-2 bg-gray-100 rounded-lg text-sm font-medium hover:bg-gray-200 transition-colors">
            Search
          </button>
        </form>
        <select
          value={typeFilter}
          onChange={(e) => updateUrl({ type: e.target.value, page: '' })}
          className="px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
        >
          <option value="">All Types</option>
          {TYPES.map((t) => (
            <option key={t} value={t}>{t.charAt(0).toUpperCase() + t.slice(1)}</option>
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
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Type</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Brand</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Title</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Badge</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Views</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Clicks</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">CTR</th>
              <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Active</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Expires</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {items.length === 0 && (
              <tr>
                <td colSpan={10} className="px-4 py-12 text-center text-gray-400 text-sm">
                  No featured items found. Add your first one!
                </td>
              </tr>
            )}
            {items.map((item) => (
              <tr key={item.id} className="hover:bg-gray-50 transition-colors">
                <td className="px-4 py-3">
                  <span className={`inline-flex px-2 py-0.5 rounded-full text-xs font-medium ${typeBadge(item.type)}`}>
                    {item.type}
                  </span>
                </td>
                <td className="px-4 py-3">
                  <div className="text-sm font-medium text-gray-900">{item.brand_name || '—'}</div>
                </td>
                <td className="px-4 py-3">
                  <div className="text-sm text-gray-900 max-w-[200px] truncate">{item.title}</div>
                </td>
                <td className="px-4 py-3">
                  <span className="text-xs text-gray-500">{item.badge_text || 'FEATURED'}</span>
                </td>
                <td className="px-4 py-3 text-right">
                  <span className="text-sm text-gray-600">{(item.impressions || 0).toLocaleString()}</span>
                </td>
                <td className="px-4 py-3 text-right">
                  <span className="text-sm text-gray-600">{(item.clicks || 0).toLocaleString()}</span>
                </td>
                <td className="px-4 py-3 text-right">
                  <span className="text-sm text-gray-600">
                    {item.impressions > 0 ? ((item.clicks / item.impressions) * 100).toFixed(1) + '%' : '—'}
                  </span>
                </td>
                <td className="px-4 py-3 text-center">
                  <button
                    onClick={() => toggleActive(item.id, item.is_active)}
                    disabled={togglingId === item.id}
                    className={`relative inline-flex h-5 w-9 items-center rounded-full transition-colors ${
                      item.is_active ? 'bg-emerald-500' : 'bg-gray-300'
                    }`}
                  >
                    <span
                      className={`inline-block h-3.5 w-3.5 transform rounded-full bg-white transition-transform ${
                        item.is_active ? 'translate-x-4.5' : 'translate-x-0.5'
                      }`}
                    />
                  </button>
                </td>
                <td className="px-4 py-3">
                  <span className={`text-xs ${isExpired(item.expires_at) ? 'text-red-500' : 'text-gray-600'}`}>
                    {formatExpires(item.expires_at)}
                  </span>
                </td>
                <td className="px-4 py-3 text-right">
                  <a
                    href={`/dashboard/featured/${item.id}`}
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
