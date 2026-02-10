-- =============================================================================
-- Expand curated products database — Round 7
-- Frozen foods, breakfast staples, bathroom cleaners, personal care, cat litter
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- =============================================================================
-- FOOD (expand — frozen meals, breakfast, processed staples)
-- =============================================================================

('Pepperoni Pizza Rolls', 'Totino''s', 'food', '042800006219', 15, 'toxic',
 'Contains BHA, BHT, TBHQ, sodium nitrite, artificial colors, modified corn starch, and enriched flour. Triple preservative combo in a single product aimed at kids.',
 'BHA, BHT, AND TBHQ — all three controversial preservatives in one snack. Plus sodium nitrite in the pepperoni, artificial flavors, and enough sodium to pickle something. This is ultra-processed engineering for kids.',
 'Enriched Flour (Wheat Flour, Niacin, Ferrous Sulfate, Thiamine Mononitrate, Riboflavin, Folic Acid), Tomato Puree (Water, Tomato Paste), Water, Pepperoni (Pork, Beef, Salt, Spices, Dextrose, Lactic Acid Starter Culture, Oleoresin of Paprika, Sodium Nitrite, BHA, BHT, Citric Acid), Imitation Mozzarella Cheese (Water, Palm Oil, Modified Corn Starch, Rennet Casein, Sodium Citrate), Soybean Oil, Modified Corn Starch, Sugar, TBHQ',
 'database_seed', 0),

('Pepperoni Pizza Crispy Pan', 'DiGiorno', 'food', '071921006839', 32, 'toxic',
 'Contains sodium nitrite (in pepperoni), BHA, BHT, modified food starch, artificial flavor, and soybean oil. High sodium at over 800mg per serving. "It''s not delivery" — it is chemistry.',
 'Better than Totino''s but still has sodium nitrite, BHA, BHT, soybean oil, and artificial flavors. The crust is enriched flour with chemical dough conditioners. Frozen pizza doesn''t have to be this processed.',
 'Crust (Enriched Flour, Water, Soybean Oil, Sugar, Yeast, Salt, DATEM, Dough Conditioners), Sauce (Tomato Paste, Water, Modified Food Starch, Salt, Spices, Garlic Powder), Mozzarella (Pasteurized Milk, Cheese Cultures, Salt, Enzymes), Pepperoni (Pork, Beef, Salt, Spices, Dextrose, Lactic Acid, Oleoresin Paprika, Sodium Nitrite, BHA, BHT)',
 'database_seed', 0),

('Chicken Nuggets', 'Tyson', 'food', '023700011527', 30, 'toxic',
 'Contains enriched bleached flour, soybean oil, modified corn starch, sodium phosphates, and dextrose. The chicken is a mix of "chicken breast with rib meat" — meaning processed and reformed.',
 'The chicken is mechanically processed, mixed with water, sodium phosphates, and modified food starch, then coated in bleached flour fried in soybean oil. Compare the ingredient list to "chicken, salt, pepper" and you see the problem.',
 'Chicken Breast with Rib Meat, Water, Enriched Bleached Wheat Flour, Modified Corn Starch, Soybean Oil, Salt, Sodium Phosphates, Dextrose, Dried Yeast, Extractives of Paprika, Leavening (Sodium Acid Pyrophosphate, Sodium Bicarbonate), Soybean Oil, Yellow Corn Flour, Natural Flavor',
 'database_seed', 0),

('Organic Chicken Nuggets', 'Applegate Naturals', 'food', '025317693004', 78, 'safe',
 'Made with organic chicken breast, organic bread crumbs, and organic expeller-pressed canola oil. No antibiotics, chemical nitrites, or artificial ingredients. Humanely raised chicken.',
 'Organic chicken, organic bread crumbs, organic oil. The ingredient list is short and clean. Humanely raised, no antibiotics. Frozen chicken nuggets your kids will eat that you won''t feel guilty about.',
 'Organic Chicken Breast, Water, Organic Bread Crumbs (Organic Wheat Flour, Organic Cane Sugar, Sea Salt, Organic Expeller-Pressed Canola Oil, Yeast), Organic Expeller-Pressed Canola Oil, Organic Rice Starch, Sea Salt',
 'database_seed', 0),

