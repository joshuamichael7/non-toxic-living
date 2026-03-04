-- ======================================================
-- Product name enrichment: fix generic names,
-- deactivate exact duplicates, normalize brand names
-- ======================================================
-- Based on web-verified official product names.

-- ── 1. Fix generic / descriptive names ────────────────────────────────────────

-- AquaBliss: "Shower Filter" → official model SF100 name
UPDATE public.swaps
SET name = 'High Output Revitalizing Shower Filter (SF100)'
WHERE brand = 'AquaBliss' AND name = 'Shower Filter';

-- Better Life: official whimsical product names
UPDATE public.swaps
SET name = 'WhatEVER All Purpose Cleaner'
WHERE brand = 'Better Life' AND name = 'All-Purpose Cleaner';

UPDATE public.swaps
SET name = 'Tub & Tile Cleaner'
WHERE brand = 'Better Life' AND name = 'Shower Cleaner';

UPDATE public.swaps
SET name = 'Einshine Stainless Steel Cleaner & Polish'
WHERE brand = 'Better Life' AND name = 'Plant-Based Stainless Steel Cleaner';

-- LifeStraw: official product line name
UPDATE public.swaps
SET name = 'Go Series Water Filter Bottle'
WHERE brand = 'LifeStraw' AND name = 'Filtered Water Bottle';

-- Open Farm: "Natural Cat Food" → specific product line name
UPDATE public.swaps
SET name = 'Homestead Turkey & Chicken Dry Cat Food'
WHERE brand = 'Open Farm' AND name = 'Natural Cat Food';

-- Green Toys: generic "set" → official product name
UPDATE public.swaps
SET name = 'Mini Vehicle Set (4-Pack)'
WHERE brand = 'Green Toys' AND name = 'Recycled Plastic Toy Set';

-- Aura Cacia: official product name
UPDATE public.swaps
SET name = 'Fresh Room Spray'
WHERE brand = 'Aura Cacia' AND name = 'Natural Room Spray';

-- Full Circle: official product name
UPDATE public.swaps
SET name = 'Be Good Bamboo Dish Brush'
WHERE brand = 'Full Circle' AND name = 'Natural Dish Brush';

-- Avocado: "Organic Cotton Pet Bed" → official product name
UPDATE public.swaps
SET name = 'Organic Dog Bed'
WHERE brand = 'Avocado' AND name = 'Organic Cotton Pet Bed';

-- Avocado: "Reclaimed Wood Collection" is a category, not a product
UPDATE public.swaps
SET name = 'Reclaimed Wood Bed Frame'
WHERE brand = 'Avocado' AND name = 'Reclaimed Wood Collection';

-- The Honest Kitchen: "Natural Dog Treats" → specific product
UPDATE public.swaps
SET name = 'Beams Ocean Chews Fish Skin Treats'
WHERE brand = 'The Honest Kitchen' AND name = 'Natural Dog Treats';

-- Four Sigmatic: generic mix → specific "Think" product line name
UPDATE public.swaps
SET name = 'Think Instant Mushroom Coffee with Lion''s Mane'
WHERE brand = 'Four Sigmatic' AND name = 'Organic Mushroom Coffee Mix';

-- Hook & Loom: official product line name
UPDATE public.swaps
SET name = 'Natural Wool Loom-Hooked Rug'
WHERE brand = 'Hook & Loom' AND name = 'Organic Wool Area Rug';

-- ── 2. Brand name normalizations ──────────────────────────────────────────────

-- ATTITUDE is the official brand capitalization (not "Attitude")
UPDATE public.swaps
SET brand = 'ATTITUDE'
WHERE brand = 'Attitude';

-- Normalize Kicking Horse brand name + make name more specific
UPDATE public.swaps
SET brand = 'Kicking Horse Coffee',
    name  = 'Organic Whole Bean Coffee'
WHERE brand = 'Kicking Horse' AND name = 'Organic Coffee';

-- ── 3. Deactivate confirmed exact duplicates ──────────────────────────────────
-- Using known UUIDs from DB query to target specific duplicate rows.

-- gimMe Organic Seaweed Snacks — keep 53e2fcc7, deactivate 93a2ba39
UPDATE public.swaps SET is_active = false
WHERE id = '93a2ba39-469a-4390-9de2-27b83c93df5d';

-- Madhava Organic Coconut Sugar — keep b2ee8e8f, deactivate 9bf01dcf
UPDATE public.swaps SET is_active = false
WHERE id = '9bf01dcf-7a3d-4941-b955-0d80e21b27b0';

-- Aunt Fannie's Vinegar Floor Cleaner — keep 3448cd2a, deactivate dfb02d80
UPDATE public.swaps SET is_active = false
WHERE id = 'dfb02d80-69bf-4a64-a0a2-e188dca7d78d';

-- Annie's Homegrown Organic Yellow Mustard — keep b52cd75a, deactivate 0ca10980
UPDATE public.swaps SET is_active = false
WHERE id = '0ca10980-6cc8-47a4-8a5a-fe4eb88ba664';

-- ── 4. Deactivate near-duplicates (generic vs. specific version) ──────────────

-- Numi Organic Tea (brand "Numi Organic") vs Numi (brand "Numi") — same product
-- Deactivate the "Numi Organic" branded entry
UPDATE public.swaps
SET is_active = false
WHERE brand = 'Numi Organic' AND name = 'Organic Green Tea';

-- GreenPan: "Ceramic Nonstick Frypan" (generic) vs "Valencia Pro" (specific model)
UPDATE public.swaps
SET is_active = false
WHERE brand = 'GreenPan' AND name = 'Ceramic Nonstick Frypan';

-- Berkey: "Countertop Water Filter" (generic) vs "Big Berkey Water Filter System"
UPDATE public.swaps
SET is_active = false
WHERE brand = 'Berkey' AND name = 'Countertop Water Filter';

-- Pyrex: "Glass Food Storage Set" (generic) vs "Simply Store Glass Containers"
UPDATE public.swaps
SET is_active = false
WHERE brand = 'Pyrex' AND name = 'Glass Food Storage Set';

-- RXBAR: "Protein Bar" (singular, generic) vs "Protein Bars" (kept)
UPDATE public.swaps
SET is_active = false
WHERE brand = 'RXBAR' AND name = 'Protein Bar';

-- Fourth & Heart: "Organic Ghee" (generic) vs "Organic Grass-Fed Ghee" (kept)
UPDATE public.swaps
SET is_active = false
WHERE brand = 'Fourth & Heart' AND name = 'Organic Ghee';
