-- Batch: Personal Care Specialty, Feminine Care, Nail Care, More Food (~40 products)
-- All products are real, verified non-toxic alternatives

-- ============================================
-- FEMININE CARE (organic cotton alternatives)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Cotton Tampons',
  'Cora',
  'personal_care',
  91,
  'Made from 100% certified organic cotton. No chlorine bleaching, no pesticides, no fragrances, no dyes, no rayon. BPA-free applicator. Hypoallergenic.',
  ARRAY['Organic Cotton', 'Chlorine-Free', 'Hypoallergenic'],
  ARRAY['rayon', 'chlorine bleach', 'dioxins', 'synthetic fragrance', 'pesticide residues', 'BPA'],
  ARRAY['Tampax', 'Playtex', 'Kotex', 'o.b.'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart'],
  true, false
),
(
  'Organic Cotton Menstrual Pads',
  'Rael',
  'personal_care',
  90,
  'Certified organic cotton top sheet with no chlorine bleaching, no fragrances, no dyes. Individually wrapped in compostable packaging. Dermatologist tested.',
  ARRAY['Organic Cotton', 'Dermatologist Tested', 'Chlorine-Free'],
  ARRAY['rayon', 'chlorine bleach', 'dioxins', 'synthetic fragrance', 'plastic film', 'pesticide residues'],
  ARRAY['Always', 'Stayfree', 'Kotex Pads'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true, false
),
(
  'Organic Cotton Pads Ultra Super',
  'Natracare',
  'personal_care',
  92,
  'Pioneer of organic feminine care since 1989. 100% organic cotton, no plastic, no chlorine, no synthetic materials touching skin. Totally chlorine-free (TCF) process.',
  ARRAY['Organic Cotton', 'Plastic-Free', 'TCF Bleached'],
  ARRAY['rayon', 'chlorine bleach', 'dioxins', 'synthetic fragrance', 'plastic film', 'SAP gel'],
  ARRAY['Always', 'Stayfree', 'Kotex Pads'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Saalt Soft Menstrual Cup',
  'Saalt',
  'personal_care',
  93,
  'Medical-grade silicone menstrual cup — no BPA, no latex, no dyes, no chemicals. Reusable for up to 10 years, replacing thousands of disposable products. FDA registered.',
  ARRAY['Medical-Grade Silicone', 'FDA Registered', 'Reusable 10 Years'],
  ARRAY['rayon', 'chlorine bleach', 'dioxins', 'synthetic fragrance', 'BPA', 'plastic'],
  ARRAY['Tampax', 'Playtex', 'disposable tampons'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Direct'],
  true, false
);

-- ============================================
-- HAND SANITIZER (clean alternatives)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Hand Sanitizer Lavender',
  'Dr. Bronner''s',
  'soap',
  88,
  'Made with organic ethanol from sugarcane, organic essential oils, and organic glycerin. No synthetic fragrance, no triclosan, no benzalkonium chloride.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['triclosan', 'benzalkonium chloride', 'synthetic fragrance', 'parabens', 'phthalates', 'propylene glycol'],
  ARRAY['Purell', 'Germ-X', 'Bath & Body Works Hand Sanitizer'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Hand Sanitizer',
  'Pipette',
  'soap',
  86,
  'Made with sugarcane-derived ethanol. No synthetic fragrances, no harsh chemicals. Moisturizing formula with squalane so it doesn''t dry out hands. Safe for families.',
  ARRAY['Plant-Derived', 'Non-Drying', 'Dermatologist Tested'],
  ARRAY['triclosan', 'benzalkonium chloride', 'synthetic fragrance', 'parabens', 'propylene glycol'],
  ARRAY['Purell', 'Germ-X'],
  ARRAY['Amazon', 'Target'],
  true, false
),
(
  'Organic Hand Sanitizer Spray',
  'EO Products',
  'soap',
  87,
  'USDA Certified Organic hand sanitizer with organic ethanol and organic essential oils. No synthetic fragrance, no triclosan. Plant-based ingredients.',
  ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['triclosan', 'benzalkonium chloride', 'synthetic fragrance', 'parabens', 'phthalates'],
  ARRAY['Purell', 'Germ-X', 'generic hand sanitizers'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- LIP CARE (clean alternatives)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Moon Balm Lip Treatment',
  'Hurraw!',
  'skincare',
  90,
  'Raw, organic, vegan lip balm with blue chamomile. No petroleum, no synthetic fragrance, no parabens, no GMOs. Cold-pressed organic oils and butters only.',
  ARRAY['Organic', 'Vegan', 'Non-GMO'],
  ARRAY['petrolatum', 'mineral oil', 'synthetic fragrance', 'parabens', 'BHT', 'phenoxyethanol'],
  ARRAY['Chapstick', 'Carmex', 'Blistex', 'EOS Lip Balm'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Organic Lip Balm Peppermint',
  'Dr. Bronner''s',
  'skincare',
  89,
  'USDA Certified Organic lip balm with organic beeswax, organic oils, and organic peppermint. No petroleum derivatives, no synthetic flavors, no parabens.',
  ARRAY['USDA Organic', 'Fair Trade', 'Non-GMO'],
  ARRAY['petrolatum', 'mineral oil', 'synthetic fragrance', 'parabens', 'BHT', 'artificial flavors'],
  ARRAY['Chapstick', 'Carmex', 'Blistex'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Lip Balm',
  'S.W. Basics',
  'skincare',
  88,
  'Made with just 3 organic ingredients: coconut oil, shea butter, and vanilla extract. No synthetic anything — the most minimal lip balm possible. Handmade in Brooklyn.',
  ARRAY['Organic', 'Vegan', 'Minimal Ingredients'],
  ARRAY['petrolatum', 'mineral oil', 'synthetic fragrance', 'parabens', 'phenoxyethanol'],
  ARRAY['Chapstick', 'Carmex', 'Blistex', 'EOS Lip Balm'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Direct'],
  true, false
);

-- ============================================
-- BODY LOTION (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Everyday Shea Body Lotion',
  'Alaffia',
  'skincare',
  86,
  'Fair trade shea butter and virgin coconut oil. No synthetic fragrance, no parabens, no mineral oil, no petroleum. Empowers West African communities.',
  ARRAY['Fair Trade', 'Cruelty-Free', 'Certified B Corp'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs'],
  ARRAY['Jergens', 'Vaseline Lotion', 'Lubriderm', 'Suave Body Lotion'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Hand & Body Lotion',
  'Dr. Bronner''s',
  'skincare',
  88,
  'USDA Certified Organic with organic jojoba oil, organic coconut oil, and organic hemp seed oil. No synthetic preservatives, no detergents, no petrochemicals.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'DMDM hydantoin'],
  ARRAY['Jergens', 'Vaseline Lotion', 'Lubriderm', 'Aveeno Lotion'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Seriously Soothing Body Lotion',
  'Acure',
  'skincare',
  85,
  'Made with organic argan oil and cocoa butter. No parabens, no sulfates, no mineral oil, no petrolatum, no formaldehyde. EWG Verified for safety.',
  ARRAY['EWG Verified', 'Vegan', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs'],
  ARRAY['Jergens', 'Lubriderm', 'Aveeno Lotion', 'Eucerin'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Nourishing Body Lotion',
  'Everyone',
  'skincare',
  84,
  'Plant-based body lotion with essential oils. No synthetic fragrance, no parabens, no artificial colors. EWG Verified. Affordable clean body care.',
  ARRAY['EWG Verified', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'synthetic fragrance', 'parabens', 'phthalates', 'DMDM hydantoin'],
  ARRAY['Jergens', 'Vaseline Lotion', 'Suave Body Lotion'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
);

-- ============================================
-- NAIL CARE (toxin-free polish)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Breathable Nail Polish',
  'Ella+Mila',
  'nail_care',
  83,
  '17-free nail polish — free of 17 toxic chemicals including formaldehyde, toluene, DBP, camphor, and TPHP. Vegan, cruelty-free, and chip-resistant.',
  ARRAY['17-Free', 'Vegan', 'Cruelty-Free'],
  ARRAY['formaldehyde', 'toluene', 'DBP', 'camphor', 'TPHP', 'formaldehyde resin', 'xylene'],
  ARRAY['OPI', 'Essie', 'Sally Hansen', 'Revlon Nail Polish'],
  ARRAY['Amazon', 'Target', 'Ulta', 'Direct'],
  true, false
),
(
  'Water-Based Nail Polish',
  'Suncoat',
  'nail_care',
  86,
  'Water-based formula — the cleanest nail polish available. No chemical solvents, no toluene, no formaldehyde, no DBP, no camphor. Peels off, no remover needed.',
  ARRAY['Water-Based', 'Non-Toxic', 'Peel-Off'],
  ARRAY['formaldehyde', 'toluene', 'DBP', 'camphor', 'acetone', 'ethyl acetate', 'butyl acetate'],
  ARRAY['OPI', 'Essie', 'Sally Hansen'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Toxin-Free Nail Polish',
  'Zoya',
  'nail_care',
  84,
  '10-free professional nail lacquer. No formaldehyde, no toluene, no DBP, no formaldehyde resin, no camphor. Longest-wearing natural nail polish on the market.',
  ARRAY['10-Free', 'Vegan', 'Cruelty-Free'],
  ARRAY['formaldehyde', 'toluene', 'DBP', 'camphor', 'formaldehyde resin', 'TPHP', 'xylene'],
  ARRAY['OPI', 'Essie', 'Sally Hansen', 'CND Vinylux'],
  ARRAY['Amazon', 'Ulta', 'Direct'],
  true, false
);

-- ============================================
-- KIDS PRODUCTS (beyond baby age)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Silly Strawberry Kids Fluoride-Free Toothpaste',
  'Tom''s of Maine',
  'oral_care',
  84,
  'ADA accepted, fluoride-free kids toothpaste with real strawberry flavor. No artificial dyes, no artificial preservatives, no SLS. Made in the USA.',
  ARRAY['ADA Accepted', 'No Artificial Dyes', 'Cruelty-Free'],
  ARRAY['SLS', 'triclosan', 'artificial sweeteners', 'artificial colors', 'propylene glycol', 'DEA'],
  ARRAY['Colgate Kids', 'Crest Kids', 'Aquafresh Kids'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart', 'CVS'],
  true, false
),
(
  'Kids Sunscreen SPF 40',
  'Badger',
  'sunscreen',
  91,
  'Zinc oxide only mineral sunscreen for kids. USDA Certified Organic, reef-safe, water-resistant 40 minutes. No chemical UV filters, no synthetic fragrance.',
  ARRAY['USDA Organic', 'Reef Safe', 'Non-Nano Zinc'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'synthetic fragrance', 'parabens'],
  ARRAY['Banana Boat Kids', 'Coppertone Kids', 'Neutrogena Kids'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'REI'],
  true, false
),
(
  'Kids 2-in-1 Shampoo + Body Wash',
  'The Honest Company',
  'baby',
  86,
  'Tear-free formula with no sulfates, no parabens, no synthetic fragrance, no dyes, no phthalates. Dermatologist and pediatrician tested. EWG Verified.',
  ARRAY['EWG Verified', 'Tear-Free', 'Dermatologist Tested'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', '1,4-dioxane', 'artificial dyes'],
  ARRAY['Johnson''s Kids Shampoo', 'Suave Kids', 'L''Oreal Kids'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Costco'],
  true, false
);

-- ============================================
-- MORE SUPPLEMENTS (trusted brands)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Every Man''s One Daily Multivitamin',
  'New Chapter',
  'supplement',
  88,
  'Fermented whole-food multivitamin with organic vegetables and herbs. No synthetic fillers, no artificial colors, no magnesium stearate. Can be taken on empty stomach.',
  ARRAY['Certified Organic', 'Non-GMO Project Verified', 'Certified B Corp'],
  ARRAY['titanium dioxide', 'artificial colors', 'magnesium stearate', 'talc', 'BHT', 'synthetic fillers'],
  ARRAY['Centrum Men', 'One A Day Men''s', 'GNC Mega Men'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Basic Nutrients 2/Day',
  'Thorne',
  'supplement',
  90,
  'Pharmaceutical-grade multivitamin trusted by professional athletes and doctors. No unnecessary additives, no artificial colors, no gluten, no soy. NSF Certified for Sport.',
  ARRAY['NSF Certified for Sport', 'Gluten-Free', 'No Artificial Colors'],
  ARRAY['titanium dioxide', 'artificial colors', 'magnesium stearate', 'talc', 'hydrogenated oils'],
  ARRAY['Centrum', 'One A Day', 'Nature Made Multi'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'O.N.E. Multivitamin',
  'Pure Encapsulations',
  'supplement',
  91,
  'Hypoallergenic one-daily multivitamin with methylated B vitamins. No artificial colors, no magnesium stearate, no gluten, no GMOs, no hydrogenated fats. Practitioner trusted.',
  ARRAY['Hypoallergenic', 'Non-GMO', 'GMP Certified'],
  ARRAY['titanium dioxide', 'artificial colors', 'magnesium stearate', 'talc', 'BHT', 'hydrogenated oils'],
  ARRAY['Centrum', 'One A Day', 'Nature Made'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'mykind Organics Women''s Multi',
  'Garden of Life',
  'supplement',
  87,
  'USDA Organic, Non-GMO Project Verified whole food multivitamin. Made from real organic fruits, vegetables, and herbs. No synthetic fillers, no binders.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified', 'Vegan'],
  ARRAY['titanium dioxide', 'artificial colors', 'magnesium stearate', 'synthetic folic acid', 'BHT'],
  ARRAY['Centrum Women', 'One A Day Women''s', 'Nature Made Women''s Multi'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Walmart'],
  true, false
);

-- ============================================
-- MORE BEVERAGES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Ceremonial Grade Matcha',
  'Rishi Tea',
  'beverage',
  92,
  'Stone-ground organic matcha from Uji, Japan. First harvest ceremonial grade. No pesticides, no additives, no lead (tested). Single origin transparency.',
  ARRAY['USDA Organic', 'Ceremonial Grade', 'Non-GMO'],
  ARRAY['pesticide residues', 'lead', 'artificial colors', 'artificial flavors', 'added sugar'],
  ARRAY['generic matcha powders', 'Starbucks Matcha', 'sweetened matcha mixes'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Organic Mushroom Coffee Mix',
  'Four Sigmatic',
  'beverage',
  86,
  'Organic coffee with functional mushroom extracts (lion''s mane, chaga). Half the caffeine of regular coffee. No artificial anything, no fillers, no carriers.',
  ARRAY['USDA Organic', 'Non-GMO', 'Third-Party Tested'],
  ARRAY['mycotoxins', 'pesticide residues', 'artificial flavors', 'acrylamide'],
  ARRAY['Folgers', 'Maxwell House', 'Nescafe Instant Coffee'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Zero Calorie Soda',
  'Zevia',
  'beverage',
  84,
  'Sweetened with stevia leaf extract — no aspartame, no sucralose, no ace-K. No artificial colors, no phosphoric acid. Clear cans (no BPA-lined coating).',
  ARRAY['Non-GMO', 'Zero Sugar', 'No Artificial Sweeteners'],
  ARRAY['aspartame', 'sucralose', 'acesulfame potassium', 'phosphoric acid', 'caramel color', 'BPA'],
  ARRAY['Diet Coke', 'Diet Pepsi', 'Coke Zero', 'Diet Dr Pepper'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
);

-- ============================================
-- MORE FOOD (sauces, crackers, dairy alternatives)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Tomato Basil Marinara Sauce',
  'Primal Kitchen',
  'condiment',
  88,
  'Made with avocado oil instead of soybean or canola oil. No added sugar, no seed oils, no artificial preservatives. Whole30 approved with organic tomatoes.',
  ARRAY['Non-GMO', 'Whole30 Approved', 'No Seed Oils'],
  ARRAY['soybean oil', 'canola oil', 'added sugar', 'natural flavors', 'citric acid', 'calcium chloride'],
  ARRAY['Prego', 'Ragu', 'Bertolli Sauce', 'Newman''s Own'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Homemade Marinara Sauce',
  'Rao''s',
  'condiment',
  87,
  'Slow-simmered with Italian tomatoes, olive oil, and fresh vegetables. No added sugar, no tomato paste, no artificial anything. Only whole, simple ingredients.',
  ARRAY['No Added Sugar', 'Non-GMO', 'Kosher'],
  ARRAY['added sugar', 'high fructose corn syrup', 'soybean oil', 'natural flavors', 'calcium chloride'],
  ARRAY['Prego', 'Ragu', 'Hunt''s Pasta Sauce'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Original Crackers',
  'Mary''s Gone Crackers',
  'snack',
  89,
  'Made from organic whole grains and seeds. Gluten-free, no preservatives, no refined flour, no trans fats. USDA Organic with simple, real food ingredients.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free'],
  ARRAY['enriched flour', 'soybean oil', 'high fructose corn syrup', 'BHT', 'TBHQ', 'artificial flavors'],
  ARRAY['Ritz Crackers', 'Wheat Thins', 'Triscuit', 'Cheez-It'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Flax Seed Crackers',
  'Flackers',
  'snack',
  91,
  'Made from organic flax seeds — just 4-5 organic ingredients. No grains, no gluten, no seed oils, no preservatives. Rich in omega-3 fatty acids. Raw, dehydrated.',
  ARRAY['USDA Organic', 'Non-GMO', 'Raw'],
  ARRAY['enriched flour', 'soybean oil', 'canola oil', 'BHT', 'TBHQ', 'artificial flavors'],
  ARRAY['Ritz Crackers', 'Wheat Thins', 'Goldfish'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Almond Milk Ricotta',
  'Kite Hill',
  'dairy',
  86,
  'Made from almond milk with live active cultures. No soy, no dairy hormones, no artificial preservatives. Clean plant-based cheese alternative with real cultured flavor.',
  ARRAY['Non-GMO', 'Vegan', 'Live Cultures'],
  ARRAY['rBST', 'artificial preservatives', 'natamycin', 'potassium sorbate'],
  ARRAY['Polly-O Ricotta', 'Galbani Ricotta', 'Great Value Ricotta'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Cultured Vegan Cream Cheese',
  'Miyoko''s Creamery',
  'dairy',
  87,
  'Made from organic cashews and coconut cream, cultured for authentic tang. No palm oil, no soy, no artificial flavors. Certified Organic and plant-based.',
  ARRAY['USDA Organic', 'Vegan', 'Non-GMO'],
  ARRAY['rBST', 'artificial preservatives', 'natamycin', 'artificial flavors', 'guar gum'],
  ARRAY['Philadelphia Cream Cheese', 'Great Value Cream Cheese'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Unsweetened Original Pea Milk',
  'Ripple',
  'dairy',
  86,
  'Made from yellow pea protein — more protein than almond milk with no nuts, no soy, no gluten. No carrageenan, no gums, no artificial anything. DHA omega-3 added.',
  ARRAY['Non-GMO', 'Vegan', 'Allergen-Friendly'],
  ARRAY['carrageenan', 'dipotassium phosphate', 'natural flavors', 'guar gum'],
  ARRAY['Silk Soy Milk', 'Almond Breeze', 'Great Value Almond Milk'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
);
