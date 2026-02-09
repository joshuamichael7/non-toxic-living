-- Rename 'family' tier to 'power'
-- Update existing rows, CHECK constraint, and quota function

-- 1. Update existing family subscriptions to power
UPDATE public.profiles SET subscription = 'power' WHERE subscription = 'family';

-- 2. Drop and recreate the CHECK constraint
ALTER TABLE public.profiles DROP CONSTRAINT IF EXISTS profiles_subscription_check;
ALTER TABLE public.profiles ADD CONSTRAINT profiles_subscription_check
  CHECK (subscription IN ('free', 'pro', 'power'));

-- 3. Recreate quota function with 'power' instead of 'family'
CREATE OR REPLACE FUNCTION check_and_increment_scan_quota(user_uuid UUID)
RETURNS TABLE (
  allowed BOOLEAN,
  scans_used INTEGER,
  scans_limit INTEGER,
  resets_at TIMESTAMPTZ
) AS $$
DECLARE
  user_profile public.profiles;
  scan_limit INTEGER;
BEGIN
  -- Get user profile
  SELECT * INTO user_profile FROM public.profiles WHERE id = user_uuid;

  IF NOT FOUND THEN
    RETURN QUERY SELECT false, 0, 0, NOW();
    RETURN;
  END IF;

  -- Reset monthly count if needed
  IF user_profile.scans_month_reset_at < NOW() THEN
    UPDATE public.profiles
    SET scans_this_month = 0,
        scans_month_reset_at = DATE_TRUNC('month', NOW()) + INTERVAL '1 month'
    WHERE id = user_uuid;
    user_profile.scans_this_month := 0;
    user_profile.scans_month_reset_at := DATE_TRUNC('month', NOW()) + INTERVAL '1 month';
  END IF;

  -- Determine limit based on subscription
  scan_limit := CASE user_profile.subscription
    WHEN 'free' THEN 5
    WHEN 'pro' THEN 200
    WHEN 'power' THEN 500
    ELSE 5
  END;

  -- Check if under limit
  IF user_profile.scans_this_month >= scan_limit THEN
    RETURN QUERY SELECT false, user_profile.scans_this_month, scan_limit, user_profile.scans_month_reset_at;
    RETURN;
  END IF;

  -- Increment count
  UPDATE public.profiles
  SET scans_this_month = scans_this_month + 1,
      stats = jsonb_set(
        stats,
        '{totalScans}',
        to_jsonb((stats->>'totalScans')::integer + 1)
      )
  WHERE id = user_uuid;

  RETURN QUERY SELECT true, user_profile.scans_this_month + 1, scan_limit, user_profile.scans_month_reset_at;
END;
$$ LANGUAGE plpgsql;
