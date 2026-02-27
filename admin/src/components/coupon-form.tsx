'use client';

import { useState, useEffect, useCallback } from 'react';
import { useRouter } from 'next/navigation';
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

const DISCOUNT_TYPES = ['percent', 'fixed', 'free_shipping', 'bogo', 'other'] as const;
const REDEMPTION_TYPES = ['online', 'in_store', 'both', 'ibotta'] as const;

interface SwapOption {
  id: string;
  name: string;
  brand: string;
  category: string;
  score: number;
}

interface CouponData {
  id?: string;
  brand_name: string;
  title: string;
  description: string;
  coupon_code: string;
  discount_type: string;
  discount_value: number | null;
  category: string;
  product_id: string | null;
  redemption_url: string;
  ibotta_url: string;
  badge_text: string;
  starts_at: string;
  expires_at: string;
  max_redemptions: number | null;
  per_user_limit: number | null;
  is_active: boolean;
  sort_order: number;
  redemption_type: string;
  barcode_image_url: string;
  store_name: string;
}

const emptyCoupon: CouponData = {
  brand_name: '',
  title: '',
  description: '',
  coupon_code: '',
  discount_type: 'percent',
  discount_value: null,
  category: 'food',
  product_id: null,
  redemption_url: '',
  ibotta_url: '',
  badge_text: 'PARTNER DEAL',
  starts_at: new Date().toISOString().slice(0, 16),
  expires_at: '',
  max_redemptions: null,
  per_user_limit: null,
  is_active: true,
  sort_order: 100,
  redemption_type: 'online',
  barcode_image_url: '',
  store_name: '',
};

interface Props {
  initialData?: CouponData;
  isEditing?: boolean;
}

