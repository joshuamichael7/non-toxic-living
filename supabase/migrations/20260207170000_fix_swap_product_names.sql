-- Fix swap product names to use actual product names as they appear on shelves
-- Remove brand name repetition, use real product names not descriptions

-- Clothing: remove brand from product name
UPDATE public.swaps SET name = 'Organic Cotton Essential Tee' WHERE brand = 'Pact' AND name LIKE '%Pact%Essential Tee%';
UPDATE public.swaps SET name = 'Regenerative Organic Stand Up Tee' WHERE brand = 'Patagonia' AND name LIKE '%Patagonia%Organic%Tee%';
UPDATE public.swaps SET name = 'Organic Baby Bodysuit' WHERE brand = 'Burt''s Bees Baby' AND name LIKE '%Burt%Bodysuit%';

-- Cookware: remove brand from product name, use real names
UPDATE public.swaps SET name = 'D3 Stainless Steel Fry Pan' WHERE brand = 'All-Clad' AND name LIKE '%All-Clad%';
UPDATE public.swaps SET name = 'Ceramic Cookware Set' WHERE brand = 'Caraway' AND name LIKE '%Caraway%';
UPDATE public.swaps SET name = '12-Inch Cast Iron Skillet' WHERE brand = 'Lodge' AND name LIKE '%Lodge%';
UPDATE public.swaps SET name = 'Pure Ceramic Skillet' WHERE brand = 'Xtrema' AND name LIKE '%Xtrema%';

-- Storage: remove brand from product name
UPDATE public.swaps SET name = 'Reusable Food Wraps' WHERE brand = 'Bee''s Wrap' AND name LIKE '%Bee%Wrap%Reusable%';
UPDATE public.swaps SET name = 'Simply Store Glass Containers' WHERE brand = 'Pyrex' AND name LIKE '%Pyrex%Simply%';
UPDATE public.swaps SET name = 'Stainless Steel Containers' WHERE brand = 'U-Konserve' AND name LIKE '%U-Konserve%';

-- Paint: remove brand from product name, use actual line names
UPDATE public.swaps SET name = 'Natura Interior Paint' WHERE brand = 'Benjamin Moore' AND name LIKE '%Benjamin Moore%Natura%';
UPDATE public.swaps SET name = 'Zero-Toxin Interior Paint' WHERE brand = 'ECOS Paints' AND name LIKE '%ECOS Interior%';
UPDATE public.swaps SET name = 'Harmony Interior Paint' WHERE brand = 'Sherwin-Williams' AND name LIKE '%Sherwin-Williams%Harmony%';

-- Garden: remove brand from product name
UPDATE public.swaps SET name = 'Organic All-Purpose Fertilizer' WHERE brand = 'Dr. Earth' AND name LIKE '%Dr. Earth%Fertilizer%';
UPDATE public.swaps SET name = 'Pure Organic Neem Oil' WHERE brand = 'Neem Bliss' AND name LIKE '%Neem Bliss%';
UPDATE public.swaps SET name = 'Insecticidal Soap Concentrate' WHERE brand = 'Safer Brand' AND name LIKE '%Safer Brand%';

-- Baby food: shorten to actual product names
UPDATE public.swaps SET name = 'Cold-Pressed Fruit & Veggie Pouches' WHERE brand = 'Once Upon a Farm' AND name LIKE '%Cold-Pressed%';
UPDATE public.swaps SET name = 'Meat & Veggie Pouches' WHERE brand = 'Serenity Kids' AND name LIKE '%Grass Fed%';
UPDATE public.swaps SET name = 'Smart Bar Variety Pack' WHERE brand = 'Cerebelly' AND name LIKE '%Smart Bar%';

