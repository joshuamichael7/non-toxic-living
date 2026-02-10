-- =============================================================================
-- Expand curated products database — Round 5
-- Fabric softeners, glass cleaner, popular skincare, kids' snacks, condiments
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- =============================================================================
-- LAUNDRY (expand — fabric softener, dryer sheets)
-- =============================================================================

('Ultra Downy April Fresh Fabric Softener', 'Downy', 'laundry', '037000128113', 18, 'toxic',
 'Contains diethyl ester dimethyl ammonium chloride (a "quat" linked to respiratory issues and skin irritation), heavy synthetic fragrance, and artificial dyes. Coats fabrics with chemical residue.',
 'Fabric softener coats your clothes with a thin layer of chemical lubricant that you wear against your skin all day. The "April Fresh" scent is dozens of undisclosed fragrance chemicals. Your dryer doesn''t need this.',
 'Water, Diethyl Ester Dimethyl Ammonium Chloride, Fragrance, Formic Acid, Calcium Chloride, Liquitint Blue, Diethylenetriamine Pentaacetate Sodium, Polyethylene Glycol 4000',
 'database_seed', 0),

('Outdoor Fresh Dryer Sheets', 'Bounce', 'laundry', '037000070702', 20, 'toxic',
 'Sheets are coated with cationic surfactants and heavy synthetic fragrance that transfers to all your clothing. Contains dipalmethyl hydroxyethylammonium methosulfate and artificial scent compounds.',
 'Dryer sheets coat your clothes with synthetic fragrance chemicals and surfactants. You then wear those chemicals against your skin for 12-16 hours. Wool dryer balls do the same job — soften clothes and reduce static — with zero chemicals.',
 'Dipalmethyl Hydroxyethylammonium Methosulfate, Fatty Acids C16-18, Fragrance, Polyester Sheet Substrate',
 'database_seed', 0),

('Wool Dryer Balls 6-Pack', 'Friendsheep', 'laundry', '645038470601', 95, 'safe',
 '100% organic New Zealand wool. Naturally softens clothes and reduces drying time by 25%. No chemicals, fragrances, or synthetic coatings. Reusable for 1,000+ loads.',
 'Wool dryer balls are the simplest swap. Toss them in the dryer — they soften clothes, reduce static, and cut drying time by bouncing between fabrics. Zero chemicals. Last for years. This is a no-brainer.',
 '100% Organic New Zealand Wool',
 'database_seed', 0),

-- =============================================================================
-- CLEANING (expand — glass, floor, more)
-- =============================================================================

('Original Glass Cleaner', 'Windex', 'cleaning', '019800002732', 28, 'toxic',
 'Contains 2-hexoxyethanol (a glycol ether linked to reproductive toxicity), isopropanolamine, synthetic fragrance, and Liquitint Sky Blue dye. Ammonia-based formula produces harsh fumes.',
 '2-hexoxyethanol is a glycol ether that the EU classifies as a reproductive toxicant. You are spraying this on surfaces and breathing the mist. White vinegar and water cleans glass just as well.',
 'Water, 2-Hexoxyethanol, Isopropanolamine, Sodium Dodecylbenzene Sulfonate, Lauramine Oxide, Ammonium Hydroxide, Fragrance, Liquitint Sky Blue Dye',
 'database_seed', 0),

('Original Pine Cleaner', 'Pine-Sol', 'cleaning', '041294400015', 22, 'toxic',
 'Contains glycolic acid, C10-12 alcohol ethoxylates (potential 1,4-dioxane contamination), synthetic pine fragrance, and Caramel color dye. The pine scent is artificial, not from real pine.',
 'The pine smell is synthetic fragrance, not real pine oil. The formula has glycolic acid and ethoxylated alcohols that can be contaminated with 1,4-dioxane, a probable carcinogen. Smelling "clean" and being clean are different things.',
 'Water, Glycolic Acid, C10-12 Alcohol Ethoxylates, Sodium C14-16 Olefin Sulfonate, Fragrance, Sodium Hydroxide, Caramel, Colorant',
 'database_seed', 0),

