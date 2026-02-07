'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

const CATEGORIES = [
  'food', 'beverage', 'snack', 'condiment', 'dairy', 'baby_food',
  'personal_care', 'skincare', 'haircare', 'oral_care', 'deodorant',
  'cleaning', 'laundry', 'cookware', 'storage', 'supplement', 'other',
];

const AFFILIATE_SOURCES = ['amazon', 'thrive', 'iherb', 'direct', 'other'] as const;

const BADGE_OPTIONS = [
  'organic', 'non-gmo', 'dad-approved', 'ewg-verified', 'usda-organic',
  'b-corp', 'cruelty-free', 'vegan', 'gluten-free', 'fragrance-free',
  'dermatologist-tested', 'pediatrician-recommended',
];

const COMMON_STORES = [
  'Walmart', 'Target', 'Whole Foods', "Trader Joe's", 'Costco',
  'Kroger', 'Safeway', 'Publix', 'Aldi', 'Sprouts',
  'Natural Grocers', 'Thrive Market', 'Amazon', 'CVS', 'Walgreens', 'iHerb',
  'H-E-B', 'Wegmans', 'Meijer', "Sam's Club",
];

interface SwapData {
  id?: string;
  name: string;
  brand: string;
  category: string;
  description: string;
  score: number;
  why_better: string;
  badges: string[];
  replaces_ingredients: string[];
  replaces_products: string[];
  price_cents: number | null;
  affiliate_url: string;
  affiliate_source: string;
  affiliate_commission_percent: number | null;
  available_stores: string[];
  image_url: string;
  is_active: boolean;
  featured: boolean;
}

const emptySwap: SwapData = {
  name: '',
  brand: '',
  category: 'food',
  description: '',
  score: 80,
  why_better: '',
  badges: [],
  replaces_ingredients: [],
  replaces_products: [],
  price_cents: null,
  affiliate_url: '',
  affiliate_source: '',
  affiliate_commission_percent: null,
  available_stores: [],
  image_url: '',
  is_active: true,
  featured: false,
};

interface Props {
  initialData?: SwapData;
  isEditing?: boolean;
}

