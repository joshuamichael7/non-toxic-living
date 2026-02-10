-- =============================================================================
-- Expand curated products database — Round 3
-- Focus on popular everyday products people commonly scan
-- Expand thin categories: food, snack, condiment, dairy, laundry, soap, sunscreen
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- =============================================================================
-- FOOD (expand from 3 to 9)
-- =============================================================================

('Original Macaroni & Cheese Dinner', 'Kraft', 'food', '021000658862', 30, 'toxic',
 'Contains artificial colors (Yellow 5, Yellow 6), sodium tripolyphosphate, modified food starch, and "cheese sauce mix" with more additives than cheese. Highly processed.',
 'The powder cheese has Yellow 5 and Yellow 6 — artificial dyes banned in several countries and linked to hyperactivity in kids. Europe requires warning labels on these. We just feed them to children.',
 'Enriched Macaroni (Wheat Flour, Niacin, Ferrous Sulfate, Thiamin Mononitrate, Riboflavin, Folic Acid), Cheese Sauce Mix (Whey, Milkfat, Milk Protein Concentrate, Salt, Sodium Tripolyphosphate, Citric Acid, Lactic Acid, Sodium Phosphate, Calcium Phosphate, Yellow 5, Yellow 6, Enzymes, Cheese Culture)',
 'database_seed', 0),

('Creamy Peanut Butter', 'Skippy', 'food', '037600105439', 45, 'caution',
 'Contains hydrogenated vegetable oils (trans fat source), sugar, and salt added to peanuts. The hydrogenated oils are used to prevent separation but are a health concern.',
 'Real peanut butter should be one ingredient: peanuts. Skippy adds hydrogenated oils (linked to heart disease), sugar, and salt. If your peanut butter doesn''t separate, that''s a red flag.',
 'Roasted Peanuts, Sugar, Hydrogenated Vegetable Oils (Cottonseed, Soybean and Rapeseed Oil) To Prevent Separation, Salt',
 'database_seed', 0),

('Organic Creamy Peanut Butter', 'Once Again', 'food', '044082532615', 92, 'safe',
 'Single ingredient: dry roasted organic peanuts. No added sugar, oils, salt, or stabilizers. USDA Organic, Non-GMO, gluten-free, and vegan. Made in small batches.',
 'One ingredient. Organic peanuts. That is it. No sugar, no hydrogenated oils, no salt. This is what peanut butter is supposed to be. Yes, you have to stir it. That''s a feature, not a bug.',
 'Organic Dry Roasted Peanuts',
 'database_seed', 0),

('Traditional Pasta Sauce', 'Ragu', 'food', '036200004890', 40, 'caution',
 'Contains soybean oil, sugar, corn syrup, and "natural flavors." More like tomato-flavored sugar sauce than real marinara. Multiple processed ingredients.',
 'Sugar and corn syrup in pasta sauce? Soybean oil as the second ingredient after tomatoes? A real marinara should be tomatoes, olive oil, garlic, basil. Ragu is cosplaying as Italian food.',
 'Tomato Puree (Water, Tomato Paste), Soybean Oil, Sugar, Salt, Corn Syrup, Dehydrated Onions, Extra Virgin Olive Oil, Romano Cheese (Pasteurized Sheep''s Milk, Cheese Cultures, Salt, Enzymes), Spices, Natural Flavors, Citric Acid',
 'database_seed', 0),

('Marinara Sauce', 'Rao''s Homemade', 'food', '070134000017', 90, 'safe',
 'Made with whole Italian tomatoes, olive oil, fresh onions, garlic, basil, and salt. No added sugar, soybean oil, or artificial anything. Slow-simmered in small batches.',
 'This is what pasta sauce should be — tomatoes, olive oil, garlic, basil, salt. That''s it. No sugar, no soybean oil, no corn syrup. Yes it costs more. Your health is worth the upgrade.',
 'Italian Whole Peeled Tomatoes, Olive Oil, Fresh Onions, Salt, Fresh Garlic, Fresh Basil, Black Pepper, Oregano',
 'database_seed', 0),

