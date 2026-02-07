'use client';

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { createClient } from '@/lib/supabase/client';

const CATEGORIES = [
  'additive', 'preservative', 'sweetener', 'color', 'flavor',
  'fragrance', 'surfactant', 'solvent', 'emulsifier',
  'pesticide', 'heavy_metal', 'plastic', 'other',
];

interface IngredientData {
  id: string;
  name: string;
  slug: string;
  aliases: string[];
  category: string;
  toxicity_score: number;
  concerns: string[];
  safe_alternatives: string[];
  commonly_found_in: string[];
  sources: string[];
}

interface Props {
  initialData: IngredientData;
}

export function IngredientForm({ initialData }: Props) {
  const router = useRouter();
  const [form, setForm] = useState<IngredientData>(initialData);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);

  // Tag input states
  const [aliasInput, setAliasInput] = useState('');
  const [concernInput, setConcernInput] = useState('');
  const [alternativeInput, setAlternativeInput] = useState('');
  const [foundInInput, setFoundInInput] = useState('');
  const [sourceInput, setSourceInput] = useState('');

  const update = (field: keyof IngredientData, value: IngredientData[keyof IngredientData]) => {
    setForm((prev) => ({ ...prev, [field]: value }));
    setSuccess(false);
  };

  const addTag = (field: 'aliases' | 'concerns' | 'safe_alternatives' | 'commonly_found_in' | 'sources', value: string) => {
    const trimmed = value.trim();
    if (!trimmed || form[field].includes(trimmed)) return;
    update(field, [...form[field], trimmed]);
  };

  const removeTag = (field: 'aliases' | 'concerns' | 'safe_alternatives' | 'commonly_found_in' | 'sources', index: number) => {
    update(field, form[field].filter((_, i) => i !== index));
  };

  const scoreColor = (score: number) => {
    if (score <= 3) return 'text-emerald-600';
    if (score <= 6) return 'text-amber-600';
    return 'text-red-600';
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setSuccess(false);

    if (!form.name.trim()) {
      setError('Name is required.');
      return;
    }

    setSaving(true);
    const supabase = createClient();

    const { error: updateError } = await supabase
      .from('ingredients')
      .update({
        name: form.name.trim(),
        slug: form.slug.trim(),
        aliases: form.aliases,
        category: form.category,
        toxicity_score: form.toxicity_score,
        concerns: form.concerns,
        safe_alternatives: form.safe_alternatives,
        commonly_found_in: form.commonly_found_in,
        sources: form.sources,
        embedding: null, // Clear so generate-embeddings refreshes it
      })
      .eq('id', form.id);

    if (updateError) {
      setError(updateError.message);
    } else {
      setSuccess(true);
    }
    setSaving(false);
  };

  return (
    <form onSubmit={handleSubmit} className="space-y-6 max-w-3xl">
      {error && (
        <div className="bg-red-50 border border-red-200 text-red-700 rounded-lg px-4 py-3 text-sm">
          {error}
        </div>
      )}
      {success && (
        <div className="bg-emerald-50 border border-emerald-200 text-emerald-700 rounded-lg px-4 py-3 text-sm">
          Ingredient saved successfully.
        </div>
      )}

      {/* Basic Info */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Basic Info</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Name</label>
            <input
              type="text"
              value={form.name}
              onChange={(e) => update('name', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">Slug</label>
            <input
              type="text"
              value={form.slug}
              onChange={(e) => update('slug', e.target.value)}
              className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
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
            <label className="block text-sm font-medium text-gray-700 mb-1">
              Toxicity Score <span className={`font-bold ${scoreColor(form.toxicity_score)}`}>{form.toxicity_score}/10</span>
            </label>
            <input
              type="range"
              min={1}
              max={10}
              value={form.toxicity_score}
              onChange={(e) => update('toxicity_score', parseInt(e.target.value))}
              className="w-full"
            />
            <div className="flex justify-between text-xs text-gray-400 mt-1">
              <span>1 (Safe)</span>
              <span>10 (Toxic)</span>
            </div>
          </div>
        </div>
      </section>

      {/* Aliases */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Aliases / Other Names</h2>
        <div className="flex flex-wrap gap-2 mb-3">
          {form.aliases.map((alias, i) => (
            <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-gray-100 text-gray-700">
              {alias}
              <button type="button" onClick={() => removeTag('aliases', i)} className="hover:text-gray-900">&times;</button>
            </span>
          ))}
        </div>
        <input
          type="text"
          value={aliasInput}
          onChange={(e) => setAliasInput(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); addTag('aliases', aliasInput); setAliasInput(''); } }}
          className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          placeholder="Type alias, press Enter..."
        />
      </section>

      {/* Concerns */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Health Concerns</h2>
        <div className="flex flex-wrap gap-2 mb-3">
          {form.concerns.map((concern, i) => (
            <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-red-50 text-red-600">
              {concern}
              <button type="button" onClick={() => removeTag('concerns', i)} className="hover:text-red-900">&times;</button>
            </span>
          ))}
        </div>
        <input
          type="text"
          value={concernInput}
          onChange={(e) => setConcernInput(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); addTag('concerns', concernInput); setConcernInput(''); } }}
          className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          placeholder="Type concern, press Enter..."
        />
      </section>

      {/* Safe Alternatives */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Safe Alternatives</h2>
        <div className="flex flex-wrap gap-2 mb-3">
          {form.safe_alternatives.map((alt, i) => (
            <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-emerald-50 text-emerald-700">
              {alt}
              <button type="button" onClick={() => removeTag('safe_alternatives', i)} className="hover:text-emerald-900">&times;</button>
            </span>
          ))}
        </div>
        <input
          type="text"
          value={alternativeInput}
          onChange={(e) => setAlternativeInput(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); addTag('safe_alternatives', alternativeInput); setAlternativeInput(''); } }}
          className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          placeholder="Type alternative, press Enter..."
        />
      </section>

      {/* Commonly Found In */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Commonly Found In</h2>
        <div className="flex flex-wrap gap-2 mb-3">
          {form.commonly_found_in.map((item, i) => (
            <span key={i} className="inline-flex items-center gap-1 px-2.5 py-1 rounded-full text-xs font-medium bg-amber-50 text-amber-700">
              {item}
              <button type="button" onClick={() => removeTag('commonly_found_in', i)} className="hover:text-amber-900">&times;</button>
            </span>
          ))}
        </div>
        <input
          type="text"
          value={foundInInput}
          onChange={(e) => setFoundInInput(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); addTag('commonly_found_in', foundInInput); setFoundInInput(''); } }}
          className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          placeholder="Type product category, press Enter..."
        />
      </section>

      {/* Sources */}
      <section className="bg-white rounded-xl border border-gray-200 p-6">
        <h2 className="text-lg font-semibold text-gray-900 mb-4">Sources</h2>
        <div className="space-y-2 mb-3">
          {form.sources.map((source, i) => (
            <div key={i} className="flex items-center gap-2">
              <span className="flex-1 text-xs text-gray-600 truncate">{source}</span>
              <button type="button" onClick={() => removeTag('sources', i)} className="text-gray-400 hover:text-red-500 text-xs">&times;</button>
            </div>
          ))}
        </div>
        <input
          type="text"
          value={sourceInput}
          onChange={(e) => setSourceInput(e.target.value)}
          onKeyDown={(e) => { if (e.key === 'Enter') { e.preventDefault(); addTag('sources', sourceInput); setSourceInput(''); } }}
          className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
          placeholder="Add source URL or reference, press Enter..."
        />
      </section>

      {/* Actions */}
      <div className="flex items-center gap-3">
        <button
          type="submit"
          disabled={saving}
          className="px-6 py-2.5 bg-sky-600 text-white rounded-lg text-sm font-medium hover:bg-sky-700 transition-colors disabled:opacity-50"
        >
          {saving ? 'Saving...' : 'Save Changes'}
        </button>
        <button
          type="button"
          onClick={() => router.push('/dashboard/ingredients')}
          className="px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg text-sm font-medium hover:bg-gray-50 transition-colors"
        >
          Back to List
        </button>
      </div>
    </form>
  );
}
