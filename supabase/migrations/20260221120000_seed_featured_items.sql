-- ============================================================================
-- Seed 10 featured items for the homepage carousel
-- Links to existing swaps across diverse categories
-- Update image_url and action_url with real values via admin panel
-- ============================================================================

-- 1. Cookware - Caraway (popular, photogenic, mainstream appeal)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Non-Toxic Cookware', 'Ditch the Teflon', 'Caraway', 'Ceramic-coated cookware free from PTFE, PFOA, and other toxic chemicals.', 'TOP PICK', 'Learn More', 10, true, id
FROM public.swaps WHERE name = 'Caraway Non-Toxic Ceramic Cookware Set' AND is_active = true LIMIT 1;

-- 2. Sunscreen - Thinkbaby (family-friendly, high trust)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Safe Sunscreen for Kids', 'Reef-safe, mineral-only', 'Thinkbaby', 'Zinc oxide sunscreen rated safest by EWG for 10 years running.', 'FAMILY SAFE', 'Learn More', 20, true, id
FROM public.swaps WHERE name = 'SPF 50+ Sunscreen' AND brand = 'Thinkbaby' AND is_active = true LIMIT 1;

-- 3. Cleaning - Branch Basics (universal appeal, replaces many products)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'One Cleaner for Everything', 'Replace all your toxic cleaners', 'Branch Basics', 'Plant-based concentrate that replaces dozens of cleaning products in your home.', 'EDITOR PICK', 'Learn More', 30, true, id
FROM public.swaps WHERE name = 'All-Purpose Concentrate' AND brand = 'Branch Basics' AND is_active = true LIMIT 1;

-- 4. Baby Food - Serenity Kids (highest-scored swap in the DB)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Clean Baby Food', 'Grass-fed, no fillers', 'Serenity Kids', 'Grass-fed meat and veggie baby food pouches with no added sugars or seed oils.', 'TOP RATED', 'Learn More', 40, true, id
FROM public.swaps WHERE name LIKE '%Serenity Kids%' AND is_active = true LIMIT 1;

-- 5. Deodorant - Each & Every (EWG Verified, great intro to clean swap)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Aluminum-Free Deodorant', 'Only 6 ingredients', 'Each & Every', 'EWG Verified deodorant with Dead Sea salt. No aluminum, baking soda, or synthetic fragrance.', 'EWG VERIFIED', 'Learn More', 50, true, id
FROM public.swaps WHERE name LIKE '%Each & Every%' AND is_active = true LIMIT 1;

-- 6. Mattress - Avocado (flagship non-toxic home product)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Sleep Toxin-Free', 'Organic certified mattress', 'Avocado', 'GOLS and GOTS certified organic mattress with zero off-gassing and no flame retardant chemicals.', 'CERTIFIED', 'Learn More', 60, true, id
FROM public.swaps WHERE name = 'Green Mattress' AND brand = 'Avocado' AND is_active = true LIMIT 1;

-- 7. Oral Care - Dr. Bronner's Toothpaste (trusted brand, everyday product)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Clean Toothpaste', '70% organic ingredients', 'Dr. Bronner''s', 'Organic toothpaste with no SLS, artificial sweeteners, or synthetic preservatives.', 'ORGANIC', 'Learn More', 70, true, id
FROM public.swaps WHERE name LIKE '%Peppermint Toothpaste%' AND brand = 'Dr. Bronner''s' AND is_active = true LIMIT 1;

-- 8. Food - Primal Kitchen Ketchup (common pantry swap, relatable)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Ketchup Without the Junk', 'No high-fructose corn syrup', 'Primal Kitchen', 'USDA Organic ketchup sweetened with balsamic vinegar instead of corn syrup.', 'PANTRY SWAP', 'Learn More', 80, true, id
FROM public.swaps WHERE name LIKE '%Ketchup%' AND brand = 'Primal Kitchen' AND is_active = true LIMIT 1;

-- 9. Laundry - Woolzies Dryer Balls (highest-scored laundry swap, easy switch)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', 'Ditch Dryer Sheets', 'Reusable for 1,000+ loads', 'Woolzies', 'New Zealand wool dryer balls that replace toxic dryer sheets. Naturally softens and reduces static.', 'EASY SWAP', 'Learn More', 90, true, id
FROM public.swaps WHERE name LIKE '%Wool Dryer Balls%' AND is_active = true LIMIT 1;

-- 10. Soap - Dr. Bronner's Castile (iconic, multi-purpose, high score)
INSERT INTO public.featured_items (type, title, subtitle, brand_name, description, badge_text, action_label, sort_order, is_active, swap_id)
SELECT 'product', '18-in-1 Clean Soap', 'Body wash, hand soap & more', 'Dr. Bronner''s', 'Organic castile soap that replaces body wash, hand soap, shampoo, and household cleaners. One bottle, zero toxins.', 'MULTI-USE', 'Learn More', 100, true, id
FROM public.swaps WHERE name = 'Pure-Castile Liquid Soap' AND brand = 'Dr. Bronner''s' AND is_active = true LIMIT 1;