('Classic White Bread', 'Wonder', 'food', '045000110724', 28, 'toxic',
 'Made with enriched bleached flour (stripped of nutrients then synthetically fortified), high fructose corn syrup, soybean oil, and multiple chemical dough conditioners including DATEM and calcium peroxide.',
 'Bleached flour + high fructose corn syrup + soybean oil + DATEM + calcium peroxide. That is not bread, that is a chemistry experiment shaped like bread. Real bread is flour, water, salt, yeast.',
 'Enriched Bleached Flour (Wheat Flour, Malted Barley Flour, Niacin, Iron, Thiamin Mononitrate, Riboflavin, Folic Acid), Water, High Fructose Corn Syrup, Yeast, Soybean Oil, Salt, Wheat Gluten, Calcium Sulfate, DATEM, Monoglycerides, Calcium Peroxide, Calcium Iodate, Soy Lecithin, Ammonium Sulfate',
 'database_seed', 0),

('21 Whole Grains and Seeds Bread', 'Dave''s Killer Bread', 'food', '013764011526', 80, 'safe',
 'USDA Organic bread with 21 whole grains and seeds. No artificial preservatives, colors, or flavors. No high fructose corn syrup. Sweetened with organic cane sugar.',
 'Dave''s is the king of clean bread. 21 whole grains, organic, no HFCS or artificial anything. It still has some organic sugar, so not perfect, but leagues ahead of Wonder Bread.',
 'Organic Whole Wheat, Water, Organic Cane Sugar, Organic Wheat Gluten, Organic Sunflower Seeds, Organic Flax Seeds, Organic Sesame Seeds, Organic Pumpkin Seeds, Organic Oat Fiber, Sea Salt, Organic Cultured Wheat, Yeast, Organic Vinegar',
 'database_seed', 0),

-- =============================================================================
-- SNACK (expand from 3 to 9)
-- =============================================================================

('Original Sandwich Cookies', 'Oreo', 'snack', '044000032166', 18, 'toxic',
 'Contains high fructose corn syrup, soy lecithin, artificial flavor, and palm oil. The "creme" is mostly sugar and vegetable oil. One of the most ultra-processed snack foods available.',
 'The ingredient list reads like a chemical inventory — high fructose corn syrup, palm oil, artificial flavor, multiple types of sugar. There is zero real food in an Oreo. It is edible, but barely qualifies as food.',
 'Sugar, Unbleached Enriched Flour (Wheat Flour, Niacin, Reduced Iron, Thiamine Mononitrate, Riboflavin, Folic Acid), High Oleic Canola Oil, Palm Oil, Cocoa (Processed with Alkali), High Fructose Corn Syrup, Cornstarch, Leavening (Baking Soda, Ammonium Phosphate), Salt, Soy Lecithin, Artificial Flavor, Chocolate',
 'database_seed', 0),

('Original Crackers', 'Cheez-It', 'snack', '024100440702', 38, 'caution',
 'Contains soybean oil, TBHQ (a controversial preservative), paprika extract for color, and "cheese made with skim milk" rather than real aged cheese. Highly processed cracker.',
 'TBHQ is a preservative derived from butane — yes, lighter fluid butane. It is FDA approved but banned in Japan and several other countries. Soybean oil and processed cheese round out the not-great picture.',
 'Enriched Flour (Wheat Flour, Niacin, Reduced Iron, Vitamin B1, Vitamin B2, Folic Acid), Vegetable Oil (High Oleic Soybean, Soybean, Palm, Canola), Cheese Made With Skim Milk (Skim Milk, Whey Protein, Salt, Cheese Cultures, Enzymes, Annatto Extract Color), Salt, Paprika Extract Color, Soy Lecithin, TBHQ For Freshness',
 'database_seed', 0),

