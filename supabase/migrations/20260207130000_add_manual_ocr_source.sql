-- Add 'manual' to the allowed ocr_source values for no-label product scans
ALTER TABLE public.scans DROP CONSTRAINT IF EXISTS scans_ocr_source_check;
ALTER TABLE public.scans ADD CONSTRAINT scans_ocr_source_check
  CHECK (ocr_source IN ('device', 'cloud', 'ai-mini', 'ai-vision', 'manual'));
