-- Seed: Final batch to reach ~500 total swaps
-- Categories: men's grooming, first aid, kids, oral care, feminine care,
-- home textiles, pet care, athletic/outdoor, furniture care, food/snacks

-- ============================================
-- MEN'S GROOMING (7 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Shaving Cream',
  'Dr. Bronner''s',
  'personal_care',
  92,
  'Organic coconut, olive, and hemp oils create a rich lather that protects skin without synthetic fragrance, parabens, sulfates, or propellants. Fair Trade and USDA Organic certified.',
  ARRAY['USDA Organic', 'Fair Trade', 'Vegan'],
  ARRAY['triethanolamine', 'fragrance', 'PEG-150', 'methylparaben', 'propane', 'isobutane'],
  ARRAY['Barbasol', 'Gillette Foamy', 'Edge Shave Gel'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Face Wash for Men',
  'Brickell',
  'personal_care',
  88,
  'Plant-based cleanser with aloe vera, geranium, and green tea extract. No sulfates, parabens, phthalates, synthetic fragrances, or petrochemicals. Dermatologist recommended.',
  ARRAY['Natural', 'Cruelty-Free', 'Made in USA'],
  ARRAY['sodium lauryl sulfate', 'fragrance', 'methylparaben', 'propylparaben', 'DMDM hydantoin'],
  ARRAY['Neutrogena Men', 'Dove Men+Care', 'Nivea Men'],
  ARRAY['Amazon', 'Nordstrom', 'brickellmensproducts.com'],
  true, false
),
(
  'Natural Aftershave Balm',
  'Ursa Major',
  'personal_care',
  90,
  'Birch sap and aloe calm razor burn while witch hazel tones skin. No denatured alcohol, synthetic fragrance, parabens, or artificial dyes. B Corp certified.',
  ARRAY['Vegan', 'Cruelty-Free', 'B Corp'],
  ARRAY['denatured alcohol', 'fragrance', 'propylene glycol', 'FD&C Blue No. 1', 'methylparaben'],
  ARRAY['Nivea Aftershave', 'Old Spice', 'Aqua Velva'],
  ARRAY['Amazon', 'REI', 'Credo Beauty'],
  true, false
),
(
  'Organic Beard Oil',
  'Honest Amish',
  'personal_care',
  91,
  'Cold-pressed virgin argan, avocado, and golden jojoba oils condition and soften facial hair. No mineral oil, synthetic fragrance, dimethicone, or petroleum derivatives. Handmade in small batches.',
  ARRAY['Organic', 'Handmade', 'Vegan'],
  ARRAY['mineral oil', 'fragrance', 'dimethicone', 'isopropyl myristate', 'cyclomethicone'],
  ARRAY['Just For Men Beard Oil', 'Cremo Beard Oil'],
  ARRAY['Amazon', 'honestamish.com'],
  true, false
),
(
  'Natural Hair Pomade',
  'O''Douds',
  'personal_care',
  87,
  'Beeswax, castor oil, and bentonite clay provide medium hold without petrolatum, synthetic polymers, parabens, or artificial fragrance. Water-soluble for easy washout.',
  ARRAY['Natural', 'Cruelty-Free', 'Handmade'],
  ARRAY['petrolatum', 'PVP', 'fragrance', 'BHT', 'PEG-40 hydrogenated castor oil'],
  ARRAY['Suavecito', 'American Crew', 'Axe'],
  ARRAY['Amazon', 'odouds.com'],
  true, false
),
(
  'Organic Body Wash for Men',
  'Every Man Jack',
  'personal_care',
  86,
  'Coconut-derived cleansers with cedarwood essential oil. Free of dyes, parabens, phthalates, DMDM hydantoin, and sodium lauryl sulfate. Certified cruelty-free.',
  ARRAY['Cruelty-Free', 'No Parabens', 'No Phthalates'],
  ARRAY['sodium laureth sulfate', 'fragrance', 'DMDM hydantoin', 'FD&C Yellow No. 5', 'cocamide DEA'],
  ARRAY['Axe Body Wash', 'Old Spice Body Wash', 'Dove Men+Care Body Wash'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true, false
),
(
  'Natural Deodorant for Men',
  'Sam''s Natural',
  'personal_care',
  89,
  'Baking soda-free formula with arrowroot and magnesium hydroxide neutralizes odor. No aluminum, synthetic fragrance, propylene glycol, triclosan, or parabens. Handmade in USA.',
  ARRAY['Vegan', 'Handmade', 'Made in USA'],
  ARRAY['aluminum zirconium', 'fragrance', 'propylene glycol', 'triclosan', 'steareth-100'],
  ARRAY['Old Spice', 'Degree Men', 'Dove Men+Care Deodorant'],
  ARRAY['Amazon', 'samsnatural.com'],
  true, false
);

-- ============================================
-- FIRST AID & MEDICAL (6 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Healing Balm',
  'Badger',
  'personal_care',
  93,
  'USDA Organic olive oil and beeswax soothe minor cuts, scrapes, and dry patches. No petroleum, mineral oil, synthetic preservatives, or fragrance. B Corp certified.',
  ARRAY['USDA Organic', 'B Corp', 'Cruelty-Free'],
  ARRAY['petrolatum', 'mineral oil', 'fragrance', 'methylparaben', 'propylparaben'],
  ARRAY['Neosporin', 'Vaseline', 'Aquaphor'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'REI'],
  true, false
),
(
  'Natural Bamboo Bandages',
  'PATCH',
  'personal_care',
  90,
  'Bamboo fiber bandages enriched with coconut oil or activated charcoal. Compostable, latex-free, hypoallergenic. No plastic backing, chemical adhesives, or BHA preservatives.',
  ARRAY['Compostable', 'Hypoallergenic', 'Vegan'],
  ARRAY['latex', 'polyethylene', 'acrylic adhesive', 'BHA'],
  ARRAY['Band-Aid', 'Curad', 'Nexcare'],
  ARRAY['Amazon', 'Whole Foods', 'patchstrips.com'],
  true, false
),
(
  'Organic Chest Rub',
  'Maty''s',
  'personal_care',
  91,
  'Eucalyptus, peppermint, and tea tree in a beeswax and coconut oil base. USDA Organic certified. No petroleum, synthetic camphor, turpentine oil, or parabens.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Petroleum'],
  ARRAY['petrolatum', 'camphor synthetic', 'turpentine oil', 'cetyl alcohol', 'parabens'],
  ARRAY['Vicks VapoRub', 'store brand vapor rubs'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods'],
  true, false
),
(
  'Organic Cough Syrup',
  'Maty''s',
  'personal_care',
  89,
  'Buckwheat honey with immune-supporting herbs including elderberry, ginger, and turmeric. USDA Organic. No dextromethorphan, high fructose corn syrup, artificial colors, or sodium benzoate.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Artificial Colors'],
  ARRAY['dextromethorphan', 'high fructose corn syrup', 'FD&C Red No. 40', 'sodium benzoate', 'saccharin'],
  ARRAY['Robitussin', 'Delsym', 'NyQuil'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods'],
  true, false
),
(
  'Natural Muscle Rub',
  'Badger',
  'personal_care',
  90,
  'Cayenne and ginger extract in organic extra virgin olive oil base. Eases sore muscles naturally. No methyl salicylate, propylene glycol, synthetic menthol, or parabens.',
  ARRAY['USDA Organic', 'Cruelty-Free', 'Non-GMO'],
  ARRAY['methyl salicylate', 'propylene glycol', 'triethanolamine', 'EDTA', 'parabens'],
  ARRAY['Bengay', 'Icy Hot', 'Biofreeze'],
  ARRAY['Amazon', 'Whole Foods', 'REI', 'Sprouts'],
  true, false
),
(
  'Organic Lip & Skin Balm',
  'Dr. Bronner''s',
  'personal_care',
  92,
  'Organic avocado, jojoba, and hemp seed oils heal dry cracked skin. USDA Organic and Fair Trade certified. No petroleum, mineral oil, synthetic fragrance, or BHT.',
  ARRAY['USDA Organic', 'Fair Trade', 'Vegan'],
  ARRAY['petrolatum', 'mineral oil', 'fragrance', 'BHT', 'oxybenzone'],
  ARRAY['Chapstick', 'Carmex', 'Blistex'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
);

-- ============================================
-- KIDS & TEENS (6 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Kids Natural Shampoo & Body Wash',
  'Pipette',
  'baby',
  91,
  'Plant-derived squalane and glycerin gently cleanse without stripping skin. EWG Verified. No sulfates, parabens, synthetic fragrance, DMDM hydantoin, or phthalates.',
  ARRAY['EWG Verified', 'Dermatologist Tested', 'Hypoallergenic'],
  ARRAY['sodium lauryl sulfate', 'fragrance', 'cocamidopropyl betaine', 'DMDM hydantoin', 'phthalates'],
  ARRAY['Johnson''s Kids', 'Suave Kids', 'L''Oréal Kids'],
  ARRAY['Amazon', 'Target', 'Walmart', 'pipette.com'],
  true, false
),
(
  'Kids Mineral Sunscreen SPF 50',
  'Badger',
  'baby',
  93,
  'Non-nano zinc oxide in organic sunflower and jojoba oil base. USDA Organic, reef-safe, water-resistant 80 min. No oxybenzone, octinoxate, avobenzone, or nanoparticles.',
  ARRAY['USDA Organic', 'Reef Safe', 'Non-Nano Zinc'],
  ARRAY['oxybenzone', 'octinoxate', 'avobenzone', 'homosalate', 'octocrylene'],
  ARRAY['Banana Boat Kids', 'Coppertone Kids', 'Neutrogena Kids'],
  ARRAY['Amazon', 'Whole Foods', 'REI', 'Target'],
  true, false
),
(
  'Kids Fluoride-Free Toothpaste',
  'Hello',
  'oral_care',
  88,
  'Apple-flavored with xylitol and erythritol for natural cavity protection. No SLS, artificial sweeteners, dyes, triclosan, or microbeads. Vegan and cruelty-free.',
  ARRAY['Vegan', 'Cruelty-Free', 'SLS-Free'],
  ARRAY['sodium lauryl sulfate', 'triclosan', 'FD&C Blue No. 1', 'saccharin', 'microbeads'],
  ARRAY['Crest Kids', 'Colgate Kids', 'Tom''s Kids Fluoride'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true, false
),
(
  'Kids Natural Bug Spray',
  'Babyganics',
  'baby',
  87,
  'Citronella, peppermint, and rosemary essential oils repel mosquitoes and ticks. Plant-based and DEET-free. No synthetic chemicals, propellants, or artificial fragrance.',
  ARRAY['Plant-Based', 'DEET-Free', 'Pediatrician Tested'],
  ARRAY['DEET', 'permethrin', 'fragrance', 'propellant', 'piperonyl butoxide'],
  ARRAY['OFF! Kids', 'Cutter', 'Repel'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Buy Buy Baby'],
  true, false
),
(
  'Kids Natural Hand Soap',
  'Puracy',
  'soap',
  90,
  'Plant-based formula with coconut cleansers and citrus essential oils. EWG A-rated, hypoallergenic. No triclosan, sulfates, artificial fragrance, methylisothiazolinone, or dyes.',
  ARRAY['EWG A-Rated', 'Hypoallergenic', 'Vegan'],
  ARRAY['triclosan', 'sodium lauryl sulfate', 'fragrance', 'methylisothiazolinone', 'FD&C dyes'],
  ARRAY['Softsoap', 'Dial', 'Bath & Body Works'],
  ARRAY['Amazon', 'Target', 'puracy.com'],
  true, false
),
(
  'Natural Art Supplies Set',
  'Eco-Kids',
  'baby',
  92,
  'Beeswax crayons colored with mineral pigments, plant-dye finger paints, and fruit/vegetable-based modeling dough. No petroleum wax, lead, phthalates, synthetic dyes, or VOCs.',
  ARRAY['Non-Toxic Certified', 'Plant-Based', 'Made in USA'],
  ARRAY['lead', 'phthalates', 'petroleum wax', 'synthetic dyes', 'VOCs'],
  ARRAY['Crayola', 'Play-Doh', 'standard art supplies'],
  ARRAY['Amazon', 'Whole Foods', 'ecokidsusa.com'],
  true, false
);

-- ============================================
-- ORAL CARE TOOLS (4 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Bamboo Toothbrush',
  'Brush with Bamboo',
  'oral_care',
  90,
  'USDA-certified biobased bamboo handle with plant-based castor bean bristles. Fully compostable. Replaces plastic toothbrushes made from polypropylene and nylon.',
  ARRAY['USDA Biobased', 'Vegan', 'Compostable'],
  ARRAY['polypropylene', 'nylon-6', 'BPA', 'phthalates', 'petroleum-based plastic'],
  ARRAY['Oral-B manual', 'Colgate plastic toothbrush'],
  ARRAY['Amazon', 'Whole Foods', 'brushwithbamboo.com'],
  true, false
),
(
  'Natural Silk Dental Floss',
  'Dental Lace',
  'oral_care',
  89,
  'Pure silk floss coated with candelilla wax in a refillable glass container. No PFAS, PTFE, or petroleum-based nylon. Zero-waste design with compostable refills.',
  ARRAY['Zero Waste', 'PFAS-Free', 'Refillable'],
  ARRAY['PTFE', 'PFAS', 'PFC', 'nylon', 'petroleum-based wax'],
  ARRAY['Oral-B Glide', 'Reach floss', 'GUM floss'],
  ARRAY['Amazon', 'dentallace.com'],
  true, false
),
(
  'Natural Mouthwash',
  'hello',
  'oral_care',
  87,
  'Coconut oil and tea tree oil naturally freshen breath while aloe soothes gums. No alcohol, artificial sweeteners, dyes, cetylpyridinium chloride, or SLS.',
  ARRAY['Vegan', 'SLS-Free', 'Cruelty-Free'],
  ARRAY['cetylpyridinium chloride', 'saccharin', 'FD&C Green No. 3', 'poloxamer 407', 'alcohol'],
  ARRAY['Listerine', 'Scope', 'Crest mouthwash'],
  ARRAY['Amazon', 'Target', 'Walmart', 'CVS'],
  true, false
),
(
  'Plant-Based Floss Picks',
  'The Humble Co.',
  'oral_care',
  86,
  'Cornstarch-based handles with charcoal-infused thread. No PFAS coatings, petroleum-based plastics, or PTFE. Dentist-approved and vegan certified.',
  ARRAY['Vegan', 'BPA-Free', 'Dentist Approved'],
  ARRAY['PTFE', 'polypropylene', 'PFAS', 'BPA', 'petroleum plastic'],
  ARRAY['Plackers', 'DenTek', 'GUM floss picks'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
);

-- ============================================
-- FEMININE CARE (5 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Cotton Tampons',
  'Lola',
  'personal_care',
  91,
  '100% organic cotton with no chlorine bleaching, fragrances, pesticide residues, rayon, or dioxins. BPA-free compact applicator. Customizable subscription.',
  ARRAY['Organic Cotton', 'Hypoallergenic', 'BPA-Free Applicator'],
  ARRAY['rayon', 'chlorine bleach', 'fragrance', 'dioxin', 'pesticide residues', 'polyester'],
  ARRAY['Tampax', 'Playtex Sport', 'Kotex'],
  ARRAY['Amazon', 'mylola.com'],
  true, false
),
(
  'Reusable Menstrual Disc',
  'Cora',
  'personal_care',
  93,
  'Medical-grade silicone lasts up to 10 years, eliminating thousands of disposables. No BPA, latex, phthalates, or chemical leaching. Gynecologist recommended.',
  ARRAY['Medical-Grade Silicone', 'Reusable', 'BPA-Free'],
  ARRAY['rayon', 'chlorine bleach', 'fragrance', 'polyethylene', 'dioxins'],
  ARRAY['disposable discs', 'conventional tampons', 'synthetic pads'],
  ARRAY['Amazon', 'Target', 'cora.life'],
  true, false
),
(
  'Organic Period Underwear',
  'Knix',
  'personal_care',
  88,
  'Organic cotton gusset with PFAS-free leak-proof lining. No antimicrobial chemical treatments, silver nanoparticles, or synthetic fragrance. Machine washable, lasts years.',
  ARRAY['PFAS-Free', 'Organic Cotton', 'Reusable'],
  ARRAY['PFAS', 'triclosan', 'silver nanoparticles', 'synthetic fragrance', 'polyethylene film'],
  ARRAY['Thinx original', 'conventional pads'],
  ARRAY['Amazon', 'knix.com'],
  true, false
),
(
  'Organic Panty Liners',
  'Natracare',
  'personal_care',
  92,
  'Certified organic cotton with totally chlorine-free pulp and compostable bioplastic wrapper. No polyethylene, polypropylene, chlorine bleach, fragrance, or dyes.',
  ARRAY['Organic', 'Compostable', 'Vegan'],
  ARRAY['polyethylene', 'polypropylene', 'chlorine', 'fragrance', 'synthetic super-absorbents'],
  ARRAY['Carefree', 'Always liners', 'Kotex liners'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Natural Feminine Wash',
  'The Honey Pot',
  'personal_care',
  87,
  'Plant-derived cleansers infused with herbs that support natural pH balance. Gynecologist approved. No sulfates, synthetic fragrance, parabens, DMDM hydantoin, or dyes.',
  ARRAY['Plant-Based', 'pH Balanced', 'Gynecologist Approved'],
  ARRAY['sodium lauryl sulfate', 'fragrance', 'methylparaben', 'DMDM hydantoin', 'FD&C dyes'],
  ARRAY['Summer''s Eve', 'Vagisil', 'FDS'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Whole Foods'],
  true, false
);

-- ============================================
-- HOME TEXTILES (5 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Cotton Bath Towels',
  'Coyuchi',
  'home',
  93,
  'GOTS-certified organic cotton, woven without formaldehyde wrinkle-free finishes, flame retardants, synthetic dyes, or PFAS water-repellent coatings. Fair Trade factory.',
  ARRAY['GOTS Organic', 'Fair Trade', 'B Corp'],
  ARRAY['formaldehyde', 'flame retardants', 'synthetic dyes', 'PFAS', 'chlorine bleach'],
  ARRAY['conventional cotton towels', 'Target towels', 'Walmart towels'],
  ARRAY['Amazon', 'coyuchi.com'],
  true, false
),
(
  'Organic Hemp Shower Curtain',
  'Bean Products',
  'home',
  90,
  'Organic hemp and cotton blend is naturally mildew-resistant. Replaces PVC vinyl curtains that off-gas phthalates, lead, and VOCs into your bathroom daily.',
  ARRAY['Organic', 'PFAS-Free', 'Made in USA'],
  ARRAY['PVC', 'phthalates', 'lead', 'VOCs', 'chlorine'],
  ARRAY['vinyl shower curtains', 'PVC curtain liners'],
  ARRAY['Amazon', 'beanproducts.com'],
  true, false
),
(
  'Organic Wool Dryer Balls',
  'Friendsheep',
  'home',
  92,
  'Hand-felted New Zealand wool naturally softens clothes and reduces drying time by 25%. Replaces dryer sheets loaded with quaternary ammonium compounds, fragrance, and chloroform.',
  ARRAY['Organic', 'Fair Trade', 'Handmade'],
  ARRAY['quaternary ammonium compounds', 'fragrance', 'benzyl acetate', 'chloroform', 'alpha-terpineol'],
  ARRAY['Bounce dryer sheets', 'Downy sheets', 'Snuggle sheets'],
  ARRAY['Amazon', 'Target', 'Whole Foods'],
  true, false
),
(
  'Organic Linen Table Napkins',
  'MagicLinen',
  'home',
  89,
  'OEKO-TEX certified European flax linen, no formaldehyde wrinkle-free finish, synthetic dyes, PFAS, or chlorine bleach. Reusable and machine washable.',
  ARRAY['OEKO-TEX', 'Reusable', 'European Linen'],
  ARRAY['formaldehyde', 'synthetic dyes', 'PFAS', 'chlorine bleach', 'polyester'],
  ARRAY['paper napkins', 'polyester napkins'],
  ARRAY['Amazon', 'magiclinen.com'],
  true, false
),
(
  'Organic Wool Area Rug',
  'Hook & Loom',
  'home',
  88,
  'Undyed organic wool with natural latex backing. No VOCs, flame retardants, stain-resistant PFAS chemicals, styrene-butadiene rubber, or formaldehyde adhesives. Handwoven.',
  ARRAY['Organic', 'Non-Toxic', 'Handwoven'],
  ARRAY['formaldehyde', 'PFAS', 'flame retardants', 'styrene-butadiene rubber', 'VOCs'],
  ARRAY['conventional synthetic rugs', 'polypropylene rugs'],
  ARRAY['hookandloom.com'],
  true, false
);

-- ============================================
-- PET CARE (5 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Natural Cat Food',
  'Open Farm',
  'home',
  91,
  'Humanely raised meat as first ingredient with no artificial preservatives, by-product meals, corn, wheat, soy, BHA, BHT, or ethoxyquin. Full ingredient traceability.',
  ARRAY['Certified Humane', 'Non-GMO', 'Sustainably Sourced'],
  ARRAY['BHA', 'BHT', 'ethoxyquin', 'artificial colors', 'by-product meal', 'corn gluten'],
  ARRAY['Meow Mix', 'Friskies', 'Fancy Feast'],
  ARRAY['Amazon', 'Petco', 'Chewy', 'Whole Foods'],
  true, false
),
(
  'Natural Dog Treats',
  'The Honest Kitchen',
  'home',
  90,
  'Human-grade dehydrated treats with single-ingredient recipes. No propylene glycol, BHA, artificial flavors, sodium nitrite, by-products, or fillers.',
  ARRAY['Human Grade', 'Non-GMO', 'Made in USA'],
  ARRAY['propylene glycol', 'BHA', 'artificial flavors', 'sodium nitrite', 'by-product meal'],
  ARRAY['Beggin Strips', 'Milk-Bone', 'Pup-Peroni'],
  ARRAY['Amazon', 'Petco', 'Chewy', 'Whole Foods'],
  true, false
),
(
  'Natural Pet Shampoo',
  'Earthbath',
  'home',
  89,
  'Plant-based oatmeal and aloe formula soothes itchy skin. Biodegradable and cruelty-free. No parabens, sulfates, artificial fragrance, formaldehyde, or phosphates.',
  ARRAY['Cruelty-Free', 'Biodegradable', 'Made in USA'],
  ARRAY['sodium lauryl sulfate', 'fragrance', 'parabens', 'formaldehyde', 'phosphates'],
  ARRAY['Hartz', 'Sentry', 'Adams'],
  ARRAY['Amazon', 'Petco', 'PetSmart', 'Chewy'],
  true, false
),
(
  'Natural Flea & Tick Spray',
  'Wondercide',
  'home',
  87,
  'Cedarwood and lemongrass essential oils repel and kill fleas, ticks, and mosquitoes on contact. No fipronil, imidacloprid, permethrin, pyriproxyfen, or neurotoxic pesticides.',
  ARRAY['Plant-Based', 'Family-Safe', 'Vet Approved'],
  ARRAY['fipronil', 'imidacloprid', 'permethrin', 'pyriproxyfen', 'tetrachlorvinphos'],
  ARRAY['Frontline', 'Advantix', 'Seresto'],
  ARRAY['Amazon', 'Petco', 'Chewy', 'wondercide.com'],
  true, false
),
(
  'Organic Cotton Pet Bed',
  'Avocado',
  'home',
  90,
  'GOTS organic cotton cover with natural latex fill. GREENGUARD Gold certified for low chemical emissions. No polyurethane foam, flame retardants, formaldehyde, or VOCs.',
  ARRAY['GOTS Organic', 'GREENGUARD Gold', 'Handmade in USA'],
  ARRAY['polyurethane foam', 'flame retardants', 'formaldehyde', 'VOCs', 'antimony trioxide'],
  ARRAY['conventional polyester pet beds'],
  ARRAY['Amazon', 'avocadogreenmattress.com'],
  true, false
);

-- ============================================
-- ATHLETIC & OUTDOOR (5 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Cotton Athletic Socks',
  'Pact',
  'home',
  88,
  'GOTS-certified organic cotton with arch support and cushioned sole. No formaldehyde wrinkle-free finishes, antimicrobial triclosan treatments, silver nanoparticles, or PFAS.',
  ARRAY['GOTS Organic', 'Fair Trade', 'B Corp'],
  ARRAY['formaldehyde', 'triclosan', 'silver nanoparticles', 'PFAS', 'synthetic dyes'],
  ARRAY['Nike Dri-FIT', 'Under Armour', 'Hanes'],
  ARRAY['Amazon', 'wearpact.com'],
  true, false
),
(
  'Organic Sports Drink',
  'NOOMA',
  'beverage',
  89,
  'Coconut water electrolytes with organic fruit flavoring. No sucralose, acesulfame potassium, artificial colors, brominated vegetable oil, or preservatives.',
  ARRAY['Organic', 'Non-GMO', 'Vegan'],
  ARRAY['sucralose', 'acesulfame potassium', 'Yellow 6', 'brominated vegetable oil', 'Red 40'],
  ARRAY['Gatorade', 'Powerade', 'Propel'],
  ARRAY['Amazon', 'Whole Foods', 'drinknooma.com'],
  true, false
),
(
  'Organic Plant Protein Powder',
  'Orgain',
  'supplement',
  88,
  'Organic pea, brown rice, and chia seed protein blend. USDA Organic. No sucralose, acesulfame K, soy lecithin, carrageenan, artificial sweeteners, or heavy metals above safe thresholds.',
  ARRAY['USDA Organic', 'Non-GMO', 'Plant-Based'],
  ARRAY['sucralose', 'acesulfame K', 'soy lecithin', 'carrageenan', 'artificial flavors'],
  ARRAY['Optimum Nutrition', 'Premier Protein', 'Muscle Milk'],
  ARRAY['Amazon', 'Costco', 'Target', 'Whole Foods'],
  true, false
),
(
  'Clean Electrolyte Capsules',
  'SaltStick',
  'supplement',
  87,
  'Clean sodium, potassium, magnesium, and calcium electrolyte replacement in vegetable capsule shells. Non-GMO, Informed Sport certified. No artificial colors, titanium dioxide, talc, or magnesium stearate.',
  ARRAY['Non-GMO', 'Informed Sport', 'Gluten-Free'],
  ARRAY['artificial colors', 'magnesium stearate', 'titanium dioxide', 'talc', 'silicon dioxide'],
  ARRAY['Pedialyte capsules', 'salt tablets'],
  ARRAY['Amazon', 'REI', 'saltstick.com'],
  true, false
),
(
  'Natural Rubber Yoga Mat',
  'Scoria',
  'home',
  90,
  'Sustainably harvested natural tree rubber with organic cotton surface. No PVC, phthalates, lead, azodicarbonamide, or toxic foam that off-gasses during use.',
  ARRAY['Organic', 'Non-Toxic', 'Biodegradable'],
  ARRAY['PVC', 'phthalates', 'lead', 'azodicarbonamide', 'EVA foam'],
  ARRAY['Gaiam PVC mats', 'Amazon basics yoga mat'],
  ARRAY['Amazon', 'REI', 'scoriaworld.com'],
  true, false
);

-- ============================================
-- FURNITURE CARE & HOME MAINTENANCE (5 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Natural Beeswax Wood Polish',
  'Howard',
  'cleaning',
  88,
  'Beeswax and orange oil feed and protect wood surfaces. No petroleum distillates, silicone, synthetic fragrance, butane propellant, or formaldehyde.',
  ARRAY['Natural', 'Made in USA', 'No Silicone'],
  ARRAY['petroleum distillates', 'silicone', 'fragrance', 'butane propellant', 'formaldehyde'],
  ARRAY['Pledge', 'Old English', 'Scott''s Liquid Gold'],
  ARRAY['Amazon', 'Ace Hardware', 'howardproducts.com'],
  true, false
),
(
  'Vinegar Floor Cleaner',
  'Aunt Fannie''s',
  'cleaning',
  89,
  'Vinegar-based floor wash with essential oils works on all hard floors. No 2-butoxyethanol, synthetic fragrance, nonylphenol ethoxylate, sodium hypochlorite, or ammonia.',
  ARRAY['Plant-Based', 'EWG A-Rated', 'Non-Toxic'],
  ARRAY['2-butoxyethanol', 'fragrance', 'nonylphenol ethoxylate', 'sodium hypochlorite', 'ammonia'],
  ARRAY['Swiffer WetJet', 'Pine-Sol', 'Bona'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Natural Leather Conditioner',
  'Chamberlain''s',
  'cleaning',
  87,
  'Plant-based oils and beeswax nourish and protect leather. No petroleum distillates, silicone oil, formaldehyde, mineral spirits, or animal-derived tallow.',
  ARRAY['Natural', 'Non-Toxic', 'Made in USA'],
  ARRAY['petroleum distillates', 'silicone oil', 'formaldehyde', 'mineral spirits', 'toluene'],
  ARRAY['Leather Honey', 'Lexol', 'Mink Oil'],
  ARRAY['Amazon', 'chamberlainsleather.com'],
  true, false
),
(
  'Plant-Based Stainless Steel Cleaner',
  'Better Life',
  'cleaning',
  88,
  'Plant-based formula cleans, polishes, and protects stainless steel. EWG A-rated. No ammonia, petroleum distillates, synthetic fragrance, 2-butoxyethanol, or phosphates.',
  ARRAY['EWG A-Rated', 'Plant-Based', 'Cruelty-Free'],
  ARRAY['ammonia', 'petroleum distillates', 'fragrance', '2-butoxyethanol', 'phosphates'],
  ARRAY['Weiman Stainless Cleaner', 'Bar Keepers Friend'],
  ARRAY['Amazon', 'Target', 'cleanhappens.com'],
  true, false
),
(
  'Zero-VOC Wood Finish',
  'Vermont Natural Coatings',
  'home',
  86,
  'Whey protein-based wood finish with near-zero VOCs. No toluene, xylene, formaldehyde, methylene chloride, or isocyanates. Safe for indoor use from day one.',
  ARRAY['Low VOC', 'Bio-Based', 'Made in USA'],
  ARRAY['toluene', 'xylene', 'formaldehyde', 'methylene chloride', 'isocyanates'],
  ARRAY['Minwax Polyurethane', 'Varathane', 'oil-based stains'],
  ARRAY['Amazon', 'vermontnaturalcoatings.com'],
  true, false
);

-- ============================================
-- MORE FOOD & SNACKS (8 products)
-- ============================================
INSERT INTO public.swaps (name, brand, category, score, why_better, badges, replaces_ingredients, replaces_products, available_stores, is_active, featured) VALUES
(
  'Organic Bone Broth',
  'Bonafide Provisions',
  'food',
  91,
  'USDA Organic pasture-raised bones slow-simmered 18+ hours for maximum nutrition. No yeast extract, natural flavors, maltodextrin, caramel color, or added sugar.',
  ARRAY['USDA Organic', 'Pasture-Raised', 'Whole30'],
  ARRAY['yeast extract', 'natural flavors', 'maltodextrin', 'caramel color', 'sugar'],
  ARRAY['Swanson broth', 'College Inn', 'Pacific Foods conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'bonafideprovisions.com'],
  true, false
),
(
  'Organic Dark Chocolate Peanut Butter Cups',
  'Unreal',
  'snack',
  87,
  'Organic fair trade cocoa with organic peanut butter. No PGPR, TBHQ, artificial flavors, high fructose corn syrup, or partially hydrogenated oils.',
  ARRAY['Organic', 'Fair Trade', 'Non-GMO'],
  ARRAY['PGPR', 'TBHQ', 'artificial flavor', 'high fructose corn syrup', 'partially hydrogenated oil'],
  ARRAY['Reese''s', 'store brand peanut butter cups'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Marinara Sauce',
  'Bionaturae',
  'condiment',
  90,
  'Organic Italian tomatoes with organic olive oil. No added sugar, citric acid, calcium chloride, natural flavors, or canola oil. Imported from Italy.',
  ARRAY['USDA Organic', 'Imported from Italy', 'Non-GMO'],
  ARRAY['high fructose corn syrup', 'calcium chloride', 'citric acid', 'natural flavors', 'canola oil'],
  ARRAY['Ragú', 'Prego', 'Bertolli'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts'],
  true, false
),
(
  'Organic Tortilla Chips',
  'Late July',
  'snack',
  86,
  'Organic stone-ground corn cooked in organic sunflower oil. No GMO corn, inflammatory seed oils, BHT, TBHQ, or MSG. Gluten-free certified.',
  ARRAY['USDA Organic', 'Non-GMO', 'Gluten-Free'],
  ARRAY['BHT', 'TBHQ', 'partially hydrogenated oil', 'MSG', 'artificial flavor'],
  ARRAY['Tostitos', 'Mission Chips', 'store brand tortilla chips'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Walmart'],
  true, false
),
(
  'Organic Trail Mix',
  'Made in Nature',
  'snack',
  89,
  'USDA Organic dried fruits and nuts with no sulfur dioxide, BHT, artificial sweeteners, hydrogenated oils, or inflammatory seed oils. No added sugar.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Added Sugar'],
  ARRAY['sulfur dioxide', 'BHT', 'artificial colors', 'hydrogenated oil', 'canola oil'],
  ARRAY['Planters Trail Mix', 'store brand trail mix'],
  ARRAY['Amazon', 'Target', 'Whole Foods', 'Costco'],
  true, false
),
(
  'Organic Apple Sauce Pouches',
  'GoGo squeeZ Organic',
  'food',
  87,
  'USDA Organic fruit puree with nothing else — no added sugar, high fructose corn syrup, artificial colors, sodium benzoate, or potassium sorbate.',
  ARRAY['USDA Organic', 'Non-GMO', 'No Added Sugar'],
  ARRAY['high fructose corn syrup', 'artificial colors', 'sodium benzoate', 'potassium sorbate', 'ascorbic acid filler'],
  ARRAY['Mott''s', 'store brand applesauce pouches'],
  ARRAY['Amazon', 'Target', 'Walmart', 'Costco'],
  true, false
),
(
  'Organic Vegetable Crisps',
  'Rhythm Superfoods',
  'snack',
  88,
  'Air-dried organic kale, beet, and carrot crisps. Real vegetables with no potato starch filler, maltodextrin, artificial flavors, or MSG-derivatives.',
  ARRAY['USDA Organic', 'Non-GMO', 'Vegan'],
  ARRAY['maltodextrin', 'artificial flavor', 'disodium inosinate', 'disodium guanylate', 'MSG'],
  ARRAY['Veggie Straws', 'Terra Chips conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Target', 'Sprouts'],
  true, false
),
(
  'Organic Coconut Yogurt',
  'CocoJune',
  'dairy',
  90,
  'Young coconut meat fermented with live probiotic cultures. No carrageenan, guar gum, artificial sweeteners, potassium sorbate, or added sugar.',
  ARRAY['USDA Organic', 'Non-GMO', 'Paleo'],
  ARRAY['carrageenan', 'guar gum', 'artificial sweeteners', 'potassium sorbate', 'modified food starch'],
  ARRAY['Yoplait', 'Dannon', 'Chobani conventional'],
  ARRAY['Amazon', 'Whole Foods', 'Sprouts', 'cocojune.com'],
  true, false
);