('Classic Potato Chips', 'Lay''s', 'snack', '028400028899', 42, 'caution',
 'Only three ingredients — potatoes, vegetable oil, and salt — but the vegetable oil is a blend of canola, corn, soybean, and sunflower oils, all inflammatory seed oils.',
 'Lay''s looks clean with only 3 ingredients, but the devil is in the details. The vegetable oil is a mix of canola, corn, soybean, and sunflower oils — all highly processed seed oils linked to inflammation.',
 'Potatoes, Vegetable Oil (Canola, Corn, Soybean, and/or Sunflower Oil), Salt',
 'database_seed', 0),

('Avocado Oil Potato Chips Sea Salt', 'Good Health', 'snack', '755355003120', 82, 'safe',
 'Kettle-cooked in avocado oil instead of seed oils. Only three ingredients: potatoes, avocado oil, and sea salt. Non-GMO, gluten-free, no artificial anything.',
 'Same concept as regular chips but with avocado oil instead of inflammatory seed oils. That one swap makes a huge difference. Same crunch, same satisfaction, much better for your body.',
 'Potatoes, Avocado Oil, Sea Salt',
 'database_seed', 0),

('Protein Bar Chocolate Sea Salt', 'RXBAR', 'snack', '851406007041', 88, 'safe',
 'Made with egg whites, dates, nuts, and cocoa. No added sugar, artificial colors, flavors, or preservatives. Every ingredient is listed on the front of the package.',
 'RXBAR puts the whole ingredient list on the front of the package because they have nothing to hide. Egg whites, dates, nuts, cocoa. That is real food in a bar. No protein powder, no sugar alcohol.',
 'Dates, Egg Whites, Cashews, Almonds, Cocoa, Natural Flavors, Sea Salt, Chocolate',
 'database_seed', 0),

('Almond Flour Crackers Fine Ground Sea Salt', 'Simple Mills', 'snack', '856069005018', 90, 'safe',
 'Made with almond flour, sunflower seeds, and flax seeds. Grain-free, gluten-free, no seed oils, soy, corn, or artificial flavors. Simple, whole food ingredients.',
 'The ingredient list is short and you can pronounce everything. Almond flour, sunflower seeds, flax seeds, cassava, sunflower oil. No inflammatory seed oils, no grains, no junk.',
 'Almond Flour, Sunflower Seeds, Flax Seeds, Cassava, Organic Sunflower Oil, Sea Salt, Organic Onion, Organic Garlic, Rosemary Extract',
 'database_seed', 0),

-- =============================================================================
-- CONDIMENT (expand from 2 to 6)
-- =============================================================================

('Tomato Ketchup', 'Heinz', 'condiment', '013000001250', 45, 'caution',
 'Contains high fructose corn syrup as the third ingredient, plus "natural flavoring" (undisclosed). The tomato concentrate is good but the sweetener is a concern.',
 'Ketchup seems harmless but Heinz loads it with high fructose corn syrup — the third ingredient after tomatoes and vinegar. One tablespoon has 4 grams of sugar. Try an organic ketchup with real sugar instead.',
 'Tomato Concentrate From Red Ripe Tomatoes, Distilled Vinegar, High Fructose Corn Syrup, Corn Syrup, Salt, Spice, Onion Powder, Natural Flavoring',
 'database_seed', 0),

('Organic Ketchup', 'Sir Kensington''s', 'condiment', '850551005036', 85, 'safe',
 'Made with organic tomatoes, organic cane sugar (not HFCS), and Fair Trade certified ingredients. No artificial preservatives, colors, or flavors.',
 'Real tomatoes, organic cane sugar instead of high fructose corn syrup, and you can actually taste the difference. Yes ketchup can be clean. Heinz set the bar low and Sir Kensington raised it.',
 'Organic Tomato Concentrate, Organic Cane Sugar, Organic White Vinegar, Salt, Organic Onion Powder, Organic Allspice, Organic Clove',
 'database_seed', 0),

