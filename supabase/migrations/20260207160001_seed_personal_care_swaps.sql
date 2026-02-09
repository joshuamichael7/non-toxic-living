-- Seed swap products for personal care subcategories
-- Real, well-known non-toxic brands with accurate certifications and availability

-- ============================================================
-- SUNSCREEN (5 products)
-- ============================================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'SPF 50+ Sunscreen',
    'Thinkbaby',
    'sunscreen',
    92,
    'Uses zinc oxide as the sole active ingredient instead of chemical UV filters. Free from biologically harmful chemicals, avobenzone, oxybenzone, and UV chemical absorbers.',
    ARRAY['EWG Verified', 'Cruelty-Free', 'Reef-Safe'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'octocrylene'],
    ARRAY['Banana Boat Ultra Sport', 'Coppertone Sport', 'Neutrogena Ultra Sheer']
  ),
  (
    'Clear Zinc Sunscreen SPF 40',
    'Badger',
    'sunscreen',
    90,
    'Certified organic with non-nano zinc oxide. Simple ingredient list with no synthetic chemicals, fragrances, or GMO ingredients. Biodegradable and reef-safe formula.',
    ARRAY['USDA Organic', 'Non-GMO', 'Cruelty-Free', 'Reef-Safe', 'B Corp'],
    ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'retinyl palmitate', 'fragrance'],
    ARRAY['Hawaiian Tropic Silk Hydration', 'Sun Bum Original', 'Aveeno Protect + Hydrate']
  ),
  (
    'Sensitive Mineral Sunscreen SPF 50+',
    'Blue Lizard',
    'sunscreen',
    88,
    'Mineral-only formula using zinc oxide and titanium dioxide. Recommended by dermatologists for sensitive skin. No chemical UV filters or parabens.',
    ARRAY['Dermatologist Tested', 'Reef-Safe', 'Fragrance-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens'],
    true,
    ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'fragrance', 'parabens'],
    ARRAY['Neutrogena Sensitive Skin', 'Coppertone Pure & Simple', 'La Roche-Posay Anthelios']
  ),
  (
    'Unseen Sunscreen SPF 40',
    'Supergoop!',
    'sunscreen',
    85,
    'Invisible, weightless formula free from oxybenzone and octinoxate. Uses newer-generation chemical filters considered safer than legacy UV absorbers. Vegan and reef-friendly.',
    ARRAY['Cruelty-Free', 'Reef-Safe'],
    ARRAY['Amazon', 'Target', 'Sephora', 'Nordstrom'],
    true,
    ARRAY['oxybenzone', 'octinoxate', 'parabens', 'fragrance'],
    ARRAY['Neutrogena Ultra Sheer Dry-Touch', 'Olay Regenerist Whip SPF', 'Garnier Ombrelle']
  ),
  (
    'Mineral Sunscreen Lotion SPF 30',
    'All Good',
    'sunscreen',
    91,
    'Organic ingredients with non-nano zinc oxide. Made with green tea, rose hip, and buriti oil. No synthetic chemicals, parabens, or petroleum-based ingredients.',
    ARRAY['Cruelty-Free', 'Reef-Safe', 'Non-GMO', 'B Corp'],
    ARRAY['Amazon', 'Whole Foods', 'REI', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['oxybenzone', 'octinoxate', 'octocrylene', 'homosalate', 'parabens'],
    ARRAY['Banana Boat Simply Protect', 'Coppertone Water Babies', 'NO-AD Sport']
  )
;

-- ============================================================
-- SKINCARE (4 products)
-- ============================================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Daily Moisturizing Lotion',
    'CeraVe',
    'skincare',
    84,
    'Developed with dermatologists using three essential ceramides and hyaluronic acid. Free from parabens, sulfates, and synthetic fragrance. Non-comedogenic and suitable for sensitive skin.',
    ARRAY['Dermatologist Tested', 'Fragrance-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens', 'Costco'],
    true,
    ARRAY['parabens', 'synthetic fragrance', 'phthalates', 'formaldehyde releasers', 'mineral oil'],
    ARRAY['Jergens Original Scent', 'Vaseline Intensive Care', 'Nivea Essentially Enriched']
  ),
  (
    'Chlorophyll Mask',
    'Cocokind',
    'skincare',
    89,
    'Made with organic spirulina, chlorophyll, and plant-based ingredients. Free from synthetic dyes, fragrance, parabens, and sulfates. Sustainably packaged and transparently sourced.',
    ARRAY['Cruelty-Free', 'Non-GMO'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Ulta'],
    true,
    ARRAY['synthetic fragrance', 'parabens', 'phthalates', 'synthetic dyes', 'petroleum derivatives'],
    ARRAY['Freeman Feeling Beautiful Clay Mask', 'LOreal Pure Clay Mask', 'Neutrogena Hydro Boost Mask']
  ),
  (
    'Blue Tansy Resurfacing Clarity Mask',
    'Herbivore Botanicals',
    'skincare',
    87,
    'Made with natural blue tansy, white willow bark, and fruit enzymes instead of harsh synthetic acids. Vegan, cruelty-free, and free from synthetic ingredients, parabens, and sulfates.',
    ARRAY['Cruelty-Free', 'EWG Verified'],
    ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Credo Beauty'],
    true,
    ARRAY['synthetic fragrance', 'parabens', 'sulfates', 'phthalates', 'petroleum derivatives', 'synthetic dyes'],
    ARRAY['GlamGlow Supermud', 'Origins Clear Improvement Mask', 'Peter Thomas Roth Mud Mask']
  ),
  (
    'Protini Polypeptide Cream',
    'Drunk Elephant',
    'skincare',
    86,
    'Formulated without the "Suspicious 6" — essential oils, drying alcohols, silicones, chemical sunscreens, fragrances, and SLS. Uses signal peptides and growth factors for anti-aging without harmful additives.',
    ARRAY['Cruelty-Free', 'Fragrance-Free'],
    ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Ulta'],
    true,
    ARRAY['synthetic fragrance', 'parabens', 'SLS', 'silicones', 'phthalates', 'formaldehyde releasers'],
    ARRAY['Olay Regenerist Micro-Sculpting Cream', 'Neutrogena Rapid Wrinkle Repair', 'LOreal Revitalift']
  )
;

-- ============================================================
-- MAKEUP (3 products)
-- ============================================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Super Serum Skin Tint SPF 40',
    'ILIA',
    'makeup',
    88,
    'Combines skincare with clean coverage using mineral SPF, niacinamide, hyaluronic acid, and squalane. Free from synthetic fragrance, parabens, phthalates, talc, and chemical sunscreens.',
    ARRAY['Cruelty-Free', 'EWG Verified', 'Reef-Safe'],
    ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Credo Beauty', 'Ulta'],
    true,
    ARRAY['talc', 'parabens', 'synthetic fragrance', 'phthalates', 'oxybenzone', 'dimethicone', 'formaldehyde releasers'],
    ARRAY['Maybelline Fit Me', 'LOreal True Match', 'Revlon ColorStay', 'IT Cosmetics CC Cream']
  ),
  (
    'Un Cover-Up Cream Foundation',
    'RMS Beauty',
    'makeup',
    90,
    'Made with organic coconut oil, beeswax, and cocoa butter as a base instead of silicones and synthetic polymers. Minimal ingredient list with food-grade organic components. No nano particles or harmful preservatives.',
    ARRAY['Cruelty-Free', 'Non-GMO', 'USDA Organic'],
    ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Credo Beauty', 'Whole Foods'],
    true,
    ARRAY['talc', 'parabens', 'synthetic fragrance', 'dimethicone', 'BHA', 'BHT', 'phthalates'],
    ARRAY['Maybelline Instant Age Rewind Concealer', 'NYX HD Photogenic Concealer', 'LOreal Infallible Full Wear Concealer']
  ),
  (
    'Revealer Skin-Improving Foundation SPF 25',
    'Kosas',
    'makeup',
    86,
    'Clean foundation with active skincare ingredients including peptides, niacinamide, and hyaluronic acid. Free from silicones, parabens, phthalates, talc, and synthetic fragrance. Lightweight and breathable.',
    ARRAY['Cruelty-Free', 'Dermatologist Tested'],
    ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Ulta', 'Credo Beauty'],
    true,
    ARRAY['talc', 'parabens', 'synthetic fragrance', 'dimethicone', 'phthalates', 'formaldehyde releasers', 'mineral oil'],
    ARRAY['Estee Lauder Double Wear', 'MAC Studio Fix Fluid', 'Maybelline SuperStay']
  )
