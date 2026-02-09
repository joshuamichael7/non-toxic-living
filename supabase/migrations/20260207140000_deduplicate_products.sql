-- Clean up duplicate products: keep the most recently analyzed entry for each name+brand
-- This handles duplicates caused by OCR text variation producing different ingredient hashes

-- Delete older duplicates, keeping the row with the most recent last_analyzed_at
DELETE FROM public.products
WHERE id NOT IN (
  SELECT DISTINCT ON (LOWER(name), LOWER(COALESCE(brand, '')))
    id
  FROM public.products
  ORDER BY LOWER(name), LOWER(COALESCE(brand, '')), last_analyzed_at DESC
);

-- Add a unique index on lowercased name+brand to prevent future duplicates
-- This allows upsert with ON CONFLICT to work without barcode
CREATE UNIQUE INDEX IF NOT EXISTS products_name_brand_unique
  ON public.products (LOWER(name), LOWER(COALESCE(brand, '')))
  WHERE barcode IS NULL;
