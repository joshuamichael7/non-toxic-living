-- Batch 2: Personal Care & Baby swaps (~45 products)
-- All products are real, verified non-toxic alternatives with correct brand names

-- ============================================
-- SKINCARE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Ocean Gel Cleanser',
  'OSEA',
  'skincare',
  89,
  'Vegan, climate-neutral gel cleanser with seaweed-based ingredients. No sulfates, no parabens, no synthetic fragrance, no phthalates. EWG Verified.',
  ARRAY['EWG Verified', 'Vegan', 'Climate Neutral'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs'],
  ARRAY['Cetaphil Cleanser', 'Neutrogena', 'CeraVe Cleanser', 'Clean & Clear'],
  ARRAY['Amazon', 'Whole Foods', 'Nordstrom', 'Direct'],
  true, false
),
(
  'Superfood Antioxidant Cleanser',
  'Youth to the People',
  'skincare',
  87,
  'Made with cold-pressed antioxidants: kale, spinach, and green tea. No sulfates, no parabens, no synthetic fragrance. Vegan and cruelty-free.',
  ARRAY['Vegan', 'Cruelty-Free', 'Clean at Sephora'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'mineral oil', 'PEGs'],
  ARRAY['Cetaphil Cleanser', 'Neutrogena', 'Olay Cleanser'],
  ARRAY['Amazon', 'Sephora', 'Whole Foods', 'Target'],
  true, false
),
(
  'Vitamin C Serum',
  'Mad Hippie',
  'skincare',
  88,
  'Active vitamin C with konjac root and ferulic acid. No parabens, no synthetic fragrance, no phthalates, no SLS. EWG Verified for safety.',
  ARRAY['EWG Verified', 'Vegan', 'Cruelty-Free'],
  ARRAY['synthetic fragrance', 'parabens', 'phthalates', 'mineral oil', 'PEGs', 'formaldehyde releasers'],
  ARRAY['Olay Serum', 'L''Oreal Serum', 'Neutrogena Serum'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Rosehip BioRegenerate Oil',
  'Pai Skincare',
  'skincare',
  90,
  'Certified organic rosehip oil using CO2 extraction (no chemical solvents). No synthetic fragrance, no parabens, no mineral oil. Rich in omegas and vitamins.',
  ARRAY['Certified Organic', 'Vegan', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'silicones', 'PEGs'],
  ARRAY['Olay Regenerist', 'Neutrogena Oil', 'L''Oreal Face Oil'],
  ARRAY['Amazon', 'Whole Foods', 'Credo Beauty', 'Direct'],
  true, false
),
(
  'Pure Radiance Oil',
  'True Botanicals',
  'skincare',
  91,
  'MADE SAFE certified facial oil with organic botanical extracts. No synthetic fragrance, no parabens, no silicones. Clinical results comparable to high-end brands.',
  ARRAY['MADE SAFE', 'Certified B Corp', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'silicones', 'phthalates'],
  ARRAY['Clinique Moisturizer', 'Estee Lauder', 'Olay Regenerist'],
  ARRAY['Amazon', 'Nordstrom', 'Credo Beauty', 'Direct'],
  true, false
),
(
  'Stem Cellular Anti-Wrinkle Moisturizer',
  'Juice Beauty',
  'skincare',
  87,
  'Made with certified organic ingredients and fruit stem cells. No petroleum, no parabens, no synthetic fragrance, no propylene glycol.',
  ARRAY['USDA Organic', 'Certified B Corp', 'Cruelty-Free'],
  ARRAY['petrolatum', 'mineral oil', 'synthetic fragrance', 'parabens', 'propylene glycol', 'PEGs'],
  ARRAY['Olay Regenerist', 'Neutrogena Moisturizer', 'L''Oreal Revitalift'],
  ARRAY['Amazon', 'Ulta', 'Direct'],
  true, false
),
(
  'Regenerating Cleanser',
  'Tata Harper',
  'skincare',
  90,
  '100% natural origin ingredients. No synthetic fragrance, no synthetic chemicals, no GMOs. Made on the founder''s Vermont farm. Luxury clean beauty pioneer.',
  ARRAY['100% Natural', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['SLS', 'synthetic fragrance', 'parabens', 'PEGs', 'phthalates', 'formaldehyde releasers'],
  ARRAY['Clinique', 'Estee Lauder', 'La Mer'],
  ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Direct'],
  true, false
),
(
  'Squalane + Vitamin C Rose Oil',
  'Biossance',
  'skincare',
  88,
  'Made with sugarcane-derived squalane (not shark liver). No parabens, no synthetic fragrance, no PEGs. EWG Verified for ingredient safety.',
  ARRAY['EWG Verified', 'Vegan', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'PEGs', 'silicones'],
  ARRAY['Olay Regenerist', 'Neutrogena Oil', 'L''Oreal Face Oil'],
  ARRAY['Amazon', 'Sephora', 'Target', 'Direct'],
  true, false
);

-- ============================================
-- MAKEUP (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Expressionist Bio Extreme Mascara',
  'W3LL PEOPLE',
  'makeup',
  86,
  'EWG Verified mascara with plant-based ingredients. No synthetic fragrance, no parabens, no talc, no coal tar dyes. Certified clean beauty.',
  ARRAY['EWG Verified', 'Cruelty-Free', 'Plant-Based'],
  ARRAY['coal tar dyes', 'parabens', 'synthetic fragrance', 'BHA', 'formaldehyde releasers', 'carbon black'],
  ARRAY['Maybelline Great Lash', 'CoverGirl LashBlast', 'L''Oreal Voluminous'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Fruit Pigmented Ultra Lengthening Mascara',
  '100% Pure',
  'makeup',
  89,
  'Colored with fruit pigments instead of synthetic dyes. No synthetic chemicals, no artificial colors, no FD&C dyes. Nourishes lashes with pro-vitamin B5.',
  ARRAY['Cruelty-Free', 'Vegan', 'Fruit Pigmented'],
  ARRAY['coal tar dyes', 'parabens', 'synthetic fragrance', 'BHA', 'formaldehyde releasers'],
  ARRAY['Maybelline Great Lash', 'CoverGirl LashBlast', 'L''Oreal Voluminous'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Soft Focus Foundation',
  'Vapour Beauty',
  'makeup',
  87,
  'Certified organic ingredients with mineral-based coverage. No synthetic fragrance, no parabens, no nano-particles, no talc. USDA Organic certified.',
  ARRAY['USDA Organic', 'Cruelty-Free', 'Non-GMO'],
  ARRAY['talc', 'parabens', 'synthetic fragrance', 'PEGs', 'BHA', 'formaldehyde releasers'],
  ARRAY['Maybelline Fit Me', 'L''Oreal True Match', 'Covergirl Foundation'],
  ARRAY['Amazon', 'Whole Foods', 'Credo Beauty', 'Direct'],
  true, false
),
(
  'Everything Primer',
  'Honest Beauty',
  'makeup',
  85,
  'Micronized bamboo silica for a natural matte finish. No silicones, no synthetic fragrance, no parabens, no phthalates. Dermatologist tested.',
  ARRAY['EWG Verified', 'Dermatologist Tested', 'Cruelty-Free'],
  ARRAY['silicones', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs', 'BHA'],
  ARRAY['Maybelline Baby Skin Primer', 'NYX Pore Filler', 'e.l.f. Primer'],
  ARRAY['Amazon', 'Target', 'Ulta', 'Walmart'],
  true, false
),
(
  'Phyto-Pigments Flawless Serum Foundation',
  'Juice Beauty',
  'makeup',
  86,
  'Made with an organic botanical juice base instead of water. No petroleum, no propylene glycol, no synthetic fragrance. Fruit pigments for color.',
  ARRAY['USDA Organic', 'Cruelty-Free', 'Fruit Pigmented'],
  ARRAY['talc', 'parabens', 'synthetic fragrance', 'PEGs', 'propylene glycol', 'formaldehyde releasers'],
  ARRAY['Maybelline Fit Me', 'L''Oreal True Match', 'Revlon Foundation'],
  ARRAY['Amazon', 'Ulta', 'Direct'],
  true, false
);

-- ============================================
-- HAIRCARE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Hydrating Cream Conditioner',
  'Innersense Organic Beauty',
  'haircare',
  89,
  'Made with organic and sustainably sourced ingredients. No sulfates, no parabens, no synthetic fragrance. USDA Organic certified hair care.',
  ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'silicones', 'DMDM hydantoin'],
  ARRAY['Pantene Conditioner', 'TRESemme', 'Herbal Essences', 'Suave Conditioner'],
  ARRAY['Amazon', 'Whole Foods', 'Credo Beauty', 'Direct'],
  true, false
),
(
  'Classic Shampoo',
  'Rahua',
  'haircare',
  90,
  'Made with Rahua oil from the Amazon rainforest (sustainably harvested by indigenous communities). No sulfates, no parabens, no gluten.',
  ARRAY['Organic', 'Vegan', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'silicones', 'DMDM hydantoin'],
  ARRAY['Pantene Shampoo', 'Head & Shoulders', 'TRESemme', 'Herbal Essences'],
  ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Direct'],
  true, false
),
(
  'Nourish Shampoo',
  'Josh Rosebrook',
  'haircare',
  91,
  'Handcrafted with organic herbal infusions and cold-pressed plant oils. No sulfates, no silicones, no synthetic fragrance, no parabens. Made in small batches.',
  ARRAY['Organic', 'Cruelty-Free', 'Made in USA'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'silicones', 'DMDM hydantoin', 'cocamidopropyl betaine'],
  ARRAY['Pantene Shampoo', 'Head & Shoulders', 'TRESemme'],
  ARRAY['Amazon', 'Credo Beauty', 'Direct'],
  true, false
),
(
  'Evening Primrose Shampoo',
  'John Masters Organics',
  'haircare',
  88,
  'Certified organic shampoo for dry hair. No SLS, no parabens, no DEA, no synthetic fragrance. Uses organic evening primrose oil for moisture.',
  ARRAY['USDA Organic', 'Cruelty-Free', 'Vegan'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'DEA', 'DMDM hydantoin'],
  ARRAY['Pantene Shampoo', 'Head & Shoulders', 'TRESemme', 'Herbal Essences'],
  ARRAY['Amazon', 'Whole Foods', 'Sephora', 'Nordstrom'],
  true, false
),
(
  'Kelp & Mint Volumizing Shampoo',
  '100% Pure',
  'haircare',
  87,
  'Colored and scented with natural plant pigments and essential oils. No sulfates, no synthetic fragrance, no silicones. Uses kelp for hair strength.',
  ARRAY['Cruelty-Free', 'Vegan', 'Plant-Based'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'silicones', 'DMDM hydantoin'],
  ARRAY['Pantene Shampoo', 'Head & Shoulders', 'Suave Shampoo'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
);

-- ============================================
-- BODY WASH & SOAP (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Pure-Castile Liquid Soap Unscented',
  'Dr. Bronner''s',
  'soap',
  93,
  'Made with organic and fair trade oils. 100% biodegradable, no synthetic preservatives, no foaming agents, no detergents. Multi-use — body, face, dishes.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'triclosan', 'methylisothiazolinone'],
  ARRAY['Dial Body Wash', 'Dove Body Wash', 'Irish Spring', 'Softsoap'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Natural Body Wash Citrus & Sea Salt',
  'Puracy',
  'soap',
  88,
  'Plant-derived, pH-balanced body wash developed by doctors. No sulfates, no parabens, no synthetic fragrances, no dyes. Hypoallergenic formula.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'triclosan'],
  ARRAY['Dial Body Wash', 'Dove Body Wash', 'Old Spice Body Wash'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Thoroughly Clean Face Wash',
  'Desert Essence',
  'skincare',
  86,
  'Made with organic tea tree oil and naturally derived ingredients. No parabens, no phthalates, no synthetic fragrance, no artificial colors.',
  ARRAY['Non-GMO', 'Vegan', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'artificial colors'],
  ARRAY['Neutrogena Face Wash', 'Clean & Clear', 'St. Ives'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Fantastic Face Wash',
  'Ursa Major',
  'skincare',
  88,
  'Plant-powered gel cleanser with aloe, birch sap, and willow bark. No sulfates, no silicones, no synthetic fragrance, no parabens. B Corp certified.',
  ARRAY['Certified B Corp', 'Vegan', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'silicones', 'PEGs'],
  ARRAY['Cetaphil', 'Neutrogena', 'CeraVe'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Organic Body Wash',
  'Public Goods',
  'soap',
  85,
  'Made with certified organic ingredients. No sulfates, no parabens, no synthetic fragrance. Minimalist, clean formula at an accessible price point.',
  ARRAY['Organic', 'Cruelty-Free', 'Vegan'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'DMDM hydantoin'],
  ARRAY['Dial Body Wash', 'Dove Body Wash', 'Suave Body Wash'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- DEODORANT (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Coconut Deodorant',
  'Kopari',
  'deodorant',
  86,
  'Made with organic coconut oil and plant-based ingredients. No aluminum, no baking soda, no parabens, no synthetic fragrance. Sage and sage extract for odor control.',
  ARRAY['Cruelty-Free', 'Vegan', 'Aluminum Free'],
  ARRAY['aluminum', 'aluminum zirconium', 'parabens', 'synthetic fragrance', 'propylene glycol', 'phthalates'],
  ARRAY['Secret Deodorant', 'Degree Deodorant', 'Dove Deodorant', 'Old Spice'],
  ARRAY['Amazon', 'Target', 'Sephora', 'Ulta'],
  true, false
),
(
  'Baking Soda Free Deodorant Cream',
  'Meow Meow Tweet',
  'deodorant',
  88,
  'Handmade deodorant cream with organic ingredients. No aluminum, no baking soda (gentle on sensitive skin), no synthetic fragrance, no propylene glycol.',
  ARRAY['Organic', 'Vegan', 'Cruelty-Free'],
  ARRAY['aluminum', 'aluminum zirconium', 'parabens', 'synthetic fragrance', 'propylene glycol', 'triclosan'],
  ARRAY['Secret Deodorant', 'Degree Deodorant', 'Dove Deodorant'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Hoppin'' Fresh Deodorant',
  'Ursa Major',
  'deodorant',
  87,
  'Plant-powered deodorant with kaolin clay, hops, and eucalyptus. No aluminum, no parabens, no synthetic fragrance. Certified B Corp.',
  ARRAY['Certified B Corp', 'Vegan', 'Cruelty-Free'],
  ARRAY['aluminum', 'aluminum zirconium', 'parabens', 'synthetic fragrance', 'propylene glycol', 'phthalates'],
  ARRAY['Old Spice', 'Degree', 'Dove Men+Care'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Clean Confidence Deodorant',
  'Type:A',
  'deodorant',
  85,
  'Dermatologist-tested, aluminum-free deodorant with micro-biome friendly formula. No parabens, no phthalates, no baking soda option available.',
  ARRAY['Dermatologist Tested', 'Vegan', 'Cruelty-Free'],
  ARRAY['aluminum', 'aluminum zirconium', 'parabens', 'synthetic fragrance', 'propylene glycol'],
  ARRAY['Secret Deodorant', 'Degree', 'Dove Deodorant'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Refillable Deodorant',
  'Myro',
  'deodorant',
  84,
  'Refillable case design reduces plastic waste by 50%. No aluminum, no parabens, no phthalates. Plant-powered odor protection.',
  ARRAY['Cruelty-Free', 'Vegan', 'Reduced Plastic'],
  ARRAY['aluminum', 'aluminum zirconium', 'parabens', 'synthetic fragrance', 'propylene glycol', 'phthalates'],
  ARRAY['Secret Deodorant', 'Degree', 'Ban Deodorant'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
);

-- ============================================
-- BABY (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Free & Clear Baby Diapers',
  'Seventh Generation',
  'baby',
  88,
  'Made without chlorine bleaching, lotions, or fragrances. No latex, no petroleum-based lotions. FSC certified fluff pulp.',
  ARRAY['FSC Certified', 'Fragrance Free', 'Chlorine Free'],
  ARRAY['chlorine', 'fragrances', 'lotions', 'latex', 'dioxins', 'phthalates'],
  ARRAY['Pampers', 'Huggies', 'Luvs'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Eco-Friendly Diapers',
  'Bambo Nature',
  'baby',
  90,
  'Nordic Swan Ecolabel and FSC certified. No harmful chemicals, no fragrance, no lotions, no latex. Dermatologically tested. Made in Denmark.',
  ARRAY['Nordic Swan Ecolabel', 'FSC Certified', 'Dermatologically Tested'],
  ARRAY['chlorine', 'fragrances', 'lotions', 'latex', 'dioxins', 'phthalates'],
  ARRAY['Pampers', 'Huggies', 'Luvs'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Super Sensitive Shampoo & Body Wash',
  'California Baby',
  'baby',
  91,
  'Allergy-tested, plant-based formula with no common allergens. No synthetic fragrance, no gluten, no soy, no dairy, no nuts. Pediatrician recommended.',
  ARRAY['Plant-Based', 'Allergy Tested', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs', '1,4-dioxane'],
  ARRAY['Johnson''s Baby Shampoo', 'Aveeno Baby', 'Cetaphil Baby'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Diaper Balm',
  'Earth Mama',
  'baby',
  92,
  'USDA Certified Organic diaper cream. No zinc oxide, no petroleum, no parabens, no artificial fragrance. Made with organic herbs and oils.',
  ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['petrolatum', 'mineral oil', 'synthetic fragrance', 'parabens', 'talc', 'BHA'],
  ARRAY['Desitin', 'A+D Ointment', 'Boudreaux''s Butt Paste'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Cotton Baby Wipes',
  'Natracare',
  'baby',
  90,
  'Made with certified organic cotton. No plastic, no parabens, no SLS, no methylisothiazolinone, no alcohol. Biodegradable and compostable.',
  ARRAY['Organic Cotton', 'Biodegradable', 'Cruelty-Free'],
  ARRAY['methylisothiazolinone', 'phenoxyethanol', 'parabens', 'synthetic fragrance', 'SLS', 'polyester'],
  ARRAY['Pampers Wipes', 'Huggies Wipes', 'Cottonelle Wipes'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Honest Baby Wipes',
  'The Honest Company',
  'baby',
  87,
  'Plant-based wipes with 99% water formula. No alcohol, no parabens, no fragrances, no chlorine processing. Hypoallergenic and dermatologist tested.',
  ARRAY['Plant-Based', 'Hypoallergenic', 'Dermatologist Tested'],
  ARRAY['methylisothiazolinone', 'phenoxyethanol', 'synthetic fragrance', 'alcohol', 'chlorine'],
  ARRAY['Pampers Wipes', 'Huggies Wipes', 'Parent''s Choice Wipes'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Costco'],
  true, false
);

-- ============================================
-- BABY FOOD (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Purees',
  'Little Spoon',
  'baby food',
  90,
  'Fresh, organic baby food delivered cold (never shelf-stable). No preservatives, no water fillers, no added sugar. Over 100 organic ingredients sourced.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Preservatives'],
  ARRAY['added sugar', 'citric acid', 'ascorbic acid', 'preservatives', 'water fillers'],
  ARRAY['Gerber Baby Food', 'Beech-Nut', 'Plum Organics'],
  ARRAY['Direct'],
  true, false
),
(
  'Organic Stage 2 Clearly Crafted',
  'Happy Baby',
  'baby food',
  87,
  'USDA Organic with transparent labeling showing exact ingredient amounts. No added sugar, no salt, no preservatives. BPA-free packaging.',
  ARRAY['USDA Organic', 'Non-GMO', 'BPA-Free'],
  ARRAY['added sugar', 'preservatives', 'artificial flavors', 'BPA'],
  ARRAY['Gerber Baby Food', 'Beech-Nut'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
);

-- ============================================
-- SUNSCREEN (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Certified Natural Sunscreen SPF 30',
  'Raw Elements',
  'sunscreen',
  91,
  'Reef-safe, biodegradable mineral sunscreen. Only non-nano zinc oxide for UV protection. No oxybenzone, no octinoxate, no chemical UV filters.',
  ARRAY['Reef Safe', 'Non-Nano Zinc', 'Certified Natural'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'octocrylene', 'synthetic fragrance'],
  ARRAY['Banana Boat', 'Coppertone', 'Neutrogena Sunscreen', 'Hawaiian Tropic'],
  ARRAY['Amazon', 'Whole Foods', 'REI', 'Direct'],
  true, false
),
(
  'Sheer Zinc Sunscreen SPF 30',
  'Babo Botanicals',
  'sunscreen',
  89,
  'Zinc-only mineral sunscreen safe for babies and sensitive skin. No chemical UV filters, no synthetic fragrance, no parabens. EWG Verified.',
  ARRAY['EWG Verified', 'Non-Nano Zinc', 'Cruelty-Free'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'synthetic fragrance', 'parabens'],
  ARRAY['Banana Boat', 'Coppertone', 'Neutrogena Sunscreen'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Thinksport SPF 50+ Sunscreen',
  'Think',
  'sunscreen',
  90,
  'Highest rated sunscreen by EWG for safety. Non-nano zinc oxide only. No biologically harmful chemicals, no avobenzone, no oxybenzone.',
  ARRAY['EWG Top Rated', 'Non-Nano Zinc', 'Reef Safe'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'octocrylene', 'synthetic fragrance'],
  ARRAY['Banana Boat', 'Coppertone', 'Neutrogena Sunscreen', 'Hawaiian Tropic'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'REI'],
  true, false
),
(
  'Sunglow SPF 35',
  'Kinfield',
  'sunscreen',
  86,
  'Lightweight mineral sunscreen with a subtle glow finish. Non-nano zinc oxide, no oxybenzone, no octinoxate. Reef-safe and outdoor-focused brand.',
  ARRAY['Reef Safe', 'Non-Nano Zinc', 'Cruelty-Free'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'synthetic fragrance'],
  ARRAY['Banana Boat', 'Coppertone', 'Sun Bum'],
  ARRAY['Amazon', 'REI', 'Direct'],
  true, false
);

-- ============================================
-- ORAL CARE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'All-One Toothpaste Peppermint',
  'Dr. Bronner''s',
  'oral care',
  87,
  'Organic and fair trade ingredients. No synthetic detergents (SLS), no artificial sweeteners, no preservatives, no fluoride, no artificial colors.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['SLS', 'triclosan', 'artificial sweeteners', 'artificial colors', 'propylene glycol', 'DEA'],
  ARRAY['Colgate', 'Crest', 'Aquafresh', 'Sensodyne'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Toothpaste Bits Mint',
  'Bite',
  'oral care',
  86,
  'Plastic-free toothpaste tablets in a glass jar. No SLS, no fluoride, no artificial flavors, no preservatives. Nano-hydroxyapatite for enamel support.',
  ARRAY['Plastic-Free', 'Vegan', 'Cruelty-Free'],
  ARRAY['SLS', 'triclosan', 'artificial sweeteners', 'artificial colors', 'microplastics', 'propylene glycol'],
  ARRAY['Colgate', 'Crest', 'Arm & Hammer'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Natural Toothpaste Sensitive',
  'Wellnesse',
  'oral care',
  85,
  'Formulated with hydroxyapatite and green tea extract. No SLS, no glycerin (which can coat teeth), no fluoride, no artificial ingredients. Founded by wellness expert.',
  ARRAY['Non-GMO', 'Cruelty-Free', 'Made in USA'],
  ARRAY['SLS', 'triclosan', 'artificial sweeteners', 'artificial colors', 'propylene glycol'],
  ARRAY['Colgate Sensitive', 'Sensodyne', 'Crest'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- SUPPLEMENTS (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Essential for Women Multivitamin',
  'Ritual',
  'supplement',
  88,
  'Traceable ingredients with visible supply chain. Delayed-release capsule for better absorption. No artificial colorants, no synthetic fillers, no GMOs.',
  ARRAY['Non-GMO', 'Third-Party Tested', 'Vegan', 'Certified B Corp'],
  ARRAY['titanium dioxide', 'artificial colors', 'magnesium stearate', 'talc', 'BHT', 'hydrogenated oils'],
  ARRAY['Centrum Women', 'One A Day Women''s', 'Nature Made Multi'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'AG1 Daily Greens Powder',
  'Athletic Greens',
  'supplement',
  85,
  '75 vitamins, minerals, and whole food sourced ingredients. No artificial colors, no artificial preservatives, no artificial sweeteners. NSF Certified for Sport.',
  ARRAY['NSF Certified', 'Non-GMO', 'No Artificial Sweeteners'],
  ARRAY['artificial colors', 'artificial sweeteners', 'magnesium stearate', 'titanium dioxide', 'maltodextrin'],
  ARRAY['Emergen-C', 'Airborne', 'Centrum Multivitamin'],
  ARRAY['Amazon', 'Direct'],
  true, false
);