('Real Mayonnaise', 'Hellmann''s', 'condiment', '048001213562', 40, 'caution',
 'Made primarily with soybean oil — a highly processed, inflammatory seed oil. Also contains calcium disodium EDTA (preservative) and "natural flavors."',
 'Soybean oil is the first ingredient. That means this mayo is mostly inflammatory seed oil with some egg mixed in. Calcium disodium EDTA is a synthetic preservative. Try an avocado oil mayo instead.',
 'Soybean Oil, Water, Whole Eggs and Egg Yolks, Vinegar, Salt, Sugar, Lemon Juice, Calcium Disodium EDTA (Used to Protect Quality), Natural Flavors',
 'database_seed', 0),

('Organic Yellow Mustard', 'Annie''s', 'condiment', '013562610358', 88, 'safe',
 'USDA Organic mustard with simple ingredients: organic mustard seed, organic vinegar, water, and salt. No artificial colors, preservatives, or high fructose corn syrup.',
 'Mustard should be simple — mustard seeds, vinegar, water, salt. That is exactly what Annie''s gives you, all organic. No Yellow 5 dye that you find in conventional mustards.',
 'Organic Distilled Vinegar, Water, Organic Mustard Seed, Salt, Organic Turmeric, Organic Paprika',
 'database_seed', 0),

-- =============================================================================
-- DAIRY (expand from 2 to 6)
-- =============================================================================

('Original Strawberry Yogurt', 'Yoplait', 'dairy', '070470003047', 35, 'toxic',
 'Contains modified corn starch, artificial sweeteners or sugar depending on variety, carrageenan, potassium sorbate, Red 40, and "natural flavors." More like a dessert than health food.',
 'Red 40 in yogurt? Added sugar and corn starch? The strawberry flavor comes from "natural flavors" not real strawberries. This is candy masquerading as a healthy breakfast.',
 'Cultured Pasteurized Grade A Low Fat Milk, Sugar, Strawberries, Modified Corn Starch, Kosher Gelatin, Citric Acid, Tricalcium Phosphate, Natural Flavor, Pectin, Colored with Carmine, Vitamin A Acetate, Vitamin D3',
 'database_seed', 0),

('Original Coffee Creamer', 'Coffee mate', 'dairy', '050000128006', 15, 'toxic',
 'Contains no actual dairy — made from corn syrup solids, hydrogenated vegetable oil (trans fat), and sodium caseinate. Artificial colors and flavors. Highly processed non-food.',
 'This "creamer" contains zero cream. It is corn syrup, hydrogenated oil (trans fat), and chemicals. You are stirring fake food into your coffee every morning. Use real cream or milk.',
 'Corn Syrup Solids, Hydrogenated Vegetable Oil (Coconut and/or Palm Kernel and/or Soybean), Sodium Caseinate (A Milk Derivative), Dipotassium Phosphate, Mono- and Diglycerides, Sodium Aluminosilicate, Artificial Flavor, Annatto Color',
 'database_seed', 0),

('Organic Whole Milk Yogurt Plain', 'Stonyfield', 'dairy', '052159700164', 88, 'safe',
 'Just organic milk and live active cultures — six probiotic strains. No added sugar, artificial sweeteners, colors, or preservatives. USDA Organic and Non-GMO.',
 'Six ingredients — all of them are probiotic cultures plus organic milk. No sugar, no corn starch, no Red 40. This is what yogurt should look like. Add your own fruit and honey.',
 'Cultured Pasteurized Organic Whole Milk (Provides: S. thermophilus, L. bulgaricus, L. acidophilus, Bifidus, L. paracasei, L. rhamnosus)',
 'database_seed', 0),

