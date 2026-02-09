'use client';

import { useState, useEffect, useRef } from 'react';
import { createClient } from '@/lib/supabase/client';

interface SwapResult {
  id: string;
  name: string;
  brand: string;
  score: number;
  category: string;
  image_url: string | null;
}

interface Props {
  value: string | null;
  displayName: string | null;
  onSelect: (swap: SwapResult) => void;
  onClear: () => void;
}

function ScoreBadge({ score }: { score: number }) {
  let bg = 'bg-emerald-100 text-emerald-700';
  if (score < 34) bg = 'bg-rose-100 text-rose-700';
  else if (score < 67) bg = 'bg-amber-100 text-amber-700';

  return (
    <span className={`inline-flex items-center px-1.5 py-0.5 rounded text-xs font-medium ${bg}`}>
      {score}
    </span>
  );
}

export function SwapSearchInput({ value, displayName, onSelect, onClear }: Props) {
  const [query, setQuery] = useState('');
  const [results, setResults] = useState<SwapResult[]>([]);
  const [loading, setLoading] = useState(false);
  const [showDropdown, setShowDropdown] = useState(false);
  const [searched, setSearched] = useState(false);
  const debounceRef = useRef<NodeJS.Timeout | null>(null);
  const containerRef = useRef<HTMLDivElement>(null);

  // Close dropdown on outside click
  useEffect(() => {
    function handleClickOutside(e: MouseEvent) {
      if (containerRef.current && !containerRef.current.contains(e.target as Node)) {
        setShowDropdown(false);
      }
    }
    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  const search = async (q: string) => {
    if (q.trim().length < 2) {
      setResults([]);
      setSearched(false);
      setShowDropdown(false);
      return;
    }

    setLoading(true);
    setSearched(true);
    const supabase = createClient();
    const pattern = `%${q.trim()}%`;

    const { data, error } = await supabase
      .from('swaps')
      .select('id, name, brand, score, category, image_url')
      .eq('is_active', true)
      .or(`name.ilike.${pattern},brand.ilike.${pattern}`)
      .order('score', { ascending: false })
      .limit(10);

    if (!error && data) {
      setResults(data as SwapResult[]);
    } else {
      setResults([]);
    }
    setLoading(false);
    setShowDropdown(true);
  };

  const handleInputChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const val = e.target.value;
    setQuery(val);

    if (debounceRef.current) clearTimeout(debounceRef.current);
    debounceRef.current = setTimeout(() => search(val), 300);
  };

  const handleSelect = (swap: SwapResult) => {
    onSelect(swap);
    setQuery('');
    setResults([]);
    setShowDropdown(false);
    setSearched(false);
  };

  // If already linked, show chip
  if (value && displayName) {
    return (
      <div className="flex items-center gap-2">
        <span className="inline-flex items-center gap-1.5 px-3 py-1.5 bg-sky-50 border border-sky-200 text-sky-700 rounded-lg text-sm font-medium">
          {displayName}
          <button
            type="button"
            onClick={onClear}
            className="ml-1 text-sky-400 hover:text-sky-600 transition-colors"
            aria-label="Remove linked product"
          >
            <svg xmlns="http://www.w3.org/2000/svg" className="h-4 w-4" viewBox="0 0 20 20" fill="currentColor">
              <path fillRule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clipRule="evenodd" />
            </svg>
          </button>
        </span>
      </div>
    );
  }

  return (
    <div ref={containerRef} className="relative">
      <input
        type="text"
        value={query}
        onChange={handleInputChange}
        onFocus={() => { if (results.length > 0 || searched) setShowDropdown(true); }}
        placeholder="Search swaps by name or brand..."
        className="w-full px-3 py-2 border border-gray-300 rounded-lg text-sm focus:outline-none focus:ring-2 focus:ring-sky-500"
      />
      {loading && (
        <div className="absolute right-3 top-2.5">
          <svg className="animate-spin h-4 w-4 text-gray-400" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
            <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
            <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
          </svg>
        </div>
      )}

      {showDropdown && (
        <div className="absolute z-50 mt-1 w-full bg-white border border-gray-200 rounded-lg shadow-lg max-h-72 overflow-y-auto">
          {results.length === 0 && searched && !loading && (
            <div className="px-4 py-3 text-sm text-gray-500">No matches found</div>
          )}
          {results.map((swap) => (
            <button
              key={swap.id}
              type="button"
              onClick={() => handleSelect(swap)}
              className="w-full text-left px-4 py-2.5 hover:bg-gray-50 transition-colors border-b border-gray-100 last:border-b-0 flex items-center gap-3"
            >
              {swap.image_url && (
                <img
                  src={swap.image_url}
                  alt=""
                  className="w-8 h-8 rounded object-cover flex-shrink-0"
                />
              )}
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2">
                  <span className="text-sm font-medium text-gray-900 truncate">{swap.name}</span>
                  <ScoreBadge score={swap.score} />
                </div>
                <div className="flex items-center gap-2 mt-0.5">
                  <span className="text-xs text-gray-500">{swap.brand}</span>
                  <span className="inline-flex items-center px-1.5 py-0.5 bg-gray-100 text-gray-600 rounded text-xs">
                    {swap.category}
                  </span>
                </div>
              </div>
            </button>
          ))}
        </div>
      )}
    </div>
  );
}
