-- Swaps table cleanup:
-- 1. Remove "Coupang" from available_stores (Korean marketplace, not US market)
-- 2. Update "buybuy BABY" references (chain closed physical stores in 2023)
-- 3. Add descriptions to all swaps missing them
-- 4. Add more swaps to thin categories (condiment, laundry, oral_care, soap)

-- ============================================================
-- 1. REMOVE COUPANG FROM ALL SWAPS
-- ============================================================
UPDATE public.swaps
SET available_stores = array_remove(available_stores, 'Coupang')
WHERE 'Coupang' = ANY(available_stores);

-- ============================================================
-- 2. REPLACE "buybuy BABY" WITH "buybuyBaby.com"
-- (Chain closed physical stores in 2023, now online-only)
-- ============================================================
UPDATE public.swaps
SET available_stores = array_replace(available_stores, 'buybuy BABY', 'buybuyBaby.com')
WHERE 'buybuy BABY' = ANY(available_stores);

UPDATE public.swaps
SET available_stores = array_replace(available_stores, 'buybuyBaby', 'buybuyBaby.com')
WHERE 'buybuyBaby' = ANY(available_stores);

-- ============================================================
-- 3. ADD DESCRIPTIONS TO ALL SWAPS MISSING THEM
-- ============================================================

-- BABY
UPDATE public.swaps SET description = 'Plant-based diapers made without chlorine processing, latex, or fragrances. Hypoallergenic with a cute printed design.'
WHERE brand = 'The Honest Company' AND name = 'Clean Conscious Diapers' AND description IS NULL;

UPDATE public.swaps SET description = 'Gentle, plant-based wash for baby hair and body. Made with natural ingredients like lavender, rosemary, and jojoba. No sulfates, parabens, or synthetic fragrance.'
WHERE brand = 'Tubby Todd' AND name = 'Hair & Body Wash' AND description IS NULL;

UPDATE public.swaps SET description = 'Plant-based baby lotion with NeoNourish seed oil blend. Fragrance-free, non-allergenic, and pediatrician tested. No parabens, sulfates, or phthalates.'
WHERE brand = 'Babyganics' AND name = 'Moisturizing Daily Lotion' AND description IS NULL;

UPDATE public.swaps SET description = 'USDA Certified Organic nipple cream made with herbs and botanut butters. Lanolin-free, safe for nursing, no need to wash off before feeding.'
WHERE brand = 'Earth Mama' AND name = 'Organic Nipple Butter' AND description IS NULL;

-- BABY FOOD
UPDATE public.swaps SET description = 'Cold-pressed organic baby food made with whole fruits and vegetables. No concentrates, added sugars, or preservatives. Refrigerated for freshness.'
WHERE brand = 'Once Upon a Farm' AND name = 'Cold-Pressed Fruit & Veggie Pouches' AND description IS NULL;

UPDATE public.swaps SET description = 'Unique meat-based baby food pouches with ethically sourced proteins and organic vegetables. No grains, fillers, or added sugars. Rich in healthy fats for brain development.'
WHERE brand = 'Serenity Kids' AND name = 'Meat & Veggie Pouches' AND description IS NULL;

UPDATE public.swaps SET description = 'Nutrient-dense baby food bars designed by a neurosurgeon. Made with organic ingredients targeting 16 key brain nutrients. No artificial anything.'
WHERE brand = 'Cerebelly' AND name = 'Smart Bar Variety Pack' AND description IS NULL;

-- BEVERAGE
UPDATE public.swaps SET description = 'Raw, organic kombucha with real ginger. Naturally fermented with living probiotics. No artificial flavoring, preservatives, or added sugars.'
WHERE brand = 'GT''s Living Foods' AND name = 'Gingerade Kombucha' AND description IS NULL;

UPDATE public.swaps SET description = 'Direct-trade loose leaf green tea grown in the Wuyi Mountains. Organic, no artificial flavors or additives. Fair Trade certified.'
WHERE brand = 'Rishi Tea' AND name = 'Jade Cloud Green Tea' AND description IS NULL;

UPDATE public.swaps SET description = 'Prebiotic soda with plant fiber and botanicals. Only 2-5g sugar per can. Replaces conventional sodas without artificial sweeteners or high fructose corn syrup.'
WHERE brand = 'Olipop' AND name = 'Vintage Cola' AND description IS NULL;

