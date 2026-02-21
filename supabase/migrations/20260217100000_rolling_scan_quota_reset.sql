-- Change scan quota from calendar-month reset to rolling per-user cycle.
-- Reset date is now based on signup date (or upgrade date), not the 1st of the month.

-- 1. Update default for new profiles: reset 1 month from signup, not start of next calendar month
ALTER TABLE public.profiles
  ALTER COLUMN scans_month_reset_at SET DEFAULT NOW() + INTERVAL '1 month';

-- 2. Recreate quota function with rolling reset logic
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

  -- Reset monthly count if needed (rolling: next reset is 1 month from now)
  IF user_profile.scans_month_reset_at < NOW() THEN
    UPDATE public.profiles
    SET scans_this_month = 0,
        scans_month_reset_at = NOW() + INTERVAL '1 month'
    WHERE id = user_uuid;
    user_profile.scans_this_month := 0;
    user_profile.scans_month_reset_at := NOW() + INTERVAL '1 month';
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