('Organic Valley Grassmilk Whole Milk Yogurt', 'Organic Valley', 'dairy', '093966001242', 90, 'safe',
 '100% grass-fed organic milk with live cultures. No added sugar, thickeners, or preservatives. The cows eat only organic grass and dried forages — no grain ever.',
 'Grass-fed makes a real difference — the milk has more omega-3s and CLA. These cows never eat grain, just organic pasture. The result is a richer, more nutritious yogurt.',
 'Organic Pasteurized Whole Grassmilk, Live Active Cultures (L. acidophilus, Bifidus, L. casei, L. rhamnosus, S. thermophilus, L. bulgaricus)',
 'database_seed', 0),

-- =============================================================================
-- LAUNDRY (expand from 2 to 5)
-- =============================================================================

('Original Scent Liquid Laundry Detergent', 'Gain', 'laundry', '037000918462', 20, 'toxic',
 'Loaded with synthetic fragrances that persist on clothing and skin. Contains optical brighteners (UV-reactive dyes), ethoxylated surfactants (1,4-dioxane risk), and multiple synthetic dyes.',
 'Gain is basically fragrance with some cleaning agents mixed in. That long-lasting scent is synthetic chemicals clinging to your clothes and absorbing through your skin all day. Optical brighteners trick your eyes, not your laundry.',
 'Water, Alcohol Ethoxylate C12-15, Linear Alkylbenzene Sulfonate, Propylene Glycol, Citric Acid, Sodium Borate, Ethanolamine, Diquaternium Ethoxy Sulfate, Sodium Fatty Acids, Polyethyleneimine Ethoxylate, Fragrance, DTPA, Disodium Diaminostilbene Disulfonate (Optical Brightener), Liquitint Blue Dye',
 'database_seed', 0),

('Stage 1: Newborn Liquid Laundry Detergent', 'Dreft', 'laundry', '037000161905', 38, 'caution',
 'Marketed for babies but still contains synthetic fragrance, optical brighteners, and ethoxylated surfactants. "Hypoallergenic" claim is self-certified — no independent verification.',
 'Dreft markets itself as the baby-safe choice, but read the label. It still has synthetic fragrance and optical brighteners touching your baby''s skin 24/7. For babies especially, go truly fragrance-free.',
 'Water, Alcohol Ethoxylate C12-15, Linear Alkylbenzene Sulfonate, Propylene Glycol, Citric Acid, Ethanolamine, Sodium Borate, Diquaternium Ethoxy Sulfate, Fragrance, Sodium Fatty Acids, Polyethyleneimine Ethoxylate, DTPA, Disodium Diaminostilbene Disulfonate (Optical Brightener)',
 'database_seed', 0),

('Laundry Detergent Sheets Fresh Scent', 'Earth Breeze', 'laundry', NULL, 88, 'safe',
 'Ultra-concentrated detergent sheets that dissolve in water. No plastic jug waste. Free from parabens, phthalates, phosphates, bleach, dyes, and 1,4-dioxane. Vegan and cruelty-free.',
 'These little sheets replace giant plastic jugs. No phosphates, no dyes, no optical brighteners, no 1,4-dioxane. They dissolve completely and actually clean well. The future of laundry.',
 'Glycerin, Primary Alcohol Ethoxylate, Sodium Dodecyl Sulfate, Polyvinyl Alcohol, Protease, Sodium Acetate Trihydrate',
 'database_seed', 0),

-- =============================================================================
-- SOAP (expand from 2 to 5)
-- =============================================================================

('Antibacterial Liquid Hand Soap Crisp Clean', 'Softsoap', 'soap', '074182261795', 25, 'toxic',
 'Contains synthetic fragrance, multiple dyes (Yellow 5, Red 33), and the surfactant sodium laureth sulfate with potential 1,4-dioxane contamination. Marketed as antibacterial.',
 'The FDA banned triclosan from hand soaps years ago because antibacterial soaps are no better than regular soap. Softsoap dropped triclosan but kept all the synthetic fragrance and artificial dyes.',
 'Water, Sodium Laureth Sulfate, Lauramidopropyl Betaine, Sodium Chloride, Fragrance, PEG-120 Methyl Glucose Dioleate, Citric Acid, Tetrasodium EDTA, Polyquaternium-7, Sodium Benzoate, Methylchloroisothiazolinone, Methylisothiazolinone, Yellow 5, Red 33',
 'database_seed', 0),

