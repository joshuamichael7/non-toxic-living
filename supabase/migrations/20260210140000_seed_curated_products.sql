-- =============================================================================
-- Seed curated products database
-- Remove auto-created scan products, add real US products with accurate data
-- =============================================================================

-- First, remove all auto-created products from user scans
DELETE FROM public.products WHERE source = 'user_scan';

-- =============================================================================
-- FOOD & BEVERAGES
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Cheerios Original
('Cheerios Original', 'General Mills', 'food', '016000275263', 72, 'safe',
 'A classic whole grain oat cereal with minimal additives. Contains some added sugar and tripotassium phosphate, but overall a clean option.',
 'One of the cleaner mainstream cereals. The whole grain oats are the star here. Just watch the sugar if you are eating multiple bowls.',
 'Whole Grain Oats, Modified Corn Starch, Sugar, Salt, Tripotassium Phosphate, Oat Fiber, Wheat Starch, Vitamin E (Mixed Tocopherols) Added to Preserve Freshness',
 'database_seed', 0),

-- Honey Nut Cheerios
('Honey Nut Cheerios', 'General Mills', 'food', '016000487796', 58, 'caution',
 'Contains more sugar than Original Cheerios plus natural flavors. The honey is mostly sugar syrup.',
 'This is basically Cheerios with a lot more sugar and natural flavors (which can hide a lot). The original is a much better choice.',
 'Whole Grain Oats, Sugar, Oat Bran, Modified Corn Starch, Honey, Brown Sugar Syrup, Salt, Tripotassium Phosphate, Canola Oil, Natural Almond Flavor, Vitamin E (Mixed Tocopherols) Added to Preserve Freshness',
 'database_seed', 0),

-- Goldfish Cheddar
('Goldfish Cheddar', 'Pepperidge Farm', 'snack', '014100085478', 52, 'caution',
 'Contains enriched wheat flour and annatto extract for color. No artificial preservatives but has some processed ingredients.',
 'A popular kid snack that is okay in moderation. The enriched flour and annatto are not ideal but there are worse snacks out there.',
 'Enriched Wheat Flour (Flour, Niacin, Reduced Iron, Thiamine Mononitrate, Riboflavin, Folic Acid), Cheddar Cheese (Cultured Milk, Salt, Enzymes), Vegetable Oils (Canola, Sunflower, and/or Soybean), Salt, Yeast, Sugar, Autolyzed Yeast, Baking Soda, Monocalcium Phosphate, Paprika, Celery, Onion Powder, Annatto Extract (Color)',
 'database_seed', 0),

-- Doritos Nacho Cheese
('Doritos Nacho Cheese', 'Frito-Lay', 'snack', '028400443685', 28, 'toxic',
 'Highly processed with artificial colors (Red 40, Yellow 6, Yellow 5), MSG, and multiple artificial additives.',
 'This is one of the worst mainstream snacks ingredient-wise. Multiple artificial colors linked to behavioral issues in kids, plus MSG and tons of processing.',
 'Corn, Vegetable Oil (Corn, Canola, and/or Sunflower Oil), Maltodextrin, Salt, Cheddar Cheese (Milk, Cheese Cultures, Salt, Enzymes), Whey, Monosodium Glutamate, Buttermilk, Romano Cheese (Part-Skim Cow''s Milk, Cheese Cultures, Salt, Enzymes), Whey Protein Concentrate, Onion Powder, Corn Flour, Natural and Artificial Flavors, Dextrose, Tomato Powder, Lactose, Spices, Artificial Color (including Red 40, Blue 1, Yellow 6), Lactic Acid, Citric Acid, Sugar, Garlic Powder, Skim Milk, Red and Green Bell Pepper Powder, Disodium Inosinate, Disodium Guanylate',
 'database_seed', 0),

