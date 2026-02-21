-- Track the full plan ID (e.g., 'pro_monthly', 'power_annual') so the webhook
-- can properly detect upgrades vs downgrades including billing period changes.
ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS subscription_plan TEXT DEFAULT 'free';

-- Update scan quota function to handle both old tier values and new plan IDs
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
  SELECT * INTO user_profile FROM public.profiles WHERE id = user_uuid;

  IF NOT FOUND THEN
    RETURN QUERY SELECT false, 0, 0, NOW();
    RETURN;
  END IF;

  -- Reset monthly count if needed (rolling cycle)
  IF user_profile.scans_month_reset_at < NOW() THEN
    UPDATE public.profiles
    SET scans_this_month = 0,
        scans_month_reset_at = NOW() + INTERVAL '1 month'
    WHERE id = user_uuid;
    user_profile.scans_this_month := 0;
    user_profile.scans_month_reset_at := NOW() + INTERVAL '1 month';
  END IF;

  -- Determine limit based on subscription tier
  -- Handles both old format ('pro') and new format ('pro_monthly')
  scan_limit := CASE
    WHEN user_profile.subscription LIKE 'power%' THEN 500
    WHEN user_profile.subscription LIKE 'pro%' THEN 200
    WHEN user_profile.subscription = 'free' THEN 5
    ELSE 5
  END;

  IF user_profile.scans_this_month >= scan_limit THEN
    RETURN QUERY SELECT false, user_profile.scans_this_month, scan_limit, user_profile.scans_month_reset_at;
    RETURN;
  END IF;

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