('All-Purpose Cleaner Pink Grapefruit', 'Method', 'cleaning', '817939000106', 72, 'safe',
 'Plant-based formula with naturally derived surfactants. No parabens, phthalates, or formaldehyde. Cruelty-free and uses recycled packaging. Uses fragrance from natural sources.',
 'Method is a big step up from conventional cleaners. Plant-based surfactants, no harsh chemicals, and the bottles are made from recycled plastic. Not perfect — still has some fragrance — but vastly better than Windex or Pine-Sol.',
 'Water, Sodium Lauryl Sulfate (Plant-Derived), Lauramine Oxide (Plant-Derived), Decyl Glucoside (Plant-Derived), Sodium Chloride, Fragrance (Naturally Derived), Citric Acid, Colorant',
 'database_seed', 0),

-- =============================================================================
-- SKINCARE (expand — popular drugstore brands)
-- =============================================================================

('Petroleum Jelly Original', 'Vaseline', 'skincare', '305210004412', 48, 'caution',
 'Triple-purified petroleum jelly — 100% petrolatum. Effective moisture barrier but is a petroleum byproduct. May contain trace polycyclic aromatic hydrocarbons (PAHs) depending on refinement grade.',
 'Vaseline is one ingredient — petrolatum. It seals moisture in effectively. The debate is whether petroleum byproducts belong on your skin. European regulations require PAH testing; US regulations don''t. Shea butter does the same job.',
 'White Petrolatum 100%',
 'database_seed', 0),

('Daily Moisturizing Lotion', 'Aveeno', 'skincare', '381370036005', 62, 'caution',
 'Contains colloidal oatmeal (great) but also dimethicone (silicone), benzyl alcohol, and sodium hydroxide. No parabens or fragrance-free version available, but base formula still has synthetic ingredients.',
 'Aveeno is better than most drugstore lotions. The oatmeal is genuinely beneficial. But dimethicone is a silicone that sits on skin rather than nourishing it. A step in the right direction, not the destination.',
 'Water, Glycerin, Distearyldimonium Chloride, Petrolatum, Isopropyl Palmitate, Cetyl Alcohol, Dimethicone, Avena Sativa (Oat) Kernel Flour, Benzyl Alcohol, Sodium Chloride',
 'database_seed', 0),

('Gentle Skin Cleanser', 'Cetaphil', 'skincare', '302993921158', 58, 'caution',
 'Dermatologist-recommended but contains sodium lauryl sulfate (irritant), propylene glycol, and parabens (methylparaben, propylparaben, butylparaben). The "gentle" claim is relative.',
 'Dermatologists recommend this because it is gentler than other conventional cleansers, but the ingredient list still has SLS, three types of parabens, and propylene glycol. "Gentle" just means "less bad."',
 'Water, Cetyl Alcohol, Propylene Glycol, Sodium Lauryl Sulfate, Stearyl Alcohol, Methylparaben, Propylparaben, Butylparaben',
 'database_seed', 0),

('Japanese Cherry Blossom Body Lotion', 'Bath & Body Works', 'skincare', '667548750776', 25, 'toxic',
 'Heavy synthetic fragrance (listed as "fragrance"), DMDM hydantoin (formaldehyde releaser), methylparaben, propylparaben, and artificial colors. One of the most chemical-heavy body lotions available.',
 'DMDM hydantoin releases formaldehyde — a known carcinogen — slowly into your skin every time you apply this. Plus parabens, synthetic dyes, and a massive dose of synthetic fragrance. This is not a treat for your skin.',
 'Water, Glycerin, Cetearyl Alcohol, Mineral Oil, Fragrance, Cetyl Alcohol, Dimethicone, Stearic Acid, PEG-100 Stearate, Glyceryl Stearate, DMDM Hydantoin, Carbomer, Disodium EDTA, Methylparaben, Propylparaben, Titanium Dioxide, Red 33, Yellow 5',
 'database_seed', 0),

('Skin Food Original Ultra-Rich Cream', 'Weleda', 'skincare', '4001638088107', 90, 'safe',
 'Made with organic sunflower seed oil, organic rosemary, organic chamomile, and beeswax. No synthetic fragrances, preservatives, mineral oil, or petroleum derivatives. Certified natural by NATRUE.',
 'Weleda Skin Food has been around since 1926 for a reason. Organic plant oils and extracts, lanolin, and beeswax. No petroleum, no parabens, no synthetic fragrance. Almost 100 years of clean skincare.',
 'Water, Helianthus Annuus (Sunflower) Seed Oil, Lanolin, Prunus Amygdalus Dulcis (Sweet Almond) Oil, Cera Alba (Beeswax), Glyceryl Linoleate, Fragrance (Essential Oils), Viola Tricolor Extract, Rosmarinus Officinalis (Rosemary) Leaf Extract, Chamomilla Recutita (Matricaria) Flower Extract',
 'database_seed', 0),

