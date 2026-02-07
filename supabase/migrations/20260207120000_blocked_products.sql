-- ============================================================================
-- Blocked products: prevent AI from recommending specific products
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.blocked_products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  brand TEXT,
  reason TEXT NOT NULL,
  blocked_by UUID REFERENCES auth.users(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

ALTER TABLE public.blocked_products ENABLE ROW LEVEL SECURITY;

-- Admin roles can manage blocked products
CREATE POLICY "Admin roles can manage blocked_products" ON public.blocked_products
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

-- Anyone can read blocked products (needed by Edge Functions via service role)
CREATE POLICY "Public can read blocked_products" ON public.blocked_products
  FOR SELECT USING (true);

CREATE INDEX idx_blocked_products_name ON public.blocked_products USING btree (lower(name));