('Maple & Brown Sugar Instant Oatmeal', 'Quaker', 'food', '030000010556', 45, 'caution',
 'Contains 12 grams of sugar per packet from multiple sources (sugar, corn syrup, dextrose). Also has "natural and artificial flavors" and caramel color. Highly sweetened processed oatmeal.',
 'Quaker instant oatmeal is 30% sugar by weight in the flavored varieties. Sugar, corn syrup, AND dextrose — three sweeteners for one breakfast. Buy plain oats and add your own maple syrup. Same convenience, way less sugar.',
 'Whole Grain Rolled Oats, Sugar, Natural and Artificial Flavors, Salt, Calcium Carbonate, Guar Gum, Caramel Color, Niacinamide, Vitamin A Palmitate, Reduced Iron, Pyridoxine Hydrochloride, Riboflavin, Thiamine Mononitrate, Folic Acid',
 'database_seed', 0),

('Organic Instant Oatmeal Original', 'Nature''s Path', 'food', '058449450009', 88, 'safe',
 'Just organic whole grain rolled oats. No added sugar, flavors, colors, or preservatives. USDA Organic, Non-GMO Project Verified. Add your own toppings.',
 'One ingredient: organic oats. Add your own banana, honey, berries, or maple syrup. You control the sugar, the flavor, and the quality. This is how breakfast should work.',
 'Organic Whole Grain Rolled Oats',
 'database_seed', 0),

('Original Pancake Syrup', 'Mrs. Butterworth''s', 'food', '644209424023', 10, 'toxic',
 'Contains zero maple syrup. First two ingredients are corn syrup and high fructose corn syrup. Also has artificial flavor, caramel color (potential 4-MeI), sodium benzoate, and sorbic acid.',
 'This is not maple syrup. It is corn syrup and high fructose corn syrup flavored with artificial maple flavoring and colored with caramel color. Read the label — the word "maple" does not appear in the ingredients.',
 'Corn Syrup, High Fructose Corn Syrup, Water, Cellulose Gum, Caramel Color, Salt, Natural and Artificial Flavor, Sodium Benzoate and Sorbic Acid (Preservatives), Citric Acid',
 'database_seed', 0),

('Organic Maple Syrup Grade A Dark Robust', 'Coombs Family Farms', 'food', '710282439176', 92, 'safe',
 'Single ingredient: organic maple syrup. Tapped from organic maple trees and boiled down — nothing added. Rich in manganese, zinc, and antioxidants. USDA Organic.',
 'One ingredient: organic maple syrup. Boiled tree sap. That is it. Compare to Mrs. Butterworth''s two types of corn syrup plus chemicals. Real maple syrup costs more because it is actually food.',
 'Organic Maple Syrup',
 'database_seed', 0),

-- =============================================================================
-- CLEANING (expand — bathroom, toilet, fabric)
-- =============================================================================

('Bathroom Cleaner', 'Scrubbing Bubbles', 'cleaning', '025700701323', 18, 'toxic',
 'Contains 2-butoxyethanol (glycol ether linked to blood disorders), synthetic fragrance, multiple surfactants, and propellant gases. Creates heavy fumes in enclosed bathroom spaces.',
 'You spray this in a small enclosed bathroom and breathe 2-butoxyethanol — a glycol ether that the EPA flags for blood and kidney damage. In a small bathroom with no ventilation, the concentration gets high fast.',
 'Water, Diethylene Glycol Butyl Ether, C10-16 Alkyldimethylamine Oxide, Sodium Hypochlorite, Fragrance, Tetrasodium EDTA, Sodium Hydroxide, Colorant',
 'database_seed', 0),