-- =============================================================================
-- HAIRCARE (expand — popular brands)
-- =============================================================================

('Keratin Smooth Shampoo', 'TRESemmé', 'haircare', '022400428659', 28, 'toxic',
 'Contains DMDM hydantoin (formaldehyde releaser), sodium laureth sulfate, synthetic fragrance, and artificial colors. TRESemmé faced a class action lawsuit over DMDM hydantoin causing hair loss.',
 'TRESemmé was hit with a major class action lawsuit because DMDM hydantoin — a formaldehyde releaser — was causing hair loss and scalp irritation. They still use it. Read that again.',
 'Water, Sodium Laureth Sulfate, Cocamidopropyl Betaine, Sodium Chloride, Fragrance, Dimethicone, Glycol Distearate, DMDM Hydantoin, Guar Hydroxypropyltrimonium Chloride, TEA-Dodecylbenzenesulfonate, Cetyl Alcohol, Citric Acid, PEG-7M, Yellow 5, Red 33',
 'database_seed', 0),

('Essentials Daily Clarifying Shampoo', 'Suave', 'haircare', '079400375407', 25, 'toxic',
 'Contains ammonium laureth sulfate, ammonium lauryl sulfate, DMDM hydantoin (formaldehyde releaser), fragrance, and artificial colors. One of the cheapest and most chemical-heavy shampoos available.',
 'Suave is about as cheap as shampoo gets, and the ingredients reflect that. DMDM hydantoin (formaldehyde releaser), two types of sulfates, synthetic dye, and fragrance. Your scalp deserves better than the dollar shelf.',
 'Water, Ammonium Lauryl Sulfate, Ammonium Laureth Sulfate, Cocamide MEA, Fragrance, Cocamidopropyl Betaine, DMDM Hydantoin, Tetrasodium EDTA, Citric Acid, PEG-5M, Sodium Chloride, Blue 1, Yellow 10',
 'database_seed', 0),

('Shampoo & Conditioner Coconut & Vanilla', 'Native', 'haircare', '810044131277', 82, 'safe',
 'Sulfate-free, paraben-free, silicone-free shampoo with no DMDM hydantoin or formaldehyde releasers. Clean fragrance from coconut and vanilla. Vegan and cruelty-free.',
 'Native started in deodorant and brought the same clean philosophy to haircare. No sulfates, no parabens, no formaldehyde releasers. The coconut vanilla scent is clean-sourced. A solid mainstream clean option.',
 'Water, Cocamidopropyl Betaine, Sodium Cocoyl Isethionate, Sodium Methyl Cocoyl Taurate, Glycerin, Acrylates Copolymer, Sodium Chloride, Cocos Nucifera (Coconut) Oil, Fragrance, Guar Hydroxypropyltrimonium Chloride, Polyquaternium-10, Panthenol, Citric Acid',
 'database_seed', 0),

-- =============================================================================
-- BABY (expand — diaper cream, lotion)
-- =============================================================================

('Maximum Strength Diaper Rash Paste', 'Desitin', 'baby', '074300003009', 52, 'caution',
 'Active ingredient zinc oxide 40% (good) but inactive ingredients include petroleum, mineral oil, synthetic fragrance, BHA (possible carcinogen), and methylparaben. Mixed bag.',
 'Zinc oxide is an excellent diaper cream ingredient — it creates a barrier and helps healing. But Desitin wraps it in petroleum, mineral oil, BHA, and paraben. You can get zinc oxide in a much cleaner base.',
 'Active: Zinc Oxide 40%. Inactive: Cod Liver Oil, Fragrance, Lanolin, Methylparaben, Mineral Oil, Petrolatum, Talc, Water, BHA, Microcrystalline Wax',
 'database_seed', 0),

('Organic Diaper Balm', 'Earth Mama', 'baby', '859220002024', 92, 'safe',
 'USDA Organic diaper cream with organic calendula, organic olive oil, and organic beeswax. No petroleum, zinc oxide, or synthetic fragrance. Gentle enough for every diaper change.',
 'Organic calendula and olive oil — nature''s diaper cream. No petroleum, no parabens, no zinc oxide even. Just organic plant oils that soothe and protect. Safe enough to use at every single diaper change.',
 'Organic Olea Europaea (Olive) Fruit Oil, Organic Cera Alba (Beeswax), Organic Calendula Officinalis Flower Extract, Organic Butyrospermum Parkii (Shea) Butter',
 'database_seed', 0),

