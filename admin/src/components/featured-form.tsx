'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

const ITEM_TYPES = ['coupon', 'product', 'sponsored'] as const;
const REDEMPTION_TYPES = ['online', 'in_store', 'both'] as const;

interface FeaturedData {
  id?: string;
  type: string;
  title: string;
  subtitle: string;
  brand_name: string;
  description: string;
  image_url: string;
  action_url: string;
  action_label: string;
  coupon_code: string;
  discount_text: string;
  badge_text: string;
  redemption_type: string;
  barcode_image_url: string;
  store_name: string;
  sort_order: number;
  starts_at: string;
  expires_at: string;
  is_active: boolean;
}

const emptyItem: FeaturedData = {
  type: 'product',
  title: '',
  subtitle: '',
  brand_name: '',
  description: '',
  image_url: '',
  action_url: '',
  action_label: '',
  coupon_code: '',
  discount_text: '',
  badge_text: 'FEATURED',
  redemption_type: 'online',
  barcode_image_url: '',
  store_name: '',
  sort_order: 100,
  starts_at: new Date().toISOString().slice(0, 16),
  expires_at: '',
  is_active: true,
};

interface Props {
  initialData?: FeaturedData;
  isEditing?: boolean;
}

export function FeaturedForm({ initialData, isEditing }: Props) {
  const router = useRouter();
  const [form, setForm] = useState<FeaturedData>(initialData || emptyItem);
  const [saving, setSaving] = useState(false);
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const update = (field: keyof FeaturedData, value: FeaturedData[keyof FeaturedData]) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const isCoupon = form.type === 'coupon';

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!form.title.trim()) {
      setError('Title is required.');
      return;
    }

    setSaving(true);
    const supabase = createClient();

    const payload = {
      type: form.type,
      title: form.title.trim(),
      subtitle: form.subtitle.trim() || null,
      brand_name: form.brand_name.trim() || null,
      description: form.description.trim() || null,
      image_url: form.image_url.trim() || null,
      action_url: form.action_url.trim() || null,
      action_label: form.action_label.trim() || null,
      coupon_code: form.coupon_code.trim() || null,
      discount_text: form.discount_text.trim() || null,
      badge_text: form.badge_text.trim() || 'FEATURED',
      redemption_type: form.redemption_type,
      barcode_image_url: form.barcode_image_url.trim() || null,
      store_name: form.store_name.trim() || null,
      sort_order: form.sort_order,
      starts_at: form.starts_at ? new Date(form.starts_at).toISOString() : new Date().toISOString(),
      expires_at: form.expires_at ? new Date(form.expires_at).toISOString() : null,
      is_active: form.is_active,
    };

    let result;
    if (isEditing && form.id) {
      result = await supabase.from('featured_items').update(payload).eq('id', form.id);
    } else {
      result = await supabase.from('featured_items').insert(payload);
    }

    if (result.error) {
      setError(result.error.message);
      setSaving(false);
      return;
    }

    router.push('/dashboard/featured');
    router.refresh();
  };

  const handleDelete = async () => {
    if (!form.id) return;
    if (!confirm('Are you sure you want to delete this item? This action cannot be undone.')) return;

    setDeleting(true);
    const supabase = createClient();
    const { error } = await supabase.from('featured_items').delete().eq('id', form.id);

    if (error) {
      setError(error.message);
      setDeleting(false);
      return;
    }

    router.push('/dashboard/featured');
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
            <label className="block text-sm font-medium text-gray-700 mb-1">Type *</label>
            <select
              value={form.type}
              onChange={(e) => update('type', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
            >
              {ITEM_TYPES.map((t) => (
                <option key={t} value={t}>
                  {t === 'coupon' ? 'Coupon / Discount' : t === 'product' ? 'Affiliate Product' : 'Sponsored Post'}
                </option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Brand Name</label>
            <input
              type="text"
              value={form.brand_name}
              onChange={(e) => update('brand_name', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. Branch Basics"
            />
          </div>
          <div className="md:col-span-2">
            <label className="block text-sm font-medium text-gray-700 mb-1">Title *</label>
            <input
              type="text"
              value={form.title}
              onChange={(e) => update('title', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. 20% off first order"
            />
          </div>
          <div className="md:col-span-2">
            <label className="block text-sm font-medium text-gray-700 mb-1">Subtitle</label>
            <input
              type="text"
              value={form.subtitle}
              onChange={(e) => update('subtitle', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="Short description shown below title"
            />
          </div>
        </div>
        <div className="mt-4">
          <label className="block text-sm font-medium text-gray-700 mb-1">Description</label>
          <textarea
            value={form.description}
            onChange={(e) => update('description', e.target.value)}
            rows={3}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            placeholder="Longer description (optional)..."
          />
        </div>
      </section>

      {/* Media & Action */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Media & Action</h2>
        <div className="grid grid-cols-1 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Image URL</label>
            <input
              type="url"
              value={form.image_url}
              onChange={(e) => update('image_url', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="https://... (product image or brand logo)"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Action URL</label>
            <input
              type="url"
              value={form.action_url}
              onChange={(e) => update('action_url', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="https://... (where the button leads)"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Action Label</label>
            <input
              type="text"
              value={form.action_label}
              onChange={(e) => update('action_label', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. Shop Now, Learn More (leave empty for default)"
            />
          </div>
        </div>
      </section>

      {/* Coupon Details (only shown for coupon type) */}
      {isCoupon && (
        <section className="bg-white rounded-xl border border-gray-200 p-6">
          <h2 className="text-lg font-semibold text-gray-900 mb-4">Coupon Details</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Coupon Code</label>
              <input
                type="text"
                value={form.coupon_code}
                onChange={(e) => update('coupon_code', e.target.value.toUpperCase())}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500 font-mono"
                placeholder="e.g. NONTOXIC20"
              />
            </div>
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-1">Discount Text</label>
              <input
                type="text"
                value={form.discount_text}
                onChange={(e) => update('discount_text', e.target.value)}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
                placeholder="e.g. 20% OFF, FREE SHIPPING"
              />
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
                    {type === 'online' ? 'Online Only' : type === 'in_store' ? 'In-Store Only' : 'Both (Online + In-Store)'}
                  </option>
                ))}
              </select>
            </div>
          </div>
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
      )}

      {/* Display Settings */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Display Settings</h2>
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
            <label className="block text-sm font-medium text-gray-700 mb-1">Badge Text</label>
            <input
              type="text"
              value={form.badge_text}
              onChange={(e) => update('badge_text', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. FEATURED, PARTNER DEAL, NEW"
            />
          </div>
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
            {saving ? 'Saving...' : isEditing ? 'Update Item' : 'Create Item'}
          </button>
          <button
            type="button"
            onClick={() => router.push('/dashboard/featured')}
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
            {deleting ? 'Deleting...' : 'Delete Item'}
          </button>
        )}
      </div>
    </form>
  );
}