('Toilet Bowl Cleaner with Bleach', 'Clorox', 'cleaning', '044600001685', 15, 'toxic',
 'Contains sodium hypochlorite (bleach), sodium hydroxide (lye), and synthetic fragrance. Extremely corrosive. Never mix with ammonia or other cleaners — produces chlorine gas (potentially fatal).',
 'Bleach toilet cleaners are some of the most dangerous products in your home. Mixing with ammonia-based cleaners creates chlorine gas. The synthetic fragrance adds chemical exposure on top. Baking soda and vinegar clean toilets safely.',
 'Water, Sodium Hypochlorite, Sodium Hydroxide, C12-18 Alkyl Dimethyl Amine Oxide, Fragrance, Sodium Silicate, Colorant (Blue 1)',
 'database_seed', 0),

('Toilet Bowl Cleaner', 'Better Life', 'cleaning', '895454002232', 85, 'safe',
 'Plant-derived formula with tea tree oil and eucalyptus. No chlorine bleach, synthetic fragrances, dyes, or caustic chemicals. Safe for septic systems. Cruelty-free and made in USA.',
 'Tea tree oil is a natural antimicrobial. Combined with plant-based surfactants, it cleans toilets without bleach fumes or the risk of creating chlorine gas. Your bathroom doesn''t need to smell like a chemical plant.',
 'Water, Citric Acid, Decyl Glucoside, Lauryl Glucoside, Xanthan Gum, Melaleuca Alternifolia (Tea Tree) Leaf Oil, Eucalyptus Globulus Leaf Oil',
 'database_seed', 0),

('Fabric Refresher Allergen Reducer', 'Febreze', 'cleaning', '037000961949', 22, 'toxic',
 'Contains cyclodextrin (odor trapper), synthetic fragrance, ethanol, and didecyl dimethyl ammonium chloride (a quaternary ammonium compound). Sprayed on couches, beds, and pillows you rest on.',
 'You spray this on your couch, pillow, and bed — surfaces you press your face against for hours. The synthetic fragrance and quaternary ammonium compound sit on the fabric indefinitely. Open a window instead.',
 'Water, Alcohol, Hydrogenated Castor Oil, Cyclodextrin, Didecyl Dimethyl Ammonium Chloride, Fragrance, Diethylene Glycol, Benzisothiazolinone, Sodium Hydroxide',
 'database_seed', 0),

-- =============================================================================
-- SKINCARE (expand — acne, face wash, SPF moisturizer)
-- =============================================================================

('Apricot Scrub Blemish & Blackhead Control', 'St. Ives', 'skincare', '077043100684', 25, 'toxic',
 'Walnut shell powder creates micro-tears in skin (dermatologists widely condemn physical scrubs this abrasive). Contains fragrance, BHT, and DMDM hydantoin (formaldehyde releaser).',
 'Dermatologists have been warning against this scrub for years — the crushed walnut shells create microscopic tears in your skin that cause inflammation and damage. Add in DMDM hydantoin and you have a product that actively harms.',
 'Water, Juglans Regia (Walnut) Shell Powder, Glycerin, Cetearyl Alcohol, Salicylic Acid, Zea Mays (Corn) Kernel Meal, PEG-100 Stearate, Glyceryl Stearate, Cetyl Alcohol, Fragrance, DMDM Hydantoin, Dimethicone, Carbomer, Triethanolamine, BHT, Methylchloroisothiazolinone',
 'database_seed', 0),

('Oil-Free Acne Wash', 'Neutrogena', 'skincare', '070501053508', 48, 'caution',
 'Active ingredient salicylic acid 2% (effective for acne). But also contains SLS, fragrance, artificial color (D&C Yellow 10), and DMDM hydantoin in some formulations. A mixed bag.',
 'The salicylic acid works for acne — that part is good. But SLS is a known irritant, and putting fragrance on already-inflamed acne skin is counterproductive. Clean acne products exist without the irritants.',
 'Active: Salicylic Acid 2%. Inactive: Water, Sodium C14-16 Olefin Sulfonate, Cocamidopropyl Betaine, Sodium Chloride, PEG-80 Sorbitan Laurate, C12-15 Alkyl Lactate, Cocamidopropyl PG-Dimonium Chloride Phosphate, Fragrance, Disodium EDTA, D&C Yellow No. 10, Citric Acid, Aloe Barbadensis Leaf Juice',
 'database_seed', 0),