-- =============================================================================
-- FOOD (expand — popular processed foods)
-- =============================================================================

('Frosted Strawberry Toaster Pastries', 'Pop-Tarts', 'food', '038000318306', 12, 'toxic',
 'Contains TBHQ, high fructose corn syrup, artificial colors (Red 40, Yellow 6, Blue 1), soybean oil, bleached flour, and "natural and artificial flavors." Ultra-processed breakfast item.',
 'TBHQ, three artificial dyes, HFCS, soybean oil, and bleached flour — all before 8 AM. And they market this as breakfast for kids. The "strawberry" is mostly corn syrup and Red 40. Real breakfast takes 5 minutes.',
 'Enriched Flour (Wheat Flour, Niacin, Reduced Iron, Vitamin B1, Vitamin B2, Folic Acid), Corn Syrup, High Fructose Corn Syrup, Dextrose, Soybean and Palm Oil, Sugar, Bleached Wheat Flour, Salt, Dried Strawberries, Dried Pears, Dried Apples, TBHQ, Gelatin, Cornstarch, Modified Wheat Starch, Xanthan Gum, Red 40, Soy Lecithin, Yellow 6, Blue 1, Natural and Artificial Flavors',
 'database_seed', 0),

('Turkey & Cheddar Cracker Stackers', 'Lunchables', 'food', '044700001400', 20, 'toxic',
 'Ultra-processed lunch kit with sodium nitrite (linked to cancer), artificial colors, BHT, modified food starch, and multiple forms of sodium. Over 600mg sodium in one small package.',
 'Sodium nitrite is used to preserve the meat and is classified as probably carcinogenic to humans when consumed as processed meat. BHT, artificial colors, and 600mg+ sodium for a kid''s lunch. Pack a real sandwich.',
 'Turkey Breast (Turkey Breast, Water, Modified Corn Starch, Contains 2% or Less of: Salt, Sodium Phosphate, Sodium Nitrite, BHT, BHA), Pasteurized Process Cheddar Cheese (Milk, Cheese Culture, Salt, Enzymes, Annatto Color, Sorbic Acid), Crackers (Enriched Flour, Vegetable Oil, Sugar, Salt, TBHQ, Artificial Color)',
 'database_seed', 0),

('Organic Cheese Pizza Frozen', 'Amy''s Kitchen', 'food', '042272000647', 78, 'safe',
 'Made with organic wheat flour, organic tomatoes, organic mozzarella, and organic olive oil. No artificial preservatives, colors, or flavors. Non-GMO. Vegetarian.',
 'Frozen pizza doesn''t have to be junk food. Amy''s uses organic flour, real mozzarella, organic tomatoes, and olive oil. Same convenience, drastically better ingredients. Your freezer should stock this.',
 'Organic Wheat Flour, Organic Tomato Puree, Organic Mozzarella Cheese (Organic Pasteurized Milk, Culture, Enzymes), Water, Organic Extra Virgin Olive Oil, Organic Cane Sugar, Salt, Organic Garlic, Spices, Yeast',
 'database_seed', 0),

