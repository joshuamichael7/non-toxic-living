-- =============================================================================
-- Expand curated products database — Round 6
-- More pantry staples, kids' snacks, dairy, beverages, household items
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- =============================================================================
-- FOOD (expand — pantry staples, frozen, canned)
-- =============================================================================

('Hazelnut Spread', 'Nutella', 'food', '009800895007', 22, 'toxic',
 'Sugar is the first ingredient (21g per serving), followed by palm oil. Contains soy lecithin and vanillin (synthetic vanilla). Only 13% hazelnuts and 7.4% cocoa. Basically candy marketed as a spread.',
 'Sugar, palm oil, then hazelnuts. In that order. Nutella is dessert pretending to be breakfast. 21 grams of sugar per two tablespoons. The hazelnut and cocoa are just flavoring for the sugar and palm oil.',
 'Sugar, Palm Oil, Hazelnuts (13%), Skim Milk Powder (8.7%), Fat-Reduced Cocoa Powder (7.4%), Soy Lecithin, Vanillin',
 'database_seed', 0),

('Condensed Tomato Soup', 'Campbell''s', 'food', '051000012517', 38, 'caution',
 'Contains high fructose corn syrup, modified food starch, and "flavoring." Relatively simple ingredient list for a canned soup but the HFCS and high sodium (480mg per serving) are concerns.',
 'Campbell''s tomato soup is a pantry staple, and it is not the worst offender. But high fructose corn syrup in soup? Modified food starch? Amy''s makes an organic version with real ingredients.',
 'Tomato Puree (Water, Tomato Paste), High Fructose Corn Syrup, Wheat Flour, Water, Salt, Potassium Chloride, Flavoring, Citric Acid, Lower Sodium Natural Sea Salt, Ascorbic Acid, Monopotassium Phosphate',
 'database_seed', 0),

('SpaghettiOs Original', 'Campbell''s', 'food', '051000025524', 28, 'toxic',
 'Contains high fructose corn syrup, enzyme modified cheese, soybean oil, and multiple forms of processed starch. Marketed to children. High sodium with 600mg per serving.',
 'This is what happens when you engineer food in a lab to appeal to children. HFCS, soybean oil, enzyme modified cheese (not real cheese), and enough sodium to make a nutritionist cry. Just boil some real pasta.',
 'Water, Tomato Puree (Water, Tomato Paste), Enriched Pasta (Wheat Flour, Niacin, Ferrous Sulfate, Thiamine Mononitrate, Riboflavin, Folic Acid, Egg Whites), High Fructose Corn Syrup, Salt, Enzyme Modified Cheese (Cheddar Cheese, Water, Disodium Phosphate, Enzymes), Soybean Oil, Potassium Chloride, Modified Food Starch, Flavoring',
 'database_seed', 0),

('Organic Tomato Bisque', 'Pacific Foods', 'food', '052603054393', 82, 'safe',
 'Made with organic tomatoes, organic cream, and organic onions. No artificial preservatives, colors, or flavors. Low sodium option available. Comes in a BPA-free carton.',
 'Organic tomatoes, organic cream, organic onion, sea salt. That is soup. No HFCS, no modified food starch, no "flavoring." Pacific Foods proves that convenient food can also be clean food.',
 'Organic Tomato Puree, Water, Organic Cream, Organic Cane Sugar, Sea Salt, Organic Onion Puree, Organic Garlic, Organic Black Pepper',
 'database_seed', 0),

('Original Beef Jerky', 'Jack Link''s', 'food', '017082878137', 42, 'caution',
 'Contains soy sauce (wheat), corn syrup, sugar, sodium nitrite (preservative linked to cancer in processed meats), monosodium glutamate, and sodium erythorbate. High in protein but also high in processing.',
 'Beef jerky should be dried meat with seasoning. Jack Link''s adds corn syrup, MSG, sodium nitrite, and multiple forms of sugar. The protein is real but the additives are not great.',
 'Beef, Water, Sugar, Salt, Corn Syrup, Flavorings, Soy Sauce (Water, Wheat, Soybeans, Salt), Hydrolyzed Corn Protein, Monosodium Glutamate, Maltodextrin, Citric Acid, Sodium Nitrite, Sodium Erythorbate',
 'database_seed', 0),