-- CLOTHING
UPDATE public.swaps SET description = 'Made from 100% GOTS Certified Organic cotton. Free from harmful chemicals, dyes, and flame retardants. Gentle on sensitive baby skin.'
WHERE brand = 'Burt''s Bees Baby' AND name = 'Organic Baby Bodysuit' AND description IS NULL;

UPDATE public.swaps SET description = 'Made from 100% organic cotton grown without toxic pesticides or synthetic fertilizers. Fair Trade Certified factory. Carbon-offset shipping.'
WHERE brand = 'Pact' AND name = 'Organic Cotton Essential Tee' AND description IS NULL;

UPDATE public.swaps SET description = 'Made with Regenerative Organic Certified cotton. Grown without synthetic chemicals, supporting soil health and fair labor practices.'
WHERE brand = 'Patagonia' AND name = 'Regenerative Organic Stand Up Tee' AND description IS NULL;

-- COOKWARE
UPDATE public.swaps SET description = 'Pre-seasoned American-made cast iron. No synthetic coatings, PFAS, or PTFE. Naturally nonstick when seasoned. Lasts generations.'
WHERE brand = 'Lodge' AND name = '12-Inch Cast Iron Skillet' AND description IS NULL;

UPDATE public.swaps SET description = 'Ceramic-coated cookware free from PTFE, PFOA, PFAS, lead, and cadmium. Non-toxic nonstick surface that releases food easily without harmful fumes.'
WHERE brand = 'Caraway' AND name = 'Ceramic Cookware Set' AND description IS NULL;

UPDATE public.swaps SET description = 'American-made tri-ply stainless steel. No coatings, no chemicals — just pure stainless steel bonded with aluminum for even heating. Completely inert cooking surface.'
WHERE brand = 'All-Clad' AND name = 'D3 Stainless Steel Fry Pan' AND description IS NULL;

UPDATE public.swaps SET description = '100% pure ceramic cookware — no coatings, glazes, or metals that can leach. Tested for 10,000+ chemicals. The safest cookware available.'
WHERE brand = 'Xtrema' AND name = 'Pure Ceramic Skillet' AND description IS NULL;

-- DAIRY
UPDATE public.swaps SET description = 'USDA Organic shredded cheese from pasture-raised cows. No antibiotics, synthetic hormones, or pesticides. No artificial colors or preservatives.'
WHERE brand = 'Horizon Organic' AND name = 'Organic Shredded Cheese' AND description IS NULL;

UPDATE public.swaps SET description = 'Pasture-raised organic whole milk from small family farms. No antibiotics, synthetic hormones, or GMOs. Certified Humane and B Corp.'
WHERE brand = 'Organic Valley' AND name = 'Organic Whole Milk' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic whole milk yogurt with live active cultures. No artificial hormones, toxic persistent pesticides, or GMOs. Made on organic farms.'
WHERE brand = 'Stonyfield Organic' AND name = 'Organic Whole Milk Yogurt' AND description IS NULL;

-- FOOD
UPDATE public.swaps SET description = 'Made with avocado oil instead of soybean or canola oil. No sugar, soy, canola, gluten, or dairy. Simple, clean ingredients.'
WHERE brand = 'Primal Kitchen' AND name = 'Avocado Oil Mayo' AND description IS NULL;

UPDATE public.swaps SET description = 'Uncured hot dogs made with grass-fed beef. No antibiotics, nitrates, nitrites, artificial ingredients, or chemical preservatives.'
WHERE brand = 'Applegate Naturals' AND name = 'Natural Uncured Hot Dogs' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic lentil soup made in small batches. No GMOs, preservatives, or artificial flavors. Made in a BPA-free can lining.'
WHERE brand = 'Amy''s Kitchen' AND name = 'Organic Lentil Soup' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic mac and cheese with real cheese and organic pasta. No artificial flavors, synthetic colors, or preservatives. Fun bunny-shaped noodles available.'
WHERE brand = 'Annie''s Homegrown' AND name = 'Organic Mac & Cheese' AND description IS NULL;

-- FRAGRANCE
UPDATE public.swaps SET description = 'Hand-poured soy wax candle with cotton wick. Made with domestically grown soy and fine fragrance oils. No lead, phthalates, or paraffin.'
WHERE brand = 'P.F. Candle Co.' AND name = 'Soy Candle (Amber & Moss)' AND description IS NULL;

