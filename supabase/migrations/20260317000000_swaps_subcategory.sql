-- Add subcategory column to swaps for more granular swap matching
-- This lets us distinguish e.g. dish_soap vs hand_soap vs laundry_detergent
-- within the broad 'cleaning' category
ALTER TABLE swaps ADD COLUMN IF NOT EXISTS subcategory text;

-- ── Cleaning subcategories ──────────────────────────────────────────────────
UPDATE swaps SET subcategory = 'dish_soap'
  WHERE category IN ('cleaning', 'soap')
    AND (name ILIKE '%dish soap%' OR name ILIKE '%dishwashing liquid%' OR name ILIKE '%dish liquid%' OR name ILIKE '%dish cleaner%');

UPDATE swaps SET subcategory = 'dishwasher_detergent'
  WHERE category = 'cleaning'
    AND (name ILIKE '%dishwasher%');

UPDATE swaps SET subcategory = 'hand_soap'
  WHERE category IN ('cleaning', 'soap', 'personal_care')
    AND (name ILIKE '%hand soap%' OR name ILIKE '%hand wash%' OR name ILIKE '%foaming soap%')
    AND name NOT ILIKE '%dish%';

UPDATE swaps SET subcategory = 'laundry_detergent'
  WHERE category IN ('cleaning', 'laundry')
    AND (name ILIKE '%laundry%' OR name ILIKE '%washing powder%' OR name ILIKE '%washing liquid%');

UPDATE swaps SET subcategory = 'all_purpose_cleaner'
  WHERE category = 'cleaning'
    AND subcategory IS NULL
    AND (name ILIKE '%all-purpose%' OR name ILIKE '%all purpose%' OR name ILIKE '%multi-surface%'
         OR name ILIKE '%multi surface%' OR name ILIKE '%multipurpose%' OR name ILIKE '%everyday cleaner%'
         OR name ILIKE '%concentrate%' OR name ILIKE '%concentrate cleaner%');

UPDATE swaps SET subcategory = 'bathroom_cleaner'
  WHERE category = 'cleaning'
    AND subcategory IS NULL
    AND (name ILIKE '%bathroom%' OR name ILIKE '%tub%' OR name ILIKE '%toilet%' OR name ILIKE '%tile%');

UPDATE swaps SET subcategory = 'floor_cleaner'
  WHERE category = 'cleaning'
    AND subcategory IS NULL
    AND name ILIKE '%floor%';

UPDATE swaps SET subcategory = 'glass_cleaner'
  WHERE category = 'cleaning'
    AND subcategory IS NULL
    AND (name ILIKE '%glass%' OR name ILIKE '%window%');

UPDATE swaps SET subcategory = 'surface_cleaner'
  WHERE category = 'cleaning'
    AND subcategory IS NULL
    AND (name ILIKE '%surface%' OR name ILIKE '%countertop%' OR name ILIKE '%granite%' OR name ILIKE '%stainless%');

UPDATE swaps SET subcategory = 'stain_remover'
  WHERE category = 'cleaning'
    AND subcategory IS NULL
    AND (name ILIKE '%stain%' OR name ILIKE '%odor%' OR name ILIKE '%bac-out%');

-- ── Baby subcategories ──────────────────────────────────────────────────────
UPDATE swaps SET subcategory = 'baby_wipes'
  WHERE category = 'baby'
    AND (name ILIKE '%wipes%' OR name ILIKE '%wipees%');

UPDATE swaps SET subcategory = 'diapers'
  WHERE category = 'baby'
    AND name ILIKE '%diaper%';

UPDATE swaps SET subcategory = 'baby_formula'
  WHERE category IN ('baby', 'baby_food')
    AND (name ILIKE '%formula%' OR name ILIKE '%infant formula%' OR name ILIKE '%toddler formula%');

UPDATE swaps SET subcategory = 'baby_lotion'
  WHERE category = 'baby'
    AND (name ILIKE '%lotion%' OR name ILIKE '%balm%' OR name ILIKE '%butter%' OR name ILIKE '%moisturize%');

UPDATE swaps SET subcategory = 'baby_sunscreen'
  WHERE category = 'baby'
    AND name ILIKE '%sunscreen%';

UPDATE swaps SET subcategory = 'baby_shampoo'
  WHERE category = 'baby'
    AND subcategory IS NULL
    AND (name ILIKE '%shampoo%' OR name ILIKE '%body wash%' OR name ILIKE '%hair%' OR name ILIKE '%wash%');

-- ── Soap subcategories ──────────────────────────────────────────────────────
UPDATE swaps SET subcategory = 'body_wash'
  WHERE category IN ('soap', 'personal_care')
    AND subcategory IS NULL
    AND (name ILIKE '%body wash%' OR name ILIKE '%shower gel%' OR name ILIKE '%body cleanser%');

UPDATE swaps SET subcategory = 'bar_soap'
  WHERE category IN ('soap', 'personal_care')
    AND subcategory IS NULL
    AND (name ILIKE '%bar soap%' OR name ILIKE '%soap bar%');

-- Index for fast subcategory lookups
CREATE INDEX IF NOT EXISTS idx_swaps_subcategory ON swaps (subcategory) WHERE subcategory IS NOT NULL;
