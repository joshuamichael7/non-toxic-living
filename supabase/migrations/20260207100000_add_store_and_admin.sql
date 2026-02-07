-- ============================================================================
-- Add store-aware swaps + admin role support
-- ============================================================================

-- Add available_stores to swaps for store-filtered queries
ALTER TABLE public.swaps ADD COLUMN IF NOT EXISTS available_stores TEXT[] DEFAULT '{}';
CREATE INDEX IF NOT EXISTS idx_swaps_available_stores ON public.swaps USING gin(available_stores);

-- Add is_admin to profiles for admin panel access control
ALTER TABLE public.profiles ADD COLUMN IF NOT EXISTS is_admin BOOLEAN DEFAULT false;

-- Admin RLS policies: admins can fully manage ingredients and swaps
CREATE POLICY "Admins can manage swaps" ON public.swaps
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true)
  );

CREATE POLICY "Admins can manage ingredients" ON public.ingredients
  FOR ALL USING (
    EXISTS (SELECT 1 FROM public.profiles WHERE id = auth.uid() AND is_admin = true)
  );

-- Update get_swap_recommendations to accept optional store filter
-- and return available_stores for display
CREATE OR REPLACE FUNCTION get_swap_recommendations(
  product_category TEXT,
  product_embedding vector(1536),
  min_score INTEGER DEFAULT 70,
  match_count INTEGER DEFAULT 5,
  filter_store TEXT DEFAULT NULL
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  brand TEXT,
  score INTEGER,
  price_cents INTEGER,
  affiliate_url TEXT,
  why_better TEXT,
  similarity FLOAT,
  available_stores TEXT[]
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.id,
    s.name,
    s.brand,
    s.score,
    s.price_cents,
    s.affiliate_url,
    s.why_better,
    CASE
      WHEN s.embedding IS NOT NULL AND product_embedding IS NOT NULL
      THEN 1 - (s.embedding <=> product_embedding)
      ELSE 0.5
    END AS similarity,
    s.available_stores
  FROM public.swaps s
  WHERE s.is_active = true
    AND s.category = product_category
    AND s.score >= min_score
    AND (filter_store IS NULL OR filter_store = ANY(s.available_stores))
  ORDER BY
    CASE
      WHEN s.embedding IS NOT NULL AND product_embedding IS NOT NULL
      THEN s.embedding <=> product_embedding
      ELSE 1
    END,
    s.score DESC
  LIMIT match_count;
END;
$$ LANGUAGE plpgsql;
