'use client';

import { useState } from 'react';
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

interface CouponData {
  id?: string;
  brand_name: string;
  title: string;
  description: string;
  coupon_code: string;
  discount_type: string;
  discount_value: number | null;
  category: string;
  redemption_url: string;
  badge_text: string;
  starts_at: string;
  expires_at: string;
  max_redemptions: number | null;
  is_active: boolean;
}

const emptyCoupon: CouponData = {
  brand_name: '',
  title: '',
  description: '',
  coupon_code: '',
  discount_type: 'percent',
  discount_value: null,
  category: 'food',
  redemption_url: '',
  badge_text: 'PARTNER DEAL',
  starts_at: new Date().toISOString().slice(0, 16),
  expires_at: '',
  max_redemptions: null,
  is_active: true,
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

  const update = (field: keyof CouponData, value: CouponData[keyof CouponData]) => {
    setForm((prev) => ({ ...prev, [field]: value }));
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
      redemption_url: form.redemption_url.trim() || null,
      badge_text: form.badge_text.trim() || 'PARTNER DEAL',
      starts_at: form.starts_at ? new Date(form.starts_at).toISOString() : new Date().toISOString(),
      expires_at: form.expires_at ? new Date(form.expires_at).toISOString() : null,
      max_redemptions: form.max_redemptions,
      is_active: form.is_active,
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
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Max Redemptions</label>
            <input
              type="number"
              min={0}
              value={form.max_redemptions ?? ''}
              onChange={(e) => update('max_redemptions', e.target.value ? parseInt(e.target.value) : null)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="Leave empty for unlimited"
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
