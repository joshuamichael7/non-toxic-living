-- Add new columns for coupon display and redemption flexibility

-- Sort order for controlling display priority (lower = shown first)
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS sort_order INTEGER DEFAULT 100;

-- Redemption type: online, in_store, or both
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS redemption_type TEXT DEFAULT 'online'
  CHECK (redemption_type IN ('online', 'in_store', 'both'));

-- Barcode/QR image URL for in-store redemption
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS barcode_image_url TEXT;

-- Store name for in-store deals
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS store_name TEXT;

-- Index for efficient ordering
CREATE INDEX IF NOT EXISTS idx_coupons_sort_order ON public.coupons(sort_order);

-- RPC function to safely increment impressions (callable by any authenticated user)
CREATE OR REPLACE FUNCTION increment_coupon_impressions(coupon_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE public.coupons
  SET impressions = impressions + 1
  WHERE id = coupon_id
    AND is_active = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- RPC function to safely increment clicks
CREATE OR REPLACE FUNCTION increment_coupon_clicks(coupon_id UUID)
RETURNS void AS $$
BEGIN
  UPDATE public.coupons
  SET clicks = clicks + 1,
      current_redemptions = current_redemptions + 1
  WHERE id = coupon_id
    AND is_active = true;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;