UPDATE public.swaps SET description = 'Soy wax candle made with essential oils and plant-derived ingredients. Burns cleaner than paraffin candles. Recyclable glass container.'
WHERE brand = 'Mrs. Meyer''s Clean Day' AND name = 'Soy Candle (Iowa Pine)' AND description IS NULL;

UPDATE public.swaps SET description = 'Porcelain stone diffuser that uses ultrasonic technology with 100% organic essential oils. No heat, flame, or synthetic fragrance. Covers up to 500 sq ft.'
WHERE brand = 'Vitruvi' AND name = 'Stone Diffuser with Organic Essential Oils' AND description IS NULL;

-- FURNITURE
UPDATE public.swaps SET description = 'Solid wood kids desk made with non-toxic, water-based finish. GREENGUARD Gold Certified for low chemical emissions. Meets strict safety standards.'
WHERE brand = 'Crate & Kids' AND name = 'Mid-Century Kids Desk Set' AND description IS NULL;

UPDATE public.swaps SET description = 'Handcrafted from FSC-certified reclaimed wood with non-toxic, zero-VOC finishes. Made in Los Angeles. GREENGUARD Gold Certified.'
WHERE brand = 'Avocado' AND name = 'Reclaimed Wood Collection' AND description IS NULL;

UPDATE public.swaps SET description = 'Solid beech wood crib with non-toxic paint finish. Meets or exceeds all US safety standards. No formaldehyde-based adhesives. Converts to toddler bed.'
WHERE brand = 'IKEA' AND name = 'SUNDVIK Crib' AND description IS NULL;

-- GARDEN
UPDATE public.swaps SET description = 'OMRI Listed organic insecticidal soap that kills insects on contact. Made from naturally occurring plant oils. Safe for use around pets and children when dry.'
WHERE brand = 'Safer Brand' AND name = 'Insecticidal Soap Concentrate' AND description IS NULL;

UPDATE public.swaps SET description = 'OMRI Listed organic fertilizer with beneficial soil microbes and mycorrhizae. No synthetic chemicals, chicken manure, or sewage sludge. Safe for people, pets, and planet.'
WHERE brand = 'Dr. Earth' AND name = 'Organic All-Purpose Fertilizer' AND description IS NULL;

UPDATE public.swaps SET description = 'Cold-pressed, 100% pure neem oil. OMRI Listed for organic gardening. Natural pest deterrent and fungicide. No chemical additives.'
WHERE brand = 'Neem Bliss' AND name = 'Pure Organic Neem Oil' AND description IS NULL;

-- HAIRCARE
UPDATE public.swaps SET description = 'Sulfate-free shampoo with avocado and olive oils. No parabens, lauryl sulfate, or artificial colors. Cruelty-free and eco-friendly packaging.'
WHERE brand = 'Giovanni' AND name = '2chic Ultra-Moist Shampoo' AND description IS NULL;

UPDATE public.swaps SET description = 'Lemongrass and rosemary clarifying shampoo. 100% vegan, sulfate-free, and paraben-free. Made with Fair Trade organic ingredients.'
WHERE brand = 'Acure' AND name = 'Curiously Clarifying Shampoo' AND description IS NULL;

UPDATE public.swaps SET description = 'Intensive hair repair mask with rosehip, argan, and avocado oils. Free from sulfates, silicones, phthalates, parabens, and artificial dyes. 97% naturally derived.'
WHERE brand = 'Briogeo' AND name = 'Don''t Despair, Repair! Mask' AND description IS NULL;

UPDATE public.swaps SET description = 'EWG Verified shampoo with plant- and mineral-based ingredients. Hypoallergenic, no synthetic fragrance, dyes, or preservatives. Biodegradable formula.'
WHERE brand = 'Attitude' AND name = 'Super Leaves Shampoo' AND description IS NULL;

-- MAKEUP
UPDATE public.swaps SET description = 'Clean foundation with SPF 25 and skincare benefits. Made without parabens, sulfates, phthalates, or talc. Active botanical ingredients improve skin over time.'
WHERE brand = 'Kosas' AND name = 'Revealer Skin-Improving Foundation SPF 25' AND description IS NULL;

UPDATE public.swaps SET description = 'Serum-meets-skin-tint with SPF 40 mineral sunscreen. Made with niacinamide, squalane, and hyaluronic acid. No parabens, sulfates, phthalates, talc, or synthetic fragrance.'
WHERE brand = 'ILIA' AND name = 'Super Serum Skin Tint SPF 40' AND description IS NULL;

