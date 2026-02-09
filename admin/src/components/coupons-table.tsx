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

interface Coupon {
  id: string;
  brand_name: string;
  title: string;
  coupon_code: string;
  category: string;
  discount_type: string;
  discount_value: number | null;
  is_active: boolean;
  expires_at: string | null;
  created_at: string;
}

interface Props {
  coupons: Coupon[];
  totalPages: number;
  currentPage: number;
  search: string;
  category: string;
  activeFilter: string;
}

export function CouponsTable({ coupons, totalPages, currentPage, search, category, activeFilter }: Props) {
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
    router.push(`/dashboard/coupons?${sp.toString()}`);
  };

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    updateUrl({ search: searchInput, page: '' });
  };

  const toggleActive = async (id: string, currentActive: boolean) => {
    setTogglingId(id);
    const supabase = createClient();
    await supabase.from('coupons').update({ is_active: !currentActive }).eq('id', id);
    setTogglingId(null);
    router.refresh();
  };

  const formatDiscount = (type: string, value: number | null) => {
    if (!type || type === 'other') return 'Other';
    if (type === 'free_shipping') return 'Free Shipping';
    if (type === 'bogo') return 'BOGO';
    if (type === 'percent' && value) return `${value}% off`;
    if (type === 'fixed' && value) return `$${(value / 100).toFixed(2)} off`;
    return type;
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

  return (
    <div className="bg-white rounded-xl border border-gray-200">
      {/* Filters */}
      <div className="p-4 border-b border-gray-100 flex gap-3 flex-wrap">
        <form onSubmit={handleSearch} className="flex gap-2 flex-1 min-w-[200px]">
          <input
            type="text"
            value={searchInput}
            onChange={(e) => setSearchInput(e.target.value)}
            placeholder="Search coupons..."
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
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Brand</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Title</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Code</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Category</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Discount</th>
              <th className="text-center px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Active</th>
              <th className="text-left px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Expires</th>
              <th className="text-right px-4 py-3 text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
            </tr>
          </thead>
          <tbody className="divide-y divide-gray-50">
            {coupons.length === 0 && (
              <tr>
                <td colSpan={8} className="px-4 py-12 text-center text-gray-400 text-sm">
                  No coupons found. Add your first coupon!
                </td>
              </tr>
            )}
            {coupons.map((coupon) => (
              <tr key={coupon.id} className="hover:bg-gray-50 transition-colors">
                <td className="px-4 py-3">
                  <div className="text-sm font-medium text-gray-900">{coupon.brand_name}</div>
                </td>
                <td className="px-4 py-3">
                  <div className="text-sm text-gray-900">{coupon.title}</div>
                </td>
                <td className="px-4 py-3">
                  <code className="px-2 py-1 bg-gray-100 rounded text-xs font-mono text-gray-700">
                    {coupon.coupon_code}
                  </code>
                </td>
                <td className="px-4 py-3">
                  <span className="inline-flex px-2 py-0.5 rounded-full text-xs font-medium bg-gray-100 text-gray-700">
                    {coupon.category.replace(/_/g, ' ')}
                  </span>
                </td>
                <td className="px-4 py-3">
                  <span className="text-sm text-gray-600">
                    {formatDiscount(coupon.discount_type, coupon.discount_value)}
                  </span>
                </td>
                <td className="px-4 py-3 text-center">
                  <button
                    onClick={() => toggleActive(coupon.id, coupon.is_active)}
                    disabled={togglingId === coupon.id}
                    className={`relative inline-flex h-5 w-9 items-center rounded-full transition-colors ${
                      coupon.is_active ? 'bg-emerald-500' : 'bg-gray-300'
                    }`}
                  >
                    <span
                      className={`inline-block h-3.5 w-3.5 transform rounded-full bg-white transition-transform ${
                        coupon.is_active ? 'translate-x-4.5' : 'translate-x-0.5'
                      }`}
                    />
                  </button>
                </td>
                <td className="px-4 py-3">
                  <span className={`text-xs ${isExpired(coupon.expires_at) ? 'text-red-500' : 'text-gray-600'}`}>
                    {formatExpires(coupon.expires_at)}
                  </span>
                </td>
                <td className="px-4 py-3 text-right">
                  <a
                    href={`/dashboard/coupons/${coupon.id}`}
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
