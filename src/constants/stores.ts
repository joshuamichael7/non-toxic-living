export const COMMON_STORES = [
  'Walmart',
  'Target',
  'Whole Foods',
  "Trader Joe's",
  'Costco',
  'Kroger',
  'Safeway',
  'Publix',
  'Aldi',
  'Sprouts',
  'Natural Grocers',
  'Thrive Market',
  'Amazon',
  'CVS',
  'Walgreens',
  'iHerb',
  'H-E-B',
  'Wegmans',
  'Meijer',
  'Sam\'s Club',
] as const;

export type CommonStore = typeof COMMON_STORES[number];