export function CouponForm({ initialData, isEditing }: Props) {
  const router = useRouter();
  const [form, setForm] = useState<CouponData>(initialData || emptyCoupon);
  const [saving, setSaving] = useState(false);
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Swap search state
  const [swapSearch, setSwapSearch] = useState('');
  const [swapResults, setSwapResults] = useState<SwapOption[]>([]);
  const [selectedSwap, setSelectedSwap] = useState<SwapOption | null>(null);
  const [searchingSwaps, setSearchingSwaps] = useState(false);
  const [showSwapDropdown, setShowSwapDropdown] = useState(false);

  // Load linked swap on mount if editing
  useEffect(() => {
    if (initialData?.product_id) {
      const supabase = createClient();
      supabase
        .from('swaps')
        .select('id, name, brand, category, score')
        .eq('id', initialData.product_id)
        .single()
        .then(({ data }) => {
          if (data) {
            setSelectedSwap(data as SwapOption);
            setSwapSearch(`${data.name} (${data.brand})`);
          }
        });
    }
  }, [initialData?.product_id]);

  const searchSwaps = useCallback(async (query: string) => {
    if (query.length < 2) {
      setSwapResults([]);
      setShowSwapDropdown(false);
      return;
    }
    setSearchingSwaps(true);
    const supabase = createClient();
    const { data } = await supabase
      .from('swaps')
      .select('id, name, brand, category, score')
      .or(`name.ilike.%${query}%,brand.ilike.%${query}%`)
      .eq('is_active', true)
      .order('score', { ascending: false })
      .limit(10);

    setSwapResults((data as SwapOption[]) || []);
    setShowSwapDropdown(true);
    setSearchingSwaps(false);
  }, []);

  // Debounced swap search
  useEffect(() => {
    const timer = setTimeout(() => {
      if (swapSearch && !selectedSwap) {
        searchSwaps(swapSearch);
      }
    }, 300);
    return () => clearTimeout(timer);
  }, [swapSearch, selectedSwap, searchSwaps]);

  const update = (field: keyof CouponData, value: CouponData[keyof CouponData]) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const handleSelectSwap = (swap: SwapOption) => {
    setSelectedSwap(swap);
    setSwapSearch(`${swap.name} (${swap.brand})`);
    setShowSwapDropdown(false);
    update('product_id', swap.id);
    // Auto-fill brand and category from swap if empty
    if (!form.brand_name) update('brand_name', swap.brand);
    if (form.category === 'food') {
      const mapped = swap.category.replace(/ /g, '_').toLowerCase();
      if (CATEGORIES.includes(mapped)) update('category', mapped);
    }
  };

  const handleClearSwap = () => {
    setSelectedSwap(null);
    setSwapSearch('');
    update('product_id', null);
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!form.brand_name.trim() || !form.title.trim() || !form.coupon_code.trim()) {
      setError('Brand name, title, and coupon code are required.');
      return;
    }

    setSaving(true);
    const supabase = createClient();

    const payload = {
      brand_name: form.brand_name.trim(),
      title: form.title.trim(),
      description: form.description.trim() || null,
      coupon_code: form.coupon_code.trim(),
      discount_type: form.discount_type || null,
      discount_value: form.discount_value,
      category: form.category,
      product_id: form.product_id || null,
      redemption_url: form.redemption_url.trim() || null,
      ibotta_url: form.ibotta_url.trim() || null,
      badge_text: form.badge_text.trim() || 'PARTNER DEAL',
      starts_at: form.starts_at ? new Date(form.starts_at).toISOString() : new Date().toISOString(),
      expires_at: form.expires_at ? new Date(form.expires_at).toISOString() : null,
      max_redemptions: form.max_redemptions,
      per_user_limit: form.per_user_limit,
      is_active: form.is_active,
      sort_order: form.sort_order,
      redemption_type: form.redemption_type,
      barcode_image_url: form.barcode_image_url.trim() || null,
      store_name: form.store_name.trim() || null,
    };

    let result;
    if (isEditing && form.id) {
      result = await supabase.from('coupons').update(payload).eq('id', form.id);
    } else {
      result = await supabase.from('coupons').insert(payload);
    }

    if (result.error) {
      setError(result.error.message);
      setSaving(false);
      return;
    }

    router.push('/dashboard/coupons');
    router.refresh();
  };

  const handleDelete = async () => {
    if (!form.id) return;
    if (!confirm('Are you sure you want to delete this coupon? This action cannot be undone.')) return;

    setDeleting(true);
    const supabase = createClient();
    const { error } = await supabase.from('coupons').delete().eq('id', form.id);

    if (error) {
      setError(error.message);
      setDeleting(false);
      return;
    }

    router.push('/dashboard/coupons');
    router.refresh();
  };

  const scoreColor = (score: number) => {
    if (score >= 67) return 'text-emerald-600 bg-emerald-50';
    if (score >= 34) return 'text-amber-600 bg-amber-50';
    return 'text-red-600 bg-red-50';
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-8 max-w-3xl">
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm">
          {error}
        </div>
      )}

      {/* Basic Info */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Basic Info</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Brand Name *</label>
            <input
              type="text"
              value={form.brand_name}
              onChange={(e) => update('brand_name', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. Branch Basics"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Title *</label>
            <input
              type="text"
              value={form.title}
              onChange={(e) => update('title', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. 20% off first order"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Coupon Code *</label>
            <input
              type="text"
              value={form.coupon_code}
              onChange={(e) => update('coupon_code', e.target.value.toUpperCase())}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500 font-mono"
              placeholder="e.g. NONTOXIC20"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Category</label>
            <select
              value={form.category}
              onChange={(e) => update('category', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
            >
              {CATEGORIES.map((cat) => (
                <option key={cat} value={cat}>{cat.replace(/_/g, ' ')}</option>
              ))}
            </select>
          </div>
        </div>
        <div className="mt-4">
          <label className="block text-sm font-medium text-gray-700 mb-1">Description</label>
          <textarea
            value={form.description}
            onChange={(e) => update('description', e.target.value)}
            rows={3}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            placeholder="Brief description of the deal..."
          />
        </div>
      </section>

      {/* Link to Product */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-1">Link to Product</h2>
        <p className="text-sm text-gray-500 mb-4">Link this coupon to a safe swap product so it appears on that product&#39;s detail page.</p>
        <div className="relative">
          <label className="block text-sm font-medium text-gray-700 mb-1">Search Swaps</label>
          <div className="flex gap-2">
            <div className="relative flex-1">
              <input
                type="text"
                value={swapSearch}
                onChange={(e) => {
                  setSwapSearch(e.target.value);
                  if (selectedSwap) {
                    setSelectedSwap(null);
                    update('product_id', null);
                  }
                }}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
                placeholder="Type to search products by name or brand..."
              />
              {searchingSwaps && (
                <div className="absolute right-3 top-2.5">
                  <div className="w-4 h-4 border-2 border-sky-500 border-t-transparent rounded-full animate-spin" />
                </div>
              )}
              {showSwapDropdown && swapResults.length > 0 && (
                <div className="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                  {swapResults.map((swap) => (
                    <button
                      key={swap.id}
                      type="button"
                      onClick={() => handleSelectSwap(swap)}
                      className="w-full px-3 py-2 text-left hover:bg-gray-50 flex items-center justify-between text-sm border-b border-gray-50 last:border-0"
                    >
                      <div>
                        <span className="font-medium text-gray-900">{swap.name}</span>
                        <span className="text-gray-500 ml-2">{swap.brand}</span>
                        <span className="text-gray-400 ml-2 text-xs">{swap.category}</span>
                      </div>
                      <span className={`text-xs font-bold px-2 py-0.5 rounded-full ${scoreColor(swap.score)}`}>
                        {swap.score}
                      </span>
                    </button>
                  ))}
                </div>
              )}
              {showSwapDropdown && swapResults.length === 0 && swapSearch.length >= 2 && !searchingSwaps && (
                <div className="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg p-3 text-sm text-gray-500">
                  No products found matching &quot;{swapSearch}&quot;
                </div>
              )}
            </div>
            {selectedSwap && (
              <button
                type="button"
                onClick={handleClearSwap}
                className="px-3 py-2 border border-gray-300 rounded-lg text-sm text-gray-600 hover:bg-gray-50"
              >
                Clear
              </button>
            )}
          </div>
          {selectedSwap && (
            <div className="mt-2 flex items-center gap-2 bg-sky-50 border border-sky-200 rounded-lg px-3 py-2">
              <svg className="w-4 h-4 text-sky-600 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13.828 10.172a4 4 0 00-5.656 0l-4 4a4 4 0 105.656 5.656l1.102-1.101m-.758-4.899a4 4 0 005.656 0l4-4a4 4 0 00-5.656-5.656l-1.1 1.1" />
              </svg>
              <span className="text-sm text-sky-800">
                Linked to: <strong>{selectedSwap.name}</strong> by {selectedSwap.brand} (score: {selectedSwap.score})
              </span>
            </div>
          )}
        </div>
      </section>

      {/* Discount Details */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Discount Details</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Discount Type</label>
            <select
              value={form.discount_type}
              onChange={(e) => update('discount_type', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
            >
              {DISCOUNT_TYPES.map((type) => (
                <option key={type} value={type}>
                  {type === 'free_shipping' ? 'Free Shipping' : type === 'bogo' ? 'BOGO' : type.charAt(0).toUpperCase() + type.slice(1)}
                </option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Discount Value</label>
            <input
              type="number"
              min={0}
              step={0.01}
              value={form.discount_value ?? ''}
              onChange={(e) => update('discount_value', e.target.value ? parseFloat(e.target.value) : null)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder={form.discount_type === 'percent' ? 'e.g. 20 (for 20%)' : form.discount_type === 'fixed' ? 'e.g. 1000 (for $10.00)' : 'Optional'}
            />
            {form.discount_type === 'fixed' && (
              <p className="text-xs text-gray-400 mt-1">Enter value in cents (e.g. 1000 = $10.00)</p>
            )}
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Badge Text</label>
            <input
              type="text"
              value={form.badge_text}
              onChange={(e) => update('badge_text', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. PARTNER DEAL"
            />
          </div>
        </div>
        <div className="mt-4">
          <label className="block text-sm font-medium text-gray-700 mb-1">Redemption URL</label>
          <input
            type="url"
            value={form.redemption_url}
            onChange={(e) => update('redemption_url', e.target.value)}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            placeholder="https://..."
          />
        </div>
      </section>

      {/* Redemption Limits */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-1">Redemption Limits</h2>
        <p className="text-sm text-gray-500 mb-4">Control how many times this coupon can be used globally and per user.</p>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Global Max Redemptions</label>
            <input
              type="number"
              min={0}
              value={form.max_redemptions ?? ''}
              onChange={(e) => update('max_redemptions', e.target.value ? parseInt(e.target.value) : null)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="Leave empty for unlimited"
            />
            <p className="text-xs text-gray-400 mt-1">Total across all users. Empty = unlimited.</p>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Per-User Limit</label>
            <input
              type="number"
              min={1}
              value={form.per_user_limit ?? ''}
              onChange={(e) => update('per_user_limit', e.target.value ? parseInt(e.target.value) : null)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="Leave empty for unlimited"
            />
            <p className="text-xs text-gray-400 mt-1">How many times each user can redeem. Empty = unlimited.</p>
          </div>
        </div>
      </section>

      {/* Display & Redemption Settings */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Display & Redemption</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Sort Order (Priority)</label>
            <input
              type="number"
              min={0}
              value={form.sort_order}
              onChange={(e) => update('sort_order', parseInt(e.target.value) || 100)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            />
            <p className="text-xs text-gray-400 mt-1">Lower numbers appear first. Default is 100.</p>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Redemption Type</label>
            <select
              value={form.redemption_type}
              onChange={(e) => update('redemption_type', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
            >
              {REDEMPTION_TYPES.map((type) => (
                <option key={type} value={type}>
                  {type === 'online' ? 'Online Only' :
                   type === 'in_store' ? 'In-Store Only' :
                   type === 'ibotta' ? 'Ibotta / Cashback' :
                   'Both (Online + In-Store)'}
                </option>
              ))}
            </select>
          </div>
        </div>

        {/* Ibotta fields */}
        {form.redemption_type === 'ibotta' && (
          <div className="mt-4 pt-4 border-t border-gray-100">
            <div className="flex items-start gap-2 mb-3 bg-orange-50 border border-orange-200 rounded-lg px-3 py-2">
              <svg className="w-4 h-4 text-orange-600 mt-0.5 shrink-0" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
              <p className="text-xs text-orange-800">
                Ibotta deals link users to the Ibotta app or website where they can get cashback after purchasing in-store. You don&#39;t handle money — Ibotta does.
              </p>
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Ibotta Link</label>
              <input
                type="url"
                value={form.ibotta_url}
                onChange={(e) => update('ibotta_url', e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
                placeholder="https://ibotta.com/... or Ibotta deep link"
              />
              <p className="text-xs text-gray-400 mt-1">Direct link to this offer on Ibotta. Users tap to open Ibotta and activate the cashback.</p>
            </div>
          </div>
        )}

        {/* In-store fields */}
        {(form.redemption_type === 'in_store' || form.redemption_type === 'both') && (
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4 pt-4 border-t border-gray-100">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Store Name</label>
              <input
                type="text"
                value={form.store_name}
                onChange={(e) => update('store_name', e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
                placeholder="e.g. Target, Whole Foods"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Barcode Image URL</label>
              <input
                type="url"
                value={form.barcode_image_url}
                onChange={(e) => update('barcode_image_url', e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
                placeholder="https://... (optional barcode/QR image)"
              />
            </div>
          </div>
        )}
      </section>

      {/* Validity Period */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Validity Period</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Starts At</label>
            <input
              type="datetime-local"
              value={form.starts_at}
              onChange={(e) => update('starts_at', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Expires At</label>
            <input
              type="datetime-local"
              value={form.expires_at}
              onChange={(e) => update('expires_at', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            />
            <p className="text-xs text-gray-400 mt-1">Leave empty for no expiration</p>
          </div>
        </div>
        <div className="mt-4">
          <label className="flex items-center gap-2 cursor-pointer">
            <input
              type="checkbox"
              checked={form.is_active}
              onChange={(e) => update('is_active', e.target.checked)}
              className="w-4 h-4 rounded border-gray-300 text-sky-600 focus:ring-sky-500"
            />
            <span className="text-sm text-gray-700">Active (visible to users)</span>
          </label>
        </div>
      </section>

      {/* Actions */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-3">
          <button
            type="submit"
            disabled={saving}
            className="px-6 py-2.5 bg-sky-600 text-white rounded-lg text-sm font-medium hover:bg-sky-700 transition-colors disabled:opacity-50"
          >
            {saving ? 'Saving...' : isEditing ? 'Update Coupon' : 'Create Coupon'}
          </button>
          <button
            type="button"
            onClick={() => router.push('/dashboard/coupons')}
            className="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg text-sm font-medium hover:bg-gray-50 transition-colors"
          >
            Cancel
          </button>
        </div>
        {isEditing && (
          <button
            type="button"
            onClick={handleDelete}
            disabled={deleting}
            className="px-6 py-2.5 bg-red-600 text-white rounded-lg text-sm font-medium hover:bg-red-700 transition-colors disabled:opacity-50"
          >
            {deleting ? 'Deleting...' : 'Delete Coupon'}
          </button>
        )}
      </div>
    </form>
  );
}