('Gold Antibacterial Deodorant Bar Soap', 'Dial', 'soap', '017000009001', 30, 'toxic',
 'Contains BHT, titanium dioxide, fragrance, triclocarban (antimicrobial agent with endocrine disruption concerns), and sodium tallowate from rendered animal fat.',
 'Triclocarban is Dial''s antimicrobial agent — an endocrine disruptor that accumulates in the environment. BHT and synthetic fragrance round out the chemical cocktail. Plain soap and water is more effective anyway.',
 'Sodium Tallowate, Sodium Cocoate, Water, Fragrance, Talc, Coconut Acid, Sodium Chloride, Pentasodium Pentetate, Pentaerythrityl Tetra-Di-T-Butyl Hydroxyhydrocinnamate, Titanium Dioxide, BHT, Triclocarban, D&C Brown No. 1',
 'database_seed', 0),

('Organic Hand Soap Lemon & Eucalyptus', 'EO Products', 'soap', '636874092034', 87, 'safe',
 'Plant-based hand soap with organic essential oils. No synthetic fragrances, parabens, sulfates, or phthalates. Biodegradable and cruelty-free. B Corp certified.',
 'This is clean soap — plant-based cleansers with real essential oils instead of synthetic fragrance. No SLS, no parabens, no weird preservatives. B Corp certified means the whole company walks the talk.',
 'Water, Organic Coconut Oil, Potassium Hydroxide, Organic Olive Oil, Organic Lemon Peel Oil, Organic Eucalyptus Leaf Oil, Organic Rosemary Leaf Extract, Organic White Thyme Extract, Vitamin E',
 'database_seed', 0),

-- =============================================================================
-- SUNSCREEN (expand from 2 to 5)
-- =============================================================================

('Sport Sunscreen Lotion SPF 50', 'Banana Boat', 'sunscreen', '079656008487', 22, 'toxic',
 'Contains oxybenzone (hormone disruptor absorbed through skin), octinoxate (coral reef killer), retinyl palmitate (may accelerate skin damage in sun), and synthetic fragrance.',
 'Oxybenzone is detected in 97% of Americans'' bloodstream. It is a hormone disruptor that also destroys coral reefs — Hawaii banned it. Retinyl palmitate may actually speed up sun damage. Use mineral zinc instead.',
 'Active: Avobenzone 3%, Homosalate 10%, Octisalate 5%, Octocrylene 7%, Oxybenzone 5%. Inactive: Water, Sorbitol, VP/Hexadecene Copolymer, Beeswax, Styrene/Acrylates Copolymer, Silica, Benzyl Alcohol, Microcrystalline Cellulose, Fragrance, Retinyl Palmitate, Tocopheryl Acetate, BHT',
 'database_seed', 0),

('Sport Sunscreen SPF 50', 'Coppertone', 'sunscreen', '041100002693', 28, 'toxic',
 'Contains chemical UV filters (avobenzone, homosalate, octisalate, octocrylene) that absorb into the bloodstream. Also contains synthetic fragrance and methylisothiazolinone preservative.',
 'Chemical sunscreens absorb UV by creating a chemical reaction ON your skin. The FDA found these chemicals in the bloodstream after just one day of use. Mineral sunscreens sit on top and physically block UV.',
 'Active: Avobenzone 3%, Homosalate 13%, Octisalate 5%, Octocrylene 8%. Inactive: Water, Silica, Styrene/Acrylates Copolymer, Beeswax, Cetyl Dimethicone, Fragrance, Methylisothiazolinone, Tocopheryl Acetate',
 'database_seed', 0),

