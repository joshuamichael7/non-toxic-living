-- Featured items: flexible table for coupons, affiliate products, sponsored posts
CREATE TABLE public.featured_items (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL DEFAULT 'product'
    CHECK (type IN ('coupon', 'product', 'sponsored')),
  title TEXT NOT NULL,
  subtitle TEXT,
  brand_name TEXT,
  description TEXT,
  image_url TEXT,
  action_url TEXT,
  action_label TEXT,
  coupon_code TEXT,
  discount_text TEXT,
  badge_text TEXT DEFAULT 'FEATURED',
  redemption_type TEXT DEFAULT 'online'
    CHECK (redemption_type IN ('online', 'in_store', 'both')),
  barcode_image_url TEXT,
  store_name TEXT,
  sort_order INTEGER DEFAULT 100,
  starts_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ,
  is_active BOOLEAN DEFAULT true,
  impressions INTEGER DEFAULT 0,
  clicks INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- RLS
ALTER TABLE public.featured_items ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can view active featured items"
  ON public.featured_items FOR SELECT
  USING (
    is_active = true
    AND starts_at <= NOW()
    AND (expires_at IS NULL OR expires_at > NOW())
  );

CREATE POLICY "Admins can manage featured items"
  ON public.featured_items FOR ALL
  USING (
    EXISTS (
      SELECT 1 FROM profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

-- Indexes
CREATE INDEX idx_featured_items_sort ON public.featured_items(sort_order);
CREATE INDEX idx_featured_items_active ON public.featured_items(is_active, starts_at, expires_at);

-- RPC: increment impressions (SECURITY DEFINER so anon users can update counter)
CREATE OR REPLACE FUNCTION increment_featured_impressions(item_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE public.featured_items
  SET impressions = impressions + 1
  WHERE id = item_id AND is_active = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RPC: increment clicks
CREATE OR REPLACE FUNCTION increment_featured_clicks(item_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE public.featured_items
  SET clicks = clicks + 1
  WHERE id = item_id AND is_active = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