-- Annie's Organic Cheddar Bunnies
('Organic Cheddar Bunnies', 'Annie''s Homegrown', 'snack', '013562302307', 78, 'safe',
 'Organic ingredients with no artificial colors, flavors, or preservatives. A much cleaner alternative to conventional cheese crackers.',
 'This is what a cheese cracker should look like ingredient-wise. Organic flour, real cheese, no artificial anything. Great swap for Goldfish or Cheez-Its.',
 'Organic Wheat Flour, Organic Cheddar Cheese (Organic Cultured Pasteurized Milk, Salt, Enzymes), Organic Sunflower Oil, Salt, Organic Annatto Extract (Color)',
 'database_seed', 0),

-- Coca-Cola Classic
('Coca-Cola Classic', 'The Coca-Cola Company', 'beverage', '049000006346', 18, 'toxic',
 'Contains high fructose corn syrup (or sugar), phosphoric acid, caramel color (4-MEI concerns), and caffeine. Zero nutritional value.',
 'The caramel color in Coca-Cola contains 4-MEI, a potential carcinogen. Add in 39g of sugar per can and phosphoric acid that leaches calcium, and this is a hard pass.',
 'Carbonated Water, High Fructose Corn Syrup, Caramel Color, Phosphoric Acid, Natural Flavors, Caffeine',
 'database_seed', 0),

-- Horizon Organic Whole Milk
('Organic Whole Milk', 'Horizon Organic', 'dairy', '036632036117', 88, 'safe',
 'USDA Organic whole milk with no artificial hormones, antibiotics, or synthetic pesticides. A clean dairy option.',
 'This is about as clean as conventional milk gets. Organic, no rBST hormones, pasture-raised. If you drink milk, this is a solid choice.',
 'Organic Grade A Milk, Vitamin D3',
 'database_seed', 0),

-- Hidden Valley Ranch Dressing
('Original Ranch Dressing', 'Hidden Valley', 'condiment', '071100003291', 25, 'toxic',
 'Contains MSG, artificial flavors, multiple preservatives (calcium disodium EDTA, potassium sorbate, sodium benzoate), and soybean oil.',
 'Ranch dressing is one of the sneakiest toxic products in the average American fridge. MSG, artificial flavors, multiple preservatives, and inflammatory soybean oil. Make your own or find a clean brand.',
 'Vegetable Oil (Soybean and/or Canola), Water, Egg Yolk, Sugar, Salt, Cultured Nonfat Buttermilk, Natural Flavors, Spices, Dried Garlic, Dried Onion, Vinegar, Phosphoric Acid, Xanthan Gum, Modified Food Starch, Monosodium Glutamate, Artificial Flavors, Disodium Phosphate, Sorbic Acid, Calcium Disodium EDTA',
 'database_seed', 0),

-- Primal Kitchen Ranch
('Ranch Dressing with Avocado Oil', 'Primal Kitchen', 'condiment', '855232007118', 82, 'safe',
 'Made with avocado oil instead of soybean oil, organic ingredients, no artificial preservatives or MSG.',
 'This is what ranch should be. Avocado oil base, organic herbs, no artificial anything. It costs more but your body will thank you.',
 'Avocado Oil, Water, Organic Distilled Vinegar, Organic Gum Acacia, Sea Salt, Organic Onion, Organic Garlic, Organic Black Pepper, Organic Dill, Organic Chives, Organic Parsley, Organic Rosemary Extract',
 'database_seed', 0),

-- Nature's Path Organic Heritage Flakes
('Organic Heritage Flakes', 'Nature''s Path', 'food', '058449770015', 85, 'safe',
 'Certified organic cereal with ancient grains, no artificial additives. Sweetened minimally with organic cane sugar.',
 'An excellent clean cereal option. Ancient grains like kamut, spelt, and quinoa with minimal processing. One of the best mainstream cereals you can buy.',
 'Organic Kamut Khorasan Wheat, Organic Oat Flour, Organic Spelt Flour, Organic Barley Flour, Organic Millet Flour, Organic Quinoa Flour, Organic Cane Sugar, Sea Salt',
 'database_seed', 0),

