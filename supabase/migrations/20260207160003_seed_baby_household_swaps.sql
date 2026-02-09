-- Seed swap products for baby, toys, pet, and household categories
-- Real, well-known non-toxic brands with genuine certifications

INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  -- ============================================================
  -- BABY (4 products)
  -- ============================================================
  (
    'Clean Conscious Diapers',
    'The Honest Company',
    'baby',
    88,
    'Made with plant-based materials and free from chlorine processing, fragrances, lotions, and latex. Uses a sustainably harvested fluff pulp and bio-based core.',
    ARRAY['Dermatologist Tested', 'Hypoallergenic', 'Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'buybuy BABY'],
    true,
    ARRAY['chlorine bleach', 'fragrance', 'phthalates', 'latex', 'parabens'],
    ARRAY['Pampers Swaddlers', 'Huggies Little Snugglers', 'Luvs Diapers']
  ),
  (
    'Moisturizing Daily Lotion',
    'Babyganics',
    'baby',
    85,
    'Plant-derived formula with NeoNourish seed oil blend. Free from parabens, sulfates, phthalates, mineral oil, and artificial fragrances. Designed specifically for sensitive infant skin.',
    ARRAY['Dermatologist Tested', 'Hypoallergenic', 'Non-Allergenic'],
    ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'buybuy BABY'],
    true,
    ARRAY['parabens', 'phthalates', 'mineral oil', 'synthetic fragrance', 'sulfates'],
    ARRAY['Johnson''s Baby Lotion', 'Aveeno Baby Daily Moisture', 'Cetaphil Baby Lotion']
  ),
  (
    'Organic Nipple Butter',
    'Earth Mama',
    'baby',
    92,
    'USDA Certified Organic, made with only herbs and oils safe for breastfeeding. No lanolin, petroleum, or parabens. Does not need to be washed off before nursing.',
    ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free', 'Dermatologist Tested'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'buybuy BABY'],
    true,
    ARRAY['lanolin', 'petroleum', 'parabens', 'synthetic fragrance'],
    ARRAY['Lansinoh Lanolin Cream', 'Medela Purelan', 'Motherlove Nipple Cream']
  ),
  (
    'Hair & Body Wash',
    'Tubby Todd',
    'baby',
    90,
    'EWG Verified formula with no sulfates, parabens, phthalates, dyes, or synthetic fragrance. Uses gentle coconut-based cleansers and is safe for eczema-prone and sensitive skin.',
    ARRAY['Dermatologist Tested', 'Hypoallergenic', 'Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Nordstrom'],
    true,
    ARRAY['sodium lauryl sulfate', 'sodium laureth sulfate', 'parabens', 'synthetic dyes', 'phthalates', '1,4-dioxane'],
    ARRAY['Johnson''s Baby Wash', 'Aveeno Baby Wash', 'Cetaphil Baby Wash']
  ),

  -- ============================================================
  -- BABY FOOD (3 products)
  -- ============================================================
  (
    'Organic Cold-Pressed Baby Food Pouches',
    'Once Upon a Farm',
    'baby_food',
    93,
    'Cold-pressed (HPP) rather than heat-pasteurized, preserving more nutrients. USDA Organic with no added sugar, concentrates, or preservatives. Co-founded with Jennifer Garner with pediatric nutritionist oversight.',
    ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Colors'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart', 'Kroger'],
    true,
    ARRAY['added sugar', 'artificial preservatives', 'juice concentrates', 'artificial colors', 'natural flavors'],
    ARRAY['Gerber Baby Food Pouches', 'Plum Organics Pouches', 'Happy Baby Pouches']
  ),
  (
    'Smart Bar & Pouch Variety Pack',
    'Cerebelly',
    'baby_food',
    91,
    'Developed by a neurosurgeon, formulated with 16 key brain-supporting nutrients including DHA, iron, and choline. USDA Organic with no added sugar, artificial ingredients, or common allergens in most varieties.',
    ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Colors'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
    true,
    ARRAY['added sugar', 'artificial flavors', 'artificial preservatives', 'juice concentrates'],
    ARRAY['Gerber Puffs', 'Happy Baby Puffs', 'Beech-Nut Baby Food']
  ),
  (
    'Grass Fed Meat & Veggie Baby Food Pouches',
    'Serenity Kids',
    'baby_food',
    94,
    'First baby food brand focused on healthy fats and protein from ethically sourced, grass-fed and pasture-raised meats. No grains, added sugar, seed oils, or fillers. Low in heavy metals compared to rice-based baby foods.',
    ARRAY['Non-GMO', 'No Artificial Colors', 'Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
    true,
    ARRAY['added sugar', 'rice flour', 'seed oils', 'soy', 'corn starch', 'natural flavors'],
    ARRAY['Gerber Meat Baby Food', 'Beech-Nut Naturals', 'Earth''s Best Organic']
  ),

  -- ============================================================
  -- TOYS (3 products)
  -- ============================================================
  (
    'Sustainable Wooden Toy Collection',
    'PlanToys',
    'toys',
    90,
    'Made from chemical-free rubberwood trees using a kiln-drying process with no added formaldehyde. Colored with organic pigments and water-based dyes. Entire manufacturing process is zero-waste and sustainable.',
    ARRAY['Non-Toxic Certified', 'Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Nordstrom', 'Pottery Barn Kids'],
    true,
    ARRAY['BPA', 'phthalates', 'lead paint', 'formaldehyde', 'PVC'],
    ARRAY['Fisher-Price Plastic Toys', 'Mattel Plastic Toys', 'generic plastic teethers']
  ),
  (
    '100% Recycled Plastic Toy Set',
    'Green Toys',
    'toys',
    88,
    'Made in the USA from 100% recycled milk jugs. Contains no BPA, PVC, phthalates, or external coatings. Meets FDA food contact standards so every piece is safe even if mouthed by toddlers. Packaged in recycled cardboard with no plastic films.',
    ARRAY['Non-Toxic Certified', 'Hypoallergenic'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Pottery Barn Kids'],
    true,
    ARRAY['BPA', 'PVC', 'phthalates', 'lead paint', 'external coatings'],
    ARRAY['Little Tikes Toys', 'Fisher-Price Plastic Sets', 'generic bath toys']
  ),
  (
    'The Play Kit (Age-Matched)',
    'Lovevery',
    'toys',
    91,
    'Montessori-inspired play kits with sustainably sourced wood, organic cotton, and baby-safe paints. All materials are third-party tested for heavy metals, phthalates, and formaldehyde. Designed by child development experts for stage-appropriate learning.',
    ARRAY['Non-Toxic Certified', 'OEKO-TEX', 'Cruelty-Free'],
    ARRAY['Amazon', 'Nordstrom', 'Pottery Barn Kids'],
    true,
    ARRAY['BPA', 'PVC', 'phthalates', 'formaldehyde', 'lead paint', 'flame retardants'],
    ARRAY['Fisher-Price Learning Toys', 'VTech Electronic Toys', 'Melissa & Doug Painted Toys']
  ),

  -- ============================================================
  -- PET (3 products)
  -- ============================================================
  (
    'Homestead Grain & Freeze-Dried Raw Dog Food',
    'Open Farm',
    'pet',
    89,
    'Uses 100% traceable, humanely raised animal proteins with no artificial preservatives, flavors, or by-product meals. Every ingredient is sourced transparently and can be traced back to its farm or fishery of origin.',
    ARRAY['Non-GMO', 'Cruelty-Free', 'Certified Humane'],
    ARRAY['Amazon', 'Chewy', 'PetSmart', 'Petco', 'Whole Foods'],
    true,
    ARRAY['BHA', 'BHT', 'ethoxyquin', 'meat by-products', 'artificial colors', 'corn syrup', 'propylene glycol'],
    ARRAY['Purina Dog Chow', 'Pedigree Dog Food', 'Iams ProActive Health', 'Kibbles ''n Bits']
  ),
  (
    'Whole Food Clusters Dry Dog Food',
    'The Honest Kitchen',
    'pet',
    90,
    'Human-grade, whole food ingredients produced in a human food facility. No by-product meals, preservatives, or GMO ingredients. Slow-roasted in small batches with no rendered meat meals or artificial anything.',
    ARRAY['Non-GMO', 'Cruelty-Free'],
    ARRAY['Amazon', 'Chewy', 'PetSmart', 'Petco', 'Whole Foods', 'Target'],
    true,
    ARRAY['BHA', 'BHT', 'ethoxyquin', 'meat by-products', 'artificial preservatives', 'rendered fat', 'corn gluten meal'],
    ARRAY['Purina ONE', 'Blue Buffalo Life Protection', 'Hill''s Science Diet', 'Royal Canin']
  ),
  (
    'Organic Pet Soap (Unscented Baby Mild)',
    'Dr. Bronner''s',
    'pet',
    87,
    'USDA Organic castile soap safe for dogs and cats. No synthetic detergents, preservatives, or foaming agents. Made with fair-trade organic coconut and olive oils. Gentle enough for pets with sensitive skin and allergies.',
    ARRAY['USDA Organic', 'Cruelty-Free', 'Non-GMO', 'Hypoallergenic'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'PetSmart'],
    true,
    ARRAY['sodium lauryl sulfate', 'parabens', 'synthetic fragrance', 'artificial dyes', 'DEA', 'MEA'],
    ARRAY['Hartz Dog Shampoo', 'Wahl Pet Shampoo', 'FURminator deShedding Shampoo', 'Sentry Flea Shampoo']
  ),

  -- ============================================================
  -- FURNITURE (3 products)
  -- ============================================================
  (
    'Reclaimed Wood Furniture Collection',
    'Avocado',
    'furniture',
    91,
    'Handcrafted from FSC-certified reclaimed wood with zero-VOC finishes and no formaldehyde-based adhesives. Made in Los Angeles with fully transparent supply chain. Climate-neutral certified and GREENGUARD Gold certified for low chemical emissions.',
    ARRAY['GREENGUARD Gold', 'Non-Toxic Certified', 'Cruelty-Free'],
    ARRAY['Amazon', 'Avocado Green Direct', 'West Elm'],
    true,
    ARRAY['formaldehyde', 'VOCs', 'flame retardants', 'polyurethane foam', 'synthetic adhesives'],
    ARRAY['Ashley Furniture Particleboard Items', 'Wayfair Budget Furniture', 'IKEA MALM Dressers']
  ),
  (
    'SUNDVIK Crib (GREENGUARD Gold Certified)',
    'IKEA',
    'furniture',
    83,
    'GREENGUARD Gold certified for low VOC emissions, making it safe for nurseries and children''s rooms. Made from sustainably sourced solid beech wood with water-based lacquer. Affordable option that meets strict chemical emission standards.',
    ARRAY['GREENGUARD Gold'],
    ARRAY['IKEA'],
    true,
    ARRAY['formaldehyde', 'VOCs', 'flame retardants', 'lead paint'],
    ARRAY['DaVinci Kalani Crib', 'Dream On Me Crib', 'Delta Children Crib']
  ),
  (
    'Kids Mid-Century Desk & Chair Set',
    'Crate & Kids',
    'furniture',
    85,
    'Made from solid FSC-certified hardwood with water-based, low-VOC finishes. Meets or exceeds ASTM safety standards for children''s furniture. GREENGUARD Gold certified for indoor air quality with no toxic flame retardants.',
    ARRAY['GREENGUARD Gold', 'Non-Toxic Certified'],
    ARRAY['Crate & Barrel', 'Crate & Kids Online'],
    true,
    ARRAY['formaldehyde', 'VOCs', 'flame retardants', 'lead paint', 'synthetic lacquer'],
    ARRAY['Wayfair Kids Desk', 'Amazon Basics Kids Desk', 'Target Pillowfort Desk']
  ),

  -- ============================================================
  -- MATTRESS (3 products)
  -- ============================================================
  (
    'Green Mattress',
    'Avocado',
    'mattress',
    94,
    'Made with GOLS certified organic latex and GOTS certified organic wool and cotton. No polyurethane foam, no chemical flame retardants, no off-gassing. Handmade in Los Angeles. One of the only mattresses that is both GREENGUARD Gold and MADE SAFE certified.',
    ARRAY['GREENGUARD Gold', 'GOTS Certified', 'CertiPUR-US', 'Non-Toxic Certified', 'Cruelty-Free'],
    ARRAY['Amazon', 'Avocado Green Direct', 'Pottery Barn'],
    true,
    ARRAY['polyurethane foam', 'flame retardants', 'formaldehyde', 'phthalates', 'VOCs', 'PBDE'],
    ARRAY['Casper Original Mattress', 'Purple Mattress', 'Tempur-Pedic', 'Serta iComfort']
  ),
  (
    'Organic Mattress EOS Classic',
    'Naturepedic',
    'mattress',
    95,
    'GOTS certified organic cotton and wool with no polyurethane foam, no flame retardants, and no GMO bio-based foams. Encased coils eliminate motion transfer without toxic memory foam. Recommended by pediatricians and used in hospitals.',
    ARRAY['GREENGUARD Gold', 'GOTS Certified', 'Non-Toxic Certified', 'Cruelty-Free'],
    ARRAY['Amazon', 'Naturepedic Direct', 'buybuy BABY', 'Pottery Barn Kids'],
    true,
    ARRAY['polyurethane foam', 'flame retardants', 'formaldehyde', 'vinyl', 'phthalates', 'PBDE', 'glues and adhesives'],
    ARRAY['Sealy Posturepedic', 'Simmons Beautyrest', 'Sleep Number', 'Casper Original Mattress']
  ),
  (
    'Natural Mattress',
    'Birch Living',
    'mattress',
    90,
    'Made with natural Talalay latex, organic wool, and organic cotton. GREENGUARD Gold certified for low emissions. No memory foam, no polyurethane, no chemical flame retardants. Birch is a sub-brand of Helix focused entirely on natural materials.',
    ARRAY['GREENGUARD Gold', 'OEKO-TEX', 'Cruelty-Free'],
    ARRAY['Amazon', 'Birch Living Direct', 'West Elm'],
    true,
    ARRAY['polyurethane foam', 'flame retardants', 'formaldehyde', 'phthalates', 'synthetic latex'],
    ARRAY['Tuft & Needle Mint', 'Leesa Original', 'Nectar Memory Foam', 'Zinus Green Tea Mattress']
  ),

  -- ============================================================
  -- FRAGRANCE (3 products)
  -- ============================================================
  (
    'Stone Diffuser with Organic Essential Oils',
    'Vitruvi',
    'fragrance',
    89,
    'Ultrasonic diffuser uses only water and pure essential oils with no synthetic fragrance, no aerosol propellants, and no phthalates. Replaces paraffin candles and plug-in air fresheners that release VOCs and formaldehyde. Essential oils are 100% pure and GC/MS tested.',
    ARRAY['Non-Toxic Certified', 'Cruelty-Free'],
    ARRAY['Amazon', 'Nordstrom', 'Sephora', 'Target'],
    true,
    ARRAY['synthetic fragrance', 'phthalates', 'formaldehyde', 'benzene', 'toluene', 'paraffin wax', 'aerosol propellants'],
    ARRAY['Glade PlugIns', 'Air Wick Scented Oil', 'Febreze Air', 'Bath & Body Works Wallflowers']
  ),
  (
    'Soy Candle (Iowa Pine)',
    'Mrs. Meyer''s Clean Day',
    'fragrance',
    82,
    'Made with soy wax and vegetable-based wax blend instead of paraffin. Cotton wick with no lead core. Uses essential oils for fragrance. Burns cleaner than petroleum-based paraffin candles with less soot and fewer VOCs.',
    ARRAY['Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Grove Collaborative'],
    true,
    ARRAY['paraffin wax', 'lead wicks', 'synthetic fragrance', 'petroleum-based dyes'],
    ARRAY['Yankee Candle', 'Bath & Body Works 3-Wick', 'Glade Candles', 'Febreze Candles']
  ),
  (
    'Soy Candle (Amber & Moss)',
    'P.F. Candle Co.',
    'fragrance',
    86,
    'Hand-poured domestically with 100% soy wax, cotton core wicks, and fine fragrance oils free of phthalates and carcinogens. No paraffin, no lead, no synthetic dyes. Packaged in recyclable amber glass. Vegan and cruelty-free.',
    ARRAY['Cruelty-Free', 'Non-Toxic Certified'],
    ARRAY['Amazon', 'Target', 'Nordstrom', 'West Elm', 'Urban Outfitters'],
    true,
    ARRAY['paraffin wax', 'lead wicks', 'phthalates', 'synthetic dyes', 'petroleum-based wax'],
    ARRAY['Yankee Candle', 'Bath & Body Works 3-Wick', 'WoodWick Candles', 'Voluspa Candles']
  )
;
