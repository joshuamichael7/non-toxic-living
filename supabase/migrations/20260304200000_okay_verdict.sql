-- Add 'okay' as a valid verdict (67-79 score range = moderately safe)
ALTER TABLE public.scans DROP CONSTRAINT IF EXISTS scans_verdict_check;
ALTER TABLE public.scans ADD CONSTRAINT scans_verdict_check
  CHECK (verdict IN ('safe', 'okay', 'caution', 'toxic'));

ALTER TABLE public.products DROP CONSTRAINT IF EXISTS products_verdict_check;
ALTER TABLE public.products ADD CONSTRAINT products_verdict_check
  CHECK (verdict IN ('safe', 'okay', 'caution', 'toxic'));