('100% Grass-Fed Beef Jerky Original', 'Epic Provisions', 'food', '858284002667', 85, 'safe',
 'Made with 100% grass-fed beef, organic spices, and celery powder (natural preservative). No added sugar, no MSG, no sodium nitrite, no soy. Whole30 approved and paleo friendly.',
 'Grass-fed beef, salt, organic spices. That is how jerky was made before food companies got involved. No corn syrup, no MSG, no nitrites. EPIC proves snack food can be actual food.',
 'Grass Fed Beef, Sea Salt, Organic Black Pepper, Celery Powder, Organic Garlic Powder, Organic Onion Powder, Encapsulated Citric Acid',
 'database_seed', 0),

-- =============================================================================
-- SNACK (expand — kids' fruit snacks, more chips, bars)
-- =============================================================================

('Fruit Snacks Mixed Fruit', 'Welch''s', 'snack', '034856050186', 22, 'toxic',
 'Contains corn syrup, sugar, modified corn starch, and artificial colors (Red 40, Blue 1). Despite "made with real fruit" claim, the primary ingredients are sugar and corn syrup with fruit puree far down the list.',
 'These are gummy candies with a tiny bit of fruit puree, not "fruit snacks." Corn syrup, sugar, and Red 40 are the stars. Handing your kid a bag of fruit would be cheaper and infinitely healthier.',
 'Fruit Puree (Grape, Peach, Orange, Strawberry, Raspberry), Corn Syrup, Sugar, Modified Corn Starch, Gelatin, Citric Acid, Lactic Acid, Natural and Artificial Flavors, Ascorbic Acid (Vitamin C), Red 40, Blue 1',
 'database_seed', 0),

('Fruit Roll-Ups Strawberry Sensation', 'Betty Crocker', 'snack', '016000116320', 12, 'toxic',
 'Contains corn syrup, sugar, pear puree concentrate, palm oil, and artificial colors (Red 40, Yellow 5, Yellow 6, Blue 1). More sugar and dye than fruit.',
 'Six artificial dyes in a product called "Fruit" Roll-Ups. Corn syrup and sugar before any actual fruit. This is candy in a lunchbox-friendly wrapper. Dried mango or real fruit leather is the easy swap.',
 'Corn Syrup, Sugar, Pear Puree Concentrate, Palm Oil, Citric Acid, Sodium Citrate, Fruit Pectin, Dextrose, Monoglycerides, Malic Acid, Ascorbic Acid, Acetylated Mono and Diglycerides, Natural Flavor, Color (Red 40, Yellow 5 & 6, Blue 1)',
 'database_seed', 0),

('Organic Fruit Strips Mango', 'Stretch Island', 'snack', '079126008603', 88, 'safe',
 'Made with just organic mango puree and organic mango juice concentrate. No added sugar, colors, preservatives, or anything else. USDA Organic. Actual fruit leather.',
 'One ingredient: organic mangoes. That is real fruit leather. No corn syrup, no artificial dyes, no added sugar. This is what Fruit Roll-Ups should have been all along.',
 'Organic Mango Puree, Organic Mango Juice Concentrate',
 'database_seed', 0),

('Flamin'' Hot Crunchy', 'Cheetos', 'snack', '028400443661', 15, 'toxic',
 'Contains MSG, multiple artificial colors (Red 40 Lake, Yellow 6 Lake), artificial flavor, and soybean/canola oil blend. The extreme color and addictive taste come from engineered chemistry.',
 'The neon red color is Red 40, not peppers. The addictive taste is MSG and engineered flavor compounds. Plus soybean oil and corn. These are designed by food scientists to be impossible to stop eating.',
 'Enriched Corn Meal (Corn Meal, Ferric Orthophosphate, Niacin, Thiamin Mononitrate, Riboflavin, Folic Acid), Vegetable Oil (Corn, Canola, and/or Sunflower Oil), Seasoning (Maltodextrin, Salt, Sugar, Monosodium Glutamate, Yeast Extract, Citric Acid, Artificial Color (Red 40 Lake, Yellow 6 Lake), Whey, Cheddar Cheese, Onion Powder, Whey Protein Concentrate, Garlic Powder, Natural Flavor, Buttermilk Solids)',
 'database_seed', 0),

('Original Crackers', 'Ritz', 'snack', '044000000158', 35, 'toxic',
 'Contains soybean oil, sugar, high fructose corn syrup, and partially hydrogenated cottonseed oil (trans fat) in some formulations. TBHQ preservative. Refined flour with no whole grains.',
 'Ritz markets itself as a wholesome cracker but it is refined flour, soybean oil, HFCS, and sugar. TBHQ is a controversial preservative. The buttery taste comes from oil and chemicals, not butter.',
 'Unbleached Enriched Flour (Wheat Flour, Niacin, Reduced Iron, Thiamine Mononitrate, Riboflavin, Folic Acid), Soybean Oil, Sugar, Salt, High Fructose Corn Syrup, Leavening (Baking Soda, Calcium Phosphate), Soy Lecithin, Natural Flavor',
 'database_seed', 0),

('Organic Seaweed Snacks Sea Salt', 'gimMe', 'snack', '851093002197', 90, 'safe',
 'Made with organic roasted seaweed, organic sunflower oil, and sea salt. Only three ingredients. Rich in iodine, vitamins A and C. Low calorie, keto-friendly, and Non-GMO.',
 'Three ingredients — seaweed, sunflower oil, salt. Packed with minerals and only 25 calories per pack. Kids love these and they are actually good for them. Nutrient-dense real food snacking.',
 'Organic Seaweed, Organic Sunflower Oil, Sea Salt',
 'database_seed', 0),

-- =============================================================================
-- DAIRY (expand — butter, cream cheese, whipped cream)
-- =============================================================================

('I Can''t Believe It''s Not Butter! Original', 'Upfield', 'dairy', '040600004187', 20, 'toxic',
 'Contains soybean oil, palm kernel oil, salt, synthetic vitamins, artificial flavors, EDTA, and beta-carotene for color. Highly processed seed oil blend marketed as a butter alternative.',
 'You can''t believe it''s not butter because it is soybean oil and palm kernel oil with chemicals to make it taste like butter. It is ultra-processed seed oils pretending to be a natural food. Just use real butter.',
 'Vegetable Oil Blend (Soybean Oil, Palm Kernel and Palm Oil), Water, Salt, Pea Protein, Sunflower Lecithin, Natural Flavors, Vinegar, Vitamin A Palmitate, Beta-Carotene (Color), Vitamin D, Potassium Sorbate, Calcium Disodium EDTA',
 'database_seed', 0),

('Pure Irish Butter', 'Kerrygold', 'dairy', '024034000062', 90, 'safe',
 'Made from the milk of grass-fed Irish cows with just cream and salt. No artificial colors, preservatives, or growth hormones. Naturally higher in beta-carotene, omega-3s, and CLA.',
 'Cream and salt. Two ingredients. The golden color is natural beta-carotene from grass-fed cows eating actual grass. More omega-3s and CLA than grain-fed butter. Real food does not need a long ingredient list.',
 'Pasteurized Cream, Salt',
 'database_seed', 0),

('Original Whipped Topping', 'Cool Whip', 'dairy', '043000052259', 15, 'toxic',
 'Contains hydrogenated vegetable oil (trans fat), high fructose corn syrup, artificial flavor, and polysorbate 60. First ingredient is water. Has more chemicals than actual dairy.',
 'Cool Whip contains almost no cream. It is water, corn syrup, hydrogenated oil, and chemicals whipped into a cream-like substance. The first ingredient after water is hydrogenated vegetable oil — trans fat. Use real whipped cream.',
 'Water, Hydrogenated Vegetable Oil (Coconut and Palm Kernel Oils), High Fructose Corn Syrup, Corn Syrup, Skim Milk, Light Cream, Sodium Caseinate, Natural and Artificial Flavor, Xanthan and Guar Gums, Polysorbate 60, Sorbitan Monostearate, Beta Carotene (Color)',
 'database_seed', 0),

('Original Cream Cheese', 'Philadelphia', 'dairy', '021000612345', 58, 'caution',
 'Contains milk, cream, cheese culture, salt, plus carob bean gum and xanthan gum as stabilizers. Relatively simple for a processed dairy product but the gums are unnecessary additives.',
 'Philadelphia is not terrible — it is mostly cream and milk. The gums are stabilizers that are generally considered safe but unnecessary. For a cleaner option, look for organic cream cheese with just milk, cream, salt, and cultures.',
 'Pasteurized Milk and Cream, Whey Protein Concentrate, Whey, Salt, Carob Bean Gum, Xanthan Gum, Natamycin (A Natural Mold Inhibitor), Cheese Culture, Vitamin A Palmitate',
 'database_seed', 0),

-- =============================================================================
-- BEVERAGE (expand — juice, coffee, water)
-- =============================================================================

('Pure Premium Original Orange Juice No Pulp', 'Tropicana', 'beverage', '048500012345', 62, 'caution',
 'Not from concentrate and no added sugar, which is good. However, commercially processed OJ uses deaeration and flavor packs to maintain consistency. A glass has 22g natural sugar.',
 'Tropicana is 100% juice with no added sugar, which beats most drinks here. But commercial OJ is processed more than you think — deaerated and then flavor packs added back. Fresh-squeezed or eating an actual orange is cleaner.',
 'Pure Premium Pasteurized Orange Juice',
 'database_seed', 0),

('Arizona Green Tea with Ginseng and Honey', 'Arizona', 'beverage', '613008724221', 25, 'toxic',
 'Contains high fructose corn syrup and honey, totaling 17 grams of sugar per 8oz serving (51g in the full can). "Green tea" is far down the ingredient list after multiple sweeteners.',
 'The big can says "green tea" but it is really HFCS water with a splash of tea. 51 grams of sugar in one can — more than a Coca-Cola. The "ginseng" and "honey" are in trace amounts. Marketing, not health food.',
 'Premium Brewed Green Tea Using Filtered Water, High Fructose Corn Syrup, Honey, Citric Acid, Natural Flavors, Ascorbic Acid (Vitamin C), Ginseng Extract',
 'database_seed', 0),

('Organic Matcha Green Tea', 'Jade Leaf', 'beverage', '853881006177', 92, 'safe',
 'Single ingredient: USDA Organic ceremonial grade matcha from Uji, Japan. No sugar, preservatives, or additives. One serving has the antioxidants of 10 cups of regular green tea.',
 'One ingredient — organic matcha. You add the water yourself. No sugar, no HFCS, no "natural flavors." The L-theanine gives calm, focused energy without the crash. This is what green tea should be.',
 'Organic Matcha Green Tea Powder',
 'database_seed', 0),

-- =============================================================================
-- HAIRCARE (expand — conditioner, styling)
-- =============================================================================

('Total Repair 5 Conditioner', 'L''Oréal Paris Elvive', 'haircare', '071249338858', 35, 'toxic',
 'Contains dimethicone (silicone that builds up on hair), synthetic fragrance, methylparaben, DMDM hydantoin (formaldehyde releaser), and artificial colors. Coats hair rather than nourishing it.',
 'More DMDM hydantoin — the formaldehyde releaser that TRESemmé got sued for. L''Oréal puts it in their conditioner too, plus parabens and synthetic fragrance. This sits on your scalp and absorbs.',
 'Water, Cetearyl Alcohol, Behentrimonium Chloride, Dimethicone, Cetyl Esters, Fragrance, Isopropyl Alcohol, Niacinamide, Panthenol, Amodimethicone, Trideceth-6, Cetrimonium Chloride, Phenoxyethanol, Methylparaben, DMDM Hydantoin, Citric Acid, Caramel, Red 33, Yellow 5',
 'database_seed', 0),

('Daily Moisturizing Conditioner', 'Every Man Jack', 'haircare', '878639001718', 80, 'safe',
 'Made with coconut-derived surfactants, shea butter, and glycerin. No parabens, phthalates, dyes, DMDM hydantoin, or aluminum. Cruelty-free and naturally derived ingredients.',
 'Clean haircare for guys (or anyone). No formaldehyde releasers, no parabens, no artificial dyes. Shea butter and coconut-based ingredients that actually moisturize. Simple, effective, and not trying to poison you.',
 'Water, Cetearyl Alcohol, Glycerin, Behentrimonium Methosulfate, Stearamidopropyl Dimethylamine, Coconut Oil, Shea Butter, Panthenol, Citric Acid, Phenoxyethanol, Ethylhexylglycerin',
 'database_seed', 0),

-- =============================================================================
-- DEODORANT (expand)
-- =============================================================================

('Clinical Strength Secret Invisible Solid', 'Secret', 'deodorant', '037000188025', 25, 'toxic',
 'Contains aluminum zirconium trichlorohydrex (20% — maximum FDA-allowed concentration), propylene glycol, synthetic fragrance, and multiple silicones. "Clinical Strength" means maximum aluminum.',
 'Clinical strength means the maximum amount of aluminum the FDA allows — 20%. That aluminum plugs your sweat glands and gets absorbed near lymph nodes and breast tissue. There are effective natural alternatives.',
 'Aluminum Zirconium Trichlorohydrex GLY 20%, Cyclopentasiloxane, Stearyl Alcohol, C12-15 Alkyl Benzoate, PPG-14 Butyl Ether, Hydrogenated Castor Oil, Fragrance, PEG-8 Distearate, Dimethicone',
 'database_seed', 0),

('Sensitive Skin Deodorant Unscented', 'Each & Every', 'deodorant', '860003588390', 92, 'safe',
 'Made with Dead Sea salt, organic coconut oil, and essential oils. No aluminum, baking soda, synthetic fragrance, parabens, or propylene glycol. EWG Verified. Works by creating a mineral-salt barrier.',
 'Dead Sea salt creates a natural mineral barrier that prevents odor without blocking your sweat glands. No aluminum, no baking soda (which irritates many people), no synthetic anything. EWG Verified clean.',
 'Caprylic/Capric Triglyceride, Organic Coconut Oil, Magnesium Hydroxide, Maris Sal (Dead Sea Salt), Organic Shea Butter, Candelilla Wax, Organic Jojoba Seed Oil, Beeswax, Zinc Ricinoleate, Vitamin E',
 'database_seed', 0),

-- =============================================================================
-- BABY FOOD (expand)
-- =============================================================================

('Stage 2 Banana Mango Pouch', 'Plum Organics', 'baby_food', '846675000286', 80, 'safe',
 'USDA Organic baby food with just organic banana and organic mango. No added sugar, salt, or preservatives. BPA-free pouch. Non-GMO Project Verified.',
 'Organic bananas and organic mangoes. That is the whole ingredient list. No water, no fillers, no concentrates, no citric acid. This is what feeding your baby real food looks like.',
 'Organic Bananas, Organic Mangoes',
 'database_seed', 0),

('Rice Cereal Single Grain', 'Gerber', 'baby_food', '015000070328', 45, 'caution',
 'Iron-fortified rice cereal — a traditional first food but rice cereal has come under scrutiny for inorganic arsenic content. Contains soy lecithin. The FDA has proposed action levels for arsenic in baby food.',
 'Rice cereal has been the go-to first food for generations, but studies show rice absorbs more arsenic from soil than other grains. The FDA has proposed limits but hasn''t finalized them. Oat cereal is a safer first food.',
 'Rice Flour, Soy Lecithin, Minerals (Iron, Zinc, Manganese, Copper), Vitamins (C, E, B1, B2, B6, B12, Niacin, Folic Acid), Mixed Tocopherols',
 'database_seed', 0),

-- =============================================================================
-- GARDEN (expand)
-- =============================================================================

('Raid Ant & Roach Killer Spray', 'Raid', 'garden', '046500218989', 8, 'toxic',
 'Contains cypermethrin (synthetic pyrethroid neurotoxin), imiprothrin (another pyrethroid), and petroleum-based solvents. Toxic to aquatic life, bees, and pets. Residue persists on surfaces.',
 'You are spraying a neurotoxin around your kitchen where you prepare food. Pyrethroids are endocrine disruptors that are extremely toxic to cats. Boric acid and diatomaceous earth handle ants without the nerve agents.',
 'Active: Cypermethrin 0.1%, Imiprothrin 0.05%. Inactive: Contains Petroleum Distillate, Propellant',
 'database_seed', 0),

('Food Grade Diatomaceous Earth', 'Harris', 'garden', '072725001273', 88, 'safe',
 'Made from fossilized algae that physically destroys insect exoskeletons. No synthetic chemicals. Safe around food, children, and pets (food grade). Works on ants, roaches, bed bugs, and fleas.',
 'Diatomaceous earth is fossilized algae that shreds insect exoskeletons on a microscopic level — no chemicals involved. Food grade means it is safe enough to eat (literally). Nature''s pest control.',
 'Silicon Dioxide 100% (Food Grade Diatomaceous Earth)',
 'database_seed', 0),

-- =============================================================================
-- SOAP (expand — hand sanitizer alternatives)
-- =============================================================================

('Foaming Hand Wash Coconut Water & Mango', 'Method', 'soap', '817939003985', 72, 'safe',
 'Plant-based foaming soap with naturally derived surfactants. No parabens, phthalates, or triclosan. Biodegradable formula in a 100% recycled plastic bottle. Cruelty-free.',
 'Method is the mainstream clean soap option — plant-based surfactants, no triclosan, no parabens, recyclable packaging. It still has some fragrance, but the overall formula is vastly cleaner than Softsoap or Dial.',
 'Water, Sodium Coco-Sulfate, Lauryl Glucoside, Cocamidopropyl Betaine, Sodium Chloride, Fragrance, Aloe Barbadensis Leaf Juice, Citric Acid, Methylisothiazolinone, Colorant',
 'database_seed', 0),

-- =============================================================================
-- MAKEUP (expand — mascara, lip)
-- =============================================================================

('Lash Sensational Mascara', 'Maybelline', 'makeup', '041554493108', 32, 'toxic',
 'Contains BHT, multiple synthetic polymers, carbon black (potential carcinogen in certain forms), aluminum powder, and fragrance — all applied millimeters from your eyes.',
 'This goes right next to your eyeballs. BHT, synthetic fragrance, aluminum powder, and carbon black — directly on your lash line. Your eyes are one of the most absorbent parts of your body.',
 'Water, Cera Alba (Beeswax), Paraffin, Glyceryl Stearate, Acacia Senegal Gum, Butylene Glycol, Stearic Acid, Palmitic Acid, Polybutene, VP/Eicosene Copolymer, Triethanolamine, Simethicone, Hydroxyethylcellulose, BHT, Phenoxyethanol, Aluminum Powder, Fragrance, Carbon Black',
 'database_seed', 0),

('Lengthening Mineral Mascara', 'W3LL PEOPLE', 'makeup', NULL, 88, 'safe',
 'Made with organic aloe, vitamin E, and plant-based waxes. No synthetic fragrances, parabens, BHT, or carbon black. EWG Verified. Ophthalmologist tested and safe for contact lens wearers.',
 'EWG Verified mascara that goes near your eyes without the toxic cocktail. Organic aloe, vitamin E, and plant waxes. No BHT, no fragrance, no aluminum. Your eyes deserve ingredients this clean.',
 'Water, Beeswax, Copernicia Cerifera (Carnauba) Wax, Glycerin, Organic Aloe Barbadensis Leaf Juice, Stearic Acid, Palmitic Acid, Tocopherol (Vitamin E), Glyceryl Caprylate, Iron Oxides',
 'database_seed', 0);
