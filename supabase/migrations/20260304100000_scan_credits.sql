-- ============================================================
-- Scan Credit Packs: replace monthly subscription quotas
-- with a persistent credit balance that never expires.
--
-- New users start with 10 free trial credits.
-- Existing users are also seeded with 10 credits.
-- ============================================================

-- 1. Add scan_credits column (DEFAULT 10 fills all existing rows)
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS scan_credits INTEGER NOT NULL DEFAULT 10;

-- 2. Check & decrement credits atomically (called by analyze-ingredients edge function)
CREATE OR REPLACE FUNCTION check_and_decrement_credits(user_uuid UUID)
RETURNS TABLE (allowed BOOLEAN, credits_remaining INTEGER)
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  current_credits INTEGER;
BEGIN
  -- Lock the row to prevent race conditions (concurrent scans)
  SELECT scan_credits INTO current_credits
  FROM public.profiles
  WHERE id = user_uuid
  FOR UPDATE;

  IF NOT FOUND THEN
    RETURN QUERY SELECT false, 0;
    RETURN;
  END IF;

  IF current_credits <= 0 THEN
    RETURN QUERY SELECT false, 0;
    RETURN;
  END IF;

  UPDATE public.profiles
  SET
    scan_credits = scan_credits - 1,
    stats = jsonb_set(
      COALESCE(stats, '{}'::jsonb),
      '{totalScans}',
      to_jsonb((COALESCE(stats->>'totalScans', '0'))::integer + 1)
    )
  WHERE id = user_uuid;

  RETURN QUERY SELECT true, current_credits - 1;
END;
$$;

-- 3. Add credits (called by client as webhook safety-net after purchase)
CREATE OR REPLACE FUNCTION add_scan_credits(user_uuid UUID, amount INTEGER)
RETURNS INTEGER
LANGUAGE plpgsql SECURITY DEFINER AS $$
DECLARE
  new_balance INTEGER;
BEGIN
  UPDATE public.profiles
  SET scan_credits = scan_credits + amount
  WHERE id = user_uuid
  RETURNING scan_credits INTO new_balance;

  RETURN COALESCE(new_balance, 0);
END;
$$;

-- Grant execute to authenticated users
GRANT EXECUTE ON FUNCTION check_and_decrement_credits(UUID) TO authenticated;
GRANT EXECUTE ON FUNCTION add_scan_credits(UUID, INTEGER) TO authenticated;