-- Kraft Singles American Cheese
('Singles American Cheese', 'Kraft', 'dairy', '021000615858', 22, 'toxic',
 'Highly processed cheese product with sodium citrate, calcium phosphate, sorbic acid preservative, and artificial color (annatto, apocarotenal).',
 'This is technically a "cheese product," not real cheese. It is engineered in a lab with emulsifiers, preservatives, and coloring. Buy real cheese instead.',
 'Cheddar Cheese (Milk, Cheese Culture, Salt, Enzymes), Whey, Milk, Milk Protein Concentrate, Milkfat, Sodium Citrate, Contains Less than 2% of Calcium Phosphate, Whey Protein Concentrate, Salt, Lactic Acid, Sorbic Acid as a Preservative, Cheese Culture, Enzymes, Annatto and Apocarotenal (Color), Vitamin D3',
 'database_seed', 0);

-- =============================================================================
-- PERSONAL CARE & SKINCARE
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- CeraVe Moisturizing Cream
('Moisturizing Cream', 'CeraVe', 'skincare', '301871371016', 80, 'safe',
 'Dermatologist-recommended with ceramides and hyaluronic acid. Contains some parabens-free preservatives. MVE technology for sustained hydration.',
 'One of the best mainstream moisturizers. The ceramides help repair your skin barrier. No parabens, no fragrance. Dermatologists love this one for a reason.',
 'Purified Water, Glycerin, Ceteareth-20 and Cetearyl Alcohol, Capric/Caprylic Triglyceride, Behentrimonium Methosulfate and Cetearyl Alcohol, Cetyl Alcohol, Ceramide NP, Ceramide AP, Ceramide EOP, Carbomer, Dimethicone, Petrolatum, Potassium Phosphate, Cholesterol, Sodium Lauroyl Lactylate, Disodium EDTA, Dihydroxy Aluminum Aminoacetate, Sodium Hyaluronate, Phytosphingosine, Methylparaben, Propylparaben, Xanthan Gum, Dipotassium Phosphate',
 'database_seed', 0),

-- Neutrogena Ultra Sheer Dry-Touch Sunscreen SPF 70
('Ultra Sheer Dry-Touch Sunscreen SPF 70', 'Neutrogena', 'sunscreen', '086800687252', 35, 'caution',
 'Contains oxybenzone and octinoxate, two chemical UV filters with endocrine disruption concerns. Also contains fragrance and multiple synthetic ingredients.',
 'Oxybenzone is one of the most concerning sunscreen chemicals — it is absorbed into the bloodstream and mimics estrogen. Look for mineral sunscreens with zinc oxide instead.',
 'Active: Avobenzone 3%, Homosalate 15%, Octisalate 5%, Octocrylene 10%, Oxybenzone 6%. Inactive: Water, Styrene/Acrylates Copolymer, Silica, Diethylhexyl 2,6-Naphthalate, Cetyl Dimethicone, Polyester-27, Dimethicone, BHT, Glyceryl Stearate, PEG-100 Stearate, Behenyl Alcohol, Fragrance, Dimethicone/Vinyl Dimethicone Crosspolymer, Sodium Polyacrylate, Phenoxyethanol, Caprylyl Glycol, Disodium EDTA, Ethylhexylglycerin, Methylisothiazolinone',
 'database_seed', 0),

