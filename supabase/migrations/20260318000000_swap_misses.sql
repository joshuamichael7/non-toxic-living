-- Tracks subcategories that returned zero swap results during scans.
-- The populate-swaps edge function reads this to know what to auto-populate.
CREATE TABLE IF NOT EXISTS swap_misses (
  subcategory        text PRIMARY KEY,
  category           text,
  example_product    text,        -- e.g. "Mission Organic Whole Wheat Tortillas"
  miss_count         integer NOT NULL DEFAULT 1,
  last_seen_at       timestamptz NOT NULL DEFAULT now(),
  auto_populated_at  timestamptz  -- set when populate-swaps runs for this subcategory
);

-- Upsert a miss: increment count if already exists
CREATE OR REPLACE FUNCTION log_swap_miss(
  p_subcategory   text,
  p_category      text DEFAULT NULL,
  p_product_name  text DEFAULT NULL
) RETURNS void
LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO swap_misses (subcategory, category, example_product, miss_count, last_seen_at)
  VALUES (p_subcategory, p_category, p_product_name, 1, now())
  ON CONFLICT (subcategory) DO UPDATE SET
    miss_count        = swap_misses.miss_count + 1,
    last_seen_at      = now(),
    category          = COALESCE(EXCLUDED.category,        swap_misses.category),
    example_product   = COALESCE(EXCLUDED.example_product, swap_misses.example_product);
END;
$$;

GRANT EXECUTE ON FUNCTION log_swap_miss TO service_role;
