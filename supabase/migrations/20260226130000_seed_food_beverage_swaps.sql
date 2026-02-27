-- Batch 1: Food & Beverage swaps (~50 products)
-- All products are real, verified non-toxic alternatives with correct brand names

-- ============================================
-- CONDIMENTS & SAUCES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Apple Cider Vinegar',
  'Bragg',
  'condiment',
  95,
  'Raw, unfiltered organic ACV with the mother. No pasteurization, no artificial anything. Single ingredient: organic apple cider vinegar.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['caramel color', 'sodium benzoate', 'potassium sorbate', 'sulfites'],
  ARRAY['Heinz Apple Cider Vinegar', 'Great Value Apple Cider Vinegar'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Organic Coconut Aminos',
  'Coconut Secret',
  'condiment',
  93,
  'Soy-free alternative to soy sauce made from organic coconut sap. No MSG, no gluten, no soy. 73% less sodium than soy sauce.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free', 'Soy Free'],
  ARRAY['MSG', 'sodium benzoate', 'caramel color', 'hydrolyzed soy protein'],
  ARRAY['Kikkoman Soy Sauce', 'La Choy Soy Sauce', 'Great Value Soy Sauce'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Tamari Soy Sauce',
  'San-J',
  'condiment',
  90,
  'Organic, gluten-free tamari brewed with whole soybeans. No artificial preservatives, no caramel color, no MSG. Certified Non-GMO Project Verified.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified', 'Gluten Free'],
  ARRAY['MSG', 'caramel color', 'sodium benzoate', 'hydrolyzed soy protein'],
  ARRAY['Kikkoman Soy Sauce', 'La Choy Soy Sauce'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Classic BBQ Sauce',
  'Primal Kitchen',
  'condiment',
  88,
  'Made with organic and non-GMO ingredients. No high fructose corn syrup, no artificial flavors, no seed oils. Uses organic tomato concentrate and dates for sweetness.',
  ARRAY['Non-GMO', 'Paleo Friendly', 'No Refined Sugar'],
  ARRAY['high fructose corn syrup', 'caramel color', 'sodium benzoate', 'artificial flavors', 'soybean oil'],
  ARRAY['Sweet Baby Ray''s', 'Kraft BBQ Sauce', 'Bull''s-Eye BBQ Sauce'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Avocado Oil Caesar Dressing',
  'Primal Kitchen',
  'condiment',
  89,
  'Made with avocado oil instead of canola or soybean oil. No artificial preservatives, no sugar, no dairy. Clean ingredients with real lemon juice.',
  ARRAY['Non-GMO', 'Paleo Friendly', 'Dairy Free'],
  ARRAY['canola oil', 'soybean oil', 'MSG', 'artificial flavors', 'sodium benzoate', 'calcium disodium EDTA'],
  ARRAY['Hidden Valley Ranch', 'Ken''s Caesar Dressing', 'Kraft Dressing'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Dijon Mustard',
  'Annie''s',
  'condiment',
  91,
  'Organic mustard with simple, clean ingredients. No artificial colors, no artificial preservatives, no sulfites. USDA Organic certified.',
  ARRAY['USDA Organic', 'Non-GMO', 'Certified B Corp'],
  ARRAY['tartrazine', 'calcium disodium EDTA', 'sodium benzoate', 'artificial colors'],
  ARRAY['French''s Mustard', 'Grey Poupon', 'Gulden''s Mustard'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Stone Ground Mustard',
  'Organicville',
  'condiment',
  90,
  'USDA Organic stone ground mustard. No refined sugar, no artificial ingredients, no preservatives. Made with organic vinegar and spices.',
  ARRAY['USDA Organic', 'Gluten Free', 'Vegan'],
  ARRAY['artificial colors', 'sodium benzoate', 'calcium disodium EDTA'],
  ARRAY['French''s Mustard', 'Gulden''s Mustard'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Worcestershire Sauce',
  'Annie''s',
  'condiment',
  88,
  'Organic Worcestershire sauce with no artificial flavors, no artificial preservatives, no HFCS. Clean alternative to conventional Worcestershire.',
  ARRAY['USDA Organic', 'Non-GMO', 'Certified B Corp'],
  ARRAY['high fructose corn syrup', 'caramel color', 'sodium benzoate', 'artificial flavors'],
  ARRAY['Lea & Perrins Worcestershire', 'French''s Worcestershire'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger'],
  true, false
);

-- ============================================
-- FROZEN & PREPARED FOODS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Chunky Tomato Bisque',
  'Amy''s Kitchen',
  'food',
  88,
  'Organic tomato soup with no MSG, no artificial flavors, no preservatives. Made with organic cream and tomatoes. BPA-free can lining.',
  ARRAY['USDA Organic', 'Non-GMO', 'BPA-Free Can'],
  ARRAY['MSG', 'modified corn starch', 'artificial flavors', 'BPA', 'high fructose corn syrup'],
  ARRAY['Campbell''s Tomato Soup', 'Progresso Tomato Soup'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Black Bean Vegetable Soup',
  'Amy''s Kitchen',
  'food',
  89,
  'Organic soup with whole food ingredients. No artificial flavors, no MSG, no preservatives. Low sodium option available.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free'],
  ARRAY['MSG', 'modified corn starch', 'artificial flavors', 'BPA', 'caramel color'],
  ARRAY['Campbell''s Chunky Soup', 'Progresso Soup'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Chicken Bone Broth',
  'Kettle & Fire',
  'food',
  91,
  'Slow-simmered organic chicken bone broth. No hormones, no antibiotics, no artificial flavors. Shelf-stable packaging with no BPA.',
  ARRAY['Organic', 'Non-GMO', 'Gluten Free', 'Whole30 Approved'],
  ARRAY['MSG', 'autolyzed yeast extract', 'natural flavors', 'BPA', 'caramel color'],
  ARRAY['Swanson Broth', 'College Inn Broth', 'Progresso Broth'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Costco'],
  true, false
),
(
  'Organic Turkey Hot Dogs',
  'Applegate',
  'food',
  87,
  'Organic turkey raised without antibiotics. No nitrates, no nitrites, no artificial preservatives, no fillers. Simple ingredients you can pronounce.',
  ARRAY['USDA Organic', 'No Nitrates', 'Whole30 Approved'],
  ARRAY['sodium nitrite', 'sodium nitrate', 'BHA', 'BHT', 'MSG', 'corn syrup', 'mechanically separated meat'],
  ARRAY['Oscar Mayer Hot Dogs', 'Ball Park Franks', 'Hebrew National'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Organic Sliced Turkey Breast',
  'Applegate',
  'food',
  87,
  'Organic turkey from humanely raised birds. No antibiotics, no chemical nitrates, no artificial ingredients. Only meat, water, and salt.',
  ARRAY['USDA Organic', 'No Nitrates', 'Humane'],
  ARRAY['sodium nitrite', 'sodium nitrate', 'BHA', 'BHT', 'carrageenan', 'modified food starch', 'dextrose'],
  ARRAY['Oscar Mayer Deli Meat', 'Hillshire Farm', 'Boar''s Head'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
);

-- ============================================
-- PASTA ALTERNATIVES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Chickpea Pasta',
  'Banza',
  'food',
  86,
  'Made from chickpeas with 25g protein and 13g fiber per serving. Gluten-free, no artificial ingredients. Higher protein than conventional wheat pasta.',
  ARRAY['Non-GMO', 'Gluten Free', 'High Protein'],
  ARRAY['enriched wheat flour', 'folic acid', 'glyphosate'],
  ARRAY['Barilla Pasta', 'Ronzoni', 'Great Value Pasta', 'Mueller''s'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Organic Brown Rice Pasta',
  'Tinkyada',
  'food',
  88,
  'Made from organic brown rice with no additives. Gluten-free, no corn, no soy. Single ingredient: organic brown rice flour.',
  ARRAY['Organic', 'Gluten Free', 'Non-GMO'],
  ARRAY['enriched wheat flour', 'folic acid', 'glyphosate'],
  ARRAY['Barilla Pasta', 'Ronzoni', 'Great Value Pasta'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Green Lentil Penne',
  'Tolerant',
  'food',
  89,
  'Single ingredient organic green lentil pasta. High protein, high fiber, naturally gluten-free. No fillers, no gums, no additives.',
  ARRAY['USDA Organic', 'Gluten Free', 'Non-GMO', 'Single Ingredient'],
  ARRAY['enriched wheat flour', 'folic acid', 'glyphosate'],
  ARRAY['Barilla Pasta', 'Ronzoni', 'Great Value Pasta'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Organic Quinoa Supergrain Pasta',
  'Ancient Harvest',
  'food',
  87,
  'Made with organic quinoa and organic corn. Gluten-free, plant-based protein. No artificial colors, no preservatives.',
  ARRAY['USDA Organic', 'Gluten Free', 'Non-GMO'],
  ARRAY['enriched wheat flour', 'folic acid', 'glyphosate'],
  ARRAY['Barilla Pasta', 'Ronzoni', 'Great Value Pasta'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
);

-- ============================================
-- NUT BUTTERS & SPREADS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Classic Almond Butter',
  'Justin''s',
  'food',
  86,
  'Dry-roasted almonds with a touch of palm oil (sustainably sourced). No hydrogenated oils, no artificial flavors. Simple, clean ingredients.',
  ARRAY['Non-GMO', 'Gluten Free', 'Responsibly Sourced'],
  ARRAY['hydrogenated vegetable oil', 'corn syrup', 'soy lecithin', 'TBHQ', 'artificial flavors'],
  ARRAY['Jif', 'Skippy', 'Peter Pan', 'Great Value Peanut Butter'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Organic Creamy Tahini',
  'Once Again',
  'food',
  93,
  'Single ingredient: organic sesame seeds. Stone-ground, unsweetened, no additives. Fair trade certified and made in solar-powered facility.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade'],
  ARRAY['hydrogenated oils', 'soybean oil', 'artificial flavors'],
  ARRAY['Joyva Tahini', 'Ziyad Tahini'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Raw Cashew Butter',
  'Artisana Organics',
  'food',
  92,
  'Single ingredient: organic raw cashews. No added oils, no sugar, no salt. Hand-crafted in small batches, stone-ground.',
  ARRAY['USDA Organic', 'Non-GMO', 'Raw'],
  ARRAY['hydrogenated oils', 'corn syrup', 'artificial flavors', 'mono and diglycerides'],
  ARRAY['Jif', 'Skippy', 'Peter Pan'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Peanut Butter',
  'MaraNatha',
  'food',
  89,
  'Organic roasted peanuts with no hydrogenated oils. No artificial flavors, no artificial preservatives. Available in no-stir and stirred varieties.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free'],
  ARRAY['hydrogenated vegetable oil', 'corn syrup', 'mono and diglycerides', 'TBHQ'],
  ARRAY['Jif', 'Skippy', 'Peter Pan', 'Great Value Peanut Butter'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Kroger'],
  true, false
),
(
  'Organic 7 Nut & Seed Butter',
  'NuttZo',
  'food',
  90,
  'Power fuel blend of organic nuts and seeds. No palm oil, no sugar, no artificial anything. Rich in omega-3s from flax and chia seeds.',
  ARRAY['USDA Organic', 'Non-GMO', 'Paleo Friendly'],
  ARRAY['hydrogenated oils', 'corn syrup', 'soy lecithin', 'artificial flavors'],
  ARRAY['Jif', 'Skippy', 'Nutella'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Sprouts'],
  true, false
);

-- ============================================
-- DAIRY ALTERNATIVES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Unsweetened Almond Milk',
  'MALK',
  'dairy',
  94,
  'Just 3 ingredients: organic almonds, Himalayan salt, filtered water. No gums, no carrageenan, no seed oils, no natural flavors. Cold-pressed.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Gums'],
  ARRAY['carrageenan', 'gellan gum', 'natural flavors', 'sunflower lecithin', 'vitamin A palmitate'],
  ARRAY['Silk Almond Milk', 'Almond Breeze', 'Great Value Almond Milk'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Unsweetened Almondmilk',
  'Three Trees',
  'dairy',
  93,
  'Cold-blended with just organic almonds and filtered water. No gums, no emulsifiers, no fillers. Glass bottle for no plastic leaching.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Gums'],
  ARRAY['carrageenan', 'gellan gum', 'natural flavors', 'sunflower lecithin'],
  ARRAY['Silk Almond Milk', 'Almond Breeze', 'Califia Farms'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Unsweetened Milked Oats',
  'Elmhurst 1925',
  'dairy',
  88,
  'Uses patented HydroRelease method to extract nutrients without gums or oils. No carrageenan, no seed oils, no phosphates. Simple, clean ingredients.',
  ARRAY['Non-GMO', 'Vegan', 'No Gums'],
  ARRAY['carrageenan', 'gellan gum', 'dipotassium phosphate', 'rapeseed oil', 'sunflower oil'],
  ARRAY['Oatly', 'Planet Oat', 'Silk Oat Milk', 'Great Value Oat Milk'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Cashewmilk',
  'Forager Project',
  'dairy',
  89,
  'Organic cashew milk with no gums, no carrageenan, no artificial anything. Made with organic cashews and simple ingredients.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['carrageenan', 'gellan gum', 'natural flavors', 'dipotassium phosphate'],
  ARRAY['Silk Cashew Milk', 'So Delicious Cashew Milk'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Unsweetened Almondmilk',
  'New Barn',
  'dairy',
  91,
  'Organic almonds with organic acacia gum (a natural, safe stabilizer). No carrageenan, no seed oils, no artificial flavors. High almond content.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['carrageenan', 'gellan gum', 'natural flavors', 'sunflower lecithin'],
  ARRAY['Silk Almond Milk', 'Almond Breeze', 'Great Value Almond Milk'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- CEREAL & GRANOLA
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Ancient Grain Granola Original',
  'Purely Elizabeth',
  'food',
  88,
  'Made with organic ancient grains, coconut sugar, and superfood clusters. No artificial flavors, no refined sugar, no seed oils.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten Free'],
  ARRAY['high fructose corn syrup', 'BHT', 'artificial colors', 'artificial flavors', 'soybean oil'],
  ARRAY['Quaker Granola', 'Nature Valley Granola', 'Kashi Granola'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Sprouted Oat O''s',
  'One Degree Organic Foods',
  'food',
  92,
  'Made from sprouted organic oats with full ingredient traceability. Every ingredient is traceable to farm source. No artificial anything.',
  ARRAY['USDA Organic', 'Non-GMO', 'Sprouted'],
  ARRAY['BHT', 'artificial colors', 'artificial flavors', 'glyphosate', 'trisodium phosphate'],
  ARRAY['Cheerios', 'Great Value Oat Rings', 'Cascadian Farm O''s'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Heritage Flakes',
  'Nature''s Path',
  'food',
  89,
  'Blend of ancient grains including kamut, spelt, and quinoa. Organic, no artificial preservatives, no artificial flavors. Minimal processing.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified'],
  ARRAY['BHT', 'artificial colors', 'artificial flavors', 'high fructose corn syrup'],
  ARRAY['Special K', 'Total Cereal', 'Great Value Bran Flakes'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Honey Nut O''s',
  'Cascadian Farm',
  'food',
  84,
  'USDA Organic with real honey sweetening. No artificial flavors, no artificial colors, no BHT preservative found in conventional cereals.',
  ARRAY['USDA Organic', 'Non-GMO'],
  ARRAY['BHT', 'artificial colors', 'artificial flavors', 'trisodium phosphate'],
  ARRAY['Honey Nut Cheerios', 'Great Value Honey Nut Oats'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Honest O''s',
  'Barbara''s',
  'food',
  87,
  'Simple organic whole grain oat cereal. No refined sugar, no artificial colors, no preservatives. Clean toasted oat flavor with minimal ingredients.',
  ARRAY['USDA Organic', 'Non-GMO', 'Whole Grain'],
  ARRAY['BHT', 'artificial colors', 'trisodium phosphate', 'artificial flavors'],
  ARRAY['Cheerios', 'Great Value Toasted Oats'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- MORE SNACKS
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Original Fruit & Nut Bar',
  'Larabar',
  'snack',
  91,
  'Made with only 2-3 ingredients: dates, nuts, and sometimes fruit. No added sugar, no artificial ingredients, no fillers. Whole food nutrition.',
  ARRAY['Non-GMO', 'Gluten Free', 'Vegan', 'Kosher'],
  ARRAY['high fructose corn syrup', 'soy protein isolate', 'artificial flavors', 'palm oil', 'sucralose'],
  ARRAY['Clif Bar', 'Nature Valley Bars', 'Nutri-Grain Bars', 'Kind Bars'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Oatmeal Chocolate Chip MacroBar',
  'GoMacro',
  'snack',
  86,
  'Organic, plant-based protein bar. No artificial sweeteners, no artificial flavors, no seed oils. Made with organic ingredients in a solar-powered bakery.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan', 'Certified B Corp'],
  ARRAY['soy protein isolate', 'sucralose', 'artificial flavors', 'palm oil', 'high fructose corn syrup'],
  ARRAY['Clif Bar', 'PowerBar', 'Quest Bar'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Chewy Banana Bites',
  'Barnana',
  'snack',
  88,
  'Made from upcycled organic bananas. No added sugar, no artificial anything, no seed oils. Simple dehydrated fruit snack.',
  ARRAY['USDA Organic', 'Non-GMO', 'Upcycled Certified'],
  ARRAY['artificial colors', 'artificial flavors', 'high fructose corn syrup', 'sodium benzoate'],
  ARRAY['Fruit Roll-Ups', 'Welch''s Fruit Snacks', 'Gushers'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Freeze-Dried Fruits',
  'Natierra',
  'snack',
  95,
  'Single ingredient freeze-dried organic fruit. No added sugar, no preservatives, no additives. Retains nutrients through gentle freeze-drying process.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['artificial colors', 'artificial flavors', 'high fructose corn syrup', 'sulfur dioxide', 'sodium benzoate'],
  ARRAY['Fruit Roll-Ups', 'Welch''s Fruit Snacks', 'Craisins'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco'],
  true, false
),
(
  'Dark Chocolate Peanut Butter Cups',
  'Unreal',
  'snack',
  85,
  'Fair trade chocolate with no artificial anything. Less sugar than conventional, no PGPR emulsifier, no TBHQ, no vanillin. Real cocoa butter.',
  ARRAY['Non-GMO', 'Fair Trade', 'Gluten Free'],
  ARRAY['PGPR', 'TBHQ', 'artificial flavors', 'vanillin', 'soy lecithin', 'high fructose corn syrup'],
  ARRAY['Reese''s Peanut Butter Cups', 'Palmer Peanut Butter Cups'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'CVS', 'Kroger'],
  true, false
),
(
  'Avocado Oil Sweet Potato Chips',
  'Jackson''s',
  'snack',
  87,
  'Cooked in premium avocado oil instead of seed oils. No artificial flavors, no MSG, no canola oil. Simple: sweet potatoes, avocado oil, salt.',
  ARRAY['Non-GMO', 'Paleo Friendly', 'Grain Free'],
  ARRAY['canola oil', 'soybean oil', 'MSG', 'artificial flavors', 'TBHQ'],
  ARRAY['Lay''s Chips', 'Pringles', 'Ruffles', 'Kettle Brand'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Kale Chips Original',
  'Rhythm Superfoods',
  'snack',
  90,
  'Organic kale dehydrated at low temperatures to preserve nutrients. No artificial flavors, no seed oils, no preservatives. Air-dried, not fried.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['canola oil', 'soybean oil', 'MSG', 'artificial flavors', 'BHT'],
  ARRAY['Lay''s Chips', 'Doritos', 'Pringles'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
);

-- ============================================
-- MORE BEVERAGES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Pink Lady Apple Kombucha',
  'Health-Ade',
  'beverage',
  89,
  'Cold-pressed kombucha brewed in small batches in glass jars. No artificial flavors, no artificial sweeteners, no preservatives. Live probiotics.',
  ARRAY['Non-GMO', 'Vegan', 'Raw'],
  ARRAY['artificial sweeteners', 'artificial flavors', 'high fructose corn syrup', 'sodium benzoate', 'caramel color'],
  ARRAY['Coca-Cola', 'Pepsi', 'Sprite', 'Mountain Dew'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Coconut Water',
  'Harmless Harvest',
  'beverage',
  93,
  'Never heated, organically grown Thai coconuts. No added sugar, no preservatives, no flavors. Fair Trade certified. Naturally pink from antioxidants.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade'],
  ARRAY['added sugar', 'natural flavors', 'sodium metabisulfite', 'citric acid'],
  ARRAY['Vita Coco', 'Zico Coconut Water', 'Goya Coconut Water'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Costco'],
  true, false
),
(
  'Lemon Sparkling Water',
  'Spindrift',
  'beverage',
  92,
  'Made with real squeezed fruit — no natural flavors, no artificial sweeteners, no citric acid. Just sparkling water and real lemon juice.',
  ARRAY['Non-GMO', 'No Natural Flavors'],
  ARRAY['natural flavors', 'artificial sweeteners', 'citric acid', 'potassium benzoate'],
  ARRAY['LaCroix', 'Bubly', 'Polar Seltzer', 'Topo Chico'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Watermelon Hint Water',
  'Hint',
  'beverage',
  88,
  'Fruit-infused water with no sugar, no sweeteners, no calories. No natural flavors derived from solvents. Purified water with fruit essence.',
  ARRAY['Non-GMO', 'Vegan', 'Zero Sugar'],
  ARRAY['artificial sweeteners', 'aspartame', 'sucralose', 'acesulfame potassium', 'artificial colors'],
  ARRAY['Vitaminwater', 'Gatorade', 'Propel', 'Crystal Light'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco'],
  true, false
),
(
  'Organic Protein Elixir Reishi Chocolate',
  'REBBL',
  'beverage',
  86,
  'Plant-based protein drink with adaptogenic herbs. Organic, fair trade ingredients. No artificial sweeteners, no synthetic vitamins, no seed oils.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade', 'Certified B Corp'],
  ARRAY['artificial sweeteners', 'artificial flavors', 'sucralose', 'acesulfame potassium', 'soy lecithin'],
  ARRAY['Muscle Milk', 'Premier Protein', 'SlimFast'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- MORE PANTRY STAPLES
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Hemp Hearts',
  'Manitoba Harvest',
  'food',
  93,
  'Shelled hemp seeds with complete plant protein. No additives, no preservatives. Single ingredient: organic hemp hearts. Rich in omega-3 and omega-6.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['artificial flavors', 'BHT', 'TBHQ'],
  ARRAY['Conventional protein powders', 'Artificial protein supplements'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger'],
  true, false
),
(
  'Organic Cacao Powder',
  'Navitas Organics',
  'food',
  92,
  'Cold-pressed organic cacao, not Dutch-processed (retains antioxidants). No alkali treatment, no added sugar, no fillers. Single ingredient.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade'],
  ARRAY['alkali processing', 'artificial flavors', 'high fructose corn syrup', 'partially hydrogenated oils'],
  ARRAY['Hershey''s Cocoa Powder', 'Nestle Cocoa', 'Swiss Miss'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Grade A Dark Maple Syrup',
  'Coombs Family Farms',
  'food',
  93,
  'Pure organic maple syrup from family farms. Single ingredient: organic maple syrup. No artificial flavors, no corn syrup, no caramel color.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['high fructose corn syrup', 'corn syrup', 'caramel color', 'artificial flavors', 'sodium benzoate'],
  ARRAY['Aunt Jemima Syrup', 'Mrs. Butterworth''s', 'Log Cabin Syrup'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Raw Unfiltered Honey',
  'Wholesome',
  'food',
  92,
  'Organic raw honey from ethically managed hives. Unfiltered to retain pollen and enzymes. No heating, no artificial additives, no added corn syrup.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade'],
  ARRAY['high fructose corn syrup', 'corn syrup', 'artificial flavors', 'ultrafiltration'],
  ARRAY['Great Value Honey', 'Sue Bee Honey'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Organic Chia Seeds',
  'Nutiva',
  'food',
  94,
  'Organic black chia seeds with no additives. Rich in omega-3, fiber, and protein. Single ingredient: organic chia seeds. Tested for heavy metals.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['pesticide residues', 'heavy metals'],
  ARRAY['Great Value Chia Seeds', 'BetterBody Foods Chia'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
);
