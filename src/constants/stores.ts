// All stores users might shop at (used for autocomplete)
export const COMMON_STORES = [
  // National chains
  'Walmart',
  'Target',
  'Costco',
  "Sam's Club",
  'Amazon',
  // Kroger family (all share the same search URL pattern)
  'Kroger',
  'King Soopers',
  "Smith's",
  'Fred Meyer',
  'Ralphs',
  "Fry's Food",
  'Harris Teeter',
  'Dillons',
  'City Market',
  'QFC',
  // Albertsons family
  'Albertsons',
  'Safeway',
  'Vons',
  'Jewel-Osco',
  "Shaw's",
  'Acme',
  'Tom Thumb',
  'Randalls',
  // Health / specialty
  'Whole Foods',
  'Sprouts',
  'Natural Grocers',
  'Thrive Market',
  'iHerb',
  // Drug / pharmacy
  'CVS',
  'Walgreens',
  // Regional
  'H-E-B',
  'Publix',
  'Wegmans',
  'Meijer',
  // Local Utah
  'Harmons',
  'Good Earth',
  // No online inventory (kept for autocomplete, not tappable)
  "Trader Joe's",
  'Aldi',
] as const;

export type CommonStore = typeof COMMON_STORES[number];

/**
 * Search URL builders for each store.
 * Takes a query string (e.g. "Branch Basics Concentrate") and returns the full search URL.
 * Stores NOT listed here have no useful online search and won't be rendered as tappable links.
 */
export const STORE_SEARCH_MAP: Record<string, (query: string) => string> = {
  // ── Tier 1: Full search + real in-store inventory ─────────────────────────
  'Target': (q) => `https://www.target.com/s?searchTerm=${encodeURIComponent(q)}&category=0%7CDefault%7Crelevance%7Call`,
  'Walmart': (q) => `https://www.walmart.com/search?q=${encodeURIComponent(q)}`,
  // Kroger family — all same URL pattern, just different domain
  'Kroger': (q) => `https://www.kroger.com/search?query=${encodeURIComponent(q)}`,
  'King Soopers': (q) => `https://www.kingsoopers.com/search?query=${encodeURIComponent(q)}`,
  "Smith's": (q) => `https://www.smithsfoodanddrug.com/search?query=${encodeURIComponent(q)}`,
  'Fred Meyer': (q) => `https://www.fredmeyer.com/search?query=${encodeURIComponent(q)}`,
  'Ralphs': (q) => `https://www.ralphs.com/search?query=${encodeURIComponent(q)}`,
  "Fry's Food": (q) => `https://www.frysfood.com/search?query=${encodeURIComponent(q)}`,
  'Harris Teeter': (q) => `https://www.harristeeter.com/search?query=${encodeURIComponent(q)}`,
  'Dillons': (q) => `https://www.dillons.com/search?query=${encodeURIComponent(q)}`,
  'City Market': (q) => `https://www.citymarket.com/search?query=${encodeURIComponent(q)}`,
  'QFC': (q) => `https://www.qfc.com/search?query=${encodeURIComponent(q)}`,
  // Albertsons family — all same URL pattern
  'Albertsons': (q) => `https://www.albertsons.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  'Safeway': (q) => `https://www.safeway.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  'Vons': (q) => `https://www.vons.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  'Jewel-Osco': (q) => `https://www.jewelosco.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  "Shaw's": (q) => `https://www.shaws.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  'Acme': (q) => `https://www.acmemarkets.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  'Tom Thumb': (q) => `https://www.tomthumb.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  'Randalls': (q) => `https://www.randalls.com/shop/search-results.html?query=${encodeURIComponent(q)}`,
  // Pharmacy
  'CVS': (q) => `https://www.cvs.com/shop/search?searchTerm=${encodeURIComponent(q)}`,
  'Walgreens': (q) => `https://www.walgreens.com/search/results.jsp?Ntt=${encodeURIComponent(q)}`,
  // Regional chains with good inventory
  'H-E-B': (q) => `https://www.heb.com/search/?q=${encodeURIComponent(q)}`,
  'Publix': (q) => `https://www.publix.com/shop/stores/browse/search?q=${encodeURIComponent(q)}`,
  'Wegmans': (q) => `https://shop.wegmans.com/search?search_term=${encodeURIComponent(q)}`,
  'Meijer': (q) => `https://www.meijer.com/shopping/search.html?search=${encodeURIComponent(q)}`,
  // Online-only (no in-store but excellent search)
  'Amazon': (q) => `https://www.amazon.com/s?k=${encodeURIComponent(q)}`,
  'iHerb': (q) => `https://www.iherb.com/search?kw=${encodeURIComponent(q)}`,
  'Thrive Market': (q) => `https://thrivemarket.com/search?t=${encodeURIComponent(q)}`,

  // ── Tier 2: Search works, limited per-store inventory ─────────────────────
  'Whole Foods': (q) => `https://www.wholefoodsmarket.com/search?text=${encodeURIComponent(q)}`,
  'Costco': (q) => `https://www.costco.com/CatalogSearch?keyword=${encodeURIComponent(q)}`,
  "Sam's Club": (q) => `https://www.samsclub.com/s/${encodeURIComponent(q)}`,
  'Sprouts': (q) => `https://shop.sprouts.com/search?search=${encodeURIComponent(q)}`,

  // Tier 3 (Trader Joe's, Aldi, Harmons, Good Earth, Natural Grocers) are intentionally
  // omitted — no useful online search. They show as plain text in the UI.
};

/**
 * Stores that show real-time in-store inventory on their website.
 * Used to show a "Check availability" hint vs "Search online".
 */
export const STORES_WITH_INVENTORY = new Set([
  'Target', 'Walmart',
  'Kroger', 'King Soopers', "Smith's", 'Fred Meyer', 'Ralphs', "Fry's Food",
  'Harris Teeter', 'Dillons', 'City Market', 'QFC',
  'Albertsons', 'Safeway', 'Vons', 'Jewel-Osco', "Shaw's", 'Acme', 'Tom Thumb', 'Randalls',
  'CVS', 'Walgreens',
  'H-E-B', 'Publix', 'Wegmans', 'Meijer',
]);