('The Ordinary Niacinamide 10% + Zinc 1%', 'DECIEM', 'skincare', '769915190328', 88, 'safe',
 'High-concentration niacinamide serum with zinc for oil control and blemishes. No fragrance, parabens, sulfates, or mineral oil. Vegan and cruelty-free. Remarkably affordable clean skincare.',
 'This is what disrupted the skincare industry — clinical-grade niacinamide and zinc for under $10. No fragrance, no parabens, no unnecessary fillers. Proof that effective skincare doesn''t need 50 chemicals or a luxury price tag.',
 'Aqua (Water), Niacinamide, Pentylene Glycol, Zinc PCA, Dimethyl Isosorbide, Tamarindus Indica Seed Gum, Xanthan Gum, Isoceteth-20, Ethoxydiglycol, Phenoxyethanol, Chlorphenesin',
 'database_seed', 0),

-- =============================================================================
-- PET (expand — cat litter)
-- =============================================================================

('Clumping Cat Litter 24/7 Performance', 'Tidy Cats', 'pet', '070230107138', 35, 'toxic',
 'Clay-based litter with synthetic fragrance, deodorizers, and dust that cats inhale and ingest during grooming. Sodium bentonite clay is strip-mined and non-biodegradable.',
 'Clay litter creates dust your cat breathes in and swallows during grooming. The synthetic fragrance is an added chemical irritant. Sodium bentonite is strip-mined and never biodegrades. Natural alternatives exist.',
 'Natural Clay, Guar Gum, Fragrance, Deodorizer',
 'database_seed', 0),

('Clumping Litter', 'World''s Best Cat Litter', 'pet', '840673100108', 85, 'safe',
 'Made from whole-kernel corn — naturally absorbent and clumping. Flushable and septic-safe. No synthetic chemicals, fragrances, or silica dust. Biodegradable and compostable.',
 'Whole corn kernels that clump naturally. No clay dust, no synthetic fragrance, no strip mining. It is flushable, biodegradable, and your cat isn''t inhaling silica dust. Better for your cat and the planet.',
 'Whole-Kernel Corn',
 'database_seed', 0),

-- =============================================================================
-- BEVERAGE (expand — sports/wellness, chocolate milk, protein)
-- =============================================================================

('Vitamin Water XXX Açaí-Blueberry-Pomegranate', 'Glacéau', 'beverage', '786162002648', 28, 'toxic',
 'Contains crystalline fructose (processed sugar), cane sugar, and "natural flavors." Has 27 grams of sugar per bottle despite health-focused branding. The vitamins are synthetic additives.',
 'Coca-Cola was sued and lost for implying this was healthy. It is sugar water with synthetic vitamins. 27 grams of sugar in a bottle branded to look like a wellness product. The branding is the product, not the nutrition.',
 'Reverse Osmosis Water, Crystalline Fructose, Cane Sugar, Citric Acid, Natural Flavors, Ascorbic Acid (Vitamin C), Vegetable Juice (Color), Magnesium Lactate, Calcium Lactate, Niacin (B3), Pantothenic Acid (B5), Pyridoxine Hydrochloride (B6), Cyanocobalamin (B12)',
 'database_seed', 0),

('Chocolate Syrup', 'Nesquik', 'beverage', '028000968007', 20, 'toxic',
 'Contains sugar, corn syrup, and cocoa processed with alkali (reduces antioxidants). Also has potassium sorbate, artificial flavor, and citric acid. 18g sugar per 2 tablespoons.',
 'Sugar and corn syrup before cocoa — so it is more sugar than chocolate. The cocoa is processed with alkali which strips out the antioxidants that make chocolate actually beneficial. Make hot cocoa with real cocoa powder and honey instead.',
 'Sugar, Water, Corn Syrup, Cocoa (Processed with Alkali), Salt, Citric Acid, Potassium Sorbate (Preservative), Artificial Flavor, Xanthan Gum',
 'database_seed', 0),