-- Beverage: simplify
UPDATE public.swaps SET name = 'Jade Cloud Green Tea' WHERE brand = 'Rishi Tea' AND name LIKE '%Jade Cloud%';
UPDATE public.swaps SET name = 'Gingerade Kombucha' WHERE brand = 'GT''s Living Foods' AND name LIKE '%Gingerade%';
UPDATE public.swaps SET name = 'Vintage Cola' WHERE brand = 'Olipop' AND name LIKE '%Vintage Cola%';

-- Supplement: shorten
UPDATE public.swaps SET name = 'Vitamin Code Multivitamin' WHERE brand = 'Garden of Life' AND name LIKE '%Vitamin Code%';
UPDATE public.swaps SET name = 'Ultimate Omega' WHERE brand = 'Nordic Naturals' AND name LIKE '%Ultimate Omega%';
UPDATE public.swaps SET name = 'Women''s One Daily' WHERE brand = 'MegaFood' AND name LIKE '%Women%One Daily%';

-- Skincare: use actual product names
UPDATE public.swaps SET name = 'Blue Tansy Clarity Mask' WHERE brand = 'Herbivore Botanicals' AND name LIKE '%Blue Tansy%';

-- Haircare: clean up
UPDATE public.swaps SET name = 'Don''t Despair, Repair! Mask' WHERE brand = 'Briogeo' AND name LIKE '%Despair%';
UPDATE public.swaps SET name = 'Super Leaves Shampoo' WHERE brand = 'Attitude' AND name LIKE '%Super Leaves%';

-- Furniture: use real product names
UPDATE public.swaps SET name = 'Reclaimed Wood Collection' WHERE brand = 'Avocado' AND category = 'furniture' AND name LIKE '%Reclaimed%';
UPDATE public.swaps SET name = 'SUNDVIK Crib' WHERE brand = 'IKEA' AND name LIKE '%SUNDVIK%';
UPDATE public.swaps SET name = 'Mid-Century Kids Desk Set' WHERE brand = 'Crate & Kids' AND name LIKE '%Mid-Century%';

-- Mattress: use actual names
UPDATE public.swaps SET name = 'EOS Classic Mattress' WHERE brand = 'Naturepedic' AND name LIKE '%EOS%';

-- Toys: simplify
UPDATE public.swaps SET name = 'Wooden Toy Collection' WHERE brand = 'PlanToys' AND name LIKE '%Sustainable%Wooden%';
UPDATE public.swaps SET name = 'Recycled Plastic Toy Set' WHERE brand = 'Green Toys' AND name LIKE '%100%%Recycled%';
UPDATE public.swaps SET name = 'The Play Kit' WHERE brand = 'Lovevery' AND name LIKE '%Play Kit%';

-- Food: shorten
UPDATE public.swaps SET name = 'Organic Lentil Soup' WHERE brand = 'Amy''s Kitchen' AND name LIKE '%Lentil Soup%';

-- Dairy
UPDATE public.swaps SET name = 'Organic Shredded Cheese' WHERE brand = 'Horizon Organic' AND name LIKE '%Shredded Cheese%';

-- Pet
UPDATE public.swaps SET name = 'Homestead Turkey Dog Food' WHERE brand = 'Open Farm' AND name LIKE '%Homestead%';
UPDATE public.swaps SET name = 'Whole Food Clusters Dog Food' WHERE brand = 'The Honest Kitchen' AND name LIKE '%Whole Food Clusters%';
UPDATE public.swaps SET name = 'Organic Pet Soap' WHERE brand = 'Dr. Bronner''s' AND category = 'pet' AND name LIKE '%Pet Soap%';

-- Snack: simplify
UPDATE public.swaps SET name = 'Organic Popcorn' WHERE brand = 'Lesser Evil' AND name LIKE '%Popcorn%';
UPDATE public.swaps SET name = 'Dark Chocolate Bar' WHERE brand = 'Hu Kitchen' AND name LIKE '%Dark Chocolate%';
UPDATE public.swaps SET name = 'Granola Bars' WHERE brand = 'MadeGood' AND name LIKE '%Granola Bars%';