UPDATE public.swaps SET description = 'Cream foundation made with raw, organic coconut oil and natural pigments. No synthetic chemicals, GMOs, or gluten. Nourishes skin while providing coverage.'
WHERE brand = 'RMS Beauty' AND name = 'Un Cover-Up Cream Foundation' AND description IS NULL;

-- MATTRESS
UPDATE public.swaps SET description = 'Organic mattress with GOTS certified organic cotton, organic latex, and organic wool. No polyurethane foam, flame retardants, or vinyl. GREENGUARD Gold Certified.'
WHERE brand = 'Naturepedic' AND name = 'EOS Classic Mattress' AND description IS NULL;

UPDATE public.swaps SET description = 'Made with GOLS certified organic latex, GOTS certified organic wool and cotton. No polyurethane foam, toxic flame retardants, or synthetic materials. Handmade in LA.'
WHERE brand = 'Avocado' AND name = 'Green Mattress' AND description IS NULL;

UPDATE public.swaps SET description = 'Natural Talalay latex mattress with organic wool and cotton. No polyurethane foam, fiberglass, or chemical flame retardants. GREENGUARD Gold Certified.'
WHERE brand = 'Birch Living' AND name = 'Natural Mattress' AND description IS NULL;

-- PAINT
UPDATE public.swaps SET description = 'Zero-VOC interior paint with antimicrobial properties. Formulated to reduce common indoor odors. No harsh chemical fumes during or after application.'
WHERE brand = 'Sherwin-Williams' AND name = 'Harmony Interior Paint' AND description IS NULL;

UPDATE public.swaps SET description = 'Zero-VOC, zero-emission interior paint. Asthma and allergy friendly. No chemical fumes — can paint nurseries and bedrooms with no odor or off-gassing.'
WHERE brand = 'Benjamin Moore' AND name = 'Natura Interior Paint' AND description IS NULL;

UPDATE public.swaps SET description = 'Zero-toxin, zero-VOC paint made without hazardous chemicals. No carcinogens, reproductive toxins, or hormone disruptors. Safe for chemically sensitive individuals.'
WHERE brand = 'ECOS Paints' AND name = 'Zero-Toxin Interior Paint' AND description IS NULL;

-- PET
UPDATE public.swaps SET description = 'Ethically sourced turkey recipe with non-GMO fruits and vegetables. Humanely raised animals, no artificial preservatives, flavors, or colors. Certified Humane.'
WHERE brand = 'Open Farm' AND name = 'Homestead Turkey Dog Food' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic castile soap safe for dogs, made with organic oils. No synthetic fragrances, preservatives, or detergents. Gentle enough for sensitive skin.'
WHERE brand = 'Dr. Bronner''s' AND name = 'Organic Pet Soap' AND description IS NULL;

UPDATE public.swaps SET description = 'Human-grade dog food made with real, whole food ingredients. Minimally processed with no by-products, preservatives, or fillers. Dehydrated for maximum nutrition.'
WHERE brand = 'The Honest Kitchen' AND name = 'Whole Food Clusters Dog Food' AND description IS NULL;

-- SKINCARE
UPDATE public.swaps SET description = 'Blue tansy and white willow bark face mask for clear, calm skin. Made with natural fruit enzymes. No synthetic fragrance, sulfates, parabens, or mineral oil.'
WHERE brand = 'Herbivore Botanicals' AND name = 'Blue Tansy Clarity Mask' AND description IS NULL;

UPDATE public.swaps SET description = 'Chlorophyll and sea grape face mask. Organic, vegan ingredients. No parabens, sulfates, phthalates, or synthetic fragrance. Sustainably packaged.'
WHERE brand = 'Cocokind' AND name = 'Chlorophyll Mask' AND description IS NULL;

UPDATE public.swaps SET description = 'Developed by dermatologists with essential ceramides and hyaluronic acid. Fragrance-free, non-comedogenic, and accepted by the National Eczema Association.'
WHERE brand = 'CeraVe' AND name = 'Daily Moisturizing Lotion' AND description IS NULL;

UPDATE public.swaps SET description = 'Protein-powered moisturizer with signal peptides, growth factors, and amino acids. Free from essential oils, silicones, fragrances, and SLS. pH balanced.'
WHERE brand = 'Drunk Elephant' AND name = 'Protini Polypeptide Cream' AND description IS NULL;

