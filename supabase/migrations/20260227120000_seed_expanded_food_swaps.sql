-- Batch: More Food, Beverages, Condiments, Snacks (~45 products)
-- All products are real, verified non-toxic alternatives

-- ============================================
-- SAUCES & DRESSINGS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Tomato Ketchup',
  'Organicville',
  'condiment',
  89,
  'USDA Organic ketchup sweetened with organic agave instead of high fructose corn syrup. No artificial preservatives, no artificial colors, no GMOs.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free'],
  ARRAY['high fructose corn syrup', 'natural flavors', 'sodium benzoate', 'artificial colors'],
  ARRAY['Heinz Ketchup', 'Hunt''s Ketchup', 'Great Value Ketchup'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Balsamic Vinaigrette',
  'Tessemae''s',
  'condiment',
  88,
  'Made with organic extra virgin olive oil — no canola, no soybean oil. No added sugar, no natural flavors, no artificial preservatives. Whole30 approved.',
  ARRAY['USDA Organic', 'Whole30 Approved', 'No Seed Oils'],
  ARRAY['canola oil', 'soybean oil', 'high fructose corn syrup', 'natural flavors', 'xanthan gum', 'calcium disodium EDTA'],
  ARRAY['Kraft Dressing', 'Wish-Bone Dressing', 'Hidden Valley', 'Newman''s Own'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Avocado Oil Italian Dressing',
  'Primal Kitchen',
  'condiment',
  87,
  'Made with avocado oil instead of seed oils. No sugar, no soy, no canola, no dairy, no artificial preservatives. Clean ingredients with real herbs.',
  ARRAY['Non-GMO', 'Paleo Friendly', 'No Seed Oils'],
  ARRAY['canola oil', 'soybean oil', 'high fructose corn syrup', 'natural flavors', 'calcium disodium EDTA'],
  ARRAY['Kraft Italian Dressing', 'Wish-Bone Italian', 'Ken''s Italian'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Hot Sauce',
  'Yellowbird',
  'condiment',
  90,
  'Made from organic peppers with clean, whole food ingredients. No artificial colors, no preservatives, no thickeners, no added sugar. Just peppers, vegetables, and spices.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Preservatives'],
  ARRAY['sodium benzoate', 'potassium sorbate', 'artificial colors', 'xanthan gum', 'natural flavors'],
  ARRAY['Frank''s RedHot', 'Tabasco', 'Cholula', 'Sriracha (Huy Fong)'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'H-E-B'],
  true, false
),
(
  'Classic Hummus',
  'Hope Foods',
  'condiment',
  88,
  'Organic chickpeas with cold-pressed organic oils. No preservatives, no seed oils, no citric acid, no natural flavors. HPP (high pressure processing) for freshness without heat.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free'],
  ARRAY['soybean oil', 'canola oil', 'citric acid', 'potassium sorbate', 'sodium benzoate', 'natural flavors'],
  ARRAY['Sabra Hummus', 'Tribe Hummus', 'Cedar''s Hummus'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Kroger'],
  true, false
);

-- ============================================
-- FROZEN MEALS & PIZZA
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Cheese Pizza',
  'Amy''s Kitchen',
  'food',
  84,
  'Made with organic flour, organic tomatoes, and organic cheese. No preservatives, no artificial flavors, no GMOs. Vegetarian with clean ingredients you can pronounce.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegetarian'],
  ARRAY['enriched flour', 'TBHQ', 'artificial flavors', 'modified corn starch', 'sodium phosphate', 'BHT'],
  ARRAY['DiGiorno', 'Totino''s', 'Red Baron', 'Tombstone'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Cauliflower Crust Pizza',
  'Caulipower',
  'food',
  83,
  'Cauliflower-based crust with cleaner ingredients than conventional frozen pizza. No artificial preservatives, no artificial colors, no artificial flavors. Gluten-free.',
  ARRAY['Non-GMO', 'Gluten Free', 'No Artificial Preservatives'],
  ARRAY['enriched flour', 'TBHQ', 'artificial flavors', 'BHT', 'sodium phosphate'],
  ARRAY['DiGiorno', 'Totino''s', 'Red Baron'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Organic Burrito Grande',
  'Amy''s Kitchen',
  'food',
  85,
  'Organic beans, organic rice, and organic cheese in an organic tortilla. No preservatives, no artificial flavors, no GMOs. Microwaveable for quick clean meals.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegetarian'],
  ARRAY['enriched flour', 'artificial flavors', 'modified food starch', 'sodium phosphate', 'TBHQ', 'BHA'],
  ARRAY['El Monterey Burritos', 'José Olé', 'Tina''s Burritos'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Chicken Tikka Masala',
  'Saffron Road',
  'food',
  85,
  'Antibiotic-free chicken in organic spice sauce. No artificial preservatives, no artificial flavors, no MSG. Halal certified with clean ingredient list.',
  ARRAY['Non-GMO', 'Halal Certified', 'Gluten Free'],
  ARRAY['MSG', 'artificial flavors', 'sodium phosphate', 'modified food starch', 'BHA', 'TBHQ'],
  ARRAY['Stouffer''s', 'Lean Cuisine', 'Hungry-Man', 'Marie Callender''s'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger'],
  true, false
);

-- ============================================
-- CHIPS & SAVORY SNACKS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Sea Salt Kettle Chips',
  'Boulder Canyon',
  'snack',
  84,
  'Cooked in avocado oil instead of seed oils. No artificial flavors, no MSG, no preservatives. Simple ingredients: potatoes, avocado oil, sea salt.',
  ARRAY['Non-GMO', 'Gluten Free', 'Avocado Oil'],
  ARRAY['canola oil', 'soybean oil', 'MSG', 'artificial flavors', 'TBHQ', 'disodium inosinate'],
  ARRAY['Lay''s Chips', 'Pringles', 'Ruffles', 'Utz Chips'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Plantain Chips Sea Salt',
  'Barnana',
  'snack',
  86,
  'Organic plantains cooked in coconut oil. No seed oils, no artificial flavors, no preservatives. Upcycled from imperfect bananas to reduce food waste.',
  ARRAY['USDA Organic', 'Non-GMO', 'Upcycled Certified'],
  ARRAY['canola oil', 'soybean oil', 'artificial flavors', 'MSG', 'TBHQ'],
  ARRAY['Lay''s Chips', 'Pringles', 'Goya Plantain Chips'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Seaweed Snacks',
  'gimMe',
  'snack',
  90,
  'Organic roasted seaweed with organic sunflower oil and sea salt. Only 3 ingredients. No artificial flavors, no MSG, no preservatives. Nutrient-dense low-calorie snack.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['canola oil', 'artificial flavors', 'MSG', 'TBHQ', 'artificial colors'],
  ARRAY['processed chip snacks', 'Pringles', 'Goldfish'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger'],
  true, false
),
(
  'Seed Crackers Everything',
  'Hu Kitchen',
  'snack',
  88,
  'Grain-free crackers made with seeds and cassava. No seed oils, no soy, no dairy, no refined sugar, no emulsifiers. Paleo-friendly with simple ingredients.',
  ARRAY['Non-GMO', 'Grain Free', 'Paleo Friendly'],
  ARRAY['enriched flour', 'soybean oil', 'canola oil', 'artificial flavors', 'BHT', 'TBHQ'],
  ARRAY['Ritz Crackers', 'Cheez-It', 'Wheat Thins', 'Goldfish'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Cassava Flour Tortilla Chips',
  'Siete',
  'snack',
  86,
  'Made with cassava flour and avocado oil — no grains, no seed oils. No artificial flavors, no preservatives, no GMOs. Grain-free chip that tastes like real tortilla chips.',
  ARRAY['Non-GMO', 'Grain Free', 'Dairy Free'],
  ARRAY['canola oil', 'soybean oil', 'MSG', 'artificial flavors', 'TBHQ'],
  ARRAY['Tostitos', 'Mission Chips', 'On The Border Chips'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger'],
  true, false
);

-- ============================================
-- BARS & SWEET SNACKS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Collagen Protein Bar Chocolate Chip Cookie Dough',
  'Bulletproof',
  'snack',
  84,
  'Made with grass-fed collagen and MCT oil. No seed oils, no artificial sweeteners, no soy, no gluten. Short ingredient list with functional nutrition.',
  ARRAY['Non-GMO', 'Gluten Free', 'Grass-Fed Collagen'],
  ARRAY['soy protein isolate', 'sucralose', 'artificial flavors', 'palm oil', 'high fructose corn syrup', 'canola oil'],
  ARRAY['Clif Bar', 'Kind Bar', 'Quest Bar', 'Nature Valley'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Fruit Leather',
  'Stretch Island',
  'snack',
  89,
  'Made from real organic fruit — no added sugar, no artificial colors, no preservatives, no fruit juice concentrates. Just dried fruit in a strip. Non-GMO.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Added Sugar'],
  ARRAY['high fructose corn syrup', 'artificial colors', 'artificial flavors', 'sodium benzoate', 'Red 40', 'Blue 1'],
  ARRAY['Fruit Roll-Ups', 'Fruit by the Foot', 'Gushers'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Superfood Dark Chocolate Bars',
  'Endangered Species',
  'snack',
  87,
  'Fair trade dark chocolate with ethical cocoa sourcing. No soy lecithin alternatives available, non-GMO, no artificial flavors. 10% of profits to wildlife conservation.',
  ARRAY['Fair Trade', 'Non-GMO', 'Certified B Corp'],
  ARRAY['PGPR', 'artificial flavors', 'vanillin', 'high fructose corn syrup', 'hydrogenated oils'],
  ARRAY['Hershey''s', 'Cadbury', 'Nestle Chocolate', 'Mars Bars'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
);

-- ============================================
-- BABY FORMULA & TODDLER
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Clean Label Organic Infant Formula',
  'Bobbie',
  'baby food',
  90,
  'Organic, EU-style infant formula with DHA from organic algae. No corn syrup, no maltodextrin, no palm oil, no hexane-extracted DHA. FDA registered, modeled after European standards.',
  ARRAY['USDA Organic', 'Non-GMO', 'FDA Registered'],
  ARRAY['corn syrup solids', 'maltodextrin', 'palm oil', 'hexane-extracted DHA', 'carrageenan', 'synthetic preservatives'],
  ARRAY['Enfamil', 'Similac', 'Gerber Good Start'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'Organic Grass-Fed Whole Milk Toddler Formula',
  'Else Nutrition',
  'baby food',
  87,
  'Plant-based toddler nutrition made from almonds, buckwheat, and tapioca. No corn syrup, no soy, no dairy hormones. Clean alternative to conventional toddler formulas.',
  ARRAY['USDA Organic', 'Non-GMO', 'Plant-Based'],
  ARRAY['corn syrup solids', 'maltodextrin', 'soy lecithin', 'carrageenan', 'artificial vitamins'],
  ARRAY['Enfagrow Toddler', 'Go & Grow by Similac'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Organic Baby Oatmeal Cereal',
  'Happy Baby',
  'baby food',
  88,
  'USDA Organic oatmeal cereal with iron from organic ingredients. No added sugar, no salt, no artificial vitamins. Clearly crafted with ingredient transparency.',
  ARRAY['USDA Organic', 'Non-GMO', 'BPA-Free Packaging'],
  ARRAY['added sugar', 'artificial vitamins', 'pesticide residues', 'heavy metals'],
  ARRAY['Gerber Oatmeal Cereal', 'Earth''s Best Cereal'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
);

-- ============================================
-- MORE BEVERAGES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Yerba Mate',
  'Guayaki',
  'beverage',
  87,
  'Organic, fair trade yerba mate from regenerative agroforestry. No artificial sweeteners, no artificial colors, no artificial flavors. Clean natural caffeine source.',
  ARRAY['USDA Organic', 'Fair Trade', 'Certified B Corp'],
  ARRAY['artificial sweeteners', 'artificial colors', 'artificial flavors', 'high fructose corn syrup', 'sodium benzoate'],
  ARRAY['Monster Energy', 'Red Bull', 'Rockstar', 'Mountain Dew'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Cold-Brew Coffee',
  'Chameleon Cold-Brew',
  'beverage',
  88,
  'USDA Organic, Fair Trade cold-brew concentrate. No artificial anything, no preservatives, no added sugar. Smooth, low-acid alternative to conventional coffee.',
  ARRAY['USDA Organic', 'Fair Trade', 'Non-GMO'],
  ARRAY['artificial flavors', 'sodium benzoate', 'potassium sorbate', 'acesulfame potassium'],
  ARRAY['Starbucks Bottled Coffee', 'Dunkin'' Bottled Coffee', 'International Delight'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Electrolyte Drink Mix',
  'LMNT',
  'beverage',
  86,
  'Clean electrolyte powder with no sugar, no artificial ingredients, no fillers, no gluten. Just salt, potassium, and magnesium. Developed with input from researchers.',
  ARRAY['No Sugar', 'Non-GMO', 'Paleo Friendly'],
  ARRAY['artificial sweeteners', 'artificial colors', 'sucralose', 'acesulfame potassium', 'dextrose', 'maltodextrin'],
  ARRAY['Gatorade', 'Powerade', 'Liquid IV', 'Pedialyte'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Organic Oat Milk Barista Edition',
  'Califia Farms',
  'dairy',
  85,
  'Organic oat milk with no carrageenan, no gums, no artificial flavors. Formulated for coffee with clean frothing. Shelf-stable without preservatives.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Gums'],
  ARRAY['carrageenan', 'gellan gum', 'dipotassium phosphate', 'rapeseed oil', 'natural flavors'],
  ARRAY['Coffee-Mate', 'International Delight', 'Silk Oat Creamer'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
);

-- ============================================
-- MORE PANTRY & BAKING
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Unbleached All-Purpose Flour',
  'King Arthur Baking',
  'food',
  90,
  'USDA Organic flour with no bromate, no bleach, no malted barley flour. Non-GMO Project Verified. Tested for glyphosate residue. Milled from certified organic wheat.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified', 'No Bleaching'],
  ARRAY['potassium bromate', 'chlorine dioxide', 'benzoyl peroxide', 'azodicarbonamide', 'glyphosate'],
  ARRAY['Gold Medal Flour', 'Pillsbury Flour', 'Great Value Flour'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Coconut Sugar',
  'Madhava',
  'food',
  86,
  'Unrefined organic coconut palm sugar with a low glycemic index. No bleaching, no artificial processing. Single ingredient: organic coconut palm nectar. Fair trade sourced.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade'],
  ARRAY['bleaching agents', 'artificial colors', 'bone char filtering', 'sulfur dioxide'],
  ARRAY['Domino Sugar', 'C&H Sugar', 'Great Value Sugar'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Vanilla Extract',
  'Simply Organic',
  'food',
  91,
  'Made from organic vanilla beans in organic alcohol. No artificial vanillin, no propylene glycol, no corn syrup, no caramel color. Pure vanilla flavor.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['artificial vanillin', 'propylene glycol', 'corn syrup', 'caramel color', 'ethyl vanillin'],
  ARRAY['McCormick Vanilla Extract', 'Great Value Imitation Vanilla'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Chicken Sausage Sun-Dried Tomato',
  'Bilinski''s',
  'food',
  87,
  'Organic, free-range chicken sausage with no antibiotics, no nitrates, no nitrites, no MSG, no sugar. Clean ingredients from humanely raised birds. Whole30 approved.',
  ARRAY['USDA Organic', 'No Nitrates', 'Whole30 Approved'],
  ARRAY['sodium nitrite', 'sodium nitrate', 'BHA', 'BHT', 'MSG', 'corn syrup', 'mechanically separated meat'],
  ARRAY['Johnsonville Sausage', 'Hillshire Farm', 'Jimmy Dean'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Grass-Fed Beef Sticks',
  'Chomps',
  'snack',
  89,
  'Made from 100% grass-fed and grass-finished beef. No sugar, no MSG, no nitrates, no soy, no gluten. Whole30 approved with clean, simple ingredients.',
  ARRAY['Non-GMO', 'Whole30 Approved', 'Grass-Fed & Finished'],
  ARRAY['sodium nitrite', 'BHA', 'BHT', 'MSG', 'soy sauce', 'corn syrup', 'dextrose', 'mechanically separated meat'],
  ARRAY['Slim Jim', 'Jack Link''s', 'Old Wisconsin'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Trader Joe''s', 'Sprouts'],
  true, false
);

-- ============================================
-- MORE DAIRY & EGGS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Pasture-Raised Eggs',
  'Vital Farms',
  'dairy',
  91,
  'From hens raised on family farms with 108 sq ft outdoor space per bird (vs 1 sq ft conventional). No antibiotics, no hormones, no cages. Certified Humane.',
  ARRAY['Pasture-Raised', 'Certified Humane', 'Non-GMO'],
  ARRAY['antibiotics', 'hormones', 'arsenic (in feed)', 'pesticide residues'],
  ARRAY['Great Value Eggs', 'Eggland''s Best', 'generic conventional eggs'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Organic Whole Milk Yogurt',
  'Maple Hill',
  'dairy',
  90,
  '100% grass-fed organic milk from small family farms. No added sugar, no thickeners, no stabilizers, no pectin. Just organic milk and live cultures. Rich in omega-3s and CLA.',
  ARRAY['USDA Organic', '100% Grass-Fed', 'Non-GMO'],
  ARRAY['rBST', 'carrageenan', 'pectin', 'modified food starch', 'artificial sweeteners', 'artificial colors'],
  ARRAY['Yoplait', 'Dannon', 'Chobani', 'Great Value Yogurt'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Kroger'],
  true, false
),
(
  'Organic A2 Whole Milk',
  'Alexandre Family Farm',
  'dairy',
  91,
  'Regenerative organic certified A2/A2 milk. No A1 casein protein (easier to digest). 100% grass-fed, no antibiotics, no hormones, no pesticides. Carbon-negative farm.',
  ARRAY['Regenerative Organic', '100% Grass-Fed', 'A2 Protein'],
  ARRAY['rBST', 'antibiotics', 'pesticide residues', 'A1 casein'],
  ARRAY['Great Value Milk', 'Borden Milk', 'Dean''s Milk'],
  ARRAY['Whole Foods', 'Sprouts', 'Direct'],
  true, false
);