('SportWater Electrolyte Enhanced Water', 'BODYARMOR', 'beverage', '858176002270', 55, 'caution',
 'Filtered water with electrolytes — no sugar, artificial sweeteners, colors, or flavors. Contains coconut water concentrate and electrolytes. Clean for flavored water, though some varieties add sugar.',
 'The plain water version is surprisingly clean — just water, electrolytes, and coconut water. No artificial anything. The sport drinks with flavor have more sugar, so stick with the plain water variety.',
 'Reverse Osmosis Water, Coconut Water Concentrate, Magnesium Oxide, Calcium Chloride, Potassium Bicarbonate, Potassium Phosphate, Sea Salt, Zinc Gluconate',
 'database_seed', 0),

('Organic Chocolate Whole Milk', 'Horizon Organic', 'beverage', '036632032874', 68, 'safe',
 'USDA Organic milk with organic cocoa and organic cane sugar. No high fructose corn syrup, artificial flavors, or growth hormones. Contains 22g sugar (naturally occurring + added), which is the main concern.',
 'If your kids want chocolate milk, this is the way. Organic milk, organic cocoa, organic sugar. No corn syrup, no artificial anything. Still has added sugar — 22g total — but miles ahead of Nesquik.',
 'Organic Grade A Milk, Organic Cane Sugar, Organic Cocoa (Processed with Alkali), Organic Natural Flavor, Gellan Gum, Vitamin A Palmitate, Vitamin D3',
 'database_seed', 0),

-- =============================================================================
-- HAIRCARE (expand — dry shampoo, treatments)
-- =============================================================================

('Bio:Renew Argan Oil Shampoo', 'Herbal Essences', 'haircare', '190679000101', 50, 'caution',
 'Improved formula without parabens, but still contains sodium laureth sulfate, synthetic fragrance, DMDM hydantoin (formaldehyde releaser), and artificial colors. "Bio:Renew" is marketing, not a clean formulation.',
 'Herbal Essences made noise about removing parabens but kept DMDM hydantoin — the formaldehyde releaser. The plant imagery on the bottle is aspirational, not reflective of the ingredient list.',
 'Water, Sodium Laureth Sulfate, Sodium Lauryl Sulfate, Cocamide MEA, Fragrance, Sodium Chloride, Sodium Xylenesulfonate, Glycol Distearate, Linoleamidopropyl PG-Dimonium Chloride Phosphate, Guar Hydroxypropyltrimonium Chloride, Sodium Citrate, DMDM Hydantoin, Citric Acid, Tetrasodium EDTA, Blue 1, Red 33',
 'database_seed', 0),

('Dry Shampoo Fresh', 'Batiste', 'haircare', '5010724527481', 35, 'toxic',
 'Aerosol spray containing butane/isobutane/propane propellants, rice starch, synthetic fragrance, and benzisothiazolinone (preservative restricted in the EU). You spray this directly onto your scalp.',
 'You spray butane, isobutane, and propane onto your scalp near your eyes and nose. These are petroleum-derived propellant gases. The synthetic fragrance is an additional chemical cocktail absorbed through your scalp.',
 'Butane, Isobutane, Propane, Oryza Sativa (Rice) Starch, Alcohol Denat., Fragrance, Distearyldimonium Chloride, Cetrimonium Chloride, Benzisothiazolinone',
 'database_seed', 0),