-- SNACK
UPDATE public.swaps SET description = 'Organic, fair trade dark chocolate. No refined sugar, dairy, soy lecithin, emulsifiers, or artificial flavors. Simple and clean ingredients.'
WHERE brand = 'Hu Kitchen' AND name = 'Dark Chocolate Bar' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic granola bars with hidden servings of vegetables. Top 8 allergen-free. No artificial colors, flavors, or preservatives. School-safe.'
WHERE brand = 'MadeGood' AND name = 'Granola Bars' AND description IS NULL;

UPDATE public.swaps SET description = 'Organic popcorn popped in avocado oil or coconut oil. No seed oils, artificial flavors, or chemical preservatives. Himalayan pink salt seasoning.'
WHERE brand = 'Lesser Evil' AND name = 'Organic Popcorn' AND description IS NULL;

-- STORAGE
UPDATE public.swaps SET description = 'Reusable food wraps made from organic cotton, beeswax, organic jojoba oil, and tree resin. Replaces plastic wrap. Compostable at end of life.'
WHERE brand = 'Bee''s Wrap' AND name = 'Reusable Food Wraps' AND description IS NULL;

UPDATE public.swaps SET description = 'Tempered glass food storage containers. Non-porous surface won''t absorb stains or odors. No BPA, BPS, or phthalates. Oven, microwave, and dishwasher safe.'
WHERE brand = 'Pyrex' AND name = 'Simply Store Glass Containers' AND description IS NULL;

UPDATE public.swaps SET description = 'Food-grade stainless steel containers. No plastic, BPA, phthalates, or lead. Won''t leach chemicals into food. Durable, lightweight, and dishwasher safe.'
WHERE brand = 'U-Konserve' AND name = 'Stainless Steel Containers' AND description IS NULL;

-- SUNSCREEN
UPDATE public.swaps SET description = 'Invisible zinc oxide sunscreen that goes on clear. Oil-free, reef-safe, and free from parabens, oxybenzone, and octinoxate. Suitable for everyday use under makeup.'
WHERE brand = 'Supergoop!' AND name = 'Unseen Sunscreen SPF 40' AND description IS NULL;

-- SUPPLEMENT
UPDATE public.swaps SET description = 'Molecularly distilled fish oil for purity. Third-party tested for heavy metals, PCBs, and dioxins. No artificial colors, flavors, or preservatives. Sustainably sourced.'
WHERE brand = 'Nordic Naturals' AND name = 'Ultimate Omega' AND description IS NULL;

UPDATE public.swaps SET description = 'Whole food multivitamin with RAW food-created nutrients. No synthetic binders, fillers, artificial colors, or preservatives. Contains live probiotics and enzymes.'
WHERE brand = 'Garden of Life' AND name = 'Vitamin Code Multivitamin' AND description IS NULL;

UPDATE public.swaps SET description = 'Whole food multivitamin made with real food like organic oranges, broccoli, and brown rice. No artificial colors, flavors, sweeteners, or preservatives. Soy-free.'
WHERE brand = 'MegaFood' AND name = 'Women''s One Daily' AND description IS NULL;

-- TOYS
UPDATE public.swaps SET description = 'Made from 100% recycled plastic milk jugs. No BPA, phthalates, PVC, or external coatings. Manufactured in the USA. Dishwasher safe.'
WHERE brand = 'Green Toys' AND name = 'Recycled Plastic Toy Set' AND description IS NULL;

UPDATE public.swaps SET description = 'Stage-based play kits designed by child development experts. Made from sustainably sourced wood, organic cotton, and non-toxic water-based finishes. No plastic.'
WHERE brand = 'Lovevery' AND name = 'The Play Kit' AND description IS NULL;

UPDATE public.swaps SET description = 'Made from chemical-free rubberwood with water-based dyes and organic pigments. No formaldehyde. Sustainable manufacturing using solar energy and biomass.'
WHERE brand = 'PlanToys' AND name = 'Wooden Toy Collection' AND description IS NULL;

-- ============================================================
-- 4. ADD MORE SWAPS TO THIN CATEGORIES
-- ============================================================

