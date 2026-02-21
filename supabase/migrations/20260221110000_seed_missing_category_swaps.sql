-- ============================================================================
-- Seed swaps for categories that currently have zero coverage:
-- cleaning, laundry, soap, deodorant, oral_care, condiment
-- ============================================================================

-- CLEANING (5 products)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active)
VALUES
(
  'All-Purpose Concentrate',
  'Branch Basics',
  'cleaning',
  93,
  'Plant-based concentrate that dilutes into all-purpose cleaner, bathroom cleaner, streak-free glass cleaner, and more. One bottle replaces multiple toxic cleaners.',
  'Replaces dozens of toxic cleaning products with one safe concentrate. No synthetic fragrances, dyes, or preservatives. Made with plant-derived surfactants and minerals.',
  ARRAY['fragrance-free', 'non-gmo', 'cruelty-free'],
  ARRAY['sodium lauryl sulfate', 'triclosan', 'ammonia', 'chlorine bleach', 'synthetic fragrance', '2-butoxyethanol'],
  ARRAY['Windex', 'Lysol All-Purpose', 'Mr. Clean', 'Clorox Clean-Up', 'Formula 409'],
  ARRAY['Amazon', 'Branch Basics website'],
  true
),
(
  'Free & Clear All-Purpose Cleaner',
  'Seventh Generation',
  'cleaning',
  85,
  'Plant-based all-purpose cleaner with no dyes, synthetic fragrances, or triclosan. EPA Safer Choice certified.',
  'EPA Safer Choice certified with no synthetic fragrances. Uses plant-based cleaning agents instead of petroleum-derived chemicals found in most conventional cleaners.',
  ARRAY['fragrance-free', 'cruelty-free', 'b-corp'],
  ARRAY['synthetic fragrance', 'triclosan', '2-butoxyethanol', 'sodium lauryl sulfate'],
  ARRAY['Lysol All-Purpose', 'Mr. Clean', 'Pine-Sol', 'Formula 409'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Kroger'],
  true
),
(
  'Clean Essentials Kit',
  'Blueland',
  'cleaning',
  90,
  'Reusable Forever Bottles with dissolvable cleaning tablets. Makes all-purpose cleaner, bathroom cleaner, and glass cleaner with zero plastic waste.',
  'Eliminates single-use plastic bottles entirely. Tablets dissolve in water to create effective cleaners without toxic chemicals. No synthetic fragrances or dyes.',
  ARRAY['fragrance-free', 'cruelty-free', 'b-corp'],
  ARRAY['synthetic fragrance', 'ammonia', 'chlorine bleach', 'sodium lauryl sulfate'],
  ARRAY['Windex', 'Lysol', 'Scrubbing Bubbles'],
  ARRAY['Amazon', 'Blueland website', 'Target'],
  true
),
(
  'Dish Soap Free & Clear',
  'ECOS',
  'cleaning',
  87,
  'Hypoallergenic dish soap made with plant-derived ingredients. No synthetic dyes, fragrances, or parabens. USDA Certified Biobased.',
  'Uses plant-derived surfactants instead of petroleum-based ones. Zero synthetic fragrances, dyes, or parabens. Made in a carbon-neutral, water-neutral facility.',
  ARRAY['fragrance-free', 'cruelty-free', 'vegan'],
  ARRAY['synthetic fragrance', 'triclosan', 'sodium lauryl sulfate', 'methylisothiazolinone'],
  ARRAY['Dawn', 'Palmolive', 'Ajax Dish Soap'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart'],
  true
),
(
  'Multi-Surface Everyday Cleaner',
  'Mrs. Meyer''s Clean Day',
  'cleaning',
  82,
  'Plant-derived multi-surface cleaner with essential oil-based scents. Cruelty-free and made with thoughtfully chosen ingredients.',
  'Uses plant-derived cleaning agents and essential oils instead of synthetic fragrances. No parabens, phthalates, or artificial colors. Leaping Bunny certified.',
  ARRAY['cruelty-free'],
  ARRAY['synthetic fragrance', 'ammonia', '2-butoxyethanol'],
  ARRAY['Lysol All-Purpose', 'Clorox Clean-Up'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Kroger'],
  true
);

-- LAUNDRY (5 products)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active)
VALUES
(
  'Free & Clear Laundry Detergent',
  'Seventh Generation',
  'laundry',
  88,
  'Plant-based laundry detergent with no dyes, synthetic fragrances, or optical brighteners. USDA Certified Biobased.',
  'No synthetic fragrances, dyes, or optical brighteners that irritate skin. Plant-based cleaning agents are gentler than petroleum-derived surfactants in conventional detergents.',
  ARRAY['fragrance-free', 'cruelty-free', 'b-corp'],
  ARRAY['synthetic fragrance', 'optical brighteners', '1,4-dioxane', 'sodium lauryl sulfate'],
  ARRAY['Tide', 'Gain', 'All Free Clear', 'Arm & Hammer'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Kroger'],
  true
),
(
  'Original Laundry Powder',
  'Molly''s Suds',
  'laundry',
  91,
  'Only 5 earth-derived ingredients. No synthetic fragrances, optical brighteners, or harsh chemicals. Safe for sensitive skin and HE machines.',
  'Made with just 5 simple ingredients you can actually pronounce. No synthetic fragrances, optical brighteners, dyes, or SLS. Gentle enough for babies and sensitive skin.',
  ARRAY['fragrance-free', 'cruelty-free', 'vegan'],
  ARRAY['synthetic fragrance', 'optical brighteners', '1,4-dioxane', 'sodium lauryl sulfate', 'phosphates'],
  ARRAY['Tide', 'Gain', 'Persil'],
  ARRAY['Amazon', 'Molly''s Suds website', 'Thrive Market'],
  true
),
(
  'Stain & Odor Laundry Detergent Pods',
  'Dropps',
  'laundry',
  89,
  'Pre-measured laundry pods with mineral and plant-based ingredients. Septic-safe, no synthetic fragrances, and zero plastic packaging.',
  'Dissolvable film with no microplastics. Plant and mineral-based formula without synthetic fragrances, dyes, or optical brighteners. Compostable packaging.',
  ARRAY['fragrance-free', 'cruelty-free', 'b-corp', 'vegan'],
  ARRAY['synthetic fragrance', 'optical brighteners', '1,4-dioxane'],
  ARRAY['Tide Pods', 'Gain Flings', 'All Mighty Pacs'],
  ARRAY['Amazon', 'Dropps website'],
  true
),
(
  'Wool Dryer Balls (6-Pack)',
  'Woolzies',
  'laundry',
  94,
  'Reusable New Zealand wool dryer balls that naturally soften clothes, reduce static, and cut drying time by 25%. Replaces dryer sheets for 1,000+ loads.',
  'Replaces toxic dryer sheets entirely. No synthetic fragrances, quaternary ammonium compounds, or chemicals that coat your clothes. Naturally reduces static and softens fabrics.',
  ARRAY['organic', 'cruelty-free', 'fragrance-free'],
  ARRAY['synthetic fragrance', 'quaternary ammonium compounds', 'benzyl acetate', 'chloroform'],
  ARRAY['Bounce Dryer Sheets', 'Downy Dryer Sheets', 'Snuggle Dryer Sheets'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods'],
  true
),
(
  'Oxygen Whitener Pods',
  'Dropps',
  'laundry',
  87,
  'Chlorine-free oxygen whitener pods that brighten whites and remove stains without bleach. Plant and mineral-based formula.',
  'Uses oxygen-based whitening instead of chlorine bleach. No synthetic fragrances, dyes, or optical brighteners. Safe for colors and septic systems.',
  ARRAY['fragrance-free', 'cruelty-free', 'vegan'],
  ARRAY['chlorine bleach', 'optical brighteners', 'synthetic fragrance'],
  ARRAY['Clorox Bleach', 'OxiClean'],
  ARRAY['Amazon', 'Dropps website'],
  true
);

-- SOAP / BODY WASH (5 products)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active)
VALUES
(
  'Pure-Castile Liquid Soap',
  'Dr. Bronner''s',
  'soap',
  93,
  'Organic, fair-trade castile soap made with simple plant oils. 18-in-1 uses including body wash, hand soap, and household cleaning. No synthetic preservatives or foaming agents.',
  'Made with just organic plant oils and no synthetic preservatives, detergents, or foaming agents. Biodegradable and multi-purpose — replaces dozens of products.',
  ARRAY['organic', 'usda-organic', 'cruelty-free', 'vegan', 'b-corp'],
  ARRAY['synthetic fragrance', 'sodium lauryl sulfate', 'parabens', 'triclosan', 'phthalates'],
  ARRAY['Dial Body Wash', 'Dove Body Wash', 'Softsoap', 'Irish Spring'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'Trader Joe''s', 'Kroger'],
  true
),
(
  '3-in-1 Soap Cedar + Citrus',
  'Everyone',
  'soap',
  85,
  'Plant-based body wash, bubble bath, and shampoo in one. EWG Verified with no synthetic fragrances. Uses essential oils and organic botanicals.',
  'EWG Verified for safety. Uses plant-derived cleansers and essential oils instead of synthetic fragrances and sulfates. Gentle enough for the whole family.',
  ARRAY['ewg-verified', 'cruelty-free', 'gluten-free'],
  ARRAY['synthetic fragrance', 'sodium lauryl sulfate', 'parabens', 'phthalates'],
  ARRAY['Dove Body Wash', 'Dial Body Wash', 'Old Spice Body Wash'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true
),
(
  'Everyday Shea Body Wash',
  'Alaffia',
  'soap',
  87,
  'Fair-trade shea butter body wash with unrefined shea butter and neem. Ethically sourced from West African cooperatives.',
  'Made with unrefined fair-trade shea butter and traditional African botanicals. No parabens, sulfates, or synthetic fragrances. Supports women''s cooperatives in West Africa.',
  ARRAY['cruelty-free', 'vegan', 'b-corp'],
  ARRAY['synthetic fragrance', 'sodium lauryl sulfate', 'parabens', 'propylene glycol'],
  ARRAY['Dove Body Wash', 'Olay Body Wash'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true
),
(
  'Moisture Rich Body Wash',
  'Tom''s of Maine',
  'soap',
  83,
  'Naturally derived body wash with no artificial fragrances, colors, or preservatives. Uses natural moisturizers like virgin coconut oil.',
  'Uses naturally derived ingredients and natural fragrances from botanical sources. No artificial colors, fragrances, or preservatives. B Corp certified.',
  ARRAY['cruelty-free', 'b-corp'],
  ARRAY['synthetic fragrance', 'parabens', 'sodium lauryl sulfate', 'propylene glycol'],
  ARRAY['Dove Body Wash', 'Dial Body Wash'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true
),
(
  'Baby Bee Shampoo & Wash',
  'Burt''s Bees',
  'soap',
  88,
  'Tear-free baby wash with soy proteins and no synthetic fragrances, phthalates, or parabens. Pediatrician tested and 98.9% natural.',
  'Pediatrician-tested and 98.9% natural origin. No sulfates, parabens, phthalates, or synthetic fragrances. Tear-free formula safe for sensitive baby skin.',
  ARRAY['cruelty-free', 'pediatrician-recommended', 'fragrance-free'],
  ARRAY['synthetic fragrance', 'sodium lauryl sulfate', 'parabens', 'phthalates', '1,4-dioxane'],
  ARRAY['Johnson''s Baby Shampoo', 'Aveeno Baby Wash'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens'],
  true
);

-- DEODORANT (5 products)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active)
VALUES
(
  'Coconut & Vanilla Deodorant',
  'Native',
  'deodorant',
  86,
  'Aluminum-free deodorant made with simple ingredients like coconut oil, shea butter, and tapioca starch. No parabens, sulfates, or talc.',
  'No aluminum, parabens, sulfates, or talc. Uses tapioca starch and baking soda to absorb wetness naturally. Simple ingredient list you can understand.',
  ARRAY['cruelty-free', 'vegan'],
  ARRAY['aluminum', 'parabens', 'triclosan', 'propylene glycol', 'phthalates', 'synthetic fragrance'],
  ARRAY['Secret', 'Dove Deodorant', 'Degree', 'Old Spice'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true
),
(
  'Vetiver & Orange Peel Natural Deodorant',
  'Each & Every',
  'deodorant',
  90,
  'EWG Verified aluminum-free deodorant with only 6 ingredients. Dead Sea salt-based formula provides effective odor protection without baking soda or aluminum.',
  'EWG Verified with only 6 ingredients. Uses Dead Sea salt instead of aluminum or baking soda. Gentle enough for sensitive skin. No synthetic fragrances.',
  ARRAY['ewg-verified', 'cruelty-free', 'vegan', 'fragrance-free'],
  ARRAY['aluminum', 'parabens', 'triclosan', 'propylene glycol', 'synthetic fragrance'],
  ARRAY['Secret', 'Dove Deodorant', 'Degree'],
  ARRAY['Amazon', 'Each & Every website', 'Target', 'Whole Foods'],
  true
),
(
  'Charcoal + Magnesium Natural Deodorant',
  'Schmidt''s',
  'deodorant',
  85,
  'Plant-based deodorant with activated charcoal and magnesium for odor protection. No aluminum, parabens, or phthalates. Certified vegan and cruelty-free.',
  'Uses activated charcoal and magnesium for natural odor absorption. No aluminum, propylene glycol, parabens, or phthalates. Certified natural by Ecocert.',
  ARRAY['cruelty-free', 'vegan'],
  ARRAY['aluminum', 'parabens', 'propylene glycol', 'triclosan', 'phthalates'],
  ARRAY['Secret', 'Degree', 'Old Spice', 'Dove Deodorant'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods', 'CVS'],
  true
),
(
  'Charcoal Deodorant',
  'Primally Pure',
  'deodorant',
  89,
  'Organic deodorant made with kaolin clay, non-nano zinc oxide, and activated charcoal. No baking soda, aluminum, or synthetic fragrances.',
  'Made with organic ingredients and no baking soda (great for sensitive skin). Uses kaolin clay and charcoal to absorb odor naturally. Small-batch and hand-poured.',
  ARRAY['organic', 'cruelty-free'],
  ARRAY['aluminum', 'parabens', 'synthetic fragrance', 'propylene glycol', 'triclosan'],
  ARRAY['Secret', 'Dove Deodorant', 'Degree'],
  ARRAY['Amazon', 'Primally Pure website', 'Thrive Market'],
  true
),
(
  'Whole Body Deodorant Invisible Cream',
  'Lume',
  'deodorant',
  87,
  'Aluminum-free whole body deodorant clinically proven to control odor for 72 hours. Safe for underarms, private parts, feet, and anywhere you have odor.',
  'Clinically proven 72-hour odor control without aluminum. Can be used anywhere on the body. No baking soda, artificial fragrances, or parabens.',
  ARRAY['cruelty-free', 'vegan'],
  ARRAY['aluminum', 'parabens', 'synthetic fragrance', 'triclosan', 'propylene glycol'],
  ARRAY['Secret Clinical', 'Degree Motion Sense', 'Dove Advanced Care'],
  ARRAY['Amazon', 'Lume website', 'Target', 'Walmart'],
  true
);

-- ORAL CARE (5 products)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active)
VALUES
(
  'Antiplaque & Whitening Fluoride-Free Toothpaste',
  'Tom''s of Maine',
  'oral_care',
  85,
  'Naturally derived fluoride-free toothpaste with zinc citrate for plaque fighting. No artificial colors, flavors, fragrances, or preservatives.',
  'Uses naturally derived ingredients instead of synthetic detergents and artificial sweeteners. No SLS, parabens, or artificial colors. ADA accepted for cavity prevention.',
  ARRAY['cruelty-free', 'b-corp'],
  ARRAY['sodium lauryl sulfate', 'triclosan', 'artificial sweeteners', 'synthetic fragrance', 'parabens'],
  ARRAY['Colgate Total', 'Crest Pro-Health', 'Sensodyne'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens', 'Whole Foods'],
  true
),
(
  'All-One Peppermint Toothpaste',
  'Dr. Bronner''s',
  'oral_care',
  90,
  'Organic toothpaste with 70% organic ingredients. No synthetic detergents, artificial flavors, or preservatives. Uses organic coconut oil and fair-trade peppermint.',
  'Made with 70% organic ingredients including coconut oil. No SLS, fluoride, artificial sweeteners, or synthetic preservatives. Fair-trade and B Corp certified.',
  ARRAY['organic', 'cruelty-free', 'vegan', 'b-corp'],
  ARRAY['sodium lauryl sulfate', 'triclosan', 'artificial sweeteners', 'synthetic fragrance', 'parabens', 'propylene glycol'],
  ARRAY['Colgate', 'Crest', 'Aquafresh'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true
),
(
  'Kids Fluoride-Free Training Toothpaste',
  'Burt''s Bees',
  'oral_care',
  88,
  'Gentle fruit-flavored toothpaste for kids with no fluoride, SLS, parabens, or artificial flavors. Safe if swallowed. Pediatrician recommended.',
  'Safe-to-swallow formula for kids learning to brush. No fluoride, SLS, or artificial flavors. Uses natural fruit flavors and hydrated silica for gentle cleaning.',
  ARRAY['cruelty-free', 'pediatrician-recommended', 'fragrance-free'],
  ARRAY['sodium lauryl sulfate', 'artificial sweeteners', 'synthetic fragrance', 'parabens', 'triclosan'],
  ARRAY['Colgate Kids', 'Crest Kids', 'Tom''s Kids'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens'],
  true
),
(
  'Naturally Whitening Fluoride Toothpaste',
  'Hello',
  'oral_care',
  86,
  'Thoughtfully formulated toothpaste with fluoride for cavity protection. No SLS, artificial sweeteners, dyes, or parabens. Uses tea tree oil and coconut oil.',
  'Fluoride protection without SLS, artificial sweeteners, or dyes. Uses coconut oil and tea tree oil for natural antibacterial properties. Vegan and cruelty-free.',
  ARRAY['cruelty-free', 'vegan'],
  ARRAY['sodium lauryl sulfate', 'triclosan', 'artificial sweeteners', 'parabens', 'synthetic fragrance'],
  ARRAY['Colgate Optic White', 'Crest 3D White'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS', 'Walgreens', 'Whole Foods'],
  true
),
(
  'Botanica Toothpaste',
  'David''s',
  'oral_care',
  89,
  'Premium natural toothpaste in a recyclable metal tube. No SLS, fluoride, or artificial anything. Whitens with natural ingredients like peppermint oil and charcoal.',
  'Comes in a fully recyclable metal tube. No SLS, fluoride, artificial flavors, or sweeteners. Uses premium natural ingredients and is made in the USA.',
  ARRAY['cruelty-free', 'vegan'],
  ARRAY['sodium lauryl sulfate', 'artificial sweeteners', 'synthetic fragrance', 'parabens', 'triclosan', 'propylene glycol'],
  ARRAY['Colgate', 'Crest', 'Sensodyne'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true
);

-- CONDIMENTS (5 products)
INSERT INTO public.swaps (name, brand, category, score, description, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active)
VALUES
(
  'Organic Unsweetened Ketchup',
  'Primal Kitchen',
  'condiment',
  89,
  'USDA Organic ketchup sweetened with balsamic vinegar instead of high-fructose corn syrup. Whole30 Approved and paleo-friendly.',
  'Sweetened with organic balsamic vinegar instead of high-fructose corn syrup or added sugars. USDA Organic with no artificial colors, flavors, or preservatives.',
  ARRAY['organic', 'usda-organic', 'non-gmo', 'gluten-free'],
  ARRAY['high fructose corn syrup', 'artificial colors', 'natural flavors', 'corn syrup'],
  ARRAY['Heinz Ketchup', 'Hunt''s Ketchup', 'French''s Ketchup'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'Thrive Market', 'Kroger'],
  true
),
(
  'Classic Ketchup',
  'Sir Kensington''s',
  'condiment',
  86,
  'Made with Non-GMO tomatoes and sweetened with fair-trade cane sugar. No high-fructose corn syrup, artificial colors, or preservatives.',
  'Uses Non-GMO tomatoes and fair-trade organic cane sugar instead of HFCS. No artificial colors, flavors, or preservatives. Certified B Corp.',
  ARRAY['non-gmo', 'cruelty-free', 'b-corp'],
  ARRAY['high fructose corn syrup', 'artificial colors', 'natural flavors'],
  ARRAY['Heinz Ketchup', 'Hunt''s Ketchup'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger'],
  true
),
(
  'Blue Agave Sriracha',
  'Yellowbird',
  'condiment',
  88,
  'Clean-label hot sauce made with fresh peppers, blue agave, and garlic. No artificial preservatives, colors, or xanthan gum.',
  'Made with real, whole ingredients you can see and pronounce. No artificial preservatives, thickeners, or added sugars beyond blue agave. Non-GMO verified.',
  ARRAY['non-gmo', 'gluten-free', 'vegan'],
  ARRAY['sodium benzoate', 'xanthan gum', 'artificial colors', 'natural flavors'],
  ARRAY['Sriracha', 'Frank''s RedHot', 'Tabasco'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts', 'H-E-B'],
  true
),
(
  'Organic Creamy Ranch',
  'Tessemae''s',
  'condiment',
  87,
  'USDA Organic ranch dressing made with avocado oil. No canola oil, soybean oil, artificial flavors, or preservatives. Whole30 Approved.',
  'Uses organic avocado oil instead of inflammatory seed oils (canola, soybean). No artificial flavors, MSG, or preservatives. Short, clean ingredient list.',
  ARRAY['organic', 'usda-organic', 'gluten-free'],
  ARRAY['canola oil', 'soybean oil', 'monosodium glutamate', 'artificial flavors', 'calcium disodium EDTA', 'natural flavors'],
  ARRAY['Hidden Valley Ranch', 'Kraft Ranch', 'Wish-Bone Ranch'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'Thrive Market'],
  true
),
(
  'Organic Yellow Mustard',
  'Annie''s Homegrown',
  'condiment',
  90,
  'Simple organic yellow mustard with just organic mustard, organic vinegar, salt, organic turmeric, and organic paprika. No artificial anything.',
  'Just 5 simple organic ingredients. No artificial colors, flavors, or preservatives. USDA Organic and Non-GMO Project Verified.',
  ARRAY['organic', 'usda-organic', 'non-gmo', 'gluten-free', 'vegan'],
  ARRAY['artificial colors', 'natural flavors', 'calcium disodium EDTA'],
  ARRAY['French''s Yellow Mustard', 'Heinz Yellow Mustard'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Kroger', 'Sprouts'],
  true
);