-- Thinkbaby Safe Sunscreen SPF 50
('Safe Sunscreen SPF 50+', 'Thinkbaby', 'sunscreen', '852482003017', 92, 'safe',
 'Mineral-only sunscreen using zinc oxide as the active ingredient. Free of biologically harmful chemicals, avobenzone, oxybenzone, and UV chemical absorbers.',
 'This is the gold standard for clean sunscreen. Zinc oxide only, no chemical UV filters, no fragrance, no parabens. Safe for babies, safe for you, safe for coral reefs.',
 'Active: Zinc Oxide 20%. Inactive: Aloe Barbadensis Leaf Juice, Capric/Caprylic Triglyceride, Sorbitan Stearate, Caprylyl/Capryl Glucoside, Shea Butter, Jojoba Oil, Cranberry Seed Oil, Castor Oil, Vitamin E, Olive Oil, Sunflower Oil, Citric Acid',
 'database_seed', 0),

-- Dove Beauty Bar
('Beauty Bar White', 'Dove', 'soap', '011111012806', 55, 'caution',
 'Contains sodium lauroyl isethionate (mild surfactant) but also fragrance, tetrasodium EDTA, and BHT. Not as clean as marketed.',
 'Dove markets this as gentle and moisturizing, which it is compared to harsh soaps. But it still has synthetic fragrance and BHT. There are cleaner options.',
 'Sodium Lauroyl Isethionate, Stearic Acid, Sodium Palmitate, Lauric Acid, Sodium Isethionate, Water, Sodium Stearate, Cocamidopropyl Betaine, Sodium Cocoate, Fragrance, Sodium Chloride, Tetrasodium EDTA, Tetrasodium Etidronate, Alumina, BHT, Titanium Dioxide',
 'database_seed', 0),

-- Dr. Bronner's Pure-Castile Liquid Soap Peppermint
('Pure-Castile Liquid Soap Peppermint', 'Dr. Bronner''s', 'soap', '018787766187', 93, 'safe',
 'Certified organic, Fair Trade ingredients. Simple formula with organic coconut, olive, and hemp oils. No synthetic preservatives, detergents, or foaming agents.',
 'The cleanest mainstream soap you can buy. Organic oils, essential oils for scent, nothing synthetic. You can use it for basically everything — body, dishes, cleaning.',
 'Water, Organic Coconut Oil, Potassium Hydroxide, Organic Palm Kernel Oil, Organic Olive Oil, Mentha Arvensis, Organic Hemp Seed Oil, Organic Jojoba Oil, Mentha Piperita, Citric Acid, Tocopherol',
 'database_seed', 0),

-- Aquaphor Healing Ointment
('Healing Ointment', 'Aquaphor', 'skincare', '072140004453', 65, 'caution',
 'Petrolatum-based with minimal ingredients. Petrolatum is effective but concerns exist about PAH contamination in non-pharmaceutical grade petroleum jelly. Aquaphor uses USP grade.',
 'Aquaphor is very effective for dry skin and wound healing. The petrolatum is pharmaceutical grade so contamination risk is low, but some people prefer to avoid petroleum-based products entirely.',
 'Petrolatum, Mineral Oil, Ceresin, Lanolin Alcohol, Panthenol, Glycerin, Bisabolol',
 'database_seed', 0);

-- =============================================================================
-- HAIRCARE
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Head & Shoulders Classic Clean
('Classic Clean Shampoo', 'Head & Shoulders', 'haircare', '037000711124', 32, 'toxic',
 'Contains sodium lauryl sulfate (harsh surfactant), dimethicone (silicone buildup), synthetic fragrance, and cocamide MEA (potential carcinogen concerns).',
 'Despite being a top seller, this shampoo is loaded with problematic ingredients. The sodium lauryl sulfate strips your scalp, then the silicones coat your hair to mask the damage. Look for sulfate-free alternatives.',
 'Pyrithione Zinc 1%, Water, Sodium Lauryl Sulfate, Sodium Laureth Sulfate, Glycol Distearate, Zinc Carbonate, Sodium Chloride, Sodium Xylenesulfonate, Cocamide MEA, Fragrance, Dimethicone, Sodium Benzoate, Guar Hydroxypropyltrimonium Chloride, Magnesium Carbonate Hydroxide, Methylchloroisothiazolinone, Methylisothiazolinone',
 'database_seed', 0),

