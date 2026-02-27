-- Seed: Final push to 500 total swaps (~37 products)
-- Filling remaining gaps: water filtration, pregnancy, travel, kitchen tools,
-- expanded cleaning, more food

-- ============================================
-- WATER FILTRATION (4 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Countertop Water Filter',
  'Berkey',
  'home',
  94,
  'Gravity-fed filter removes fluoride, lead, chlorine, pharmaceuticals, heavy metals, pesticides, and bacteria without electricity. Black Berkey elements last 6,000+ gallons each.',
  ARRAY['NSF Tested', 'No Electricity', 'Long-Lasting'],
  ARRAY['lead', 'chlorine', 'fluoride', 'pharmaceuticals', 'pesticides', 'heavy metals'],
  ARRAY['Brita', 'PUR', 'unfiltered tap water'],
  ARRAY['Amazon', 'berkeyfilters.com'],
  true, true
),
(
  'Under-Sink Water Filter',
  'Clearly Filtered',
  'home',
  93,
  'Three-stage filtration removes 365+ contaminants including PFAS, lead, fluoride, microplastics, pesticides, and pharmaceuticals. NSF/ANSI 42, 53, and 401 certified.',
  ARRAY['NSF Certified', 'PFAS Removal', 'Made in USA'],
  ARRAY['PFAS', 'lead', 'fluoride', 'microplastics', 'chlorine', 'VOCs'],
  ARRAY['Brita', 'PUR faucet mount', 'standard fridge filters'],
  ARRAY['Amazon', 'clearlyfiltered.com'],
  true, false
),
(
  'Filtered Water Bottle',
  'LifeStraw',
  'home',
  88,
  'Hollow fiber membrane filter removes 99.999% of bacteria, parasites, and microplastics from any water source. BPA-free, phthalate-free tritan plastic. Filter lasts 1,000 gallons.',
  ARRAY['BPA-Free', 'Certified Filtration', 'B Corp'],
  ARRAY['BPA', 'phthalates', 'microplastics', 'chlorine', 'lead'],
  ARRAY['disposable plastic bottles', 'unfiltered tap water'],
  ARRAY['Amazon', 'REI', 'Target', 'lifestraw.com'],
  true, false
),
(
  'Shower Filter',
  'AquaBliss',
  'home',
  87,
  'Multi-stage filter removes chlorine, heavy metals, pesticides, and bacteria from shower water. Reduces skin irritation and dry hair from chlorinated water. Easy universal install.',
  ARRAY['Multi-Stage', 'Universal Fit', 'Long-Lasting'],
  ARRAY['chlorine', 'chloramine', 'heavy metals', 'pesticides', 'hydrogen sulfide'],
  ARRAY['unfiltered shower head'],
  ARRAY['Amazon', 'aquabliss.com'],
  true, false
);