-- CONDIMENT (currently 1, adding 3 more)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Organic Yellow Mustard',
    'Annie''s Homegrown',
    'condiment',
    90,
    'USDA Organic mustard made with simple ingredients: organic mustard seed, organic vinegar, water, and salt. No artificial colors or preservatives.',
    'Uses organic ingredients without artificial yellow dyes (Yellow #5) found in conventional mustards. No high fructose corn syrup or preservatives.',
    ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart', 'Thrive Market'],
    true,
    ARRAY['yellow 5', 'yellow 6', 'high fructose corn syrup', 'sodium benzoate'],
    ARRAY['French''s Classic Yellow Mustard', 'Heinz Yellow Mustard']
  ),
  (
    'Organic Sriracha',
    'Yellowbird',
    'condiment',
    88,
    'Organic sriracha made with real jalapeños, habaneros, and tangerine. No artificial preservatives, thickeners, or added sugar. Clean heat from real peppers.',
    'Uses real organic peppers and whole ingredients instead of the preservatives and thickeners found in conventional hot sauces.',
    ARRAY['USDA Organic', 'Non-GMO', 'Whole30 Approved'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'HEB'],
    true,
    ARRAY['sodium bisulfite', 'potassium sorbate', 'xanthan gum', 'artificial colors'],
    ARRAY['Huy Fong Sriracha', 'Tabasco', 'Frank''s RedHot']
  ),
  (
    'Organic Extra Virgin Olive Oil',
    'California Olive Ranch',
    'condiment',
    93,
    '100% California-grown extra virgin olive oil. Tested for purity and freshness. No blending with imported or seed oils. Harvest date on every bottle.',
    'Genuine single-origin olive oil verified for purity. Many imported olive oils are diluted with cheaper seed oils or are rancid.',
    ARRAY['USDA Organic', 'Non-GMO', 'California Grown'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco', 'Walmart'],
    true,
    ARRAY['soybean oil', 'canola oil', 'sunflower oil', 'rancid oil'],
    ARRAY['Bertolli Extra Virgin', 'Filippo Berio', 'store brand olive oil']
  );

-- LAUNDRY (currently 1, adding 3 more)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Laundry Detergent Sheets',
    'Earth Breeze',
    'laundry',
    91,
    'Ultra-concentrated laundry detergent sheets. No plastic jug waste. Free from parabens, phthalates, phosphates, bleach, and dyes. Hypoallergenic and dermatologist tested.',
    'Eliminates plastic jugs and harsh chemicals. Dissolves completely in any water temperature. Zero-waste packaging.',
    ARRAY['Cruelty-Free', 'Vegan', 'B Corp', 'Plastic-Free'],
    ARRAY['Amazon', 'Walmart', 'Earth Breeze website'],
    true,
    ARRAY['sodium lauryl sulfate', 'optical brighteners', 'synthetic fragrance', '1,4-dioxane', 'phosphates'],
    ARRAY['Tide Original', 'Gain Original', 'All Free Clear']
  ),
  (
    'Concentrated Laundry Detergent',
    'Branch Basics',
    'laundry',
    94,
    'One plant-based concentrate for all your laundry needs. Free from harmful chemicals, fragrances, dyes, and preservatives. Made for chemically sensitive individuals.',
    'Single concentrate replaces multiple laundry products. No fragrance, dyes, or optical brighteners that irritate skin and pollute waterways.',
    ARRAY['Fragrance-Free', 'Cruelty-Free', 'Made Safe Certified'],
    ARRAY['Amazon', 'Branch Basics website'],
    true,
    ARRAY['fragrance', 'dyes', 'optical brighteners', 'chlorine bleach', 'formaldehyde releasers'],
    ARRAY['Tide Pods', 'Persil ProClean', 'Arm & Hammer']
  ),
  (
    'Free & Clear Oxygen Brightener',
    'Molly''s Suds',
    'laundry',
    89,
    'Oxygen-based laundry brightener and stain remover. No chlorine bleach, synthetic fragrances, dyes, or optical brighteners. Safe for colors and whites.',
    'Uses sodium percarbonate (oxygen bleach) instead of chlorine bleach. No 1,4-dioxane contamination risk. Septic safe and biodegradable.',
    ARRAY['Cruelty-Free', 'Vegan', 'Made in USA'],
    ARRAY['Amazon', 'Target', 'Thrive Market', 'Whole Foods'],
    true,
    ARRAY['chlorine bleach', 'optical brighteners', 'synthetic fragrance', 'dyes'],
    ARRAY['OxiClean', 'Clorox 2', 'Shout Color Catcher']
  );