-- Shea Moisture Coconut & Hibiscus Shampoo
('Coconut & Hibiscus Curl & Shine Shampoo', 'SheaMoisture', 'haircare', '764302204121', 78, 'safe',
 'Sulfate-free formula with natural ingredients including shea butter, coconut oil, and hibiscus extract. Free from parabens, phthalates, and mineral oil.',
 'A great clean haircare option. No sulfates, no parabens, coconut oil and shea butter for moisture. One of the best mainstream clean shampoos available.',
 'Water, Sodium Cocoyl Isethionate, Cocamidopropyl Betaine, Decyl Glucoside, Glycol Stearate, Butyrospermum Parkii (Shea) Butter, Cocos Nucifera (Coconut) Oil, Mango Seed Butter, Silk Protein, Hibiscus Sabdariffa Flower Extract, Panthenol, Coconut Fatty Acids, Caprylhydroxamic Acid, Caprylyl Glycol, Fragrance',
 'database_seed', 0),

-- Pantene Pro-V Daily Moisture Renewal Conditioner
('Pro-V Daily Moisture Renewal Conditioner', 'Pantene', 'haircare', '080878181223', 40, 'caution',
 'Contains dimethicone and dimethiconol (silicone buildup), synthetic fragrance, DMDM hydantoin (formaldehyde releaser), and methylisothiazolinone (allergen).',
 'Pantene sounds premium but check the ingredients. DMDM hydantoin slowly releases formaldehyde. Methylisothiazolinone is a known allergen banned in leave-on products in the EU. Not worth the risk.',
 'Water, Stearyl Alcohol, Behentrimonium Methosulfate, Cetyl Alcohol, Bis-Aminopropyl Dimethicone, Fragrance, Benzyl Alcohol, Dimethicone, Sodium Chloride, Disodium EDTA, DMDM Hydantoin, Dimethiconol, Panthenol, Panthenyl Ethyl Ether, Methylisothiazolinone, Citric Acid',
 'database_seed', 0);

-- =============================================================================
-- CLEANING & LAUNDRY
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Tide Original Liquid Laundry Detergent
('Original Liquid Laundry Detergent', 'Tide', 'laundry', '037000230328', 25, 'toxic',
 'Contains optical brighteners (coat clothes in UV-reactive chemicals), synthetic fragrances with potential phthalates, and 1,4-dioxane contamination concerns from ethoxylated surfactants.',
 'Tide is incredibly effective at cleaning but it is a chemical cocktail. Optical brighteners stay on your clothes and contact your skin all day. The fragrance alone can contain dozens of undisclosed chemicals.',
 'Water, Alcohol Ethoxylate C12-15, Linear Alkylbenzene Sulfonate, Propylene Glycol, Citric Acid, Sodium Borate, Ethanolamine, Sodium C10-16 Alkylbenzenesulfonate, Diquaternium Ethoxy Sulfate, Fragrance, Sodium Fatty Acids, Polyethyleneimine Ethoxylate, Diethylene Glycol, Calcium Formate, Disodium Diaminostilbene Disulfonate, Fluorescent Brightener 260, Protease, Amylase, Mannanase, Liquitint Blue',
 'database_seed', 0),

-- Seventh Generation Free & Clear Laundry Detergent
('Free & Clear Liquid Laundry Detergent', 'Seventh Generation', 'laundry', '732913228102', 85, 'safe',
 'Plant-based formula with no fragrances, dyes, or optical brighteners. USDA Certified Biobased product. Hypoallergenic.',
 'This is what laundry detergent should be. Gets clothes clean without coating them in synthetic chemicals. No fragrance, no optical brighteners, no dyes. Safe for sensitive skin and babies.',
 'Water, Sodium Lauryl Sulfate (plant-derived), Lauramine Oxide (plant-derived), Glycerin (plant-derived), Sodium Chloride, Calcium Chloride, Citric Acid, Sodium Citrate, Boric Acid, Protease Enzyme, Mannanase Enzyme, Amylase Enzyme',
 'database_seed', 0),