export function SwapForm({ initialData, isEditing }: Props) {
  const router = useRouter();
  const [form, setForm] = useState<SwapData>(initialData || emptySwap);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  // Tag input states
  const [badgeInput, setBadgeInput] = useState('');
  const [ingredientInput, setIngredientInput] = useState('');
  const [productInput, setProductInput] = useState('');
  const [storeInput, setStoreInput] = useState('');
  const [showStoreDropdown, setShowStoreDropdown] = useState(false);
  const [showBadgeDropdown, setShowBadgeDropdown] = useState(false);

  const update = (field: keyof SwapData, value: SwapData[keyof SwapData]) => {
    setForm((prev) => ({ ...prev, [field]: value }));
  };

  const addTag = (field: 'badges' | 'replaces_ingredients' | 'replaces_products' | 'available_stores', value: string) => {
    const trimmed = value.trim();
    if (!trimmed || form[field].includes(trimmed)) return;
    update(field, [...form[field], trimmed]);
  };

  const removeTag = (field: 'badges' | 'replaces_ingredients' | 'replaces_products' | 'available_stores', index: number) => {
    update(field, form[field].filter((_, i) => i !== index));
  };

  const filteredStores = COMMON_STORES.filter(
    (s) => s.toLowerCase().includes(storeInput.toLowerCase()) && !form.available_stores.includes(s)
  );

  const filteredBadges = BADGE_OPTIONS.filter(
    (b) => b.toLowerCase().includes(badgeInput.toLowerCase()) && !form.badges.includes(b)
  );

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!form.name.trim() || !form.brand.trim()) {
      setError('Name and brand are required.');
      return;
    }
    if (form.score < 0 || form.score > 100) {
      setError('Score must be between 0 and 100.');
      return;
    }

    setSaving(true);
    const supabase = createClient();

    const payload = {
      name: form.name.trim(),
      brand: form.brand.trim(),
      category: form.category,
      description: form.description.trim() || null,
      score: form.score,
      why_better: form.why_better.trim() || null,
      badges: form.badges,
      replaces_ingredients: form.replaces_ingredients,
      replaces_products: form.replaces_products,
      price_cents: form.price_cents,
      affiliate_url: form.affiliate_url.trim() || null,
      affiliate_source: (form.affiliate_source || null) as 'amazon' | 'thrive' | 'iherb' | 'direct' | 'other' | null,
      affiliate_commission_percent: form.affiliate_commission_percent,
      available_stores: form.available_stores,
      image_url: form.image_url.trim() || null,
      is_active: form.is_active,
      featured: form.featured,
      embedding: null, // Clear embedding so generate-embeddings regenerates it
    };

    let result;
    if (isEditing && form.id) {
      result = await supabase.from('swaps').update(payload).eq('id', form.id);
    } else {
      result = await supabase.from('swaps').insert(payload);
    }

    if (result.error) {
      setError(result.error.message);
      setSaving(false);
      return;
    }

    router.push('/dashboard/swaps');
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
            <label className="block text-sm font-medium text-gray-700 mb-1">Name *</label>
            <input
              type="text"
              value={form.name}
              onChange={(e) => update('name', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. Dr. Bronner's Pure Castile Soap"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Brand *</label>
            <input
              type="text"
              value={form.brand}
              onChange={(e) => update('brand', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. Dr. Bronner's"
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
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Image URL</label>
            <input
              type="url"
              value={form.image_url}
              onChange={(e) => update('image_url', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="https://..."
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
            placeholder="Brief description of this product..."
          />
        </div>
      </section>

      {/* Scoring & Why Better */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Scoring</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Safety Score (0-100)</label>
            <input
              type="number"
              min={0}
              max={100}
              value={form.score}
              onChange={(e) => update('score', parseInt(e.target.value) || 0)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            />
            <p className="text-xs text-gray-400 mt-1">0-33 Toxic, 34-66 Caution, 67-100 Safe</p>
          </div>
          <div className="flex items-end gap-6">
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={form.is_active}
                onChange={(e) => update('is_active', e.target.checked)}
                className="w-4 h-4 rounded border-gray-300 text-sky-600 focus:ring-sky-500"
              />
              <span className="text-sm text-gray-700">Active</span>
            </label>
            <label className="flex items-center gap-2 cursor-pointer">
              <input
                type="checkbox"
                checked={form.featured}
                onChange={(e) => update('featured', e.target.checked)}
                className="w-4 h-4 rounded border-gray-300 text-sky-600 focus:ring-sky-500"
              />
              <span className="text-sm text-gray-700">Featured</span>
            </label>
          </div>
        </div>
        <div className="mt-4">
          <label className="block text-sm font-medium text-gray-700 mb-1">Why It&apos;s Better</label>
          <textarea
            value={form.why_better}
            onChange={(e) => update('why_better', e.target.value)}
            rows={3}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            placeholder="Explain why this is a safer alternative..."
          />
        </div>
      </section>

      {/* Badges */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Badges</h2>
        <div className="flex flex-wrap gap-2 mb-3">
          {form.badges.map((badge, i) => (
            <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-50 text-emerald-700">
              {badge}
              <button type="button" onClick={() => removeTag('badges', i)} className="hover:text-emerald-900">&times;</button>
            </span>
          ))}
        </div>
        <div className="relative">
          <input
            type="text"
            value={badgeInput}
            onChange={(e) => { setBadgeInput(e.target.value); setShowBadgeDropdown(true); }}
            onFocus={() => setShowBadgeDropdown(true)}
            onBlur={() => setTimeout(() => setShowBadgeDropdown(false), 200)}
            onKeyDown={(e) => {
              if (e.key === 'Enter') { e.preventDefault(); addTag('badges', badgeInput); setBadgeInput(''); }
            }}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            placeholder="Type to add badge..."
          />
          {showBadgeDropdown && badgeInput && filteredBadges.length > 0 && (
            <div className="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg max-h-40 overflow-y-auto">
              {filteredBadges.map((badge) => (
                <button
                  key={badge}
                  type="button"
                  onMouseDown={() => { addTag('badges', badge); setBadgeInput(''); }}
                  className="w-full text-left px-3 py-2 text-sm hover:bg-gray-50"
                >
                  {badge}
                </button>
              ))}
            </div>
          )}
        </div>
      </section>

      {/* Replaces */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Replaces</h2>
        <div className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Replaces Ingredients</label>
            <div className="flex flex-wrap gap-2 mb-2">
              {form.replaces_ingredients.map((ing, i) => (
                <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-red-50 text-red-600">
                  {ing}
                  <button type="button" onClick={() => removeTag('replaces_ingredients', i)} className="hover:text-red-900">&times;</button>
                </span>
              ))}
            </div>
            <input
              type="text"
              value={ingredientInput}
              onChange={(e) => setIngredientInput(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === 'Enter') { e.preventDefault(); addTag('replaces_ingredients', ingredientInput); setIngredientInput(''); }
              }}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="Type ingredient name, press Enter to add..."
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Replaces Products</label>
            <div className="flex flex-wrap gap-2 mb-2">
              {form.replaces_products.map((prod, i) => (
                <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-amber-50 text-amber-700">
                  {prod}
                  <button type="button" onClick={() => removeTag('replaces_products', i)} className="hover:text-amber-900">&times;</button>
                </span>
              ))}
            </div>
            <input
              type="text"
              value={productInput}
              onChange={(e) => setProductInput(e.target.value)}
              onKeyDown={(e) => {
                if (e.key === 'Enter') { e.preventDefault(); addTag('replaces_products', productInput); setProductInput(''); }
              }}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="Type product name, press Enter to add..."
            />
          </div>
        </div>
      </section>

      {/* Affiliate Info */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Affiliate Info</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Affiliate URL</label>
            <input
              type="url"
              value={form.affiliate_url}
              onChange={(e) => update('affiliate_url', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="https://..."
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Affiliate Source</label>
            <select
              value={form.affiliate_source}
              onChange={(e) => update('affiliate_source', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm bg-white focus:outline-none focus:ring-2 focus:ring-sky-500"
            >
              <option value="">None</option>
              {AFFILIATE_SOURCES.map((src) => (
                <option key={src} value={src}>{src.charAt(0).toUpperCase() + src.slice(1)}</option>
              ))}
            </select>
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Commission %</label>
            <input
              type="number"
              min={0}
              max={100}
              step={0.1}
              value={form.affiliate_commission_percent ?? ''}
              onChange={(e) => update('affiliate_commission_percent', e.target.value ? parseFloat(e.target.value) : null)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. 8.5"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Reference Price (cents, optional)</label>
            <input
              type="number"
              min={0}
              value={form.price_cents ?? ''}
              onChange={(e) => update('price_cents', e.target.value ? parseInt(e.target.value) : null)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
              placeholder="e.g. 1299 ($12.99) — not shown to users"
            />
          </div>
        </div>
      </section>

      {/* Available Stores */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Available Stores</h2>
        <div className="flex flex-wrap gap-2 mb-3">
          {form.available_stores.map((store, i) => (
            <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-sky-50 text-sky-700">
              {store}
              <button type="button" onClick={() => removeTag('available_stores', i)} className="hover:text-sky-900">&times;</button>
            </span>
          ))}
        </div>
        <div className="relative">
          <input
            type="text"
            value={storeInput}
            onChange={(e) => { setStoreInput(e.target.value); setShowStoreDropdown(true); }}
            onFocus={() => setShowStoreDropdown(true)}
            onBlur={() => setTimeout(() => setShowStoreDropdown(false), 200)}
            onKeyDown={(e) => {
              if (e.key === 'Enter') { e.preventDefault(); addTag('available_stores', storeInput); setStoreInput(''); }
            }}
            className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            placeholder="Type store name or select from list..."
          />
          {showStoreDropdown && filteredStores.length > 0 && (
            <div className="absolute z-10 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg max-h-40 overflow-y-auto">
              {filteredStores.map((store) => (
                <button
                  key={store}
                  type="button"
                  onMouseDown={() => { addTag('available_stores', store); setStoreInput(''); }}
                  className="w-full text-left px-3 py-2 text-sm hover:bg-gray-50"
                >
                  {store}
                </button>
              ))}
            </div>
          )}
        </div>
      </section>

      {/* Actions */}
      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={saving}
          className="px-6 py-2.5 bg-sky-600 text-white rounded-lg text-sm font-medium hover:bg-sky-700 transition-colors disabled:opacity-50"
        >
          {saving ? 'Saving...' : isEditing ? 'Update Swap' : 'Create Swap'}
        </button>
        <button
          type="button"
          onClick={() => router.push('/dashboard/swaps')}
          className="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg text-sm font-medium hover:bg-gray-50 transition-colors"
        >
          Cancel
        </button>
      </div>
    </form>
  );
}
