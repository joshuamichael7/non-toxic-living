-- Add optional foreign keys linking featured items to swaps or products
ALTER TABLE public.featured_items
  ADD COLUMN swap_id UUID REFERENCES public.swaps(id) ON DELETE SET NULL,
  ADD COLUMN product_id UUID REFERENCES public.products(id) ON DELETE SET NULL;

-- Partial indexes for efficient FK lookups
CREATE INDEX idx_featured_items_swap_id ON public.featured_items(swap_id) WHERE swap_id IS NOT NULL;
CREATE INDEX idx_featured_items_product_id ON public.featured_items(product_id) WHERE product_id IS NOT NULL;

-- A featured item links to at most one of swap or product, not both
ALTER TABLE public.featured_items
  ADD CONSTRAINT chk_featured_one_link
  CHECK (NOT (swap_id IS NOT NULL AND product_id IS NOT NULL));