-- ============================================
-- PREGNANCY & NURSING (4 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Prenatal Vitamin',
  'Garden of Life',
  'supplement',
  92,
  'USDA Organic whole-food prenatal with methylfolate instead of synthetic folic acid. No synthetic binders, fillers, artificial colors, titanium dioxide, or magnesium stearate.',
  ARRAY['USDA Organic', 'Non-GMO', 'Whole Food'],
  ARRAY['folic acid synthetic', 'titanium dioxide', 'magnesium stearate', 'FD&C dyes', 'talc'],
  ARRAY['One A Day Prenatal', 'Centrum Prenatal'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Nipple Balm',
  'Earth Mama',
  'personal_care',
  93,
  'USDA Organic herbs and oils soothe nursing discomfort. Safe for baby without wiping off. No lanolin (often contaminated with pesticide residues), petroleum, or parabens.',
  ARRAY['USDA Organic', 'Baby-Safe', 'Lanolin-Free'],
  ARRAY['lanolin', 'petrolatum', 'mineral oil', 'parabens', 'fragrance'],
  ARRAY['Lansinoh Lanolin', 'Medela Purelan'],
  ARRAY['Amazon', 'Target', 'Buy Buy Baby', 'Whole Foods'],
  true, false
),
(
  'Organic Stretch Mark Cream',
  'Burt''s Bees Mama Bee',
  'personal_care',
  88,
  'Cocoa butter and shea butter formula with vitamin E. No retinol (unsafe during pregnancy), synthetic fragrance, parabens, phthalates, or petroleum.',
  ARRAY['Natural', 'Dermatologist Tested', 'Pregnancy-Safe'],
  ARRAY['retinol', 'fragrance', 'parabens', 'phthalates', 'mineral oil'],
  ARRAY['Palmer''s Cocoa Butter with retinol', 'Bio-Oil'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true, false
),
(
  'Organic Morning Sickness Tea',
  'Pink Stork',
  'food',
  89,
  'Organic ginger, lemon balm, and mint naturally ease nausea. USDA Organic with no artificial flavors, colors, or synthetic additives. Caffeine-free.',
  ARRAY['USDA Organic', 'Caffeine-Free', 'Non-GMO'],
  ARRAY['artificial flavors', 'synthetic colors', 'caffeine', 'artificial sweeteners'],
  ARRAY['conventional ginger ale', 'synthetic anti-nausea meds'],
  ARRAY['Amazon', 'Target', 'Walmart', 'pinkstork.com'],
  true, false
);

-- ============================================
-- KITCHEN TOOLS & FOOD STORAGE (5 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Glass Food Storage Set',
  'Pyrex',
  'home',
  91,
  'Borosilicate glass with BPA-free lids. No chemical leaching when heated, no microplastic shedding, no PFAS non-stick coatings. Oven, microwave, and dishwasher safe.',
  ARRAY['BPA-Free', 'Oven-Safe', 'Dishwasher-Safe'],
  ARRAY['BPA', 'phthalates', 'microplastics', 'PFAS', 'PVC'],
  ARRAY['Rubbermaid plastic', 'Glad containers', 'Ziploc containers'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Costco'],
  true, false
),
(
  'Stainless Steel Bento Box',
  'LunchBots',
  'home',
  90,
  'Food-grade 18/8 stainless steel with no plastic, BPA, phthalates, lead, or chemical coatings. Dishwasher safe and virtually indestructible. Silicone-sealed lid.',
  ARRAY['BPA-Free', 'Stainless Steel', 'Dishwasher-Safe'],
  ARRAY['BPA', 'phthalates', 'PVC', 'lead', 'melamine'],
  ARRAY['plastic lunch containers', 'melamine containers'],
  ARRAY['Amazon', 'lunchbots.com'],
  true, false
),
(
  'Beeswax Food Wraps',
  'Bee''s Wrap',
  'home',
  89,
  'Organic cotton coated with beeswax, jojoba oil, and tree resin. Reusable, compostable, and plastic-free. Replaces single-use plastic wrap that leaches chemicals into food.',
  ARRAY['Organic', 'Compostable', 'Reusable'],
  ARRAY['PVC', 'PVDC', 'phthalates', 'DEHA', 'BPA'],
  ARRAY['Saran Wrap', 'Glad Cling Wrap', 'Reynolds Wrap plastic'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'beeswrap.com'],
  true, false
),
(
  'Silicone Food Storage Bags',
  'Stasher',
  'home',
  88,
  'Platinum food-grade silicone with no BPA, BPS, lead, latex, or phthalates. Reusable thousands of times, dishwasher and microwave safe. Self-sealing pinch-press design.',
  ARRAY['Platinum Silicone', 'BPA-Free', 'B Corp'],
  ARRAY['BPA', 'BPS', 'phthalates', 'PFAS', 'polyethylene'],
  ARRAY['Ziploc bags', 'Glad bags', 'generic plastic bags'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco'],
  true, false
),
(
  'Natural Dish Brush',
  'Full Circle',
  'home',
  87,
  'Bamboo handle with recycled plastic bristles and replaceable heads. No virgin plastic, BPA, or phthalates. Suction cup base keeps it hygienic and dry.',
  ARRAY['Bamboo', 'Replaceable Heads', 'Recycled Materials'],
  ARRAY['BPA', 'phthalates', 'virgin plastic', 'melamine foam'],
  ARRAY['Scotch-Brite', 'plastic dish brushes', 'melamine sponges'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'fullcircle.com'],
  true, false
);

-- ============================================
-- TRAVEL & ON-THE-GO (4 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Stainless Steel Water Bottle',
  'Klean Kanteen',
  'home',
  92,
  'Food-grade 18/8 stainless steel interior with no plastic lining, BPA, BPS, phthalates, or chemical coatings. Climate Lock insulation keeps drinks hot 26hr or cold 80hr.',
  ARRAY['BPA-Free', 'B Corp', 'Climate Neutral'],
  ARRAY['BPA', 'BPS', 'phthalates', 'polycarbonate', 'epoxy lining'],
  ARRAY['plastic water bottles', 'aluminum lined bottles'],
  ARRAY['Amazon', 'REI', 'Target', 'kleankanteen.com'],
  true, false
),
(
  'Natural Hand Sanitizer Spray',
  'Dr. Bronner''s',
  'soap',
  89,
  'Organic ethanol with lavender essential oil. No triclosan, synthetic fragrance, benzalkonium chloride, parabens, or phthalates. Fair Trade and organic.',
  ARRAY['USDA Organic', 'Fair Trade', 'Vegan'],
  ARRAY['triclosan', 'synthetic fragrance', 'benzalkonium chloride', 'parabens', 'phthalates'],
  ARRAY['Purell', 'Germ-X', 'Bath & Body Works sanitizer'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Lip Balm',
  'Badger',
  'skincare',
  91,
  'USDA Organic with extra virgin olive oil, beeswax, and essential oils. No petroleum, synthetic fragrance, parabens, or oxybenzone. Simple 5-ingredient formula.',
  ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free'],
  ARRAY['petrolatum', 'mineral oil', 'fragrance', 'oxybenzone', 'BHT'],
  ARRAY['Chapstick', 'Carmex', 'EOS conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'REI'],
  true, false
),
(
  'Natural Mineral Sunscreen Stick',
  'Raw Elements',
  'sunscreen',
  92,
  'Non-nano zinc oxide in organic sunflower and hemp seed oil. Reef-safe and USDA Certified Natural. No oxybenzone, octinoxate, nanoparticles, synthetic fragrance, or parabens.',
  ARRAY['Reef Safe', 'Non-Nano Zinc', 'USDA Certified Natural'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'fragrance', 'retinyl palmitate'],
  ARRAY['Neutrogena stick', 'Banana Boat stick', 'Coppertone stick'],
  ARRAY['Amazon', 'REI', 'Whole Foods', 'rawelementusa.com'],
  true, false
);

-- ============================================
-- MORE CLEANING (4 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Natural Oven Cleaner',
  'Puracy',
  'cleaning',
  88,
  'Plant-based formula dissolves baked-on grease without sodium hydroxide (lye), 2-butoxyethanol, synthetic fragrance, ammonia, or MEA. EWG A-rated and hypoallergenic.',
  ARRAY['EWG A-Rated', 'Plant-Based', 'Hypoallergenic'],
  ARRAY['sodium hydroxide', '2-butoxyethanol', 'fragrance', 'ammonia', 'monoethanolamine'],
  ARRAY['Easy-Off', 'Mr. Muscle oven cleaner'],
  ARRAY['Amazon', 'Target', 'puracy.com'],
  true, false
),
(
  'Natural Drain Cleaner',
  'Green Gobbler',
  'cleaning',
  86,
  'Enzymatic formula uses natural bacteria to break down organic clogs. No sodium hydroxide, sulfuric acid, bleach, or chemical fumes. Safe for all pipe types.',
  ARRAY['Enzymatic', 'Non-Corrosive', 'Septic-Safe'],
  ARRAY['sodium hydroxide', 'sulfuric acid', 'sodium hypochlorite', 'hydrochloric acid'],
  ARRAY['Drano', 'Liquid-Plumr', 'chemical drain openers'],
  ARRAY['Amazon', 'Home Depot', 'Walmart', 'Target'],
  true, false
),
(
  'Natural Mold & Mildew Cleaner',
  'Benefect',
  'cleaning',
  89,
  'Thyme oil-based botanical disinfectant kills 99.99% of bacteria and mold without bleach, ammonia, quats, synthetic fragrance, or VOCs. EPA registered botanical.',
  ARRAY['EPA Registered', 'Botanical', 'No VOCs'],
  ARRAY['sodium hypochlorite', 'quaternary ammonium', 'fragrance', 'ammonia', 'formaldehyde'],
  ARRAY['Tilex', 'Clorox mold cleaner', 'Kaboom'],
  ARRAY['Amazon', 'benefect.com'],
  true, false
),
(
  'Natural Carpet Cleaner',
  'Puracy',
  'cleaning',
  87,
  'Plant-based enzymes break down pet stains, wine, and dirt without perchloroethylene, 2-butoxyethanol, optical brighteners, synthetic fragrance, or triclosan.',
  ARRAY['EWG A-Rated', 'Enzyme-Based', 'Hypoallergenic'],
  ARRAY['perchloroethylene', '2-butoxyethanol', 'optical brighteners', 'fragrance', 'triclosan'],
  ARRAY['Resolve', 'OxiClean carpet', 'Bissell cleaning solution'],
  ARRAY['Amazon', 'Target', 'puracy.com'],
  true, false
);

-- ============================================
-- EXPANDED FOOD (8 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Grass-Fed Ghee',
  'Fourth & Heart',
  'food',
  91,
  'USDA Organic grass-fed butter ghee with naturally occurring CLA and butyric acid. No artificial flavors, soy lecithin, palm oil, or hexane-extracted oils. Casein and lactose free.',
  ARRAY['USDA Organic', 'Grass-Fed', 'Whole30'],
  ARRAY['soybean oil', 'palm oil', 'artificial flavor', 'TBHQ', 'dimethylpolysiloxane'],
  ARRAY['conventional cooking sprays', 'margarine', 'Crisco'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Oat Milk',
  'Three Trees',
  'dairy',
  90,
  'Only 3 ingredients: organic oats, filtered water, and organic oat extract. No gums, rapeseed oil, added sugar, carrageenan, or phosphates that other oat milks contain.',
  ARRAY['USDA Organic', 'Non-GMO', '3 Ingredients'],
  ARRAY['rapeseed oil', 'guar gum', 'gellan gum', 'dipotassium phosphate', 'added sugar'],
  ARRAY['Oatly', 'Planet Oat', 'Chobani Oat'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'threetrees.com'],
  true, false
),
(
  'Organic Chicken Sausage',
  'Bilinski''s',
  'food',
  89,
  'Organic free-range chicken with real vegetable and herb ingredients. No nitrates, nitrites, sodium erythorbate, BHA, MSG, artificial casings, or fillers.',
  ARRAY['Organic', 'Free-Range', 'Whole30'],
  ARRAY['sodium nitrite', 'sodium erythorbate', 'BHA', 'MSG', 'mechanically separated chicken'],
  ARRAY['Johnsonville', 'Hillshire Farm', 'Oscar Mayer'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Grass-Fed Beef Sticks',
  'Chomps',
  'snack',
  90,
  'Grass-fed, grass-finished beef with clean seasonings. Whole30 approved. No sugar, sodium nitrite, MSG, soy, dairy, fillers, or encapsulated citric acid.',
  ARRAY['Grass-Fed', 'Whole30', 'Non-GMO'],
  ARRAY['sodium nitrite', 'MSG', 'corn syrup', 'soy protein', 'mechanically separated chicken'],
  ARRAY['Slim Jim', 'Jack Link''s', 'Old Wisconsin'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Costco'],
  true, false
),
(
  'Organic Coconut Sugar',
  'Madhava',
  'food',
  87,
  'Single-ingredient organic coconut palm sugar with a lower glycemic index than refined sugar. No bone char processing, bleaching agents, anti-caking agents, or artificial flavors.',
  ARRAY['USDA Organic', 'Non-GMO', 'Low Glycemic'],
  ARRAY['bone char', 'bleaching agents', 'anti-caking agents', 'artificial flavors'],
  ARRAY['Domino sugar', 'C&H sugar', 'store brand refined sugar'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Baby Formula',
  'Bobbie',
  'baby',
  91,
  'USDA Organic with grass-fed milk and DHA from wild-caught fish oil. EU-inspired standards. No corn syrup solids, palm oil, carrageenan, hexane-extracted DHA, or synthetic preservatives.',
  ARRAY['USDA Organic', 'FDA Registered', 'EU Standards'],
  ARRAY['corn syrup solids', 'palm oil', 'carrageenan', 'hexane-extracted DHA', 'synthetic preservatives'],
  ARRAY['Similac', 'Enfamil', 'Gerber Good Start'],
  ARRAY['Amazon', 'Target', 'bobbie.com'],
  true, false
),
(
  'Organic Seaweed Snacks',
  'gimMe',
  'snack',
  88,
  'Premium organic roasted seaweed with avocado oil or extra virgin olive oil. Rich in iodine and minerals. No inflammatory seed oils, MSG, artificial flavors, or preservatives.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['canola oil', 'corn oil', 'MSG', 'artificial flavor', 'TBHQ'],
  ARRAY['conventional seaweed snacks with canola oil'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Costco'],
  true, false
),
(
  'Organic Instant Oatmeal',
  'Purely Elizabeth',
  'food',
  87,
  'Organic ancient grain oatmeal with quinoa, amaranth, and chia. Sweetened only with coconut sugar. No artificial flavors, preservatives, high fructose corn syrup, or sodium phosphates.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free'],
  ARRAY['high fructose corn syrup', 'artificial flavors', 'sodium phosphates', 'BHT', 'caramel color'],
  ARRAY['Quaker Instant', 'store brand instant oatmeal'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
);

-- ============================================
-- FINAL ADDITIONS TO REACH 500 (8 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Green Tea',
  'Numi',
  'beverage',
  90,
  'USDA Organic and Fair Trade certified whole leaf green tea. No natural flavors, artificial flavors, pesticide residues, or plastic tea bag materials (conventional bags often contain polypropylene).',
  ARRAY['USDA Organic', 'Fair Trade', 'Non-GMO'],
  ARRAY['natural flavors', 'pesticide residues', 'polypropylene', 'artificial flavors'],
  ARRAY['Lipton', 'Bigelow conventional', 'Twinings conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Dark Chocolate Bar',
  'Hu Kitchen',
  'snack',
  89,
  'Organic cacao with coconut sugar. No soy lecithin, refined sugar, dairy, emulsifiers, or artificial vanilla. Stone-ground for smooth texture without industrial processing aids.',
  ARRAY['USDA Organic', 'Paleo', 'Vegan'],
  ARRAY['soy lecithin', 'PGPR', 'artificial vanilla', 'refined sugar', 'milk powder'],
  ARRAY['Hershey''s', 'Godiva', 'Lindt conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Coffee',
  'Kicking Horse',
  'beverage',
  88,
  'USDA Organic, Fair Trade, and shade-grown whole bean coffee. No synthetic pesticides, mold, mycotoxins, or chemical solvents in processing. Rocky Mountain roasted.',
  ARRAY['USDA Organic', 'Fair Trade', 'Shade-Grown'],
  ARRAY['synthetic pesticides', 'mycotoxins', 'chemical solvents', 'propylene glycol'],
  ARRAY['Folgers', 'Maxwell House', 'Starbucks conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Costco', 'kickinghorsecoffee.com'],
  true, false
),
(
  'Natural Laundry Stain Remover',
  'Puracy',
  'cleaning',
  88,
  'Plant-based enzyme formula tackles tough stains without chlorine bleach, optical brighteners, synthetic fragrance, phosphates, or sulfates. Safe on all fabrics including baby clothes.',
  ARRAY['EWG A-Rated', 'Plant-Based', 'Hypoallergenic'],
  ARRAY['chlorine bleach', 'optical brighteners', 'fragrance', 'phosphates', 'sodium lauryl sulfate'],
  ARRAY['OxiClean', 'Shout', 'Zout'],
  ARRAY['Amazon', 'Target', 'puracy.com'],
  true, false
),
(
  'Natural Room Spray',
  'Aura Cacia',
  'home',
  87,
  'Pure essential oil mist with no synthetic fragrance, phthalates, propellants, formaldehyde, or VOC-releasing chemicals. Just essential oils and water in a recyclable glass bottle.',
  ARRAY['Pure Essential Oils', 'No Synthetic Fragrance', 'Non-Aerosol'],
  ARRAY['fragrance', 'phthalates', 'propellants', 'formaldehyde', 'benzene'],
  ARRAY['Febreze', 'Glade', 'Air Wick'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Target'],
  true, false
),
(
  'Organic Almond Butter',
  'Justin''s',
  'food',
  89,
  'Dry-roasted organic almonds ground into creamy butter. Only ingredient: organic almonds. No palm oil, sugar, hydrogenated oils, or stabilizers.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free'],
  ARRAY['palm oil', 'sugar', 'hydrogenated oils', 'mono and diglycerides', 'soy lecithin'],
  ARRAY['Jif', 'Skippy', 'store brand almond butter with palm oil'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Baby Wipes',
  'Water Wipes',
  'baby',
  92,
  'Only 2 ingredients: 99.9% water and a drop of fruit extract. No phenoxyethanol, parabens, sulfates, fragrance, alcohol, or plastic fibers. Biodegradable and compostable.',
  ARRAY['Biodegradable', 'Hypoallergenic', 'Dermatologist Approved'],
  ARRAY['phenoxyethanol', 'parabens', 'fragrance', 'sodium lauryl sulfate', 'polyester fibers'],
  ARRAY['Huggies', 'Pampers wipes', 'store brand baby wipes'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Buy Buy Baby'],
  true, false
),
(
  'Organic Maple Syrup',
  'Coombs Family Farms',
  'condiment',
  91,
  'USDA Organic pure maple syrup from Vermont family farms. Single ingredient, no formaldehyde pellets used in tap holes (banned in organic), no added sugar, corn syrup, or artificial flavors.',
  ARRAY['USDA Organic', 'Non-GMO', 'Single Ingredient'],
  ARRAY['high fructose corn syrup', 'caramel color', 'artificial maple flavor', 'sodium benzoate', 'sulfites'],
  ARRAY['Aunt Jemima', 'Mrs. Butterworth''s', 'Log Cabin'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'coombsfamilyfarms.com'],
  true, false
);
