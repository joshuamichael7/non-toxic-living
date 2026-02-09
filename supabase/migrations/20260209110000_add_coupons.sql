-- Add coupons table for brand partnership deals
CREATE TABLE IF NOT EXISTS public.coupons (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  brand_name TEXT NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  coupon_code TEXT NOT NULL,
  discount_type TEXT CHECK (discount_type IN ('percent', 'fixed', 'free_shipping', 'bogo', 'other')),
  discount_value NUMERIC,
  category TEXT NOT NULL,
  product_id UUID REFERENCES public.swaps(id) ON DELETE SET NULL,
  redemption_url TEXT,
  badge_text TEXT DEFAULT 'PARTNER DEAL',
  starts_at TIMESTAMPTZ DEFAULT NOW(),
  expires_at TIMESTAMPTZ,
  max_redemptions INTEGER,
  current_redemptions INTEGER DEFAULT 0,
  is_active BOOLEAN DEFAULT true,
  impressions INTEGER DEFAULT 0,
  clicks INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes
CREATE INDEX IF NOT EXISTS idx_coupons_category ON public.coupons(category);
CREATE INDEX IF NOT EXISTS idx_coupons_active ON public.coupons(is_active) WHERE is_active = true;
CREATE INDEX IF NOT EXISTS idx_coupons_brand ON public.coupons(brand_name);

-- RLS
ALTER TABLE public.coupons ENABLE ROW LEVEL SECURITY;

-- Anyone can read active, non-expired coupons
CREATE POLICY "Active coupons are publicly readable" ON public.coupons
  FOR SELECT USING (
    is_active = true
    AND (expires_at IS NULL OR expires_at > NOW())
    AND (starts_at IS NULL OR starts_at <= NOW())
  );

-- Admins can manage coupons
CREATE POLICY "Admin roles can manage coupons" ON public.coupons
  FOR ALL USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

-- Auto-update updated_at
CREATE TRIGGER coupons_updated_at
  BEFORE UPDATE ON public.coupons
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at();
