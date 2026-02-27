-- Batch: Home, Garden, Toys, Clothing, Storage, Pet, Bug Repellent (~40 products)
-- All products are real, verified non-toxic alternatives

-- ============================================
-- TOYS (more options - non-toxic materials)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Rainbow Stacker',
  'Grimm''s',
  'toys',
  94,
  'Hand-crafted in Germany from FSC-certified European wood. Non-toxic water-based stains, no lacquer, no varnish. Open-ended Waldorf-inspired toy that grows with child.',
  ARRAY['FSC Certified', 'Non-Toxic Stains', 'Made in Germany'],
  ARRAY['BPA', 'phthalates', 'lead paint', 'PVC', 'formaldehyde', 'flame retardants'],
  ARRAY['Fisher-Price plastic toys', 'Mega Bloks', 'generic plastic stacking toys'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Wooden Alphabet Blocks',
  'Hape',
  'toys',
  91,
  'Made from sustainably sourced wood with water-based, non-toxic paint. No plastic, no BPA, no phthalates. Meets strictest international safety standards.',
  ARRAY['Non-Toxic Paint', 'FSC Wood', 'Sustainable'],
  ARRAY['BPA', 'phthalates', 'lead paint', 'PVC', 'formaldehyde'],
  ARRAY['Mega Bloks', 'generic plastic blocks'],
  ARRAY['Amazon', 'Target', 'Walmart'],
  true, false
),
(
  'Wooden Play Kitchen',
  'Tender Leaf Toys',
  'toys',
  90,
  'Made from sustainable rubberwood with non-toxic finishes. No plastic components, no BPA, no phthalates. Designed for imaginative play without toxic exposure.',
  ARRAY['Sustainable Wood', 'Non-Toxic Finishes', 'Plastic-Free'],
  ARRAY['BPA', 'phthalates', 'PVC', 'lead paint', 'formaldehyde', 'flame retardants'],
  ARRAY['KidKraft plastic kitchen', 'Step2 plastic kitchen'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Wooden Building Blocks Set',
  'Melissa & Doug',
  'toys',
  88,
  'Solid wood blocks with non-toxic paint. No plastic, no BPA, no small parts for choking. Classic open-ended play at an affordable price. CPSIA compliant.',
  ARRAY['Non-Toxic Paint', 'CPSIA Compliant', 'Solid Wood'],
  ARRAY['BPA', 'phthalates', 'PVC', 'lead paint'],
  ARRAY['Mega Bloks', 'Lego Duplo', 'generic plastic blocks'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Costco'],
  true, false
);

-- ============================================
-- PAINT (more options - zero VOC)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Safecoat Zero VOC Interior Paint',
  'AFM',
  'paint',
  95,
  'Industry gold standard for non-toxic paint. Zero VOC, zero formaldehyde, no ammonia, no crystalline silica. Specifically formulated for chemically sensitive individuals.',
  ARRAY['Zero VOC', 'No Formaldehyde', 'MCS Safe'],
  ARRAY['VOCs', 'formaldehyde', 'ammonia', 'crystalline silica', 'ethylene glycol', 'acetaldehyde'],
  ARRAY['Behr Paint', 'Valspar Paint', 'Glidden Paint'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Baby-Safe Nursery Paint',
  'Lullaby Paints',
  'paint',
  93,
  'Zero VOC, zero toxins paint formulated specifically for nurseries. GREENGUARD Gold certified. No ammonia, no formaldehyde, no APEs. Safe to apply while pregnant.',
  ARRAY['Zero VOC', 'GREENGUARD Gold', 'Baby-Safe'],
  ARRAY['VOCs', 'formaldehyde', 'ammonia', 'ethylene glycol', 'APEs', 'biocides'],
  ARRAY['Behr Paint', 'Valspar Paint'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Zero VOC Interior Wall Paint',
  'Clare',
  'paint',
  91,
  'Zero VOC, GREENGUARD Gold certified interior paint. No formaldehyde, no acetaldehyde, no phthalates. Designer colors with self-priming formula.',
  ARRAY['Zero VOC', 'GREENGUARD Gold', 'Self-Priming'],
  ARRAY['VOCs', 'formaldehyde', 'acetaldehyde', 'phthalates', 'ammonia'],
  ARRAY['Behr Paint', 'Valspar Paint', 'Glidden Paint'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- GARDEN (more options - organic pest/soil)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Plant-Tone All Purpose Fertilizer',
  'Espoma',
  'garden',
  91,
  'OMRI listed organic fertilizer made from natural ingredients. No synthetic chemicals, no sewage sludge, no chemical salts. Contains beneficial microbes for soil health.',
  ARRAY['OMRI Listed', 'Non-GMO', 'Made in USA'],
  ARRAY['synthetic nitrogen', 'phosphate runoff', 'potassium chloride', 'heavy metals', 'sewage sludge'],
  ARRAY['Miracle-Gro', 'Scotts Turf Builder', 'Osmocote'],
  ARRAY['Amazon', 'Home Depot', 'Lowe''s'],
  true, false
),
(
  'Happy Frog Organic Potting Soil',
  'FoxFarm',
  'garden',
  90,
  'OMRI listed organic potting soil with mycorrhizal fungi and beneficial microbes. No synthetic fertilizers, no chemical wetting agents. pH adjusted for optimal growing.',
  ARRAY['OMRI Listed', 'Mycorrhizal', 'pH Adjusted'],
  ARRAY['synthetic fertilizers', 'chemical wetting agents', 'peat moss pesticides', 'synthetic nitrogen'],
  ARRAY['Miracle-Gro Potting Mix', 'Scotts Potting Soil'],
  ARRAY['Amazon', 'Home Depot', 'Lowe''s', 'Direct'],
  true, false
),
(
  'Organic Garden Insect Spray',
  'Monterey',
  'garden',
  88,
  'Spinosad-based organic insecticide derived from soil bacteria. OMRI listed for organic gardening. No synthetic pyrethroids, no neonicotinoids (which harm pollinators).',
  ARRAY['OMRI Listed', 'Pollinator Safe', 'Organic'],
  ARRAY['synthetic pyrethroids', 'neonicotinoids', 'organophosphates', 'carbaryl', 'malathion'],
  ARRAY['Ortho Bug B Gon', 'Spectracide Bug Stop', 'Sevin'],
  ARRAY['Amazon', 'Home Depot', 'Lowe''s'],
  true, false
);

-- ============================================
-- CLOTHING (more options - organic/sustainable)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Cotton Essential Tee',
  'Organic Basics',
  'clothing',
  90,
  'GOTS certified organic cotton. No pesticides in farming, no toxic dyes, no formaldehyde finishes. Fair labor practices certified. Classic fit basics.',
  ARRAY['GOTS Organic', 'Fair Labor', 'Non-Toxic Dyes'],
  ARRAY['formaldehyde', 'PFAS', 'azo dyes', 'NPEs', 'chlorine bleach', 'pesticide residues'],
  ARRAY['Hanes', 'Fruit of the Loom', 'Gildan', 'H&M basics'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Tree Runner Shoes',
  'Allbirds',
  'clothing',
  87,
  'Made from eucalyptus tree fiber (TENCEL) and merino wool. Carbon neutral, no synthetic leather, no PVC. Natural materials reduce microplastic shedding from synthetic fabrics.',
  ARRAY['Carbon Neutral', 'Certified B Corp', 'Natural Materials'],
  ARRAY['PVC', 'synthetic leather chemicals', 'formaldehyde', 'PFAS', 'microplastics'],
  ARRAY['Nike synthetic shoes', 'Adidas synthetic shoes', 'cheap fast fashion shoes'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organic Cotton Hoodie',
  'tentree',
  'clothing',
  88,
  'Organic cotton hoodie — tentree plants 10 trees for every item purchased. GOTS certified, no toxic dyes, no formaldehyde. Ethical manufacturing.',
  ARRAY['GOTS Organic', 'Certified B Corp', 'Climate Positive'],
  ARRAY['formaldehyde', 'PFAS', 'azo dyes', 'NPEs', 'pesticide residues'],
  ARRAY['Champion Hoodie', 'Hanes Hoodie', 'H&M Hoodie'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organic Essential Tee',
  'Mate the Label',
  'clothing',
  89,
  'GOTS certified organic cotton, made in Los Angeles. No toxic dyes, no synthetic finishes, no formaldehyde. Garment-dyed with non-toxic, low-impact dyes.',
  ARRAY['GOTS Organic', 'Made in USA', 'Non-Toxic Dyes'],
  ARRAY['formaldehyde', 'azo dyes', 'NPEs', 'PFAS', 'chlorine bleach'],
  ARRAY['Hanes', 'Fruit of the Loom', 'Zara basics'],
  ARRAY['Amazon', 'Direct'],
  true, false
);

-- ============================================
-- STORAGE (more options - plastic-free)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Stainless Steel Food Container',
  'Life Without Plastic',
  'storage',
  92,
  '18/8 food-grade stainless steel with no plastic lining, no BPA, no coatings. Completely plastic-free including the lid. Dishwasher safe, lasts a lifetime.',
  ARRAY['Plastic-Free', 'BPA-Free', 'Stainless Steel'],
  ARRAY['BPA', 'phthalates', 'PVC', 'microplastics', 'plastic leaching'],
  ARRAY['Glad Containers', 'Ziploc Containers', 'Rubbermaid'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Glass Canning Jars',
  'Weck',
  'storage',
  93,
  'German-made borosilicate glass jars with glass lids (not plastic). No BPA, no plastic touching food, no chemical coatings. Reusable for decades.',
  ARRAY['Glass Lids', 'BPA-Free', 'Made in Germany'],
  ARRAY['BPA', 'phthalates', 'plastic leaching', 'PVC'],
  ARRAY['Ball Mason Jars (plastic lids)', 'Glad Containers', 'Rubbermaid'],
  ARRAY['Amazon', 'Whole Foods', 'Direct'],
  true, false
),
(
  'Porter Glass Lunch Bowl',
  'W&P',
  'storage',
  89,
  'Borosilicate glass bowl with silicone sleeve. No plastic touches food. Microwave safe, dishwasher safe. Silicone snap lid instead of plastic.',
  ARRAY['Borosilicate Glass', 'BPA-Free', 'Silicone Lid'],
  ARRAY['BPA', 'phthalates', 'microplastics', 'plastic leaching'],
  ARRAY['Glad Containers', 'Ziploc Containers', 'Rubbermaid'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
),
(
  'TKWide Insulated Water Bottle',
  'Klean Kanteen',
  'storage',
  91,
  '18/8 food-grade stainless steel with no plastic liner, no BPA, no BPS. Climate Lock vacuum insulation. Electropolished interior — no coatings. Certified B Corp.',
  ARRAY['BPA-Free', 'Stainless Steel', 'Certified B Corp'],
  ARRAY['BPA', 'BPS', 'phthalates', 'microplastics', 'plastic leaching'],
  ARRAY['Nalgene', 'CamelBak', 'generic plastic water bottles'],
  ARRAY['Amazon', 'Target', 'REI', 'Whole Foods'],
  true, false
);

-- ============================================
-- PET CARE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Freeze-Dried Raw Dinner Patties',
  'Stella & Chewy''s',
  'pet',
  90,
  'Minimally processed raw food from cage-free poultry. No hormones, no antibiotics, no grains, no fillers. Added probiotics and organic fruits/vegetables.',
  ARRAY['Non-GMO', 'Cage-Free', 'No Hormones'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'corn gluten meal', 'artificial colors', 'meat by-products', 'propylene glycol'],
  ARRAY['Purina Dog Chow', 'Pedigree', 'Kibbles ''n Bits'],
  ARRAY['Amazon', 'Petco', 'PetSmart', 'Chewy'],
  true, false
),
(
  'Air-Dried Dog Food Beef Recipe',
  'Ziwi Peak',
  'pet',
  91,
  'New Zealand free-range, grass-fed beef. Air-dried (not extruded) to preserve nutrients. No hormones, no antibiotics, no grains, no added glycerin.',
  ARRAY['Free-Range', 'Grass-Fed', 'No Glycerin'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'meat by-products', 'artificial colors', 'propylene glycol', 'corn gluten meal'],
  ARRAY['Purina', 'Pedigree', 'Iams', 'Blue Buffalo'],
  ARRAY['Amazon', 'Chewy', 'Petco'],
  true, false
),
(
  'Precious Cat Ultra Clumping Litter',
  'Dr. Elsey''s',
  'pet',
  87,
  'Natural clay cat litter with no perfumes, no deodorants, no chemicals, no plant proteins (which attract cats to eat it). Hypoallergenic and 99.9% dust-free.',
  ARRAY['Hypoallergenic', 'No Perfumes', 'Dust-Free'],
  ARRAY['synthetic fragrance', 'sodium bentonite chemicals', 'silica dust', 'artificial deodorants'],
  ARRAY['Tidy Cats', 'Fresh Step', 'Arm & Hammer Cat Litter'],
  ARRAY['Amazon', 'Target', 'Petco', 'PetSmart', 'Walmart', 'Chewy'],
  true, false
),
(
  'Grain-Free Canned Dog Food',
  'Weruva',
  'pet',
  88,
  'Human-grade ingredients processed in a human food facility. No grains, no carrageenan, no artificial preservatives. BPA-free cans. Transparent ingredient sourcing.',
  ARRAY['Human-Grade', 'BPA-Free Can', 'No Carrageenan'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'meat by-products', 'carrageenan', 'artificial colors', 'corn gluten meal'],
  ARRAY['Purina Canned Dog Food', 'Pedigree Canned', 'Cesar'],
  ARRAY['Amazon', 'Petco', 'PetSmart', 'Chewy'],
  true, false
);

-- ============================================
-- BUG REPELLENT & OUTDOOR
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Lemon Eucalyptus Oil Insect Repellent',
  'Murphy''s Naturals',
  'household',
  87,
  'DEET-free repellent using oil of lemon eucalyptus (CDC-recommended DEET alternative). No synthetic chemicals, no aerosol propellants. Safe for kids 3+.',
  ARRAY['DEET-Free', 'Plant-Based', 'CDC Recommended'],
  ARRAY['DEET', 'permethrin', 'synthetic pyrethroids', 'aerosol propellants', 'phthalates'],
  ARRAY['OFF! Deep Woods', 'Repel', 'Cutter', 'Raid'],
  ARRAY['Amazon', 'Target', 'REI', 'Whole Foods'],
  true, false
),
(
  'Anti-Bug Balm',
  'Badger',
  'household',
  89,
  'USDA Certified Organic bug repellent. Just organic oils in a beeswax base — citronella, cedar, lemongrass, rosemary. No DEET, no synthetic chemicals whatsoever.',
  ARRAY['USDA Organic', 'DEET-Free', 'Cruelty-Free'],
  ARRAY['DEET', 'permethrin', 'synthetic pyrethroids', 'propylene glycol', 'aerosol propellants'],
  ARRAY['OFF! Deep Woods', 'Repel', 'Cutter'],
  ARRAY['Amazon', 'Target', 'REI', 'Whole Foods'],
  true, false
),
(
  'Picaridin Insect Repellent',
  'Ranger Ready',
  'household',
  86,
  'EPA-registered repellent using picaridin (CDC-recommended DEET alternative). Odorless, non-greasy, won''t damage gear. Effective against ticks and mosquitoes without DEET toxicity.',
  ARRAY['EPA Registered', 'DEET-Free', 'Odorless'],
  ARRAY['DEET', 'permethrin', 'synthetic pyrethroids', 'aerosol propellants'],
  ARRAY['OFF! Deep Woods', 'Repel', 'Sawyer DEET'],
  ARRAY['Amazon', 'REI', 'Direct'],
  true, false
);

-- ============================================
-- MATTRESS & FURNITURE (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Classic Mattress',
  'Saatva',
  'mattress',
  88,
  'CertiPUR-US certified foam, organic cotton cover, no fiberglass fire barrier. No chemical flame retardants — uses natural thistle instead. Free white glove delivery.',
  ARRAY['CertiPUR-US', 'No Fiberglass', 'Organic Cotton Cover'],
  ARRAY['fiberglass', 'chemical flame retardants', 'formaldehyde', 'PBDE', 'isocyanates', 'VOCs'],
  ARRAY['Casper', 'Purple Mattress', 'Nectar Mattress', 'Zinus'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Botanical Bliss Organic Latex Mattress',
  'PlushBeds',
  'mattress',
  92,
  'GOLS certified organic latex, GOTS certified organic cotton and wool. No polyurethane foam, no synthetic latex, no fiberglass, no chemical flame retardants.',
  ARRAY['GOLS Organic Latex', 'GOTS Organic', 'No Fiberglass'],
  ARRAY['polyurethane foam', 'fiberglass', 'chemical flame retardants', 'formaldehyde', 'VOCs', 'isocyanates'],
  ARRAY['Casper', 'Purple Mattress', 'Nectar Mattress', 'Tempur-Pedic'],
  ARRAY['Amazon', 'Direct'],
  true, false
),
(
  'Organic Sofa',
  'Savvy Rest',
  'furniture',
  91,
  'GOTS certified organic fabric, organic latex cushions, FSC hardwood frame. No polyurethane foam, no chemical flame retardants, no synthetic fabrics. Customizable cushion firmness.',
  ARRAY['GOTS Organic', 'FSC Wood', 'No Flame Retardants'],
  ARRAY['polyurethane foam', 'chemical flame retardants', 'PBDE', 'formaldehyde', 'VOCs', 'PFAS'],
  ARRAY['IKEA sofas', 'Wayfair sofas', 'Ashley Furniture sofas'],
  ARRAY['Direct'],
  true, false
);

-- ============================================
-- MORE CLEANING (specialized)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Toilet Bowl Cleaner Plant-Based',
  'ECOS',
  'cleaning',
  87,
  'Plant-powered toilet bowl cleaner with no chlorine bleach, no phosphates, no dyes. Cedar oil scent from essential oils. USDA certified biobased.',
  ARRAY['USDA Biobased', 'No Chlorine', 'Cruelty-Free'],
  ARRAY['chlorine bleach', 'hydrochloric acid', 'synthetic fragrance', 'paradichlorobenzene', 'phthalates'],
  ARRAY['Clorox Toilet Bowl Cleaner', 'Lysol Toilet Bowl Cleaner', 'Scrubbing Bubbles'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Bac-Out Stain & Odor Remover',
  'Biokleen',
  'cleaning',
  89,
  'Uses live enzyme cultures to break down stains and odors naturally. No chlorine, no ammonia, no artificial fragrance, no phosphates. Safe for septic systems.',
  ARRAY['Plant-Based', 'Live Enzymes', 'No Chlorine'],
  ARRAY['chlorine bleach', 'ammonia', 'synthetic fragrance', 'quaternary ammonium', 'phosphates'],
  ARRAY['OxiClean', 'Resolve', 'Shout', 'Clorox Stain Remover'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Thrive Market'],
  true, false
),
(
  'Hand Soap Tablet Starter Set',
  'Blueland',
  'cleaning',
  88,
  'Dissolvable hand soap tablets in a reusable forever bottle. No single-use plastic, no SLS, no parabens, no phthalates. EPA Safer Choice certified.',
  ARRAY['EPA Safer Choice', 'Plastic-Free Refills', 'Certified B Corp'],
  ARRAY['SLS', 'SLES', 'parabens', 'triclosan', 'synthetic fragrance', 'phthalates'],
  ARRAY['Softsoap', 'Dial Hand Soap', 'Bath & Body Works Hand Soap'],
  ARRAY['Amazon', 'Target', 'Direct'],
  true, false
);

-- ============================================
-- FRAGRANCE & AIR (more options)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Move Cordless Essential Oil Diffuser',
  'Vitruvi',
  'fragrance',
  89,
  'Ultrasonic diffuser designed for pure essential oils — no synthetic fragrance, no aerosols, no chemicals. Cordless and portable. Replaces plug-in air fresheners and sprays.',
  ARRAY['No Synthetic Fragrance', 'Cordless', 'BPA-Free'],
  ARRAY['synthetic fragrance', 'phthalates', 'VOCs', 'formaldehyde', 'aerosol propellants', 'benzene'],
  ARRAY['Glade PlugIns', 'Air Wick', 'Febreze Plug', 'Wallflowers'],
  ARRAY['Amazon', 'Nordstrom', 'Direct'],
  true, false
),
(
  'Organic Essential Oil Set',
  'Plant Therapy',
  'fragrance',
  92,
  'USDA Certified Organic essential oils, GC/MS tested for purity. No synthetic additives, no carrier oil dilution, no fragrance oils. Third-party tested batch-by-batch.',
  ARRAY['USDA Organic', 'GC/MS Tested', 'KidSafe Options'],
  ARRAY['synthetic fragrance', 'phthalates', 'diethyl phthalate', 'artificial musks', 'benzene'],
  ARRAY['Glade Scented Oils', 'Air Wick Essential Oils', 'Bath & Body Works'],
  ARRAY['Amazon', 'Direct'],
  true, false
);