-- Clorox Disinfecting Wipes
('Disinfecting Wipes Crisp Lemon', 'Clorox', 'cleaning', '044600016597', 20, 'toxic',
 'Contains alkyl dimethyl benzyl ammonium chloride (quaternary ammonium compound linked to respiratory issues), synthetic fragrance, and skin irritants.',
 'Convenient but concerning. Quats (quaternary ammonium compounds) are linked to asthma, reproductive issues, and antimicrobial resistance. Use sparingly and switch to safer disinfectants for daily cleaning.',
 'Water, Alkyl C12-18 Dimethylbenzyl Ammonium Chloride 0.184%, Alkyl C12-18 Dimethylethylbenzyl Ammonium Chloride 0.184%, Isopropyl Alcohol, Alkyl Polyglucoside, Propylene Glycol Propyl Ether, Fragrance',
 'database_seed', 0),

-- Mrs. Meyer's Clean Day Multi-Surface Cleaner Lavender
('Clean Day Multi-Surface Cleaner Lavender', 'Mrs. Meyer''s', 'cleaning', '808124174139', 68, 'safe',
 'Plant-derived cleaning agents with essential oil-based fragrance. Free from parabens, phthalates, and artificial colors. Some concern about fragrance allergens.',
 'Much cleaner than conventional cleaners. Plant-based surfactants and essential oils instead of synthetic fragrance. Not perfect — essential oil fragrance can still irritate sensitive people — but a big step up from Clorox or Lysol.',
 'Water, Decyl Glucoside, Lactic Acid, Sodium Citrate, Lavandula Angustifolia (Lavender) Oil, Oleic Acid, Glycerin, Potassium Sorbate, Methylisothiazolinone, Fragrance (Plant-Derived)',
 'database_seed', 0),

-- Branch Basics Concentrate
('The Concentrate', 'Branch Basics', 'cleaning', null, 95, 'safe',
 'Plant and mineral-based formula with zero synthetic fragrances, preservatives, or dyes. One of the cleanest all-purpose cleaners available.',
 'The gold standard for non-toxic cleaning. One concentrate does everything — all-purpose, bathroom, laundry, dishes. Zero fragrance, zero preservatives, zero garbage. This is what I use at home.',
 'Water, Coco Glucoside, Decyl Glucoside, Chamomilla Recutita (Matricaria) Flower Extract, Sodium Citrate, Sodium Bicarbonate, Sodium Phytate',
 'database_seed', 0);

-- =============================================================================
-- BABY PRODUCTS
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Johnson's Baby Shampoo
('Baby Shampoo', 'Johnson''s', 'baby', '381370032182', 42, 'caution',
 'Reformulated to remove formaldehyde-releasing preservatives, but still contains fragrance, PEG-80 sorbitan laurate, and other synthetic ingredients. Better than before but still not clean.',
 'Johnson''s cleaned up their formula after public pressure, but it still has synthetic fragrance and questionable surfactants. For a product going on your baby, you can do better.',
 'Water, Cocamidopropyl Betaine, PEG-80 Sorbitan Laurate, Sodium Trideceth Sulfate, PEG-150 Distearate, Fragrance, Polyquaternium-10, Tetrasodium EDTA, Sodium Benzoate, Citric Acid, Sodium Hydroxide, Yellow 6',
 'database_seed', 0),