;

-- ============================================================
-- HAIRCARE (4 products)
-- ============================================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  (
    'Dont Despair, Repair! Deep Conditioning Mask',
    'Briogeo',
    'haircare',
    87,
    'Uses rosehip oil, algae, and B-vitamins to repair hair instead of silicones that mask damage. Free from sulfates, silicones, parabens, phthalates, DEA, and artificial dyes.',
    ARRAY['Cruelty-Free', 'B Corp'],
    ARRAY['Amazon', 'Sephora', 'Nordstrom', 'Ulta', 'Target'],
    true,
    ARRAY['sulfates', 'silicones', 'parabens', 'phthalates', 'DEA', 'synthetic fragrance', 'artificial dyes'],
    ARRAY['Pantene Intense Rescue Shots', 'TRESemme Keratin Smooth Shine Serum', 'Garnier Fructis Damage Repairing Treat']
  ),
  (
    'Curiously Clarifying Shampoo',
    'Acure',
    'haircare',
    88,
    'Plant-based formula with lemongrass and argan oil. Gently clarifies without stripping natural oils. Free from sulfates, parabens, mineral oil, petrolatum, formaldehyde, and artificial colors.',
    ARRAY['Cruelty-Free', 'Non-GMO', 'EWG Verified'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market', 'iHerb'],
    true,
    ARRAY['SLS', 'SLES', 'parabens', 'mineral oil', 'petrolatum', 'formaldehyde releasers', 'synthetic fragrance', 'artificial colors'],
    ARRAY['Head & Shoulders Classic Clean', 'Pantene Pro-V Daily Moisture Renewal', 'Dove Daily Moisture Shampoo']
  ),
  (
    'Super Leaves Shampoo - Nourishing & Strengthening',
    'Attitude',
    'haircare',
    91,
    'Uses grape seed oil and olive leaves in a plant- and mineral-based formula verified by EWG. Hypoallergenic and dermatologically tested. Packaged in biodegradable and recyclable materials.',
    ARRAY['EWG Verified', 'Cruelty-Free', 'Non-GMO', 'Dermatologist Tested'],
    ARRAY['Amazon', 'Whole Foods', 'Thrive Market', 'iHerb', 'Walmart'],
    true,
    ARRAY['SLS', 'SLES', 'parabens', 'silicones', 'synthetic fragrance', 'phthalates', 'propylene glycol', 'triclosan'],
    ARRAY['Herbal Essences Bio:Renew', 'Garnier Whole Blends', 'LOreal EverPure']
  ),
  (
    '2chic Ultra-Moist Shampoo',
    'Giovanni',
    'haircare',
    85,
    'Dual-repairing formula with avocado and olive oil that moisturizes without synthetic silicone coating. Free from sulfates, parabens, and artificial coloring. Certified cruelty-free and eco-friendly packaging.',
    ARRAY['Cruelty-Free'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'iHerb', 'Thrive Market'],
    true,
    ARRAY['SLS', 'SLES', 'parabens', 'silicones', 'synthetic fragrance', 'mineral oil', 'artificial dyes'],
    ARRAY['Pantene Smooth & Sleek Shampoo', 'TRESemme Moisture Rich Shampoo', 'Suave Professionals Moroccan Infusion']
  )
;
