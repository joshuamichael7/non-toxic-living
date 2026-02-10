-- Remove caution-rated swaps from active recommendations
-- These products don't meet NonToxicDad's strict safety standards
-- Using is_active = false rather than deleting to preserve data integrity

UPDATE public.swaps SET is_active = false WHERE id = '184ba876-2189-4978-8900-64a39ef566b7'; -- CeraVe Daily Moisturizing Lotion (58)
UPDATE public.swaps SET is_active = false WHERE id = 'eeb229f9-8464-4f0b-84a8-ff9c22592375'; -- Mrs. Meyer's Foaming Hand Soap (52)
UPDATE public.swaps SET is_active = false WHERE id = '13d23523-b871-4c9f-a607-2d62a9b3bb33'; -- Mrs. Meyer's Soy Candle (50)
UPDATE public.swaps SET is_active = false WHERE id = 'e751bf95-46b9-4bd4-b158-52a512865919'; -- Supergoop! Unseen Sunscreen (55)