-- Babyganics Shampoo + Body Wash
('Shampoo + Body Wash Fragrance Free', 'Babyganics', 'baby', '813277012849', 80, 'safe',
 'Plant-based formula free from fragrances, sulfates, parabens, phthalates, mineral oil, and petrolatum. NeoNourish Seed Oil Blend with tomato, sunflower, cranberry, black cumin, and raspberry.',
 'A solid clean baby wash. No fragrance, no sulfates, plant-based surfactants. The seed oil blend is a nice touch. Good option for sensitive baby skin.',
 'Water, Sodium Methyl Cocoyl Taurate, Cocamidopropyl Hydroxysultaine, Sodium Cocoyl Isethionate, Glycerin, Acrylates Copolymer, Solanum Lycopersicum (Tomato) Seed Oil, Helianthus Annuus (Sunflower) Seed Oil, Vaccinium Macrocarpon (Cranberry) Seed Oil, Nigella Sativa (Black Cumin) Seed Oil, Rubus Idaeus (Raspberry) Seed Oil, Sodium Hydroxide, Citric Acid, Sodium Benzoate, Potassium Sorbate',
 'database_seed', 0),

-- Pampers Swaddlers Diapers (listing key materials)
('Swaddlers Diapers', 'Pampers', 'baby', '037000862093', 45, 'caution',
 'Contains petrolatum in the liner, fragrance, chlorine-processed wood pulp, and SAP (sodium polyacrylate). Lotion layer includes stearyl alcohol and paraffin.',
 'Most mainstream diapers have fragrance and petrolatum touching your baby''s skin 24/7. The chlorine-bleached pulp creates dioxin residues. Consider fragrance-free or plant-based alternatives.',
 'Polypropylene, Polyester, Wood Pulp (Chlorine-Free), Sodium Polyacrylate, Polypropylene/Polyethylene Film, Petrolatum, Stearyl Alcohol, Paraffin, Aloe Barbadensis Leaf Extract, Fragrance',
 'database_seed', 0),

-- Honest Company Diapers
('Clean Conscious Diapers', 'The Honest Company', 'baby', '810094550080', 78, 'safe',
 'Plant-based materials, totally chlorine-free processing, no fragrance, no lotions, no latex. Sustainable and cleaner alternative.',
 'Honest diapers are a real step up. No fragrance touching your baby 24 hours a day. Chlorine-free pulp means no dioxin residues. They cost a bit more but your baby''s skin is worth it.',
 'Fluff Pulp (Totally Chlorine-Free), Sodium Polyacrylate, Polypropylene, Polyethylene, Bio-Based Materials, Plant-Derived PLA',
 'database_seed', 0);

-- =============================================================================
-- ORAL CARE
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Colgate Total Whitening Toothpaste
('Total Whitening Toothpaste', 'Colgate', 'oral_care', '035000458148', 38, 'caution',
 'Contains stannous fluoride (effective) but also sodium lauryl sulfate (canker sore trigger), artificial sweetener (saccharin), and titanium dioxide.',
 'The SLS in Colgate is a known trigger for canker sores. Titanium dioxide is under scrutiny as a potential carcinogen when ingested (banned in food in the EU). There are SLS-free toothpastes that work just as well.',
 'Active: Stannous Fluoride 0.454%. Inactive: Glycerin, Sorbitol, Water, Hydrated Silica, Sodium Lauryl Sulfate, PVM/MA Copolymer, Flavor, Cellulose Gum, Sodium Hydroxide, Propylene Glycol, Carrageenan, Sodium Saccharin, Titanium Dioxide, Sucralose',
 'database_seed', 0),

-- Tom's of Maine Whole Care Fluoride Toothpaste
('Whole Care Fluoride Toothpaste Peppermint', 'Tom''s of Maine', 'oral_care', '077326832424', 82, 'safe',
 'No SLS, no artificial sweeteners, no artificial preservatives, no artificial colors or flavors. Uses xylitol as sweetener. Still contains fluoride for cavity protection.',
 'The best of both worlds — fluoride for cavity prevention without the SLS and artificial junk. Xylitol actually helps prevent cavities too. This is what I recommend for the whole family.',
 'Glycerin, Water, Hydrated Silica, Xylitol, Sodium Fluoride, Natural Flavors, Cellulose Gum, Sodium Bicarbonate, Carrageenan, Zinc Citrate',
 'database_seed', 0);