('Rosemary Mint Scalp & Hair Strengthening Oil', 'Mielle Organics', 'haircare', '850017735019', 82, 'safe',
 'Biotin-infused hair oil with rosemary and mint. No sulfates, parabens, mineral oil, petroleum, or artificial colors. Made with natural and organic ingredients. The viral TikTok hair product that actually delivers.',
 'This went viral on TikTok and it actually deserves the hype. Rosemary oil is proven to support hair growth. No mineral oil or petroleum — just plant oils and biotin. Clean ingredients that actually work.',
 'Ricinus Communis (Castor) Seed Oil, Cocos Nucifera (Coconut) Oil, Mentha Piperita (Peppermint) Oil, Rosmarinus Officinalis (Rosemary) Leaf Oil, Mentha Viridis (Spearmint) Leaf Oil, Simmondsia Chinensis (Jojoba) Seed Oil, Biotin, Tocopherol',
 'database_seed', 0),

-- =============================================================================
-- CONDIMENT (expand — jam, spreads)
-- =============================================================================

('Concord Grape Jelly', 'Smucker''s', 'condiment', '051500014417', 38, 'caution',
 'Made with grape juice concentrate, high fructose corn syrup, corn syrup, fruit pectin, and citric acid. Two types of corn syrup in what should be a simple fruit preserve.',
 'Jelly should be fruit and sugar. Smucker''s uses grape juice concentrate plus BOTH high fructose corn syrup AND regular corn syrup. Two corn syrups in grape jelly. Fruit preserves with just fruit and cane sugar exist.',
 'Concord Grape Juice (Water, Grape Juice Concentrate), High Fructose Corn Syrup, Corn Syrup, Fruit Pectin, Citric Acid, Sodium Citrate',
 'database_seed', 0),

('Organic Strawberry Fruit Spread', 'Crofter''s', 'condiment', '067275001019', 90, 'safe',
 'Made with organic strawberries, organic cane sugar, and fruit pectin. No high fructose corn syrup, artificial flavors, colors, or preservatives. Fair Trade certified.',
 'Three ingredients: organic strawberries, organic sugar, pectin. That is jam. No corn syrups (plural!), no artificial anything. Crofter''s proves that the simplest version is usually the cleanest.',
 'Organic Strawberries, Organic Fair Trade Cane Sugar, Fruit Pectin, Citric Acid, Ascorbic Acid',
 'database_seed', 0),

-- =============================================================================
-- SUNSCREEN (expand)
-- =============================================================================

('Regenerist Whip SPF 25 Moisturizer', 'Olay', 'sunscreen', '075609197994', 38, 'caution',
 'Uses chemical sunscreens (avobenzone, octisalate, octocrylene) that absorb into the bloodstream. Also contains dimethicone, fragrance, and phenoxyethanol. Dual-purpose but chemical-heavy.',
 'Chemical sunscreens that absorb into your bloodstream (FDA confirmed this) combined with synthetic fragrance and silicone — all on your face every day. Mineral zinc-based SPF moisturizers exist.',
 'Active: Avobenzone 3%, Octisalate 4.5%, Octocrylene 5%. Inactive: Water, Glycerin, Niacinamide, Dimethicone, Isododecane, Aluminum Starch Octenylsuccinate, PEG-100 Stearate, Fragrance, Phenoxyethanol, Acrylates/C10-30 Alkyl Acrylate Crosspolymer, Aminomethyl Propanol',
 'database_seed', 0),

('Daily Moisturizer SPF 40 Tinted Mineral Sunscreen', 'Pipette', 'sunscreen', NULL, 90, 'safe',
 'Non-nano zinc oxide mineral sunscreen with squalane moisturizer. Dermatologist tested. No chemical UV filters, synthetic fragrance, parabens, or phthalates. Originally made for postpartum skin.',
 'Mineral zinc that sits on top of your skin instead of absorbing into your bloodstream. Squalane for hydration. No chemical filters, no fragrance. Clean enough for postpartum skin means clean enough for everyone.',
 'Active: Non-Nano Zinc Oxide 16%. Inactive: Water, Squalane, Coco-Caprylate/Caprate, Glycerin, Butyloctyl Salicylate, Cetyl Alcohol, Glyceryl Stearate, Polyhydroxystearic Acid, Iron Oxides, Tocopherol',
 'database_seed', 0);
