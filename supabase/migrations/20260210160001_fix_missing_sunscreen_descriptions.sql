-- Fix 4 sunscreens that were missed in the previous description update

UPDATE public.swaps SET description = 'Zinc oxide mineral sunscreen rated #1 by EWG. No harmful chemical UV filters like oxybenzone or octinoxate. Water-resistant 80 minutes. Safe for babies and adults.'
WHERE brand = 'Thinkbaby' AND name = 'SPF 50+ Sunscreen' AND description IS NULL;

UPDATE public.swaps SET description = 'Certified organic mineral sunscreen with non-nano zinc oxide. Simple ingredient list with no synthetic chemicals, fragrances, or GMO ingredients. Biodegradable and reef-safe.'
WHERE brand = 'Badger' AND name = 'Clear Zinc Sunscreen SPF 40' AND description IS NULL;

UPDATE public.swaps SET description = 'Mineral-only formula using zinc oxide and titanium dioxide. Dermatologist recommended for sensitive skin. No chemical UV filters, parabens, or fragrances.'
WHERE brand = 'Blue Lizard' AND name = 'Sensitive Mineral Sunscreen SPF 50+' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic mineral sunscreen with zinc oxide. Reef-friendly, water-resistant, and free from oxybenzone, octinoxate, and chemical UV filters. B Corp certified.'
WHERE brand = 'All Good' AND name = 'Mineral Sunscreen Lotion SPF 30' AND description IS NULL;
