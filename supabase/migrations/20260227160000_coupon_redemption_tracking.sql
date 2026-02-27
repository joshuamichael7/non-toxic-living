-- ============================================================
-- Coupon Redemption Tracking & Ibotta Support
-- ============================================================
-- Adds:
--   1. ibotta_url column on coupons
--   2. per_user_limit column on coupons
--   3. Expands redemption_type CHECK to include 'ibotta'
--   4. coupon_redemptions table for per-user tracking
--   5. redeem_coupon RPC with global + per-user limit checks
-- ============================================================

-- 1. Add ibotta_url to coupons
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS ibotta_url TEXT;

COMMENT ON COLUMN public.coupons.ibotta_url IS 'Ibotta or cashback platform deep-link URL';

-- 2. Add per_user_limit to coupons (NULL = unlimited per user)
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS per_user_limit INTEGER DEFAULT NULL;

COMMENT ON COLUMN public.coupons.per_user_limit IS 'Max redemptions per user. NULL = unlimited.';

-- 3. Update redemption_type CHECK constraint to include ibotta
-- Drop old constraint, add new one (both coupons and featured_items)
ALTER TABLE public.coupons
  DROP CONSTRAINT IF EXISTS coupons_redemption_type_check;

ALTER TABLE public.coupons
  ADD CONSTRAINT coupons_redemption_type_check
  CHECK (redemption_type IN ('online', 'in_store', 'both', 'ibotta'));

ALTER TABLE public.featured_items
  DROP CONSTRAINT IF EXISTS featured_items_redemption_type_check;

ALTER TABLE public.featured_items
  ADD CONSTRAINT featured_items_redemption_type_check
  CHECK (redemption_type IN ('online', 'in_store', 'both', 'ibotta'));

-- Also add ibotta_url to featured_items for consistency
ALTER TABLE public.featured_items
  ADD COLUMN IF NOT EXISTS ibotta_url TEXT;

-- 4. Coupon redemptions table (per-user tracking)
CREATE TABLE IF NOT EXISTS public.coupon_redemptions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES public.profiles(id) ON DELETE CASCADE,
  coupon_id UUID NOT NULL REFERENCES public.coupons(id) ON DELETE CASCADE,
  redeemed_at TIMESTAMPTZ DEFAULT NOW(),
  redemption_type TEXT DEFAULT 'click'
    CHECK (redemption_type IN ('click', 'copy_code', 'ibotta', 'in_store'))
);

-- Index for fast lookups
CREATE INDEX IF NOT EXISTS idx_coupon_redemptions_user
  ON public.coupon_redemptions(user_id);
CREATE INDEX IF NOT EXISTS idx_coupon_redemptions_coupon
  ON public.coupon_redemptions(coupon_id);
CREATE UNIQUE INDEX IF NOT EXISTS idx_coupon_redemptions_unique_per_user
  ON public.coupon_redemptions(user_id, coupon_id)
  WHERE redemption_type = 'click';
-- Note: unique index only on 'click' type so users can copy codes multiple times
-- but the redeem_coupon function checks per_user_limit across all types

-- RLS: users can see their own redemptions, admins see all
ALTER TABLE public.coupon_redemptions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Users can view own redemptions"
  ON public.coupon_redemptions FOR SELECT
  USING (auth.uid() = user_id);

CREATE POLICY "Users can insert own redemptions"
  ON public.coupon_redemptions FOR INSERT
  WITH CHECK (auth.uid() = user_id);

CREATE POLICY "Admins can view all redemptions"
  ON public.coupon_redemptions FOR SELECT
  USING (
    EXISTS (
      SELECT 1 FROM public.profiles
      WHERE id = auth.uid() AND admin_role IS NOT NULL
    )
  );

-- 5. RPC: redeem_coupon - checks global + per-user limits, records redemption
CREATE OR REPLACE FUNCTION public.redeem_coupon(
  p_coupon_id UUID,
  p_redemption_type TEXT DEFAULT 'click'
)
RETURNS JSONB
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
DECLARE
  v_user_id UUID;
  v_coupon RECORD;
  v_user_count INTEGER;
BEGIN
  v_user_id := auth.uid();
  IF v_user_id IS NULL THEN
    RETURN jsonb_build_object('success', false, 'error', 'not_authenticated');
  END IF;

  -- Get coupon with lock
  SELECT * INTO v_coupon
    FROM public.coupons
    WHERE id = p_coupon_id
    AND is_active = true
    AND (expires_at IS NULL OR expires_at > NOW())
    AND (starts_at IS NULL OR starts_at <= NOW())
    FOR UPDATE;

  IF NOT FOUND THEN
    RETURN jsonb_build_object('success', false, 'error', 'coupon_not_found');
  END IF;

  -- Check global limit
  IF v_coupon.max_redemptions IS NOT NULL
     AND v_coupon.current_redemptions >= v_coupon.max_redemptions THEN
    RETURN jsonb_build_object('success', false, 'error', 'global_limit_reached');
  END IF;

  -- Check per-user limit
  IF v_coupon.per_user_limit IS NOT NULL THEN
    SELECT COUNT(*) INTO v_user_count
      FROM public.coupon_redemptions
      WHERE user_id = v_user_id
        AND coupon_id = p_coupon_id;

    IF v_user_count >= v_coupon.per_user_limit THEN
      RETURN jsonb_build_object('success', false, 'error', 'user_limit_reached');
    END IF;
  END IF;

  -- Record redemption
  INSERT INTO public.coupon_redemptions (user_id, coupon_id, redemption_type)
    VALUES (v_user_id, p_coupon_id, p_redemption_type);

  -- Increment global counter
  UPDATE public.coupons
    SET current_redemptions = current_redemptions + 1,
        clicks = clicks + 1
    WHERE id = p_coupon_id;

  RETURN jsonb_build_object('success', true);
END;
$$;

-- 6. RPC: check if user has redeemed a coupon (for UI state)
CREATE OR REPLACE FUNCTION public.get_user_coupon_redemptions(
  p_coupon_ids UUID[]
)
RETURNS TABLE(coupon_id UUID, redemption_count BIGINT)
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  RETURN QUERY
    SELECT cr.coupon_id, COUNT(*)::BIGINT AS redemption_count
    FROM public.coupon_redemptions cr
    WHERE cr.user_id = auth.uid()
      AND cr.coupon_id = ANY(p_coupon_ids)
    GROUP BY cr.coupon_id;
END;
$$;