('Clear Zinc Sunscreen SPF 40', 'Badger', 'sunscreen', '634084360066', 91, 'safe',
 'USDA Certified Organic with non-nano zinc oxide as the only active ingredient. No synthetic chemicals, fragrances, or GMOs. Reef-safe, biodegradable, and B Corp certified.',
 'One active ingredient: non-nano zinc oxide. Sits on top of your skin and physically blocks UV rays. USDA Organic, reef-safe, and the ingredient list is short enough to fit in a tweet.',
 'Active: Non-Nano Uncoated Zinc Oxide 22.5%. Inactive: Organic Sunflower Oil, Organic Beeswax, Organic Jojoba Oil, Sunflower Vitamin E',
 'database_seed', 0),

-- =============================================================================
-- BABY (expand from 4 to 6)
-- =============================================================================

('Baby Lotion', 'Johnson''s', 'baby', '381370032359', 38, 'caution',
 'Contains synthetic fragrance (undisclosed chemicals), multiple preservatives, and mineral oil (petroleum byproduct). "Clinically proven gentle" does not mean ingredient-safe.',
 'Johnson''s Baby Lotion contains fragrance (could be dozens of hidden chemicals), mineral oil (petroleum), and synthetic preservatives — all going on your baby''s delicate skin. "Gentle" is a marketing term, not a safety standard.',
 'Water, Mineral Oil, Glycerin, Isopropyl Palmitate, Stearic Acid, Cetyl Alcohol, Glyceryl Stearate, Dimethicone, PEG-100 Stearate, Carbomer, Phenoxyethanol, Fragrance, Ethylhexylglycerin, Methylparaben, Propylparaben',
 'database_seed', 0),

('Baby Healing Ointment', 'Aquaphor', 'baby', '072140024116', 70, 'caution',
 'Petroleum-based ointment (petrolatum 41%) with mineral oil and lanolin. Effective as a moisture barrier but relies on petroleum byproducts. Lanolin can cause reactions in some babies.',
 'Aquaphor works well as a barrier cream, but it is 41% petrolatum (petroleum jelly) plus mineral oil. It seals moisture in, but it is sealing petroleum onto your baby''s skin. Organic balms do the same job cleaner.',
 'Petrolatum 41%, Mineral Oil, Ceresin, Lanolin Alcohol, Panthenol, Glycerin, Bisabolol',
 'database_seed', 0),

-- =============================================================================
-- SKINCARE (expand from 5 to 7)
-- =============================================================================

('Regenerist Micro-Sculpting Cream', 'Olay', 'skincare', '075609003905', 42, 'caution',
 'Contains synthetic fragrance, dimethicone (silicone), multiple PEG compounds (potential 1,4-dioxane contamination), and phenoxyethanol. Heavy on synthetic polymers.',
 'Olay uses a lot of marketing buzzwords but the ingredient list tells a different story. PEG compounds, synthetic fragrance, silicones. The niacinamide and peptides are nice — but you can get those without the chemical baggage.',
 'Water, Glycerin, Niacinamide, Isohexadecane, Dimethicone, Panthenol, Palmitoyl Pentapeptide-4, Aluminum Starch Octenylsuccinate, PEG-100 Stearate, Cetearyl Alcohol, Stearic Acid, PEG-8 Stearate, Ceteareth-20, Tocopheryl Acetate, Fragrance, Phenoxyethanol, DMDM Hydantoin, Methylparaben',
 'database_seed', 0),

