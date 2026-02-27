-- ============================================================
-- Flexible Redemption Types & Per-User Period
-- ============================================================
-- Replaces single redemption_type enum with boolean flags
-- so coupons can support any combination (online + ibotta, etc.)
-- Adds per_user_period for time-windowed per-user limits.
-- ============================================================

-- 1. Add boolean redemption flags to coupons
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS redeemable_online BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS redeemable_in_store BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS redeemable_ibotta BOOLEAN DEFAULT false;

-- 2. Add boolean redemption flags to featured_items
ALTER TABLE public.featured_items
  ADD COLUMN IF NOT EXISTS redeemable_online BOOLEAN DEFAULT true,
  ADD COLUMN IF NOT EXISTS redeemable_in_store BOOLEAN DEFAULT false,
  ADD COLUMN IF NOT EXISTS redeemable_ibotta BOOLEAN DEFAULT false;

-- 3. Migrate existing data from redemption_type to booleans
UPDATE public.coupons SET
  redeemable_online = (redemption_type IN ('online', 'both')),
  redeemable_in_store = (redemption_type IN ('in_store', 'both')),
  redeemable_ibotta = (redemption_type = 'ibotta')
WHERE redemption_type IS NOT NULL;

UPDATE public.featured_items SET
  redeemable_online = (redemption_type IN ('online', 'both')),
  redeemable_in_store = (redemption_type IN ('in_store', 'both')),
  redeemable_ibotta = (redemption_type = 'ibotta')
WHERE redemption_type IS NOT NULL;

-- 4. Add per_user_period to coupons (how often the per_user_limit resets)
ALTER TABLE public.coupons
  ADD COLUMN IF NOT EXISTS per_user_period TEXT DEFAULT 'total'
  CHECK (per_user_period IN ('total', 'daily', 'weekly', 'monthly'));

COMMENT ON COLUMN public.coupons.per_user_period IS
  'How often per_user_limit resets: total (never), daily, weekly, monthly';

-- 5. Update redeem_coupon RPC to respect per_user_period
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
  v_period_start TIMESTAMPTZ;
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

  -- Check per-user limit with period
  IF v_coupon.per_user_limit IS NOT NULL THEN
    -- Determine period start
    CASE COALESCE(v_coupon.per_user_period, 'total')
      WHEN 'daily' THEN
        v_period_start := date_trunc('day', NOW());
      WHEN 'weekly' THEN
        v_period_start := date_trunc('week', NOW());
      WHEN 'monthly' THEN
        v_period_start := date_trunc('month', NOW());
      ELSE
        v_period_start := NULL; -- 'total' = all time
    END CASE;

    IF v_period_start IS NOT NULL THEN
      SELECT COUNT(*) INTO v_user_count
        FROM public.coupon_redemptions
        WHERE user_id = v_user_id
          AND coupon_id = p_coupon_id
          AND redeemed_at >= v_period_start;
    ELSE
      SELECT COUNT(*) INTO v_user_count
        FROM public.coupon_redemptions
        WHERE user_id = v_user_id
          AND coupon_id = p_coupon_id;
    END IF;

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
