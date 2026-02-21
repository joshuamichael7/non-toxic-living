-- Track deferred subscription changes (e.g., iOS downgrades that take effect at renewal).
-- pending_subscription: the tier the user is switching to at next renewal
-- pending_subscription_effective_at: when the change takes effect (end of current billing period)

ALTER TABLE public.profiles
  ADD COLUMN IF NOT EXISTS pending_subscription TEXT,
  ADD COLUMN IF NOT EXISTS pending_subscription_effective_at TIMESTAMPTZ;