('Squalane + Vitamin C Rose Oil', 'Biossance', 'skincare', NULL, 90, 'safe',
 'Made with sugarcane-derived squalane, vitamin C, and rose oil. No synthetic fragrances, parabens, PEG, SLS, phthalates, or mineral oil. Clean, sustainable, and effective.',
 'Squalane from sugarcane, not sharks. Vitamin C from kakadu plum. Rose oil that is actually from roses. Biossance proves you can have effective skincare without a chemistry set of synthetic ingredients.',
 'Squalane, Rosa Canina Fruit Oil, Terminalia Ferdinandiana Fruit Extract (Kakadu Plum), Tocopherol (Vitamin E), Rosmarinus Officinalis Leaf Extract, Helianthus Annuus Seed Oil',
 'database_seed', 0),

-- =============================================================================
-- MORE POPULAR BEVERAGES
-- =============================================================================

('Lemon Lime Soda', 'Sprite', 'beverage', '049000005080', 15, 'toxic',
 'Contains high fructose corn syrup, sodium benzoate (preservative that can form benzene when combined with vitamin C), and "natural flavors." 38 grams of sugar per can.',
 'No artificial colors, so Sprite markets itself as a better soda. But it is still loaded with high fructose corn syrup and sodium benzoate — a preservative that can form benzene, a carcinogen, under certain conditions.',
 'Carbonated Water, High Fructose Corn Syrup, Citric Acid, Natural Flavors, Sodium Citrate, Sodium Benzoate (To Protect Taste)',
 'database_seed', 0),

('Vintage Cola', 'Olipop', 'beverage', '860002467900', 80, 'safe',
 'Prebiotic soda with plant fiber, cassava root, and botanicals. Only 2g sugar and 35 calories per can. No artificial sweeteners, HFCS, or synthetic ingredients.',
 'This is the soda swap I tell everyone about. 2 grams of sugar vs 39 in Coca-Cola. Plus it has prebiotic fiber that actually feeds your gut bacteria. Tastes like a real cola too.',
 'Sparkling Water, Cassava Root Syrup, Chicory Root Inulin, Jerusalem Artichoke Inulin, Marshmallow Root Extract, Kudzu Root Extract, Cola Nut Extract, Vanilla Extract, Cinnamon Extract, Stevia Leaf Extract, Natural Flavors, Citric Acid',
 'database_seed', 0),

-- =============================================================================
-- MORE POPULAR FOOD ITEMS
-- =============================================================================

('Instant Ramen Chicken Flavor', 'Maruchan', 'food', '041789002236', 15, 'toxic',
 'Contains TBHQ (petroleum-derived preservative), MSG, multiple artificial colors, and the noodles are deep-fried in palm oil. Extremely high sodium (over 800mg per serving, 2 servings per pack).',
 'This is deep-fried noodles in a packet of MSG and TBHQ. Over 1600mg of sodium if you eat the whole pack (and everyone eats the whole pack). TBHQ is derived from butane. Your instant noodles contain lighter fluid chemicals.',
 'Enriched Wheat Flour (Wheat Flour, Niacin, Reduced Iron, Thiamine Mononitrate, Riboflavin, Folic Acid), Vegetable Oil (Contains One or More of the Following: Canola Oil, Cottonseed Oil, Palm Oil), Salt, Soy Sauce (Water, Wheat, Soybeans, Salt), Potassium Carbonate, Sodium (Mono, Hexameta, and/or Tripoly) Phosphate, Monosodium Glutamate, Onion Powder, Corn Syrup, Garlic Powder, TBHQ',
 'database_seed', 0),

('Organic Ramen Miso', 'Mike''s Mighty Good', 'food', '852570006011', 78, 'safe',
 'Organic ramen with steam-fried (not deep-fried) noodles. No TBHQ, MSG, artificial colors, or preservatives. Uses organic miso paste, organic tamari, and real spices.',
 'This proves ramen doesn''t have to be toxic. Steam-fried organic noodles instead of deep-fried in palm oil. Real miso paste instead of MSG powder. Still convenient, but actually food.',
 'Organic Wheat Flour, Organic Palm Oil, Water, Salt, Organic Tapioca Starch, Potassium Carbonate, Sodium Carbonate',
 'database_seed', 0);
