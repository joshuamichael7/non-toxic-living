-- Add avoid list columns to products table
-- Admin-controlled list of products users should avoid

ALTER TABLE public.products
  ADD COLUMN IF NOT EXISTS on_avoid_list BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS avoid_reason TEXT;

-- Index for fast queries
CREATE INDEX IF NOT EXISTS idx_products_avoid_list
  ON public.products (on_avoid_list) WHERE on_avoid_list = true;
