-- ============================================================================
-- Seed food-related swap recommendations with real brands
-- Categories: food, snack, beverage, dairy, supplement
-- ============================================================================

-- Food (4 products)
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Organic Mac & Cheese',
    'Annie''s Homegrown',
    'food',
    82,
    'Made with organic wheat pasta and real cheese — no synthetic colors, artificial flavors, or petroleum-based dyes like Yellow 5 and Yellow 6 found in conventional mac & cheese.',
    ARRAY['USDA Organic', 'Non-GMO'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s', 'Thrive Market'],
    true,
    ARRAY['Yellow 5', 'Yellow 6', 'sodium phosphate', 'artificial flavors', 'TBHQ'],
    ARRAY['Kraft Mac & Cheese', 'Velveeta Shells & Cheese', 'Great Value Mac & Cheese']
  ),
  (
    'Organic Lentil Soup',
    'Amy''s Kitchen',
    'food',
    85,
    'Organic ingredients with no MSG, no trans fats, and no GMOs. Made in a facility that prioritizes clean ingredient sourcing with transparent labeling.',
    ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Preservatives', 'Gluten-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Trader Joe''s', 'Thrive Market'],
    true,
    ARRAY['monosodium glutamate', 'high fructose corn syrup', 'hydrolyzed soy protein', 'BHA', 'BHT', 'sodium benzoate'],
    ARRAY['Campbell''s Condensed Soup', 'Progresso Soup', 'Chef Boyardee']
  ),
  (
    'Avocado Oil Mayo',
    'Primal Kitchen',
    'food',
    88,
    'Made with avocado oil instead of inflammatory seed oils like soybean or canola. No sugar, no artificial preservatives, and uses organic cage-free eggs.',
    ARRAY['Non-GMO', 'No Artificial Preservatives', 'Gluten-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['soybean oil', 'canola oil', 'calcium disodium EDTA', 'high fructose corn syrup', 'potassium sorbate', 'artificial flavors'],
    ARRAY['Hellmann''s Mayonnaise', 'Kraft Mayo', 'Duke''s Mayonnaise', 'Miracle Whip']
  ),
  (
    'Natural Uncured Hot Dogs',
    'Applegate Naturals',
    'food',
    79,
    'Made from humanely raised animals with no antibiotics ever. Free of synthetic nitrates, nitrites, artificial colors, and chemical preservatives commonly found in processed meats.',
    ARRAY['Non-GMO', 'No Artificial Preservatives'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s'],
    true,
    ARRAY['sodium nitrite', 'sodium nitrate', 'BHA', 'BHT', 'sodium erythorbate', 'Red 40', 'artificial flavors', 'corn syrup'],
    ARRAY['Oscar Mayer Hot Dogs', 'Ball Park Franks', 'Hebrew National', 'Bar-S Hot Dogs']
  );

-- Snack (3 products)
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Organic Popcorn Himalayan Pink Salt',
    'Lesser Evil',
    'snack',
    84,
    'Popped in organic coconut oil with simple, recognizable ingredients. No artificial butter flavors, diacetyl, or TBHQ that conventional microwave popcorn contains.',
    ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
    true,
    ARRAY['TBHQ', 'diacetyl', 'artificial butter flavor', 'partially hydrogenated oil', 'artificial colors'],
    ARRAY['Orville Redenbacher''s Popcorn', 'Act II Popcorn', 'Pop Secret', 'SkinnyPop']
  ),
  (
    'Dark Chocolate Bar Simple',
    'Hu Kitchen',
    'snack',
    87,
    'Made with organic cacao and unrefined coconut sugar. Free of refined sugar, soy lecithin, dairy, emulsifiers, and the heavy metals often found in cheaper chocolate brands.',
    ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free', 'Fair Trade'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['soy lecithin', 'artificial flavors', 'PGPR', 'vanillin', 'refined sugar', 'milk fat'],
    ARRAY['Hershey''s Chocolate', 'Cadbury Dairy Milk', 'Nestle Chocolate', 'M&M''s']
  ),
  (
    'Chocolate Chip Granola Bars',
    'MadeGood',
    'snack',
    81,
    'Made with organic ingredients and contains a full serving of vegetables hidden in each bar. Free from the top 9 allergens and free of artificial colors, flavors, and preservatives.',
    ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s'],
    true,
    ARRAY['BHT', 'high fructose corn syrup', 'artificial colors', 'artificial flavors', 'TBHQ', 'soy lecithin', 'partially hydrogenated oil'],
    ARRAY['Nature Valley Granola Bars', 'Quaker Chewy Bars', 'Kellogg''s Nutri-Grain Bars']
  );

-- Beverage (3 products)
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Organic Loose Leaf Jade Cloud Green Tea',
    'Rishi Tea',
    'beverage',
    90,
    'Direct-trade, organic loose leaf tea tested for pesticide residues and heavy metals. No artificial flavors, synthetic antioxidants, or hidden sweeteners found in many conventional tea brands.',
    ARRAY['USDA Organic', 'Non-GMO', 'Fair Trade'],
    ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['artificial flavors', 'caramel color', 'sodium benzoate', 'potassium sorbate', 'high fructose corn syrup', 'sucralose'],
    ARRAY['Lipton Tea', 'Arizona Iced Tea', 'Brisk Tea', 'Snapple']
  ),
  (
    'Synergy Raw Kombucha Gingerade',
    'GT''s Living Foods',
    'beverage',
    86,
    'Raw, unpasteurized kombucha with live probiotics and organic ingredients. A naturally fermented alternative to sodas with no artificial sweeteners, phosphoric acid, or caramel color.',
    ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Preservatives'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s'],
    true,
    ARRAY['phosphoric acid', 'caramel color', 'aspartame', 'high fructose corn syrup', 'sodium benzoate', 'potassium benzoate'],
    ARRAY['Coca-Cola', 'Pepsi', 'Mountain Dew', 'Sprite', 'Dr Pepper']
  ),
  (
    'Vintage Cola Prebiotic Soda',
    'Olipop',
    'beverage',
    83,
    'Contains 9g of plant-based prebiotic fiber per can to support digestive health. Uses natural botanicals and has only 2g of sugar versus 39g in a regular Coca-Cola — no artificial sweeteners or phosphoric acid.',
    ARRAY['Non-GMO', 'Gluten-Free', 'No Artificial Colors'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s'],
    true,
    ARRAY['phosphoric acid', 'high fructose corn syrup', 'caramel color', 'aspartame', 'acesulfame potassium', 'sodium benzoate'],
    ARRAY['Coca-Cola', 'Pepsi', 'Diet Coke', 'Sprite', 'Mountain Dew']
  );

-- Dairy (3 products)
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Organic Whole Milk Yogurt',
    'Stonyfield Organic',
    'dairy',
    86,
    'Made from pasture-raised organic milk with no artificial hormones (rBST/rBGH), no artificial sweeteners, and no synthetic preservatives. Contains live active probiotic cultures for gut health.',
    ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Preservatives', 'B Corp'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Trader Joe''s'],
    true,
    ARRAY['rBST', 'rBGH', 'artificial sweeteners', 'carrageenan', 'artificial colors', 'potassium sorbate', 'high fructose corn syrup'],
    ARRAY['Yoplait Yogurt', 'Dannon Yogurt', 'Chobani', 'Great Value Yogurt']
  ),
  (
    'Organic Whole Milk',
    'Organic Valley',
    'dairy',
    88,
    'From pasture-raised cows on small family farms with no antibiotics, synthetic hormones, or pesticides. Cooperative-owned ensuring sustainable farming practices and animal welfare.',
    ARRAY['USDA Organic', 'Non-GMO', 'B Corp'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s'],
    true,
    ARRAY['rBST', 'rBGH', 'antibiotics', 'pesticide residues'],
    ARRAY['Great Value Milk', 'Fairlife', 'Dean''s Milk', 'Borden Milk']
  ),
  (
    'Organic Mac & Cheese Shredded Cheese',
    'Horizon Organic',
    'dairy',
    82,
    'Organic milk from cows raised without antibiotics, added growth hormones, or persistent pesticides. Clean ingredient list with no artificial colors, flavors, or preservatives.',
    ARRAY['USDA Organic', 'Non-GMO'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Trader Joe''s'],
    true,
    ARRAY['rBST', 'rBGH', 'natamycin', 'artificial colors', 'potassium sorbate', 'cellulose (wood pulp)'],
    ARRAY['Kraft Singles', 'Sargento Cheese', 'Great Value Cheese', 'Velveeta']
  );

-- Supplement (3 products)
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Vitamin Code Raw Whole Food Multivitamin',
    'Garden of Life',
    'supplement',
    87,
    'Made from RAW whole food ingredients with live probiotics and enzymes. No synthetic binders, fillers, artificial colors, or titanium dioxide found in many mass-market supplements.',
    ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free', 'No Artificial Colors'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'iHerb', 'Thrive Market'],
    true,
    ARRAY['titanium dioxide', 'magnesium stearate', 'artificial colors', 'talc', 'BHT', 'hydrogenated oil', 'high fructose corn syrup'],
    ARRAY['Centrum Multivitamin', 'One A Day', 'Nature Made Multi', 'Flintstones Vitamins']
  ),
  (
    'Ultimate Omega Fish Oil',
    'Nordic Naturals',
    'supplement',
    91,
    'Third-party tested for purity, freshness, and potency with surpassed international standards for heavy metals and oxidation. Triglyceride form for superior absorption vs cheaper ethyl ester forms.',
    ARRAY['Non-GMO', 'No Artificial Preservatives', 'Gluten-Free'],
    ARRAY['Amazon', 'Whole Foods', 'Costco', 'iHerb', 'Thrive Market'],
    true,
    ARRAY['artificial colors', 'mercury', 'lead', 'PCBs', 'BHT', 'carrageenan', 'soybean oil'],
    ARRAY['Nature Made Fish Oil', 'Kirkland Fish Oil', 'GNC Fish Oil', 'Spring Valley Fish Oil']
  ),
  (
    'Women''s One Daily Whole Food Multivitamin',
    'MegaFood',
    'supplement',
    85,
    'Made with real food sourced from trusted farm partners. Gentle enough to take on an empty stomach. Free of synthetic fillers, artificial sweeteners, and controversial additives like titanium dioxide.',
    ARRAY['Non-GMO', 'Gluten-Free', 'B Corp', 'No Artificial Colors'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'iHerb', 'Thrive Market'],
    true,
    ARRAY['titanium dioxide', 'magnesium stearate', 'artificial colors', 'talc', 'synthetic folic acid', 'hydrogenated oil'],
    ARRAY['Centrum Women''s Multi', 'One A Day Women''s', 'Nature Made Multi For Her', 'Alive! Women''s Multi']
  );