-- ORAL CARE (currently 1, adding 3 more)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Hydroxyapatite Toothpaste',
    'Boka',
    'oral_care',
    91,
    'Remineralizing toothpaste with nano-hydroxyapatite instead of fluoride. No SLS, parabens, artificial sweeteners, or triclosan. Strengthens enamel naturally.',
    'Uses hydroxyapatite (the mineral teeth are made of) to remineralize enamel without fluoride. Gentler and effective alternative to harsh conventional pastes.',
    ARRAY['Fluoride-Free', 'SLS-Free', 'Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'CVS', 'Whole Foods'],
    true,
    ARRAY['sodium lauryl sulfate', 'triclosan', 'artificial sweeteners', 'propylene glycol', 'diethanolamine'],
    ARRAY['Colgate Total', 'Crest Pro-Health', 'Sensodyne']
  ),
  (
    'Mineral Toothpaste',
    'RiseWell',
    'oral_care',
    92,
    'Hydroxyapatite mineral toothpaste that remineralizes teeth. No fluoride, SLS, sulfates, or artificial colors. Made with organic essential oils for flavor.',
    'Remineralizes enamel with hydroxyapatite — the same mineral found in teeth and bones. No harsh chemicals or synthetic ingredients.',
    ARRAY['Fluoride-Free', 'SLS-Free', 'Non-GMO', 'Cruelty-Free'],
    ARRAY['Amazon', 'Whole Foods', 'Thrive Market'],
    true,
    ARRAY['sodium lauryl sulfate', 'triclosan', 'artificial colors', 'artificial sweeteners'],
    ARRAY['Colgate Cavity Protection', 'Crest 3D White', 'Aquafresh']
  ),
  (
    'Activated Charcoal Floss',
    'Hello',
    'oral_care',
    86,
    'Vegan floss infused with activated charcoal and natural tea tree oil. No PFAS chemicals, artificial flavors, or dyes. Comes in recyclable packaging.',
    'Most conventional flosses are coated with PFAS (forever chemicals) that leach into your body through gum tissue. This floss is PFAS-free and naturally antimicrobial.',
    ARRAY['Vegan', 'Cruelty-Free', 'PFAS-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens'],
    true,
    ARRAY['PFAS', 'PTFE', 'artificial flavors', 'artificial colors'],
    ARRAY['Oral-B Glide', 'Reach Waxed Floss', 'GUM floss']
  );

-- SOAP (currently 1, adding 3 more)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Organic Hand Soap',
    'EO Products',
    'soap',
    88,
    'Plant-based liquid hand soap with organic essential oils. No synthetic fragrances, parabens, sulfates, or phthalates. Biodegradable and cruelty-free.',
    'Uses real essential oils instead of synthetic fragrance. Plant-derived cleansers instead of harsh sulfates. Gentle enough for frequent use.',
    ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free', 'B Corp'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
    true,
    ARRAY['triclosan', 'synthetic fragrance', 'sodium lauryl sulfate', 'parabens', 'phthalates'],
    ARRAY['Softsoap', 'Dial', 'Bath & Body Works Hand Soap']
  ),
  (
    'Foaming Hand Soap',
    'Mrs. Meyer''s Clean Day',
    'soap',
    83,
    'Plant-derived foaming hand soap with essential oils. No parabens, phthalates, or formaldehyde. Cruelty-free and made with renewable energy.',
    'Cleaner formula than most conventional hand soaps. Plant-derived surfactants. Available in garden-inspired scents from essential oils.',
    ARRAY['Cruelty-Free', 'Leaping Bunny Certified'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Grove Collaborative'],
    true,
    ARRAY['triclosan', 'parabens', 'phthalates', 'formaldehyde'],
    ARRAY['Softsoap Antibacterial', 'Dial Foaming', 'Method Foaming Hand Wash']
  ),
  (
    'Castile Bar Soap',
    'Kirk''s',
    'soap',
    90,
    'Made with premium coconut oil and no synthetic detergents. Only 4 natural ingredients. Hypoallergenic, biodegradable, and fragrance-free option available.',
    'One of the simplest, cleanest bar soaps available. Only coconut oil, water, salt, and glycerin. No synthetic chemicals whatsoever.',
    ARRAY['Hypoallergenic', 'Fragrance-Free', 'Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Walgreens'],
    true,
    ARRAY['triclosan', 'synthetic fragrance', 'BHT', 'sodium lauryl sulfate', 'artificial colors'],
    ARRAY['Dove Beauty Bar', 'Irish Spring', 'Dial Bar Soap']
  );
