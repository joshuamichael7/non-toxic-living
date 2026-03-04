-- Deactivate the Kicking Horse duplicate created by brand rename
-- Keep a0a16930 (was already "Kicking Horse Coffee"), deactivate 7da6583a (was "Kicking Horse")
UPDATE public.swaps SET is_active = false
WHERE id = '7da6583a-7f3a-42f3-95d3-2f5bffa10679';
