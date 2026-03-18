-- Track how each swap was added
ALTER TABLE swaps ADD COLUMN IF NOT EXISTS source text DEFAULT 'manual';

-- Enable pg_cron extension (if not already enabled)
CREATE EXTENSION IF NOT EXISTS pg_cron;

-- Run populate-swaps every 6 hours
SELECT cron.schedule(
  'populate-swaps',
  '0 */6 * * *',
  $$
  SELECT net.http_post(
    url    := current_setting('app.supabase_url') || '/functions/v1/populate-swaps',
    headers := jsonb_build_object(
      'Authorization', 'Bearer ' || current_setting('app.service_role_key'),
      'Content-Type',  'application/json'
    ),
    body   := '{}'::jsonb
  )
  $$
);
