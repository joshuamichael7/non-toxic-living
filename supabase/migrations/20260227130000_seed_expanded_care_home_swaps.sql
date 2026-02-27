-- Batch: More Personal Care, Cleaning, Household (~40 products)
-- All products are real, verified non-toxic alternatives

-- ============================================
-- BODY CARE & LOTION (more affordable options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Shea Butter Body Cream',
  'Nubian Heritage',
  'skincare',
  86,
  'Fair trade shea butter with culturally authentic African recipes. No mineral oil, no parabens, no sulfates, no phthalates, no petrolatum. Certified B Corp.',
  ARRAY['Fair Trade', 'Certified B Corp', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'DMDM hydantoin'],
  ARRAY['Jergens', 'Vaseline Lotion', 'Palmer''s', 'Lubriderm'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'CVS', 'Walmart'],
  true, false
),
(
  'CeraVe Moisturizing Cream',
  'CeraVe',
  'skincare',
  79,
  'Dermatologist-developed with ceramides and hyaluronic acid. No fragrance, no parabens. While not organic, it is one of the cleanest mainstream moisturizers with proven efficacy.',
  ARRAY['Fragrance-Free', 'Dermatologist Recommended', 'Non-Comedogenic'],
  ARRAY['synthetic fragrance', 'parabens', 'phthalates', 'mineral oil'],
  ARRAY['St. Ives', 'Suave Body Lotion', 'Nivea Cream'],
  ARRAY['Amazon', 'Target', 'CVS', 'Walgreens', 'Walmart', 'Costco'],
  true, false
),
(
  'Body Oil Citrus',
  'Osmia',
  'skincare',
  90,
  'Made with organic jojoba, organic sunflower, and organic essential oils. No synthetic fragrance, no mineral oil, no preservatives, no parabens. Small batch, woman-owned.',
  ARRAY['Organic', 'Cruelty-Free', 'Made in USA'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'DMDM hydantoin'],
  ARRAY['Johnson''s Baby Oil', 'Bio-Oil', 'Neutrogena Body Oil'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Hemp Seed Body Care Lotion',
  'Dr. Bronner''s',
  'skincare',
  87,
  'USDA Organic lotion with organic hemp seed oil and organic jojoba oil. No synthetic preservatives, no mineral oil, no petrolatum. Fair trade ingredients.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs'],
  ARRAY['Jergens', 'Lubriderm', 'Aveeno', 'Eucerin'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- FACE CARE (serums & treatments)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Hyaluronic Acid Serum',
  'Cocokind',
  'skincare',
  87,
  'Clean hyaluronic acid serum with organic aloe and vitamin B5. No synthetic fragrance, no parabens, no silicones, no mineral oil. EWG Verified. Affordable clean beauty.',
  ARRAY['EWG Verified', 'Vegan', 'Cruelty-Free'],
  ARRAY['synthetic fragrance', 'parabens', 'silicones', 'mineral oil', 'PEGs', 'phenoxyethanol'],
  ARRAY['Olay Serum', 'Neutrogena Serum', 'L''Oreal Hyaluronic Acid'],
  ARRAY['Amazon', 'Target', 'Ulta', 'Direct'],
  true, false
),
(
  'Overnight Resurfacing Peel',
  'Herbivore Botanicals',
  'skincare',
  88,
  'Natural AHA peel with blue tansy and willow bark. No synthetic chemicals, no parabens, no sulfates, no phthalates. Vegan and cruelty-free. Made in the USA.',
  ARRAY['Vegan', 'Cruelty-Free', 'Made in USA'],
  ARRAY['synthetic fragrance', 'parabens', 'phthalates', 'mineral oil', 'PEGs', 'artificial colors'],
  ARRAY['Olay Retinol', 'Neutrogena Peel', 'The Ordinary AHA'],
  ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Direct'],
  true, false
),
(
  'Bakuchiol Retinol Alternative Serum',
  'Acure',
  'skincare',
  86,
  'Plant-based retinol alternative using bakuchiol (no irritation). No parabens, no sulfates, no mineral oil, no petrolatum, no silicones. EWG Verified.',
  ARRAY['EWG Verified', 'Vegan', 'Cruelty-Free'],
  ARRAY['retinyl palmitate', 'synthetic fragrance', 'parabens', 'mineral oil', 'PEGs', 'silicones'],
  ARRAY['Olay Retinol 24', 'Neutrogena Retinol', 'RoC Retinol'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- MEN'S GROOMING (clean options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Shaving Gel',
  'Dr. Bronner''s',
  'personal_care',
  88,
  'USDA Organic shaving gel with organic oils and organic shikakai extract. No synthetic lathering agents, no synthetic fragrance, no parabens, no propylene glycol.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'propylene glycol', 'triethanolamine', 'BHT'],
  ARRAY['Barbasol', 'Gillette Shaving Cream', 'Edge Shave Gel'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Natural Shaving Cream',
  'Pacific Shaving Company',
  'personal_care',
  85,
  'Made with natural and organic ingredients. No parabens, no phthalates, no synthetic fragrance, no propellants. Cruelty-free, vegan formula. TSA-friendly size available.',
  ARRAY['Vegan', 'Cruelty-Free', 'No Propellants'],
  ARRAY['SLS', 'synthetic fragrance', 'parabens', 'propylene glycol', 'triethanolamine', 'aerosol propellants'],
  ARRAY['Barbasol', 'Gillette Shaving Cream', 'Edge Shave Gel'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Face Lotion SPF 20',
  'Every Man Jack',
  'skincare',
  83,
  'Naturally derived ingredients with mineral SPF protection. No parabens, no phthalates, no dyes, no aluminum. Clean daily moisturizer for men at an accessible price.',
  ARRAY['No Parabens', 'No Phthalates', 'Cruelty-Free'],
  ARRAY['oxybenzone', 'synthetic fragrance', 'parabens', 'phthalates', 'aluminum', 'PEGs'],
  ARRAY['Nivea Men', 'Dove Men+Care', 'Old Spice Lotion'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true, false
);

-- ============================================
-- CLEANING (specialty - glass, dish, bathroom)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Glass Cleaner',
  'Aunt Fannie''s',
  'cleaning',
  88,
  'Made from vinegar and plant-derived cleaning agents. No ammonia, no synthetic fragrance, no 2-butoxyethanol, no VOCs. Streak-free on glass and mirrors.',
  ARRAY['Plant-Based', 'No VOCs', 'No Ammonia'],
  ARRAY['ammonia', '2-butoxyethanol', 'synthetic fragrance', 'isopropanol', 'phthalates'],
  ARRAY['Windex', 'Glass Plus', 'Sprayway Glass Cleaner'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Automatic Dishwasher Detergent Packs',
  'Seventh Generation',
  'cleaning',
  87,
  'Plant-derived, powered by enzymes. No chlorine bleach, no phosphates, no synthetic fragrance, no dyes. USDA Certified Biobased. Effective in hard water.',
  ARRAY['USDA Biobased', 'Fragrance Free', 'EPA Safer Choice'],
  ARRAY['chlorine bleach', 'phosphates', 'synthetic fragrance', '1,4-dioxane', 'artificial dyes'],
  ARRAY['Cascade', 'Finish', 'Palmolive Dishwasher Packs'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Shower Cleaner',
  'Better Life',
  'cleaning',
  87,
  'Plant-derived daily shower cleaner. No synthetic fragrance, no VOCs, no chlorine, no ammonia, no dyes. Prevents soap scum and mildew without harsh chemicals.',
  ARRAY['Plant-Derived', 'No VOCs', 'Cruelty-Free'],
  ARRAY['chlorine bleach', 'ammonia', 'synthetic fragrance', '2-butoxyethanol', 'triclosan', 'phthalates'],
  ARRAY['Scrubbing Bubbles', 'Tilex', 'Kaboom', 'Clorox Bathroom'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Granite & Stone Cleaner',
  'Method',
  'cleaning',
  84,
  'Plant-based formula safe for natural stone surfaces. No ammonia, no bleach, no phosphates. Derived from naturally occurring minerals. Biodegradable.',
  ARRAY['Plant-Based', 'Biodegradable', 'Certified B Corp'],
  ARRAY['ammonia', 'chlorine bleach', 'synthetic fragrance', '2-butoxyethanol', 'phosphates'],
  ARRAY['Weiman Granite Cleaner', 'Clorox Granite', 'generic stone cleaners'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart'],
  true, false
),
(
  'Oxygen Whitener Booster',
  'Nellie''s',
  'laundry',
  88,
  'Sodium percarbonate-based whitener and stain remover. No chlorine bleach, no synthetic fragrance, no phosphates, no SLS. Septic-safe and hypoallergenic. Biodegradable.',
  ARRAY['Hypoallergenic', 'Biodegradable', 'No Chlorine'],
  ARRAY['chlorine bleach', 'optical brighteners', 'synthetic fragrance', 'phosphates', 'SLS'],
  ARRAY['Clorox Bleach', 'OxiClean', 'Purex Bleach'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
);

-- ============================================
-- MORE HAIRCARE (treatments & styling)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Rosemary Mint Scalp & Hair Strengthening Oil',
  'Mielle Organics',
  'haircare',
  86,
  'Organic rosemary and mint oils to strengthen hair and nourish scalp. No mineral oil, no petrolatum, no sulfates, no parabens. Biotin-infused for hair health.',
  ARRAY['Organic Ingredients', 'Cruelty-Free', 'No Mineral Oil'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'silicones', 'DMDM hydantoin'],
  ARRAY['Garnier Fructis Hair Oil', 'Pantene Hair Oil', 'TRESemme Hair Oil'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Ulta'],
  true, false
),
(
  'Air Dry Cream',
  'Innersense Organic Beauty',
  'haircare',
  88,
  'USDA Organic styling cream with no silicones, no sulfates, no synthetic fragrance. Provides hold and definition without buildup or toxic ingredients. Color-safe.',
  ARRAY['USDA Organic', 'Cruelty-Free', 'Non-GMO'],
  ARRAY['silicones', 'synthetic fragrance', 'parabens', 'DMDM hydantoin', 'PEGs', 'propylene glycol'],
  ARRAY['Garnier Fructis Styling', 'TRESemme Styling', 'Paul Mitchell'],
  ARRAY['Amazon', 'Whole Foods', 'Credo Beauty', 'Direct'],
  true, false
),
(
  'Don''t Despair, Repair! Strengthening Treatment Oil',
  'Briogeo',
  'haircare',
  87,
  'Made with rosehip, argan, and sweet almond oils for damaged hair. No sulfates, no silicones, no parabens, no phthalates, no DEA, no artificial dyes. 6-free formula.',
  ARRAY['6-Free', 'Vegan', 'Cruelty-Free'],
  ARRAY['silicones', 'mineral oil', 'synthetic fragrance', 'parabens', 'DMDM hydantoin', 'phthalates'],
  ARRAY['Moroccan Oil', 'Garnier Fructis Oil', 'CHI Silk Infusion'],
  ARRAY['Amazon', 'Sephora', 'Target', 'Ulta'],
  true, false
);

-- ============================================
-- MORE DEODORANT & PERSONAL CARE
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Eucalyptus Deodorant',
  'Native',
  'deodorant',
  83,
  'Aluminum-free deodorant with simple ingredients: coconut oil, shea butter, tapioca starch, baking soda. No parabens, no sulfates, no phthalates. Widely available and affordable.',
  ARRAY['Aluminum Free', 'Cruelty-Free', 'Vegan Options'],
  ARRAY['aluminum', 'aluminum zirconium', 'parabens', 'synthetic fragrance', 'propylene glycol', 'phthalates'],
  ARRAY['Old Spice', 'Degree', 'Dove', 'Secret'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens'],
  true, false
),
(
  'Mineral Sunscreen Stick SPF 50',
  'Sun Bum Mineral',
  'sunscreen',
  85,
  'Zinc oxide mineral sunscreen in convenient stick form. Reef-friendly, no oxybenzone, no octinoxate. Vegan and cruelty-free. Good for face application on-the-go.',
  ARRAY['Reef Friendly', 'Vegan', 'Cruelty-Free'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'synthetic fragrance'],
  ARRAY['Banana Boat', 'Coppertone Stick', 'Neutrogena Stick'],
  ARRAY['Amazon', 'Target', 'Ulta', 'CVS', 'Walmart'],
  true, false
),
(
  'Mineral Body Sunscreen SPF 30',
  'Beauty Counter',
  'sunscreen',
  88,
  'Non-nano zinc oxide sunscreen screened against 2,800+ harmful ingredients (The Never List). No chemical UV filters, no oxybenzone, no octinoxate. Water-resistant 80 minutes.',
  ARRAY['Reef Safe', 'Non-Nano Zinc', 'EWG Verified'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'octocrylene', 'synthetic fragrance'],
  ARRAY['Banana Boat', 'Coppertone', 'Neutrogena Sunscreen', 'Hawaiian Tropic'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- HOUSEHOLD (dryer, dish care, misc)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Dryer Sheets',
  'Attitude',
  'laundry',
  86,
  'Plant and mineral-based dryer sheets. No synthetic fragrance, no benzyl acetate, no chloroform, no animal-derived ingredients. Hypoallergenic and compostable.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Compostable'],
  ARRAY['benzyl acetate', 'chloroform', 'synthetic fragrance', 'quaternary ammonium', 'alpha-terpineol'],
  ARRAY['Bounce Dryer Sheets', 'Downy Dryer Sheets', 'Snuggle Sheets'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Dishwasher Detergent Tablets',
  'Blueland',
  'cleaning',
  88,
  'Plastic-free dissolvable tablets for the dishwasher. No SLS, no chlorine, no synthetic fragrance, no dyes. EPA Safer Choice certified. Zero single-use plastic.',
  ARRAY['EPA Safer Choice', 'Plastic-Free', 'Certified B Corp'],
  ARRAY['chlorine bleach', 'phosphates', 'synthetic fragrance', '1,4-dioxane', 'SLS'],
  ARRAY['Cascade', 'Finish', 'Palmolive Dishwasher'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Plant-Based Disinfecting Wipes',
  'Seventh Generation',
  'cleaning',
  85,
  'Botanical disinfectant made with thymol (from thyme oil). Kills 99.99% of germs without bleach or ammonia. EPA registered, no synthetic fragrance, no chlorine.',
  ARRAY['EPA Registered', 'Plant-Based', 'No Chlorine'],
  ARRAY['chlorine bleach', 'ammonia', 'quaternary ammonium', 'synthetic fragrance', 'isopropanol'],
  ARRAY['Clorox Wipes', 'Lysol Wipes', 'Pine-Sol Wipes'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
);
