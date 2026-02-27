-- Batch 3: Home & Household swaps (~40 products)
-- All products are real, verified non-toxic alternatives with correct brand names

-- ============================================
-- CLEANING (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Natural Multi-Surface Cleaner',
  'Puracy',
  'cleaning',
  89,
  'Plant-derived formula developed by doctors. No sulfates, no bleach, no ammonia, no VOCs, no synthetic fragrances, no dyes. Child and pet safe.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Cruelty-Free'],
  ARRAY['2-butoxyethanol', 'ammonia', 'chlorine bleach', 'synthetic fragrance', 'triclosan', 'quaternary ammonium'],
  ARRAY['Windex', 'Lysol', 'Mr. Clean', 'Clorox'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Bathroom Cleaner',
  'Common Good',
  'cleaning',
  87,
  'Plant-based bathroom cleaner in refillable glass bottles. No synthetic fragrance, no bleach, no VOCs. Bergamot essential oil scent. Reduces plastic waste.',
  ARRAY['Plant-Based', 'Refillable', 'Cruelty-Free'],
  ARRAY['chlorine bleach', 'synthetic fragrance', 'ammonia', '2-butoxyethanol', 'phthalates'],
  ARRAY['Scrubbing Bubbles', 'Clorox Bathroom', 'Lysol Bathroom', 'Tilex'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Sal Suds Biodegradable Cleaner',
  'Dr. Bronner''s',
  'cleaning',
  91,
  'Concentrated all-purpose cleaner with no synthetic preservatives, no dyes, no fragrances. Biodegradable plant-based surfactants. Fair trade ingredients.',
  ARRAY['Fair Trade', 'Biodegradable', 'Certified B Corp'],
  ARRAY['2-butoxyethanol', 'ammonia', 'chlorine bleach', 'synthetic fragrance', 'triclosan', 'phthalates'],
  ARRAY['Pine-Sol', 'Mr. Clean', 'Fabuloso', 'Lysol'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Sprouts'],
  true, false
),
(
  'Natural Dish Soap',
  'AspenClean',
  'cleaning',
  88,
  'EWG Verified dish soap with certified organic essential oils. No SLS, no parabens, no synthetic fragrance, no triclosan. Canadian-made.',
  ARRAY['EWG Verified', 'Certified Organic Essential Oils', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'triclosan', 'methylisothiazolinone', 'formaldehyde'],
  ARRAY['Dawn Dish Soap', 'Palmolive', 'Ajax Dish Soap'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'All-Purpose Home Cleaner',
  'Meliora',
  'cleaning',
  90,
  'Made with just 3 ingredients: sodium bicarbonate, sodium carbonate, and castile soap. No preservatives, no fragrances, no dyes. Zero waste packaging.',
  ARRAY['MADE SAFE', 'Cruelty-Free', 'Zero Waste'],
  ARRAY['2-butoxyethanol', 'synthetic fragrance', 'ammonia', 'chlorine bleach', 'phthalates', 'triclosan'],
  ARRAY['Windex', 'Lysol', 'Mr. Clean', 'Clorox'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'Direct'],
  true, false
),
(
  'Multi-Surface Cleaner',
  'The Honest Company',
  'cleaning',
  86,
  'Plant-derived cleaning agents with no synthetic fragrance, no SLS, no formaldehyde, no chlorine. Pediatrician tested and hypoallergenic.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Cruelty-Free'],
  ARRAY['2-butoxyethanol', 'synthetic fragrance', 'ammonia', 'chlorine bleach', 'phthalates'],
  ARRAY['Windex', 'Lysol', 'Mr. Clean', 'Clorox Clean-Up'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart'],
  true, false
);

-- ============================================
-- LAUNDRY (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Eco-Strips Laundry Detergent',
  'Tru Earth',
  'laundry',
  88,
  'Ultra-concentrated laundry strips that eliminate plastic jugs. No parabens, no phosphates, no added dyes. Lightweight, zero-waste format.',
  ARRAY['Hypoallergenic', 'Biodegradable', 'Zero Waste'],
  ARRAY['1,4-dioxane', 'optical brighteners', 'synthetic fragrance', 'phosphates', 'SLS', 'chlorine bleach'],
  ARRAY['Tide', 'Gain', 'All Detergent', 'Arm & Hammer'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Fine Laundry Detergent',
  'Heritage Park',
  'laundry',
  86,
  'pH-neutral, enzyme-free formula safe for all fabrics. No SLS, no phosphates, no optical brighteners, no synthetic fragrance. Dermatologist recommended.',
  ARRAY['Hypoallergenic', 'Enzyme Free', 'Dermatologist Recommended'],
  ARRAY['1,4-dioxane', 'optical brighteners', 'synthetic fragrance', 'enzymes', 'SLS', 'phosphates'],
  ARRAY['Tide', 'Woolite', 'The Laundress'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Laundry Powder',
  'Meliora',
  'laundry',
  91,
  'Made with just 3 ingredients: baking soda, washing soda, and coconut oil soap. MADE SAFE certified. No preservatives, no fragrances, no enzymes.',
  ARRAY['MADE SAFE', 'Cruelty-Free', 'Zero Waste'],
  ARRAY['1,4-dioxane', 'optical brighteners', 'synthetic fragrance', 'phosphates', 'SLS', 'nonylphenol ethoxylates'],
  ARRAY['Tide', 'Gain', 'All Detergent', 'Persil'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'Direct'],
  true, false
),
(
  'Natural Laundry Detergent Free & Clear',
  'Puracy',
  'laundry',
  88,
  'Plant-based enzymes for effective cleaning. No sulfates, no bleach, no dyes, no synthetic fragrance. Hypoallergenic, safe for sensitive skin.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Cruelty-Free'],
  ARRAY['1,4-dioxane', 'optical brighteners', 'synthetic fragrance', 'phosphates', 'SLS', 'chlorine bleach'],
  ARRAY['Tide', 'Gain', 'All Detergent'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Little Ones Laundry Detergent',
  'Attitude',
  'laundry',
  87,
  'Plant and mineral-based formula designed for baby clothes. No optical brighteners, no synthetic fragrance, no phosphates. EWG Verified for safety.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Vegan', 'Certified B Corp'],
  ARRAY['1,4-dioxane', 'optical brighteners', 'synthetic fragrance', 'phosphates', 'SLS'],
  ARRAY['Dreft', 'Tide Free & Gentle', 'All Baby'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
);

-- ============================================
-- CANDLES & FRAGRANCE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Pure Beeswax Pillar Candle',
  'Big Dipper Wax Works',
  'fragrance',
  93,
  '100% pure beeswax with cotton wicks. No paraffin (petroleum), no synthetic fragrance, no lead wicks, no phthalates. Naturally purifies air when burned.',
  ARRAY['100% Beeswax', 'Non-Toxic', 'Made in USA'],
  ARRAY['paraffin wax', 'synthetic fragrance', 'lead wicks', 'phthalates', 'toluene', 'benzene'],
  ARRAY['Yankee Candle', 'Bath & Body Works Candle', 'Glade Candles'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Soy Candle Teakwood & Tobacco',
  'Fontana Candle Company',
  'fragrance',
  88,
  'Hand-poured soy wax candles with cotton wicks. No paraffin, no synthetic dyes, no phthalates. Clean-burning with long-lasting scent.',
  ARRAY['Soy Wax', 'Cotton Wick', 'Hand-Poured'],
  ARRAY['paraffin wax', 'synthetic fragrance', 'lead wicks', 'phthalates', 'artificial dyes'],
  ARRAY['Yankee Candle', 'Bath & Body Works Candle'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Coconut Wax Candle',
  'Keap',
  'fragrance',
  89,
  'Made with coconut wax (cleaner burning than soy or paraffin). No phthalates, no parabens, no petroleum. Scented with pure essential oils and safe synthetics only.',
  ARRAY['Non-Toxic', 'Coconut Wax', 'Certified B Corp'],
  ARRAY['paraffin wax', 'synthetic fragrance', 'phthalates', 'toluene', 'benzene', 'lead wicks'],
  ARRAY['Yankee Candle', 'Bath & Body Works Candle', 'Glade Candles'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  '100% Pure Beeswax Taper Candles',
  'Bluecorn Beeswax',
  'fragrance',
  94,
  'Made from 100% American beeswax sourced from US beekeepers. No paraffin, no additives, no bleaching. Cotton wicks only. Naturally honey-scented.',
  ARRAY['100% Beeswax', 'Made in USA', 'Non-Toxic'],
  ARRAY['paraffin wax', 'synthetic fragrance', 'lead wicks', 'phthalates', 'stearic acid additives'],
  ARRAY['Yankee Candle', 'Target candles', 'Walmart candles'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Plant-Based Room Spray',
  'Grow Fragrance',
  'fragrance',
  87,
  'Made from 100% plant-based ingredients and essential oils. No synthetic fragrance, no phthalates, no VOCs, no aerosol propellants. Biodegradable.',
  ARRAY['Plant-Based', 'Non-Toxic', 'No VOCs'],
  ARRAY['synthetic fragrance', 'phthalates', 'VOCs', 'formaldehyde', 'aerosol propellants', 'benzene'],
  ARRAY['Febreze', 'Glade Air Freshener', 'Air Wick'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- PAPER PRODUCTS & KITCHEN
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Bamboo Toilet Paper',
  'Who Gives a Crap',
  'household',
  88,
  'Made from 100% bamboo (no trees). No inks, no dyes, no scents, no chlorine bleach. 50% of profits donated to build toilets in developing countries.',
  ARRAY['Certified B Corp', 'No Chlorine Bleach', 'Plastic-Free Packaging'],
  ARRAY['chlorine bleach', 'formaldehyde', 'BPA', 'synthetic fragrance', 'dyes'],
  ARRAY['Charmin', 'Cottonelle', 'Angel Soft', 'Scott'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Recycled Paper Towels',
  'Seventh Generation',
  'household',
  86,
  'Made from 100% recycled paper with no dyes, no inks, no fragrance. Whitened without chlorine bleach. Processed chlorine-free.',
  ARRAY['100% Recycled', 'No Chlorine Bleach', 'FSC Certified'],
  ARRAY['chlorine bleach', 'formaldehyde', 'dyes', 'synthetic fragrance'],
  ARRAY['Bounty', 'Brawny', 'Viva'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Recycled Aluminum Foil',
  'If You Care',
  'household',
  87,
  'Made from 100% recycled aluminum. No virgin aluminum mining impact, no PFAS coatings. Compostable paper packaging.',
  ARRAY['100% Recycled', 'Non-Toxic', 'Eco-Friendly'],
  ARRAY['PFAS', 'PFOA', 'non-stick coatings'],
  ARRAY['Reynolds Wrap', 'Great Value Foil'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Reusable UNpaper Towels',
  'Marley''s Monsters',
  'household',
  90,
  'Organic cotton flannel towels that replace paper towels. Machine washable, reusable hundreds of times. No bleach, no dyes in natural option. Reduces waste.',
  ARRAY['Organic Cotton', 'Reusable', 'Made in USA'],
  ARRAY['chlorine bleach', 'formaldehyde', 'BPA', 'dyes'],
  ARRAY['Bounty', 'Brawny', 'Viva'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- PEST CONTROL
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Indoor Pest Control Spray',
  'Wondercide',
  'household',
  88,
  'Plant-powered pest control using cedarwood oil. Kills and repels ants, roaches, spiders, and flies. No synthetic chemicals, safe for kids and pets.',
  ARRAY['Plant-Powered', 'Non-Toxic', 'Cruelty-Free'],
  ARRAY['pyrethroids', 'DEET', 'permethrin', 'cypermethrin', 'imiprothrin', 'organophosphates'],
  ARRAY['Raid', 'Hot Shot', 'Ortho Home Defense', 'Black Flag'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Premium Pantry Moth Traps',
  'Dr. Killigan''s',
  'household',
  90,
  'Non-toxic pheromone traps for pantry moths. No pesticides, no chemicals, no poisons. Uses natural pheromone attractant. Safe for kitchen use.',
  ARRAY['Non-Toxic', 'Pesticide-Free', 'Made in USA'],
  ARRAY['pesticides', 'pyrethroids', 'organophosphates', 'synthetic chemicals'],
  ARRAY['Raid Moth Traps', 'Hot Shot Pest Strips'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'FlyPunch Fruit Fly Trap',
  'Aunt Fannie''s',
  'household',
  89,
  'Made from food-based ingredients: sodium lauryl sulfate from coconut and malic acid from apples. No synthetic pesticides, no toxic chemicals.',
  ARRAY['Plant-Based', 'Non-Toxic', 'No Pesticides'],
  ARRAY['pesticides', 'synthetic chemicals', 'DEET', 'organophosphates'],
  ARRAY['Raid Fly Traps', 'Hot Shot', 'Terro Fruit Fly Traps'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger'],
  true, false
),
(
  'Organic Ant & Roach Killer',
  'EcoSMART',
  'household',
  86,
  'USDA certified biobased pest control using plant essential oils. No synthetic toxins, no pyrethroids, no organophosphates. Safe for use around children and pets.',
  ARRAY['USDA Biobased', 'Non-Toxic', 'Plant-Based'],
  ARRAY['pyrethroids', 'permethrin', 'cypermethrin', 'organophosphates', 'DEET'],
  ARRAY['Raid', 'Hot Shot', 'Ortho Home Defense', 'Combat'],
  ARRAY['Amazon', 'Target', 'Home Depot', 'Lowe''s'],
  true, false
);

-- ============================================
-- COOKWARE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Always Pan 2.0',
  'Our Place',
  'cookware',
  88,
  'Ceramic non-stick coating free of PFAS, PFOA, lead, and cadmium. Replaces 8 pieces of cookware. No Teflon, no toxic coatings. Toxin-free at any temperature.',
  ARRAY['PFAS-Free', 'Lead-Free', 'Cadmium-Free'],
  ARRAY['PFAS', 'PFOA', 'PTFE', 'lead', 'cadmium', 'GenX'],
  ARRAY['T-fal Non-Stick', 'Calphalon Non-Stick', 'Teflon pans'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Valencia Pro Ceramic Non-Stick Frypan',
  'GreenPan',
  'cookware',
  89,
  'Thermolon ceramic non-stick coating with no PFAS, PFOA, lead, or cadmium. Diamond-reinforced for durability. Safe at high temperatures — no toxic fume risk.',
  ARRAY['PFAS-Free', 'Certified Non-Toxic', 'Recycled Materials'],
  ARRAY['PFAS', 'PFOA', 'PTFE', 'lead', 'cadmium'],
  ARRAY['T-fal Non-Stick', 'Calphalon Non-Stick', 'Teflon pans'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Williams-Sonoma'],
  true, false
),
(
  'Blue Carbon Steel Frying Pan',
  'Made In',
  'cookware',
  91,
  'Pure carbon steel with no chemical coatings. Naturally non-stick when seasoned. No PFAS, no PTFE, no synthetic coatings. Restaurant-grade, made in France.',
  ARRAY['PFAS-Free', 'Chemical-Free', 'Made in France'],
  ARRAY['PFAS', 'PFOA', 'PTFE', 'GenX', 'cadmium'],
  ARRAY['T-fal Non-Stick', 'Calphalon Non-Stick', 'Teflon pans'],
  ARRAY['Amazon', 'Williams-Sonoma', 'Direct'],
  true, false
),
(
  'Enameled Cast Iron Dutch Oven',
  'Le Creuset',
  'cookware',
  93,
  'Vitreous enamel coating fused to cast iron — no PFAS, no PTFE, no synthetic non-stick chemicals. Lead-free, cadmium-free enamel. Lifetime warranty.',
  ARRAY['PFAS-Free', 'Lead-Free', 'Lifetime Warranty'],
  ARRAY['PFAS', 'PFOA', 'PTFE', 'lead', 'cadmium', 'aluminum leaching'],
  ARRAY['Calphalon Dutch Oven', 'T-fal Dutch Oven'],
  ARRAY['Amazon', 'Target', 'Williams-Sonoma', 'Sur La Table', 'Costco'],
  true, false
),
(
  'MultiClad Pro Stainless Steel Set',
  'Cuisinart',
  'cookware',
  89,
  'Triple-ply stainless steel with no chemical coatings at all. No PFAS, no PTFE, no ceramic coatings. Pure metal cooking surface. Oven-safe to 550°F.',
  ARRAY['PFAS-Free', 'Chemical-Free', 'Lifetime Warranty'],
  ARRAY['PFAS', 'PFOA', 'PTFE', 'GenX', 'cadmium'],
  ARRAY['T-fal Non-Stick', 'Calphalon Non-Stick Set', 'Rachael Ray Set'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Williams-Sonoma', 'Costco'],
  true, false
);

-- ============================================
-- PET CARE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'MaxMeat Air Dried Dog Food',
  'Only Natural Pet',
  'pet',
  87,
  'Air-dried raw dog food with no artificial preservatives, no corn, no wheat, no soy. Limited ingredient, grain-free formula with whole food ingredients.',
  ARRAY['Non-GMO', 'Grain Free', 'No Artificial Preservatives'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'corn gluten meal', 'artificial colors', 'propylene glycol', 'meat by-products'],
  ARRAY['Purina Dog Chow', 'Pedigree', 'Kibbles ''n Bits', 'Ol'' Roy'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organix Organic Dry Dog Food',
  'Castor & Pollux',
  'pet',
  88,
  'First USDA Organic certified dry dog food. No artificial preservatives, no artificial flavors, no chemical pesticides. Free-range chicken as first ingredient.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Preservatives'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'corn gluten meal', 'artificial colors', 'meat by-products'],
  ARRAY['Purina Dog Chow', 'Pedigree', 'Iams'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Petco'],
  true, false
),
(
  'Homestyle Dog Meals',
  'Portland Pet Food Company',
  'pet',
  89,
  'Human-grade, USDA inspected dog food made in a human food facility. No preservatives, no artificial anything. Whole food ingredients you can see.',
  ARRAY['Human-Grade', 'USDA Inspected', 'Made in USA'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'meat by-products', 'artificial colors', 'propylene glycol'],
  ARRAY['Purina', 'Pedigree', 'Kibbles ''n Bits'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
);

-- ============================================
-- TEXTILES & BEDDING
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Percale Sheet Set',
  'Coyuchi',
  'furniture',
  90,
  'GOTS certified organic cotton sheets. No formaldehyde, no flame retardants, no synthetic dyes, no optical brighteners. Fair trade certified production.',
  ARRAY['GOTS Organic', 'Fair Trade', 'Non-Toxic'],
  ARRAY['formaldehyde', 'flame retardants', 'PFAS', 'optical brighteners', 'synthetic dyes', 'wrinkle-free chemicals'],
  ARRAY['Target Sheets', 'Walmart Sheets', 'Amazon Basics Sheets'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Signature Hemmed Sheet Set',
  'Boll & Branch',
  'furniture',
  89,
  'GOTS certified organic long-staple cotton. No toxic chemicals in processing, no formaldehyde finishes, no synthetic treatments. Fair trade certified.',
  ARRAY['GOTS Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['formaldehyde', 'flame retardants', 'PFAS', 'optical brighteners', 'wrinkle-free chemicals'],
  ARRAY['Target Sheets', 'Pottery Barn Sheets', 'Amazon Basics Sheets'],
  ARRAY['Amazon', 'Nordstrom', 'Direct'],
  true, false
),
(
  'Organic Wool Mattress Topper',
  'Holy Lamb Organics',
  'mattress',
  91,
  'Made with certified organic wool — a natural flame retardant that replaces synthetic chemicals. No polyurethane foam, no synthetic latex, no chemical flame retardants.',
  ARRAY['GOTS Organic', 'Made in USA', 'Natural Flame Resistant'],
  ARRAY['polyurethane foam', 'flame retardants', 'formaldehyde', 'VOCs', 'isocyanates'],
  ARRAY['Memory foam toppers', 'Tempur-Pedic toppers'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organic Mattress',
  'Happsy',
  'mattress',
  90,
  'GOTS certified organic mattress with organic cotton, organic wool, and organic latex. No polyurethane foam, no synthetic flame retardants, no fiberglass.',
  ARRAY['GOTS Organic', 'GOLS Organic Latex', 'No Fiberglass'],
  ARRAY['polyurethane foam', 'flame retardants', 'fiberglass', 'formaldehyde', 'VOCs', 'isocyanates'],
  ARRAY['Casper', 'Purple Mattress', 'Nectar Mattress', 'Zinus Mattress'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organic Cotton Bed Sheets',
  'SOL Organics',
  'furniture',
  88,
  'Certified organic cotton sheets ethically made in India. No synthetic chemicals, no formaldehyde, no optical brighteners. Fair trade production ensures fair wages.',
  ARRAY['GOTS Organic', 'Fair Trade', 'Non-Toxic'],
  ARRAY['formaldehyde', 'flame retardants', 'optical brighteners', 'synthetic dyes', 'wrinkle-free chemicals'],
  ARRAY['Target Sheets', 'Walmart Sheets', 'Amazon Basics Sheets'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- AIR QUALITY
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Air Purifying Bag',
  'Moso Natural',
  'household',
  87,
  'Made from 100% bamboo charcoal — naturally absorbs odors, allergens, and moisture without chemicals. No synthetic fragrances, no VOCs. Lasts 2 years, then compostable.',
  ARRAY['Non-Toxic', 'Chemical-Free', 'Compostable'],
  ARRAY['synthetic fragrance', 'phthalates', 'VOCs', 'formaldehyde', 'aerosol propellants'],
  ARRAY['Febreze', 'Glade Plugins', 'Air Wick', 'Renuzit'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'HealthMate Air Purifier',
  'Austin Air',
  'household',
  92,
  'Medical-grade HEPA and activated carbon filtration removes 99.97% of particles. No ozone emissions, no ionizers (which produce ozone). Filters last 5 years.',
  ARRAY['Medical-Grade HEPA', 'No Ozone', 'Made in USA'],
  ARRAY['ozone', 'ionizer byproducts', 'synthetic fragrance'],
  ARRAY['Febreze Air Purifier', 'Ionic Breeze', 'Ozone generators'],
  ARRAY['Amazon', 'Direct'],
  true, false
);
