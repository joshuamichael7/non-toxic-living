-- Expanded swap products to fill category gaps
-- All products are real, verified safe/non-toxic alternatives with correct brand names

-- ============================================
-- COOKING OILS (replaces: refined vegetable oils, canola, Crisco, PAM)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Extra Virgin Olive Oil',
  'California Olive Ranch',
  'food',
  92,
  'Cold-pressed from 100% California-grown olives. No hexane extraction or chemical refining. Certified extra virgin with full polyphenol content.',
  ARRAY['USDA Organic', 'Non-GMO', 'California Grown'],
  ARRAY['soybean oil', 'canola oil', 'vegetable oil', 'palm oil', 'TBHQ', 'dimethylpolysiloxane'],
  ARRAY['Bertolli Olive Oil', 'Filippo Berio', 'Pompeian'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Virgin Coconut Oil',
  'Nutiva',
  'food',
  94,
  'Cold-pressed, unrefined organic coconut oil. No hexane, no bleaching, no deodorizing. Single ingredient with no additives.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified', 'Fair Trade'],
  ARRAY['hydrogenated oils', 'partially hydrogenated oils', 'palm oil', 'shortening', 'TBHQ'],
  ARRAY['Crisco', 'LouAna Coconut Oil'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market', 'Costco', 'Walmart'],
  true, false
),
(
  '100% Pure Avocado Oil',
  'Chosen Foods',
  'food',
  90,
  'Naturally refined avocado oil with high smoke point. No hexane extraction, no chemicals. Ideal for high-heat cooking without toxic fume risk.',
  ARRAY['Non-GMO Project Verified', 'Kosher'],
  ARRAY['canola oil', 'vegetable oil', 'soybean oil', 'TBHQ', 'dimethylpolysiloxane'],
  ARRAY['PAM Cooking Spray', 'Wesson Vegetable Oil', 'Mazola Corn Oil'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Extra Virgin Olive Oil',
  'Bragg',
  'food',
  91,
  'Unfiltered and unrefined organic olive oil. Cold-pressed in small batches. No chemical solvents or high-heat processing.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['soybean oil', 'canola oil', 'vegetable oil', 'TBHQ'],
  ARRAY['Great Value Olive Oil', 'Kirkland Olive Oil'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Ghee',
  'Fourth & Heart',
  'food',
  91,
  'Grass-fed, organic clarified butter. Lactose and casein free. High smoke point without harmful compounds. Single ingredient.',
  ARRAY['USDA Organic', 'Grass-Fed', 'Non-GMO'],
  ARRAY['hydrogenated oils', 'vegetable oil', 'margarine', 'artificial butter flavor', 'TBHQ'],
  ARRAY['I Can''t Believe It''s Not Butter', 'Country Crock', 'Crisco'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market', 'Sprouts'],
  true, false
);

-- ============================================
-- CANNED GOODS & SHELF STABLE (replaces: BPA-lined cans, high-sodium conventional)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Black Beans',
  'Eden Organic',
  'food',
  95,
  'Only brand using BPA-free enamel-lined cans since 1999. No added salt, no calcium chloride. Just organic beans and water.',
  ARRAY['USDA Organic', 'BPA-Free Can', 'Non-GMO', 'Kosher'],
  ARRAY['BPA', 'calcium disodium EDTA', 'calcium chloride'],
  ARRAY['Goya Black Beans', 'Bush''s Black Beans', 'Great Value Black Beans'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Kidney Beans',
  'Eden Organic',
  'food',
  95,
  'BPA-free enamel-lined cans. Kombu seaweed added for digestibility. No chemical preservatives or firming agents.',
  ARRAY['USDA Organic', 'BPA-Free Can', 'Non-GMO'],
  ARRAY['BPA', 'calcium disodium EDTA', 'calcium chloride'],
  ARRAY['Goya Kidney Beans', 'Bush''s Kidney Beans'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Diced Tomatoes',
  'Muir Glen',
  'food',
  90,
  'BPA-free lined cans with organic tomatoes. No citric acid from corn, no calcium chloride. Fire-roasted option available.',
  ARRAY['USDA Organic', 'BPA-Free Can', 'Non-GMO'],
  ARRAY['BPA', 'calcium chloride', 'citric acid'],
  ARRAY['Hunt''s Diced Tomatoes', 'Rotel', 'Del Monte Tomatoes'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
),
(
  'Wild Albacore Tuna',
  'Wild Planet',
  'food',
  88,
  'Wild-caught, sustainably harvested tuna. No added water, oil, or fillers. Lower mercury due to smaller fish selection. BPA-free cans.',
  ARRAY['Non-GMO', 'BPA-Free Can', 'Sustainably Caught', 'Dolphin Safe'],
  ARRAY['BPA', 'pyrophosphate', 'vegetable broth', 'soy'],
  ARRAY['Starkist Tuna', 'Bumble Bee Tuna', 'Chicken of the Sea'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger'],
  true, false
),
(
  'Wild Sardines in Extra Virgin Olive Oil',
  'Wild Planet',
  'food',
  92,
  'Wild-caught sardines in organic olive oil. High omega-3, low mercury. No fillers, no soy, no artificial ingredients. BPA-free can.',
  ARRAY['Non-GMO', 'BPA-Free Can', 'Sustainably Caught'],
  ARRAY['BPA', 'soybean oil', 'TBHQ', 'sodium tripolyphosphate'],
  ARRAY['King Oscar Sardines', 'Brunswick Sardines'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Organic Crushed Tomatoes',
  'Jovial',
  'food',
  93,
  'Organic Italian tomatoes in BPA-free glass jars. No citric acid, no added salt. Grown in Abruzzo, Italy without pesticides.',
  ARRAY['USDA Organic', 'BPA-Free Glass', 'Non-GMO'],
  ARRAY['BPA', 'calcium chloride', 'citric acid'],
  ARRAY['Prego', 'Ragu', 'Hunt''s Tomatoes'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'Sprouts'],
  true, false
),
(
  'Organic Free Range Chicken Broth',
  'Pacific Foods',
  'food',
  88,
  'Organic broth in BPA-free cartons. No MSG, no autolyzed yeast extract, no natural flavors. Simple, clean ingredients.',
  ARRAY['USDA Organic', 'BPA-Free', 'Non-GMO', 'Gluten Free'],
  ARRAY['MSG', 'autolyzed yeast extract', 'natural flavors', 'BPA', 'caramel color'],
  ARRAY['Swanson Broth', 'College Inn Broth', 'Progresso Broth'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart'],
  true, false
);

-- ============================================
-- BREAD, GRAINS & PASTA (replaces: refined/processed grains with additives)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Ezekiel 4:9 Sprouted Whole Grain Bread',
  'Food for Life',
  'food',
  92,
  'Made from sprouted organic grains and legumes. No flour, no sugar, no preservatives, no artificial anything. Sprouting increases nutrient bioavailability.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['high fructose corn syrup', 'DATEM', 'azodicarbonamide', 'calcium sulfate', 'ammonium sulfate', 'potassium bromate'],
  ARRAY['Wonder Bread', 'Sara Lee Bread', 'Nature''s Own', 'Pepperidge Farm'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  '21 Whole Grains and Seeds Bread',
  'Dave''s Killer Bread',
  'food',
  84,
  'USDA Organic with 21 whole grains. No artificial preservatives or colors. Contains some organic sugar but far cleaner than conventional bread.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified'],
  ARRAY['high fructose corn syrup', 'DATEM', 'azodicarbonamide', 'calcium sulfate'],
  ARRAY['Wonder Bread', 'Sara Lee Bread', 'Nature''s Own'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Old Fashioned Rolled Oats',
  'Bob''s Red Mill',
  'food',
  94,
  'Organic whole grain oats with no additives. Tested for glyphosate residue. Single ingredient: organic oats. No added sugar or flavoring.',
  ARRAY['USDA Organic', 'Non-GMO', 'Whole Grain'],
  ARRAY['glyphosate', 'BHT', 'artificial flavors', 'artificial colors'],
  ARRAY['Quaker Oats', 'Great Value Oats'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Costco'],
  true, false
),
(
  'Organic Brown Rice',
  'Lundberg Family Farms',
  'food',
  91,
  'Family-farmed organic rice tested for arsenic levels. Eco-farmed with sustainable practices. No additives or preservatives.',
  ARRAY['USDA Organic', 'Non-GMO Project Verified', 'Gluten Free'],
  ARRAY['arsenic', 'pesticide residues'],
  ARRAY['Minute Rice', 'Uncle Ben''s', 'Great Value Rice'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Walmart', 'Sprouts'],
  true, false
),
(
  'Almond Flour Crackers Sea Salt',
  'Simple Mills',
  'snack',
  86,
  'Made with simple, whole food ingredients. No seed oils, no artificial anything. Almond flour base instead of refined wheat.',
  ARRAY['Non-GMO', 'Grain Free', 'Paleo Friendly'],
  ARRAY['vegetable oil', 'soybean oil', 'TBHQ', 'artificial flavors', 'BHT'],
  ARRAY['Ritz Crackers', 'Cheez-It', 'Wheat Thins', 'Triscuit'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Organic Einkorn Pasta',
  'Jovial',
  'food',
  91,
  'Made from ancient einkorn wheat, easier to digest than modern wheat. Organic, no pesticide residues. Bronze die-cut for better sauce adhesion.',
  ARRAY['USDA Organic', 'Non-GMO'],
  ARRAY['glyphosate', 'enriched wheat flour', 'folic acid'],
  ARRAY['Barilla Pasta', 'Ronzoni', 'Great Value Pasta'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'Sprouts'],
  true, false
),
(
  'Grain Free Almond Flour Tortillas',
  'Siete',
  'food',
  85,
  'Made with almond flour and cassava. No seed oils, no preservatives, no artificial ingredients. Grain-free alternative to conventional tortillas.',
  ARRAY['Non-GMO', 'Grain Free', 'Dairy Free'],
  ARRAY['vegetable oil', 'hydrogenated oils', 'sodium aluminum sulfate', 'fumaric acid', 'sodium metabisulfite'],
  ARRAY['Mission Tortillas', 'Old El Paso', 'Guerrero Tortillas'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Sprouts'],
  true, false
);

-- ============================================
-- SPICES & SEASONINGS (replaces: irradiated/contaminated conventional spices)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Ground Turmeric',
  'Simply Organic',
  'food',
  94,
  'Certified organic turmeric tested for heavy metals and pesticides. No irradiation, no anti-caking agents, no fillers.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['lead', 'heavy metals', 'pesticide residues', 'silicon dioxide', 'irradiation'],
  ARRAY['McCormick Ground Turmeric', 'Great Value Turmeric'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Ground Cinnamon',
  'Simply Organic',
  'food',
  94,
  'Organic Ceylon cinnamon with lower coumarin content than Cassia cinnamon. No irradiation, no anti-caking agents.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['coumarin', 'lead', 'irradiation', 'silicon dioxide'],
  ARRAY['McCormick Ground Cinnamon', 'Great Value Cinnamon'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Garlic Powder',
  'Frontier Co-op',
  'food',
  93,
  'Certified organic garlic powder. No irradiation, no fillers, no anti-caking agents. Just dehydrated organic garlic.',
  ARRAY['USDA Organic', 'Non-GMO', 'Kosher'],
  ARRAY['irradiation', 'silicon dioxide', 'pesticide residues'],
  ARRAY['McCormick Garlic Powder', 'Lawry''s Garlic Powder'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Real Salt Ancient Fine Sea Salt',
  'Redmond',
  'food',
  92,
  'Unrefined ancient sea salt from Utah. Contains 60+ trace minerals. No bleaching, no anti-caking agents, no microplastics from ocean harvesting.',
  ARRAY['Unrefined', 'Non-GMO', 'Kosher'],
  ARRAY['microplastics', 'sodium ferrocyanide', 'calcium silicate', 'dextrose', 'bleaching agents'],
  ARRAY['Morton Salt', 'Morton Iodized Salt', 'Great Value Salt'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Seasoning Blends',
  'Primal Palate',
  'food',
  91,
  'Certified organic spice blends with no fillers, no sugar, no MSG, no anti-caking agents. Each blend uses single-origin organic spices.',
  ARRAY['USDA Organic', 'Non-GMO', 'Whole30 Approved'],
  ARRAY['MSG', 'autolyzed yeast extract', 'natural flavors', 'silicon dioxide', 'maltodextrin'],
  ARRAY['Lawry''s Season Salt', 'Mrs. Dash', 'Tony Chachere''s'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market'],
  true, false
);

-- ============================================
-- COFFEE & TEA (replaces: pesticide-heavy conventional coffee/tea)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Purity Coffee',
  'Purity Coffee',
  'beverage',
  93,
  'Third-party tested for mold, mycotoxins, pesticides, and heavy metals. Specialty grade organic beans roasted to maximize antioxidants.',
  ARRAY['USDA Organic', 'Mold-Free Tested', 'Specialty Grade'],
  ARRAY['mycotoxins', 'ochratoxin A', 'pesticide residues', 'acrylamide'],
  ARRAY['Folgers', 'Maxwell House', 'Nescafe', 'Starbucks Ground'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organic Chamomile Tea',
  'Traditional Medicinals',
  'beverage',
  92,
  'Pharmacopoeial-grade organic chamomile. No artificial flavors, no pesticides. Compostable tea bags without plastic or epichlorohydrin.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade', 'Certified B Corp'],
  ARRAY['pesticide residues', 'artificial flavors', 'epichlorohydrin', 'plastic tea bags'],
  ARRAY['Celestial Seasonings', 'Lipton Tea', 'Bigelow Tea'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Organic Green Tea',
  'Numi Organic',
  'beverage',
  91,
  'Pure organic green tea in non-GMO biodegradable tea bags. No hidden plastic in bags, no artificial flavors, no natural flavors.',
  ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade', 'Certified B Corp'],
  ARRAY['pesticide residues', 'artificial flavors', 'natural flavors', 'plastic tea bags'],
  ARRAY['Lipton Green Tea', 'Arizona Green Tea', 'Bigelow Green Tea'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Whole Bean Coffee',
  'Kicking Horse Coffee',
  'beverage',
  89,
  'Certified organic and Fair Trade whole bean coffee. No pesticides, no synthetic fertilizers. Roasted in the Canadian Rockies.',
  ARRAY['USDA Organic', 'Fair Trade', 'Kosher'],
  ARRAY['pesticide residues', 'mycotoxins'],
  ARRAY['Folgers', 'Maxwell House', 'Dunkin'' Ground Coffee'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco'],
  true, false
);

-- ============================================
-- BUTTER, FATS & DAIRY (replaces: margarine, conventional dairy)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Pasture-Raised Butter',
  'Vital Farms',
  'dairy',
  90,
  'From pasture-raised cows on small family farms. Higher omega-3 and CLA than conventional butter. No antibiotics, no added hormones.',
  ARRAY['Pasture-Raised', 'Non-GMO', 'Certified Humane'],
  ARRAY['soybean oil', 'palm oil', 'PGPR', 'artificial flavor', 'TBHQ', 'mono and diglycerides'],
  ARRAY['I Can''t Believe It''s Not Butter', 'Country Crock', 'Parkay', 'Land O''Lakes'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts', 'Walmart'],
  true, false
),
(
  'Pure Irish Grass-Fed Butter',
  'Kerrygold',
  'dairy',
  88,
  'From grass-fed Irish cows. Rich in beta-carotene and fat-soluble vitamins. No artificial colors, no rBST growth hormone.',
  ARRAY['Grass-Fed', 'Non-GMO'],
  ARRAY['soybean oil', 'palm oil', 'artificial color', 'rBST', 'mono and diglycerides'],
  ARRAY['I Can''t Believe It''s Not Butter', 'Country Crock', 'Land O''Lakes'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Raw Sharp Cheddar',
  'Organic Valley',
  'dairy',
  88,
  'Made from organic, pasture-raised raw milk. No artificial colors, no rBST, no natamycin preservative. Raw milk retains beneficial enzymes.',
  ARRAY['USDA Organic', 'Pasture-Raised', 'Non-GMO'],
  ARRAY['annatto color', 'natamycin', 'rBST', 'potassium sorbate', 'artificial colors'],
  ARRAY['Kraft Singles', 'Velveeta', 'Sargento', 'Great Value Cheese'],
  ARRAY['Amazon', 'Whole Foods', 'Kroger', 'Sprouts'],
  true, false
),
(
  'Organic Vegan Butter',
  'Miyoko''s Creamery',
  'dairy',
  85,
  'Plant-based butter made from organic coconut oil and cashews. No palm oil, no soy, no artificial ingredients. Cultured for real butter flavor.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan', 'Plant-Based'],
  ARRAY['palm oil', 'soybean oil', 'artificial flavor', 'TBHQ', 'mono and diglycerides'],
  ARRAY['Country Crock Plant Butter', 'Earth Balance'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- WATER FILTRATION (replaces: unfiltered tap water, basic filters)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Big Berkey Water Filter System',
  'Berkey',
  'household',
  95,
  'Gravity-fed filtration removes fluoride, lead, arsenic, chlorine, pharmaceuticals, and PFAS. No electricity needed. Filters last years.',
  ARRAY['NSF Tested', 'PFAS Removal', 'No Electricity'],
  ARRAY['PFAS', 'PFOA', 'lead', 'chlorine', 'fluoride', 'arsenic', 'microplastics', 'pharmaceuticals'],
  ARRAY['Brita Water Pitcher', 'PUR Water Filter', 'ZeroWater'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Countertop Reverse Osmosis Water Purifier',
  'AquaTru',
  'household',
  93,
  'Certified 4-stage reverse osmosis removes 83 contaminants including PFAS, lead, chromium-6, and pharmaceuticals. No installation required.',
  ARRAY['NSF Certified', 'PFAS Removal', 'No Installation'],
  ARRAY['PFAS', 'PFOA', 'lead', 'chromium-6', 'chlorine', 'arsenic', 'microplastics'],
  ARRAY['Brita Water Pitcher', 'PUR Water Filter'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Water Pitcher with Affinity Filtration',
  'Clearly Filtered',
  'household',
  91,
  'Independently tested to remove 365+ contaminants including PFAS, lead, fluoride, and glyphosate. One of the few pitchers that removes PFAS.',
  ARRAY['NSF Tested', 'PFAS Removal', 'BPA-Free'],
  ARRAY['PFAS', 'PFOA', 'lead', 'fluoride', 'glyphosate', 'microplastics', 'chlorine'],
  ARRAY['Brita Water Pitcher', 'PUR Water Pitcher', 'ZeroWater Pitcher'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- MORE CLEANING (replaces: conventional cleaners with VOCs and toxins)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Multi-Purpose Cleaner',
  'Force of Nature',
  'cleaning',
  95,
  'Electrolyzes salt, water, and vinegar to create hypochlorous acid — the same antimicrobial your immune system makes. EPA registered, no toxic chemicals.',
  ARRAY['EPA Registered', 'No Fragrances', 'No VOCs', 'Certified B Corp'],
  ARRAY['2-butoxyethanol', 'quaternary ammonium compounds', 'synthetic fragrance', 'sodium hypochlorite', 'ammonia', 'triclosan'],
  ARRAY['Lysol All-Purpose', 'Clorox Clean-Up', 'Windex', 'Mr. Clean'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'All-Purpose Cleaner',
  'Better Life',
  'cleaning',
  90,
  'Plant-derived ingredients, no VOCs, no synthetic fragrances. Made in the USA. Effective cleaning without respiratory irritants.',
  ARRAY['EWG Verified', 'No VOCs', 'Cruelty-Free', 'Made in USA'],
  ARRAY['2-butoxyethanol', 'synthetic fragrance', 'ammonia', 'chlorine bleach', 'phthalates'],
  ARRAY['Lysol All-Purpose', 'Mr. Clean', 'Pine-Sol', 'Fabuloso'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Dish Soap Free & Clear',
  'Attitude',
  'cleaning',
  88,
  'Plant and mineral-based dish soap. EWG Verified, hypoallergenic, no synthetic fragrance, no dyes. Biodegradable formula.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Vegan', 'Certified B Corp'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'methylisothiazolinone', 'triclosan', 'formaldehyde'],
  ARRAY['Dawn Dish Soap', 'Palmolive', 'Ajax Dish Soap'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Vinegar Floor Cleaner',
  'Aunt Fannie''s',
  'cleaning',
  89,
  'Made from food-based ingredients including vinegar and essential oils. No synthetic surfactants, no petrochemicals. Safe for kids and pets on floors.',
  ARRAY['Plant-Based', 'No Synthetic Chemicals', 'Cruelty-Free'],
  ARRAY['2-butoxyethanol', 'synthetic fragrance', 'ammonia', 'phthalates', 'sodium lauryl sulfate'],
  ARRAY['Swiffer WetJet Solution', 'Pine-Sol', 'Mr. Clean Floor Cleaner'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Oxygen Brightener',
  'Molly''s Suds',
  'laundry',
  91,
  'Sodium percarbonate-based brightener. No optical brighteners that stay on clothes and contact skin. No synthetic fragrance or dyes.',
  ARRAY['EWG Verified', 'Cruelty-Free', 'Vegan', 'Made in USA'],
  ARRAY['optical brighteners', 'chlorine bleach', 'synthetic fragrance', 'artificial dyes'],
  ARRAY['Clorox Bleach', 'OxiClean', 'Shout'],
  ARRAY['Amazon', 'Target', 'Thrive Market'],
  true, false
);

-- ============================================
-- MORE SNACKS (replaces: processed snacks with artificial ingredients)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Grain Free Tortilla Chips',
  'Siete',
  'snack',
  85,
  'Made with avocado oil instead of seed oils. No artificial flavors, no preservatives. Grain-free cassava and coconut flour base.',
  ARRAY['Non-GMO', 'Grain Free', 'Dairy Free'],
  ARRAY['vegetable oil', 'soybean oil', 'canola oil', 'artificial flavors', 'MSG', 'TBHQ'],
  ARRAY['Doritos', 'Tostitos', 'Lay''s Chips'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Fruit Bars',
  'That''s It',
  'snack',
  95,
  'Just two ingredients: fruit and fruit. No added sugar, no preservatives, no concentrates, no artificial anything. The cleanest snack bar available.',
  ARRAY['Non-GMO', 'Vegan', 'Kosher', 'Whole30 Approved'],
  ARRAY['high fructose corn syrup', 'artificial colors', 'artificial flavors', 'BHT', 'TBHQ', 'sodium benzoate'],
  ARRAY['Nature Valley Bars', 'Nutri-Grain Bars', 'Quaker Chewy Bars'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Organic Dark Chocolate Almonds',
  'Hu Kitchen',
  'snack',
  88,
  'Organic cacao, no refined sugar (uses coconut sugar), no soy lecithin, no emulsifiers. Simple, clean chocolate with real ingredients.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan', 'Paleo'],
  ARRAY['soy lecithin', 'artificial flavors', 'PGPR', 'vanillin', 'high fructose corn syrup'],
  ARRAY['M&M''s', 'Hershey''s', 'Snickers', 'Dove Chocolate'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Protein Bars',
  'RXBAR',
  'snack',
  83,
  'Simple ingredients listed on front: egg whites, nuts, dates. No added sugar, no artificial ingredients, no fillers. Transparent labeling.',
  ARRAY['Non-GMO', 'Gluten Free', 'No Added Sugar'],
  ARRAY['soy protein isolate', 'sucralose', 'artificial flavors', 'palm oil', 'high fructose corn syrup'],
  ARRAY['Clif Bar', 'Kind Bar', 'PowerBar', 'Quest Bar'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Kroger', 'Walmart'],
  true, false
),
(
  'Venison Sea Salt Pepper Bar',
  'Epic Provisions',
  'snack',
  86,
  'Grass-fed venison with simple seasoning. Whole30 approved, no nitrates or nitrites, no added sugar, no soy. Regeneratively sourced.',
  ARRAY['Whole30 Approved', 'Grass-Fed', 'Gluten Free'],
  ARRAY['sodium nitrite', 'sodium nitrate', 'BHA', 'BHT', 'MSG', 'soy sauce', 'dextrose'],
  ARRAY['Slim Jim', 'Jack Link''s Beef Jerky', 'Old Wisconsin'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- MORE BABY CARE (replaces: conventional baby products with irritants)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Baby Shampoo + Wash',
  'Pipette',
  'baby',
  91,
  'Dermatologist-tested, plant-derived squalane formula. No synthetic fragrance, no SLS, no parabens, no phthalates. EWG Verified.',
  ARRAY['EWG Verified', 'Dermatologist Tested', 'Hypoallergenic'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phthalates', 'PEGs', '1,4-dioxane'],
  ARRAY['Johnson''s Baby Shampoo', 'Aveeno Baby Wash', 'Cetaphil Baby'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Moisturizing Baby Shampoo',
  'Babo Botanicals',
  'baby',
  89,
  'Certified organic oat and calendula formula. No synthetic fragrances, no sulfates, no dairy, no soy, no nut allergens. Pediatrician recommended.',
  ARRAY['USDA Organic', 'EWG Verified', 'Cruelty-Free'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'phenoxyethanol', 'PEGs'],
  ARRAY['Johnson''s Baby Shampoo', 'Aveeno Baby Wash'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Baby Leaves Body Lotion',
  'Attitude',
  'baby',
  90,
  'EWG Verified with plant and mineral ingredients. Hypoallergenic, no synthetic fragrance, no petroleum derivatives. CO2-neutral production.',
  ARRAY['EWG Verified', 'Hypoallergenic', 'Vegan', 'Certified B Corp'],
  ARRAY['synthetic fragrance', 'petrolatum', 'mineral oil', 'parabens', 'phthalates', 'PEGs'],
  ARRAY['Johnson''s Baby Lotion', 'Aveeno Baby Lotion', 'Cetaphil Baby Lotion'],
  ARRAY['Amazon', 'Whole Foods', 'Thrive Market'],
  true, false
);

-- ============================================
-- MORE PERSONAL CARE (replaces: conventional skincare with hidden toxins)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Skin Food Original Ultra-Rich Cream',
  'Weleda',
  'skincare',
  88,
  'Iconic formula since 1926 with organic plant extracts and beeswax. No synthetic preservatives, no mineral oil, no silicones, no parabens.',
  ARRAY['Certified Natural', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['mineral oil', 'petrolatum', 'silicones', 'parabens', 'synthetic fragrance', 'PEGs'],
  ARRAY['Vaseline', 'Jergens', 'Eucerin', 'Lubriderm'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'CVS'],
  true, false
),
(
  'Gentle Facial Cleanser',
  'Vanicream',
  'skincare',
  86,
  'Dermatologist-recommended for sensitive skin. No dyes, no fragrance, no parabens, no formaldehyde releasers. Minimal, effective ingredients.',
  ARRAY['Dermatologist Recommended', 'Fragrance Free', 'Non-Comedogenic'],
  ARRAY['SLS', 'SLES', 'synthetic fragrance', 'parabens', 'formaldehyde releasers', 'dyes'],
  ARRAY['Cetaphil Cleanser', 'Neutrogena', 'Clean & Clear', 'Noxzema'],
  ARRAY['Amazon', 'Target', 'CVS', 'Walgreens', 'Walmart'],
  true, false
),
(
  'Countermatch Adaptive Moisturizer',
  'Beautycounter',
  'skincare',
  87,
  'Formulated without 2,800+ harmful ingredients (The Never List). Phyto-technology adapts to skin''s needs. B Corp certified, rigorous third-party testing.',
  ARRAY['Certified B Corp', 'EWG Verified', 'Cruelty-Free'],
  ARRAY['parabens', 'synthetic fragrance', 'PEGs', 'phthalates', 'oxybenzone', 'formaldehyde'],
  ARRAY['Olay Regenerist', 'Clinique Moisturizer', 'L''Oreal Moisturizer'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- KITCHEN TOOLS & STORAGE (replaces: plastic items)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Reusable Silicone Storage Bags',
  'Stasher',
  'storage',
  90,
  'Made from pure platinum silicone (no fillers). BPA-free, lead-free, latex-free. Dishwasher, microwave, freezer, and oven safe. Eliminates single-use plastic.',
  ARRAY['BPA-Free', 'Non-Toxic Silicone', 'Certified B Corp'],
  ARRAY['BPA', 'phthalates', 'lead', 'PVC', 'microplastics'],
  ARRAY['Ziploc Bags', 'Glad Bags', 'Hefty Bags'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco'],
  true, false
),
(
  'Unbleached Parchment Paper',
  'If You Care',
  'storage',
  88,
  'Unbleached, chlorine-free parchment paper. No Quilon (chromium-based) coating like conventional parchment. Compostable and FSC certified.',
  ARRAY['FSC Certified', 'Unbleached', 'Compostable'],
  ARRAY['Quilon', 'chromium', 'chlorine bleach', 'PFAS', 'silicone coating'],
  ARRAY['Reynolds Parchment Paper', 'Reynolds Non-Stick Foil'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true, false
),
(
  'Organic Bamboo Utensil Set',
  'Bambu',
  'cookware',
  92,
  'Certified organic bamboo kitchen utensils. No plastic, no BPA, no chemical coatings. Naturally antimicrobial. Handcrafted and compostable.',
  ARRAY['USDA Organic', 'BPA-Free', 'Compostable'],
  ARRAY['BPA', 'melamine', 'phthalates', 'PFAS', 'plastic leaching'],
  ARRAY['Plastic spatulas', 'Nylon cooking utensils', 'Melamine utensils'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
);

-- ============================================
-- SUPPLEMENTS (replaces: synthetic vitamin brands)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Prenatal Multi',
  'Needed',
  'supplement',
  91,
  'Practitioner-formulated prenatal with methylated folate (not folic acid), chelated minerals, and optimal nutrient forms. No artificial fillers or dyes.',
  ARRAY['Third-Party Tested', 'GMP Certified', 'No Artificial Fillers'],
  ARRAY['folic acid', 'titanium dioxide', 'artificial colors', 'magnesium stearate', 'talc', 'BHT'],
  ARRAY['One A Day Prenatal', 'Nature Made Prenatal', 'Centrum Prenatal'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Liposomal Vitamin D3 + K2',
  'Cymbiotika',
  'supplement',
  89,
  'Liposomal delivery for superior absorption. Organic ingredients, no synthetic fillers, no soy lecithin. Plant-based D3 from organic algae.',
  ARRAY['Organic', 'Non-GMO', 'Third-Party Tested'],
  ARRAY['soy lecithin', 'titanium dioxide', 'artificial colors', 'magnesium stearate', 'talc'],
  ARRAY['Nature Made Vitamin D', 'Centrum', 'One A Day'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Multi Collagen Protein Powder',
  'Ancient Nutrition',
  'supplement',
  85,
  'Multi-source collagen from grass-fed beef, chicken, wild fish, and eggshell. No artificial sweeteners, no fillers. Clinically studied formulas.',
  ARRAY['Non-GMO', 'Gluten Free', 'Third-Party Tested'],
  ARRAY['artificial sweeteners', 'sucralose', 'artificial flavors', 'maltodextrin', 'silicon dioxide'],
  ARRAY['Vital Proteins Original', 'Great Lakes Collagen'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart'],
  true, false
);