-- =============================================================================
-- SNACK (expand — kids' snacks, bars)
-- =============================================================================

('Fuego Hot Chili Pepper & Lime Tortilla Chips', 'Takis', 'snack', '757528006570', 15, 'toxic',
 'Contains Red 40 Lake, Yellow 6 Lake, artificial flavors, BHT, TBHQ, and MSG. The intense color comes entirely from artificial dyes. Extremely high sodium.',
 'The bright red color is Red 40, not chili. The "lime" is citric acid and artificial flavor. Plus TBHQ, BHT, and MSG. These chips are engineered to be addictive with chemicals, not just spice.',
 'Corn Masa Flour, Vegetable Oil (Palm, Soybean, Canola, Rice Bran), Seasoning (Citric Acid, Maltodextrin, Salt, Monosodium Glutamate, Sugar, Natural and Artificial Flavors, Onion Powder, Yeast Extract, Chili Pepper, Sodium Bicarbonate, Soybean Oil, Red 40 Lake, Yellow 6 Lake, TBHQ, BHT)',
 'database_seed', 0),

('Crunchy Granola Bars Oats ''n Honey', 'Nature Valley', 'snack', '016000264601', 52, 'caution',
 'Made with whole grain oats (good) but also contains canola oil, sugar, and soy flour. "Natural" branding but still has processed seed oils and added sugars.',
 'Nature Valley looks healthy — it is in a green box with pictures of mountains. But canola oil and sugar are the 2nd and 3rd ingredients. Also soy flour and corn syrup. The oats are real, but the rest is processed.',
 'Whole Grain Oats, Sugar, Canola Oil, Rice Flour, Honey, Salt, Brown Sugar Syrup, Baking Soda, Soy Lecithin, Natural Flavor',
 'database_seed', 0),

('Nut Bar Dark Chocolate Nuts & Sea Salt', 'KIND', 'snack', '602652171215', 75, 'safe',
 'First ingredients are nuts (almonds, peanuts). Contains some sugar and soy lecithin but no artificial ingredients, corn syrup, or seed oils. Gluten-free and Non-GMO.',
 'KIND bars are actually pretty kind to your body. Whole nuts as the first ingredient, no corn syrup, no artificial anything. There is some sugar, so it is not perfect, but for a grab-and-go bar this is a solid choice.',
 'Almonds, Peanuts, Chicory Root Fiber, Honey, Palm Kernel Oil, Sugar, Dark Chocolate (Chocolate Liquor, Sugar, Cocoa Butter, Soy Lecithin), Sea Salt, Soy Lecithin',
 'database_seed', 0),

('Cashew Cookie Fruit & Nut Bar', 'Lärabar', 'snack', '021908453019', 92, 'safe',
 'Only two ingredients: cashews and dates. No added sugar, preservatives, artificial flavors, or binding agents. Whole30 approved, vegan, gluten-free, and Non-GMO.',
 'Two ingredients. Cashews. Dates. That is the entire bar. No added sugar because dates are naturally sweet. No processing beyond pressing the ingredients together. This is what a snack bar should be.',
 'Cashews, Dates',
 'database_seed', 0),

-- =============================================================================
-- CONDIMENT (expand — BBQ sauce, soy sauce)
-- =============================================================================

('Original BBQ Sauce', 'Sweet Baby Ray''s', 'condiment', '013409218037', 30, 'toxic',
 'High fructose corn syrup is the first ingredient — before tomato paste. Also contains modified food starch, caramel color (potential 4-MeI carcinogen), and sodium benzoate.',
 'When high fructose corn syrup is literally the first ingredient, you are eating corn syrup flavored like BBQ, not BBQ sauce with a little sweetness. Caramel color is also linked to a carcinogen called 4-MeI.',
 'High Fructose Corn Syrup, Tomato Paste, Vinegar, Modified Food Starch, Contains Less Than 2% of: Salt, Spices, Caramel Color, Sodium Benzoate, Molasses, Corn Syrup, Dried Garlic, Sugar, Tamarind, Natural Flavor',
 'database_seed', 0),

('Classic BBQ Sauce', 'Primal Kitchen', 'condiment', '855232007460', 88, 'safe',
 'Sweetened with organic date paste instead of HFCS. Made with organic tomato concentrate, organic balsamic vinegar, and real spices. No refined sugar, soy, canola, or artificial ingredients.',
 'Date paste instead of corn syrup, organic tomato concentrate instead of whatever Heinz puts in there, balsamic vinegar for depth. Primal Kitchen proves BBQ sauce doesn''t need to be liquid candy.',
 'Organic Tomato Concentrate, Water, Organic Balsamic Vinegar, Organic Date Paste, Organic Coconut Aminos, Salt, Organic Onion Powder, Organic Garlic Powder, Organic Smoked Paprika, Organic Black Pepper, Organic Chipotle Pepper, Organic Cayenne',
 'database_seed', 0),

('Naturally Brewed Soy Sauce', 'Kikkoman', 'condiment', '041390000119', 58, 'caution',
 'Naturally brewed from water, wheat, soybeans, and salt — much better than chemical hydrolysis soy sauces. However contains wheat (not gluten-free) and is high in sodium. No artificial additives.',
 'Kikkoman is actually naturally brewed — just soybeans, wheat, water, salt. That is light-years ahead of cheap soy sauces made with hydrolyzed soy protein and caramel color. The sodium is the main concern.',
 'Water, Wheat, Soybeans, Salt, Sodium Benzoate (Less Than 1/10 of 1% as a Preservative)',
 'database_seed', 0),

('Organic Coconut Aminos', 'Coconut Secret', 'condiment', '851492002009', 88, 'safe',
 'Soy-free, wheat-free alternative to soy sauce made from organic coconut tree sap. 73% less sodium than soy sauce. Non-GMO, gluten-free, and no artificial ingredients.',
 'If soy or gluten is a concern, coconut aminos is the answer. Tastes similar to soy sauce with 73% less sodium and zero soy or wheat. Made from coconut sap — nothing else.',
 'Organic Coconut Tree Sap, Sea Salt',
 'database_seed', 0),

-- =============================================================================
-- BEVERAGE (expand — kids' drinks)
-- =============================================================================

('Pacific Cooler Juice Drink', 'Capri Sun', 'beverage', '087684001028', 15, 'toxic',
 'Contains only 5% juice despite "juice drink" branding. Main ingredients are water, high fructose corn syrup, and citric acid. Artificial flavors. Given to millions of kids daily.',
 'Parents give this to kids thinking it is juice. It is 5% juice and 95% water, high fructose corn syrup, and artificial flavors. A juice box with barely any juice. Water is healthier and free.',
 'Filtered Water, Sugar, Pear and Grape Juice Concentrates, Citric Acid, Orange, Apple, and Pineapple Juice Concentrates, Natural Flavor',
 'database_seed', 0),

('Jammers Tropical Punch', 'Kool-Aid', 'beverage', '043000030769', 10, 'toxic',
 'Contains high fructose corn syrup, artificial flavor, Red 40, Blue 1, sucralose, and acesulfame potassium. Marketed directly to children. Essentially dyed sugar water.',
 'Red 40, Blue 1, high fructose corn syrup, and two artificial sweeteners — in a drink marketed to children with cartoon characters. This has zero nutritional value and maximum chemical additives.',
 'Filtered Water, High Fructose Corn Syrup, Citric Acid, Ascorbic Acid, Artificial Flavor, Sucralose, Acesulfame Potassium, Red 40, Blue 1',
 'database_seed', 0),

('Organic Apple Juice Boxes', 'Honest Kids', 'beverage', '657622100368', 78, 'safe',
 'USDA Organic juice with no added sugars, artificial sweeteners, or artificial flavors. Only 35 calories per box — much less sugar than conventional juice boxes. Non-GMO.',
 'If your kid wants juice boxes, this is the way to go. Organic, no added sugar, no artificial anything, and only 35 calories. Not as good as water but infinitely better than Capri Sun or Kool-Aid.',
 'Filtered Water, Organic Apple Juice Concentrate, Organic Grape Juice Concentrate, Natural Flavor, Citric Acid',
 'database_seed', 0),

-- =============================================================================
-- DAIRY (expand — more processed vs clean)
-- =============================================================================

('Velveeta Shells & Cheese', 'Kraft', 'dairy', '021000672790', 18, 'toxic',
 'Contains sodium phosphate, milk protein concentrate (not real cheese), sorbic acid, lactic acid, apocarotenal and annatto color, and modified food starch. "Liquid Gold" is liquid chemicals.',
 'Velveeta is not legally allowed to be called cheese — it is a "pasteurized prepared cheese product." It is mostly water, milk protein concentrate, and whey protein concentrate held together with sodium phosphate.',
 'Enriched Macaroni (Wheat Flour, Glyceryl Monostearate, Niacin, Ferrous Sulfate, Thiamine Mononitrate, Riboflavin, Folic Acid), Cheese Sauce (Water, Milk Protein Concentrate, Whey Protein Concentrate, Milk, Sodium Phosphate, Whey, Modified Food Starch, Milk Fat, Salt, Sorbic Acid, Lactic Acid, Apocarotenal and Annatto Color, Cheese Culture, Enzymes)',
 'database_seed', 0),

('Organic Grass-Fed Cheddar Cheese', 'Kerrygold', 'dairy', '024034000727', 88, 'safe',
 'Made from the milk of grass-fed Irish cows. Only three ingredients: pasteurized milk, salt, and cheese cultures. No artificial colors, preservatives, or growth hormones. Naturally higher in omega-3s and CLA.',
 'Three ingredients: milk, salt, cultures. That is cheese. No sodium phosphate, no food starch, no sorbic acid, no annatto. Grass-fed means more omega-3s and CLA. This is what cheese is supposed to be.',
 'Pasteurized Milk, Salt, Cheese Cultures, Enzymes',
 'database_seed', 0);