-- =============================================================================
-- DEODORANT
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Old Spice High Endurance Original
('High Endurance Deodorant Original', 'Old Spice', 'deodorant', '012044001028', 30, 'toxic',
 'Contains aluminum zirconium (endocrine disruptor), propylene glycol, synthetic fragrance, and BHT.',
 'Aluminum-based antiperspirants block your sweat glands with metal salts. Research links aluminum to breast cancer and Alzheimer''s, though not conclusively. Why risk it when aluminum-free options work great?',
 'Active: Aluminum Zirconium Trichlorohydrex Gly 19%. Inactive: Cyclopentasiloxane, Stearyl Alcohol, PPG-14 Butyl Ether, Fragrance, Hydrogenated Castor Oil, PEG-8 Distearate, BHT',
 'database_seed', 0),

-- Native Deodorant Coconut & Vanilla
('Deodorant Coconut & Vanilla', 'Native', 'deodorant', '810000280049', 84, 'safe',
 'Aluminum-free, paraben-free, sulfate-free. Uses tapioca starch and baking soda for odor control. Shea butter and coconut oil for moisture.',
 'Native proved that aluminum-free deodorant can actually work. Tapioca starch absorbs moisture, baking soda neutralizes odor, coconut oil and shea butter keep your pits happy. No toxic metals needed.',
 'Caprylic/Capric Triglyceride, Tapioca Starch, Ozokerite, Cyclodextrin, Sodium Bicarbonate, Cocos Nucifera (Coconut) Oil, Shea Butter, Dextrose, Butyrospermum Parkii Butter, Castor Oil, Magnesium Hydroxide, Fragrance',
 'database_seed', 0);

-- =============================================================================
-- COOKWARE & STORAGE
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Teflon Non-Stick Frying Pan (generic)
('Classic Non-Stick Frying Pan', 'T-fal', 'cookware', '032406564381', 28, 'toxic',
 'PTFE (Teflon) coating releases toxic fumes when overheated above 500°F. PFAS chemicals used in manufacturing are persistent environmental pollutants.',
 'Teflon pans release toxic fumes that can kill pet birds and cause flu-like symptoms in humans when overheated. The PFAS chemicals never break down in the environment or your body. Switch to cast iron or stainless steel.',
 'Materials: Aluminum Body, PTFE (Polytetrafluoroethylene) Non-Stick Coating, Stainless Steel Base, Bakelite Handle',
 'database_seed', 0),

-- Lodge Cast Iron Skillet
('Cast Iron Skillet 10.25"', 'Lodge', 'cookware', '075536000008', 97, 'safe',
 'Pure cast iron with no synthetic coatings, chemicals, or PFAS. Naturally non-stick when properly seasoned with oil. Will last generations.',
 'The safest and most durable cookware you can own. Zero chemicals, zero coatings, lasts forever. Season it with oil and it becomes naturally non-stick. This is all you need.',
 'Materials: Cast Iron, Soy-Based Vegetable Oil Seasoning',
 'database_seed', 0);

-- =============================================================================
-- SUPPLEMENTS
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- Nature Made Vitamin D3 2000 IU
('Vitamin D3 2000 IU (50 mcg)', 'Nature Made', 'supplement', '031604026721', 82, 'safe',
 'USP verified for purity and potency. Simple formula with minimal fillers. Contains soybean oil as carrier and a small amount of corn starch.',
 'Nature Made is one of the few supplement brands with USP verification, meaning what is on the label is actually in the pill. Clean formula with minimal fillers. Vitamin D3 is essential, especially if you are indoors a lot.',
 'Soybean Oil, Gelatin, Glycerin, Water, Corn Starch, Cholecalciferol (Vitamin D3)',
 'database_seed', 0);
