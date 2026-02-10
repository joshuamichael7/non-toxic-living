-- =============================================================================
-- Expand curated products database — Round 2
-- Add products for 11 missing categories + expand thin categories
-- Each category has toxic vs clean pairings where possible
-- =============================================================================

-- =============================================================================
-- BABY FOOD (new category — 4 products)
-- =============================================================================
INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

('2nd Foods Banana', 'Gerber', 'baby_food', '015000076702', 68, 'caution',
 'Simple puree with just bananas and added vitamin C. Minimal processing but uses conventional (non-organic) bananas which may have pesticide residue.',
 'Not bad as far as conventional baby food goes — it is just bananas and vitamin C. But for babies I''d spend the extra dollar for organic since their tiny bodies are more vulnerable to pesticide residue.',
 'Bananas, Ascorbic Acid (Vitamin C), Citric Acid',
 'database_seed', 0),

('Organic Stage 2 Apple Kale Oat', 'Happy Baby', 'baby_food', '819573013245', 82, 'safe',
 'USDA Organic baby food with whole fruits, vegetables, and ancient grains. No artificial preservatives, colors, or flavors. BPA-free packaging.',
 'This is what baby food should look like — real organic ingredients you can pronounce. The oats add some nice texture and nutrients for growing babies.',
 'Organic Apples, Organic Kale, Organic Oats, Water, Organic Lemon Juice Concentrate, Ascorbic Acid',
 'database_seed', 0),

('Cold-Pressed Apple Banana', 'Once Upon a Farm', 'baby_food', '860005310425', 92, 'safe',
 'Cold-pressed organic baby food with no preservatives or concentrates. Refrigerated for maximum freshness and nutrition. Never heated during processing.',
 'This is the gold standard. Cold-pressed means the nutrients stay intact, and it is refrigerated like real food should be. Worth every penny for your baby.',
 'Organic Apples, Organic Bananas',
 'database_seed', 0),

('Puffs Cereal Snack Strawberry Apple', 'Gerber', 'baby_food', '015000045364', 48, 'caution',
 'Puffed grain snack marketed for babies but contains added sugar, natural flavors, and multiple processed starches. Dissolves easily but nutritionally weak.',
 'Looks innocent but check the label — modified starches, sugar, and natural flavors for a baby product? There are much cleaner puff options out there.',
 'Rice Flour, Whole Wheat Flour, Sugar, Wheat Starch, Tri-Calcium Phosphate, Strawberry Apple Juice Concentrate, Modified Corn Starch, Soy Lecithin, Natural Flavor, Mixed Tocopherols (Vitamin E), Iron (Electrolytic), Niacinamide, Zinc Sulfate, Vitamin B6, Riboflavin, Thiamin Mononitrate',
 'database_seed', 0),

-- =============================================================================
-- BEVERAGE (expand from 1 to 4)
-- =============================================================================

('Mountain Dew', 'PepsiCo', 'beverage', '012000001536', 10, 'toxic',
 'Loaded with high fructose corn syrup, artificial colors (Yellow 5), brominated vegetable oil (BVO) concerns in the past, and caffeine. One of the worst mainstream sodas.',
 'This is basically liquid candy with artificial dyes. Yellow 5 is linked to hyperactivity in children. 46 grams of sugar in one can. Just don''t.',
 'Carbonated Water, High Fructose Corn Syrup, Concentrated Orange Juice, Citric Acid, Natural Flavor, Sodium Benzoate (Preserves Freshness), Caffeine, Sodium Citrate, Erythorbic Acid (Preserves Freshness), Gum Arabic, Yellow 5, Calcium Disodium EDTA (To Protect Flavor)',
 'database_seed', 0),

('Thirst Quencher Lemon-Lime', 'Gatorade', 'beverage', '052000328653', 32, 'toxic',
 'Sports drink with artificial colors (Yellow 5), sugar, and modified food starch. The electrolytes are helpful but the additives are concerning.',
 'Marketing makes this look healthy but it is sugar water with artificial dyes. Yellow 5 again. If you need electrolytes, add a pinch of salt to water with lemon.',
 'Water, Sugar, Dextrose, Citric Acid, Natural Flavor, Salt, Sodium Citrate, Monopotassium Phosphate, Modified Food Starch, Yellow 5',
 'database_seed', 0),

('Gingerade Kombucha', 'GT''s Living Foods', 'beverage', '722430200125', 86, 'safe',
 'Raw, organic kombucha with real ginger juice. Naturally fermented with living probiotics. No artificial anything. Low sugar from natural fermentation.',
 'This is how a healthy drink should taste — fermented tea with real ginger, full of probiotics. The tiny amount of sugar feeds the SCOBY culture, not your sweet tooth.',
 'Organic Raw Kombucha (Organic Black Tea, Organic Green Tea, Organic Kiwi Juice, 100% Pure Love), Organic Ginger Juice',
 'database_seed', 0),

-- =============================================================================
-- FRAGRANCE (new category — 3 products)
-- =============================================================================

('PlugIns Scented Oil Warmer Clean Linen', 'Glade', 'fragrance', '046500769924', 12, 'toxic',
 'Synthetic air freshener that continuously emits fragrance chemicals including potential phthalates and volatile organic compounds. "Fragrance" can hide hundreds of untested chemicals.',
 'Plug-in air fresheners are one of the worst things you can have in your home. They pump synthetic chemicals into the air 24/7. Your lungs and hormones don''t want this.',
 'Fragrance, Dipropylene Glycol, Benzyl Benzoate, Isopropyl Myristate, Butylated Hydroxytoluene (BHT), Linalool, Hexyl Cinnamal',
 'database_seed', 0),

('Air Effects Air Freshener Original', 'Febreze', 'fragrance', '037000862277', 18, 'toxic',
 'Aerosol air freshener using cyclodextrin to trap odors plus synthetic fragrance. Contains nitrogen as propellant and undisclosed fragrance chemicals.',
 'Febreze doesn''t actually clean the air — it coats odor molecules so you can''t smell them while adding synthetic fragrance on top. You are literally breathing spray chemicals.',
 'Nitrogen, Water, Alcohol, Hydrogenated Castor Oil, Cyclodextrin, Fragrance, Dialkyl Sodium Sulfosuccinate, Citric Acid, Benzisothiazolinone',
 'database_seed', 0),

('Soy Candle Amber & Moss', 'P.F. Candle Co.', 'fragrance', NULL, 82, 'safe',
 'Hand-poured soy wax candle with cotton wick and fine fragrance oils. Burns cleaner than paraffin with no lead, phthalates, or paraffin wax.',
 'Soy wax burns much cleaner than the paraffin in cheap candles. Cotton wicks eliminate lead exposure. Not perfect since it still has fragrance oils, but miles ahead of Glade or Febreze.',
 'Domestically Grown Soy Wax, Cotton Wick, Fine Fragrance Oils (Phthalate-Free)',
 'database_seed', 0),

-- =============================================================================
-- GARDEN (new category — 3 products)
-- =============================================================================

('Weed & Grass Killer Super Concentrate', 'Roundup', 'garden', '070183510108', 5, 'toxic',
 'Contains glyphosate, classified as a probable carcinogen by the WHO. Linked to cancer, endocrine disruption, and environmental damage. Extremely persistent in soil.',
 'Glyphosate is the most controversial pesticide on the planet. The WHO says it probably causes cancer. Bayer has paid billions in lawsuits. Keep this away from your family and pets.',
 'Glyphosate Isopropylamine Salt 50.2%, Other Ingredients 49.8%',
 'database_seed', 0),

('Home Defense Insect Killer for Indoor & Perimeter', 'Ortho', 'garden', '071549063214', 15, 'toxic',
 'Contains bifenthrin, a synthetic pyrethroid insecticide. Toxic to aquatic life and beneficial insects like bees. Potential endocrine disruptor with persistent residue.',
 'This stuff kills bugs — and is also toxic to your pets, your kids, the bees, and aquatic life. The residue stays active for months. There are so many better ways to handle pests.',
 'Bifenthrin 0.05%, Other Ingredients 99.95%',
 'database_seed', 0),

('Insecticidal Soap Concentrate', 'Safer Brand', 'garden', '024654320109', 82, 'safe',
 'OMRI Listed organic insecticidal soap made from naturally occurring potassium salts of fatty acids. Kills insects on contact, breaks down quickly. Safe around pets and children when dry.',
 'This is how you handle garden pests without nuking your whole ecosystem. Plant-based soap that kills bugs on contact and then biodegrades. No residue, no harm to bees.',
 'Potassium Salts of Fatty Acids 49.52%, Inert Ingredients 50.48%',
 'database_seed', 0),

-- =============================================================================
-- MAKEUP (new category — 3 products)
-- =============================================================================

('Fit Me Matte + Poreless Foundation', 'Maybelline', 'makeup', '041554433449', 35, 'toxic',
 'Contains multiple synthetic polymers, talc (potential asbestos contamination concern), synthetic fragrances, and chemical preservatives including BHT and phenoxyethanol.',
 'This foundation has a long ingredient list full of synthetic polymers and potential irritants. Talc is the big concern — it has a history of asbestos contamination. Your skin absorbs what you put on it.',
 'Water, Cyclopentasiloxane, Titanium Dioxide, Glycerin, Isododecane, Dimethicone, Alcohol Denat., PEG-10 Dimethicone, Synthetic Fluorphlogopite, Isopropyl Lauroyl Sarcosinate, Acrylates/Dimethicone Copolymer, Cetyl PEG/PPG-10/1 Dimethicone, Magnesium Sulfate, Disteardimonium Hectorite, Alumina, Fragrance, BHT, Phenoxyethanol, Talc, Methylparaben',
 'database_seed', 0),

('Clean Fresh Skin Milk Foundation', 'CoverGirl', 'makeup', '046200015390', 52, 'caution',
 'A step up from traditional foundations — claims "clean" formulation and is free from some common offenders. But still contains dimethicone and synthetic ingredients.',
 'CoverGirl is trying to go cleaner, and this is better than most drugstore foundations. But "clean" is not regulated — read the label. Still some synthetic silicones in here.',
 'Water, Dimethicone, Isododecane, Glycerin, Trimethylsiloxysilicate, PEG-10 Dimethicone, Nylon-12, Cetyl PEG/PPG-10/1 Dimethicone, Magnesium Sulfate, Sodium Chloride, Disteardimonium Hectorite, Tocopheryl Acetate, Aloe Barbadensis Leaf Juice, Coconut Alkanes',
 'database_seed', 0),

('Super Serum Skin Tint SPF 40', 'ILIA', 'makeup', NULL, 88, 'safe',
 'Clean foundation with mineral SPF 40, niacinamide, squalane, and hyaluronic acid. Free from parabens, sulfates, phthalates, talc, and synthetic fragrance. Skincare and coverage in one.',
 'This is what clean makeup looks like — real skincare ingredients plus mineral sun protection. No talc, no synthetic fragrance, no parabens. Your skin will actually be healthier wearing this.',
 'Non-Nano Zinc Oxide 13%, Squalane, Niacinamide, Hyaluronic Acid, Aloe Barbadensis Leaf Juice, Jojoba Esters, Helianthus Annuus Seed Oil, Coconut Alkanes, Polyglyceryl-4 Diisostearate/Polyhydroxystearate/Sebacate',
 'database_seed', 0),

-- =============================================================================
-- PAINT (new category — 3 products)
-- =============================================================================

('Painter''s Touch 2X Ultra Cover Spray Paint', 'Rust-Oleum', 'paint', '020066187972', 18, 'toxic',
 'Aerosol spray paint containing volatile organic compounds (VOCs), acetone, xylene, and other solvents. Extremely toxic when inhaled. Can cause serious respiratory and neurological damage.',
 'Never use spray paint indoors. The VOCs, acetone, and xylene are seriously toxic — they cause headaches, dizziness, and long-term organ damage. For indoor projects, use zero-VOC latex.',
 'Acetone, Xylene, Light Aliphatic Solvent Naphtha, Propane, N-Butane, Ethylbenzene, Methyl Isobutyl Ketone, Titanium Dioxide, Modified Alkyd Resin',
 'database_seed', 0),

('Natura Interior Paint', 'Benjamin Moore', 'paint', NULL, 90, 'safe',
 'Zero-VOC, zero-emission interior paint. Asthma and allergy friendly certification. No chemical fumes during or after application. Safe for nurseries and bedrooms.',
 'If you are painting a nursery or any room your family uses, this is the gold standard. Zero VOC means zero off-gassing. You can literally sleep in the room the same day you paint it.',
 'Water, Acrylic Polymer Emulsion, Titanium Dioxide, Mineral Fillers, Propylene Glycol, Cellulosic Thickener',
 'database_seed', 0),

('Harmony Interior Acrylic Latex', 'Sherwin-Williams', 'paint', NULL, 85, 'safe',
 'Zero-VOC interior paint with antimicrobial properties to resist mildew on the paint surface. Formulated to reduce common indoor odors.',
 'A solid clean paint option that is widely available. Zero VOC and actually helps reduce odors in the room. Great for kitchens, bathrooms, and kids rooms.',
 'Water, Acrylic Latex Polymer, Titanium Dioxide, Mineral Extenders, Propylene Glycol, Antimicrobial Agent',
 'database_seed', 0),

-- =============================================================================
-- PET (new category — 3 products)
-- =============================================================================

('Dog Chow Complete Adult Chicken', 'Purina', 'pet', '017800149129', 28, 'toxic',
 'Contains corn, soy, wheat (common allergens), poultry by-product meal, artificial colors (Red 40, Yellow 5, Yellow 6, Blue 2), BHA preservative, and animal fat with unspecified source.',
 'Everything wrong with pet food in one bag. By-product meal, artificial dyes (yes they dye dog food), BHA (a preservative linked to cancer in animals), and corn as the first ingredient. Your dog deserves better.',
 'Whole Grain Corn, Poultry By-Product Meal, Corn Gluten Meal, Whole Grain Wheat, Animal Fat Preserved with Mixed-Tocopherols, Meat and Bone Meal, Soybean Meal, Garlic Flavor, Salt, Calcium Carbonate, Potassium Chloride, Artificial Colors (Red 40, Yellow 5, Yellow 6, Blue 2), BHA (Used as a Preservative)',
 'database_seed', 0),

('Life Protection Formula Chicken and Brown Rice', 'Blue Buffalo', 'pet', '840243105809', 65, 'caution',
 'Uses real chicken as the first ingredient with whole grains and veggies. No artificial colors, flavors, or preservatives. Contains "LifeSource Bits" with vitamins. Some controversy over ingredient accuracy in the past.',
 'Much better than Purina — real chicken first, no artificial dyes or BHA. Blue Buffalo had some ingredient accuracy issues years ago, but they have cleaned up. A good mid-range option.',
 'Deboned Chicken, Chicken Meal, Brown Rice, Oatmeal, Barley, Peas, Chicken Fat (Preserved with Mixed Tocopherols), Flaxseed (Source of Omega 3 and 6 Fatty Acids), Pea Fiber, Dried Tomato Pomace, Potassium Chloride, Dried Chicory Root, Fish Meal',
 'database_seed', 0),

('Homestead Turkey Dry Dog Food', 'Open Farm', 'pet', NULL, 90, 'safe',
 'Ethically sourced turkey as the first ingredient with non-GMO fruits and vegetables. Humanely raised animals, no artificial preservatives, colors, or flavors. Certified Humane.',
 'This is premium dog food done right. You can trace every ingredient back to the farm. Humanely raised turkey, no corn/wheat/soy, no artificial anything. Your dog''s health is worth it.',
 'Turkey, Turkey Meal, Herring Meal, Field Peas, Coconut Oil (Preserved with Mixed Tocopherols), Lentils, Non-GMO Pumpkin, Non-GMO Spinach, Non-GMO Cranberries, Chicory Root',
 'database_seed', 0),

-- =============================================================================
-- STORAGE (new category — 3 products)
-- =============================================================================

('Press''n Seal Food Wrap', 'Glad', 'storage', '012587001202', 30, 'toxic',
 'Plastic cling wrap made from polyethylene with adhesive coating. Contains plasticizers that can leach into food, especially with heat or fatty foods. Single-use plastic waste.',
 'Plastic wrap on hot or fatty food is a bad combination — plasticizers leach right in. And every sheet goes straight to the landfill. Switch to glass, silicone, or beeswax wraps.',
 'Low-Density Polyethylene (LDPE), Adhesive Coating (Proprietary)',
 'database_seed', 0),

('Reusable Silicone Storage Bag Half Gallon', 'Stasher', 'storage', '816990018808', 95, 'safe',
 'Made from pure platinum food-grade silicone. No BPA, BPS, lead, latex, or phthalates. Replaces single-use plastic bags. Dishwasher, microwave, oven, and freezer safe.',
 'Pure platinum silicone is one of the safest food storage materials. It doesn''t leach anything, survives the dishwasher, and replaces thousands of plastic bags. Buy once, use forever.',
 'Pure Platinum Food-Grade Silicone',
 'database_seed', 0),

('Simply Store Glass Containers with Lids 10-Piece', 'Pyrex', 'storage', '071160096271', 92, 'safe',
 'Non-porous tempered glass that won''t absorb stains, odors, or chemicals. BPA-free lids. Completely inert surface — nothing leaches into food. Oven, microwave, and dishwasher safe.',
 'Glass is the king of food storage. Pyrex doesn''t leach, doesn''t stain, doesn''t absorb odors. The lids are BPA-free. This is what your grandparents used and it still works perfectly.',
 'Non-Porous Tempered Glass, BPA-Free Polypropylene Lids',
 'database_seed', 0),

-- =============================================================================
-- SUPPLEMENT (expand from 1 to 3)
-- =============================================================================

('Complete Adult Multivitamin', 'Centrum', 'supplement', '300054530233', 42, 'caution',
 'Contains artificial colors (FD&C Yellow No. 6 Aluminum Lake, FD&C Red No. 40 Aluminum Lake), synthetic fillers, BHT, hydrogenated palm oil, and cheap synthetic vitamin forms.',
 'America''s most popular multivitamin is full of artificial dyes and cheap synthetic forms of vitamins. BHT is a preservative your body doesn''t need. You can do much better.',
 'Calcium Carbonate, Potassium Chloride, Dibasic Calcium Phosphate, Ascorbic Acid, Microcrystalline Cellulose, Pregelatinized Corn Starch, Ferrous Fumarate, dl-Alpha Tocopheryl Acetate, Modified Food Starch, Croscarmellose Sodium, Gelatin, BHT, Hydrogenated Palm Oil, FD&C Yellow No. 6 Aluminum Lake, FD&C Red No. 40 Aluminum Lake',
 'database_seed', 0),

('Vitamin Code Raw One for Men', 'Garden of Life', 'supplement', '658010114554', 88, 'safe',
 'Whole food multivitamin with RAW food-created nutrients — not synthetic isolates. Contains live probiotics and enzymes. No binders, fillers, artificial colors, or preservatives.',
 'This is how a vitamin should be made — from real whole foods, not a chemistry lab. Live probiotics, raw enzymes, and nutrients your body actually recognizes. No junk fillers.',
 'Organic Fruit and Vegetable Blend (Organic Apple, Organic Beet, Organic Broccoli, Organic Carrot, Organic Spinach, Organic Tomato, Organic Strawberry, Organic Cherry, Organic Green Bell Pepper, Organic Brussels Sprout), RAW Probiotic and Enzyme Blend',
 'database_seed', 0),

-- =============================================================================
-- SKINCARE (expand from 2 to 5)
-- =============================================================================

('Ultra Healing Extra Dry Skin Moisturizer', 'Jergens', 'skincare', '019100110243', 35, 'toxic',
 'Contains multiple synthetic fragrance compounds, ceteareth-20 (ethoxylated surfactant), BHT, DMDM hydantoin (formaldehyde releaser), and artificial colors.',
 'DMDM hydantoin is a formaldehyde releaser — it slowly releases formaldehyde, a known carcinogen, into your skin. Add in BHT and synthetic fragrance, and this is one to avoid.',
 'Water, Glycerin, Cetyl Alcohol, Stearic Acid, Ceteareth-20, Mineral Oil, Petrolatum, Dimethicone, Sunflower Seed Oil, Retinyl Palmitate, Tocopheryl Acetate, Panthenol, Fragrance, DMDM Hydantoin, Methylparaben, Propylparaben, BHT, Yellow 5, Red 33',
 'database_seed', 0),

('Hydro Boost Water Gel', 'Neutrogena', 'skincare', '070501113219', 58, 'caution',
 'Features hyaluronic acid (good) but also contains dimethicone, fragrance, multiple synthetic preservatives, and dyes. A mixed bag of helpful and questionable ingredients.',
 'The hyaluronic acid is great for hydration, but why add synthetic fragrance and Blue 1 dye to a face product? It is a decent mainstream option but clean alternatives do it better without the additives.',
 'Water, Dimethicone, Glycerin, Dimethicone/Vinyl Dimethicone Crosspolymer, Hyaluronic Acid, Polyacrylamide, Cetearyl Olivate, Sorbitan Olivate, C13-14 Isoparaffin, Dimethicone Copolyol, Ethylhexylglycerin, Phenoxyethanol, Chlorphenesin, Fragrance, Blue 1',
 'database_seed', 0),

('Protini Polypeptide Cream', 'Drunk Elephant', 'skincare', NULL, 86, 'safe',
 'Clean moisturizer with signal peptides, growth factors, and amino acids. Free from essential oils, silicones, fragrances, dyes, and SLS. pH balanced for skin health.',
 'Drunk Elephant''s "Suspicious 6" — they cut out silicones, fragrance, dyes, SLS, essential oils, and chemical sunscreens. What is left is an effective, science-backed moisturizer that your skin actually wants.',
 'Water, Dicaprylyl Carbonate, Glycerin, Cetearyl Alcohol, Sclerocarya Birrea Seed Oil, Lathyrus Sativus Seed Extract, Acetyl Hexapeptide-8, Copper Tripeptide-1, Palmitoyl Tripeptide-1, Palmitoyl Tetrapeptide-7, Acrylates/C10-30 Alkyl Acrylate Crosspolymer, Sorbitan Olivate',
 'database_seed', 0),

-- =============================================================================
-- HAIRCARE (expand from 3 to 5)
-- =============================================================================

('Fructis Grow Strong Shampoo', 'Garnier', 'haircare', '603084491469', 30, 'toxic',
 'Contains sodium laureth sulfate (potential 1,4-dioxane contamination), synthetic fragrance, DMDM hydantoin (formaldehyde releaser), and artificial colors. The "fruit" is marketing.',
 'DMDM hydantoin is the big red flag here — it is a formaldehyde releaser. A literal carcinogen in your shampoo. Garnier had a class action lawsuit about this. Also has SLS and synthetic dyes.',
 'Water, Sodium Laureth Sulfate, Coco-Betaine, Glycerin, Sodium Chloride, Sodium Benzoate, Hexylene Glycol, Salicylic Acid, Citric Acid, Parfum/Fragrance, Pyrus Malus Apple Fruit Extract, Biotin, DMDM Hydantoin, CI 19140/Yellow 5, CI 42090/Blue 1',
 'database_seed', 0),

('Super Leaves Nourishing & Strengthening Shampoo', 'ATTITUDE', 'haircare', '626232160178', 90, 'safe',
 'EWG Verified shampoo with plant- and mineral-based ingredients. No SLS, parabens, formaldehyde releasers, synthetic fragrance, or artificial colors. Hypoallergenic and biodegradable.',
 'EWG Verified means every ingredient has been checked for safety. No SLS, no fragrance, no preservatives that release formaldehyde. This is what shampoo should be — clean, simple, effective.',
 'Aqua/Water/Eau, Sodium Coco-Sulfate, Cocamidopropyl Betaine, Coco-Glucoside, Citric Acid, Glycol Distearate, Moringa Oleifera Seed Oil, Guar Hydroxypropyltrimonium Chloride, Sodium Chloride, Tocopherol',
 'database_seed', 0),

-- =============================================================================
-- DEODORANT (expand from 2 to 4)
-- =============================================================================

('Antiperspirant Deodorant Cool Rush', 'Degree Men', 'deodorant', '079400587107', 22, 'toxic',
 'Contains aluminum zirconium tetrachlorohydrex (blocks sweat glands), propylene glycol, BHT, synthetic fragrance, and multiple other chemical ingredients.',
 'Aluminum in antiperspirants blocks your sweat glands — your body''s natural detox mechanism. Add in BHT and synthetic fragrance, and you are applying chemicals directly to your lymph nodes.',
 'Aluminum Zirconium Tetrachlorohydrex GLY 18.2%, Cyclopentasiloxane, PPG-14 Butyl Ether, Stearyl Alcohol, C12-15 Alkyl Benzoate, Hydrogenated Castor Oil, Fragrance, BHT, Propylene Glycol',
 'database_seed', 0),

('Charcoal Deodorant', 'Primally Pure', 'deodorant', NULL, 93, 'safe',
 'Handmade with organic tallow, coconut oil, beeswax, and activated charcoal. No aluminum, synthetic fragrance, propylene glycol, or parabens. Baking soda-free option available.',
 'Organic tallow and beeswax as a deodorant base — this is old-school in the best way. The activated charcoal absorbs odor naturally. No aluminum anywhere near your lymph nodes.',
 'Organic Tallow, Organic Coconut Oil, Beeswax, Non-Aluminum Baking Soda, Organic Arrowroot Powder, Activated Charcoal, Kaolin Clay, Essential Oils',
 'database_seed', 0),

-- =============================================================================
-- ORAL CARE (expand from 2 to 4)
-- =============================================================================

('3D White Radiant Mint Toothpaste', 'Crest', 'oral_care', '037000449781', 35, 'toxic',
 'Contains sodium lauryl sulfate, artificial sweeteners (sodium saccharin), titanium dioxide, and polyethylene (microplastic beads in some formulations). Multiple synthetic ingredients.',
 'SLS is an irritant that causes canker sores in many people. Sodium saccharin is an artificial sweetener. And titanium dioxide — a whitening agent that the EU banned from food — is in here too.',
 'Sodium Fluoride 0.243%, Sorbitol, Water, Hydrated Silica, Disodium Pyrophosphate, Sodium Lauryl Sulfate, Sodium Hydroxide, Cellulose Gum, Sodium Saccharin, Carbomer, Titanium Dioxide, Mica, Blue 1',
 'database_seed', 0),

('Hydroxyapatite Toothpaste Ela Mint', 'Boka', 'oral_care', NULL, 91, 'safe',
 'Remineralizing toothpaste using nano-hydroxyapatite — the mineral teeth are actually made of. No fluoride, SLS, parabens, artificial sweeteners, or triclosan. Dentist recommended.',
 'Hydroxyapatite literally is what teeth are made of, so this toothpaste rebuilds enamel naturally. Japan has used it for decades. No SLS to cause canker sores, no artificial sweeteners.',
 'Nano-Hydroxyapatite, Glycerin, Water, Hydrated Silica, Aloe Barbadensis Leaf Juice, Xylitol, Cellulose Gum, Cocamidopropyl Betaine, Mentha Piperita Oil, Mentha Spicata Leaf Oil',
 'database_seed', 0),

-- =============================================================================
-- CLEANING (expand from 3 to 5)
-- =============================================================================

('Fabuloso Multi-Purpose Cleaner Lavender', 'Colgate-Palmolive', 'cleaning', '035000460868', 15, 'toxic',
 'Contains synthetic fragrance, multiple dyes (Red 33, Blue 1), sodium dodecylbenzene sulfonate, and glutaral (a biocide). Looks and smells appealing but is chemically harsh.',
 'The purple color comes from artificial dyes and the smell is synthetic fragrance — neither cleans anything. The actual cleaning agents are harsh surfactants. If you can smell it across the room, it is too much.',
 'Water, Sodium Dodecylbenzene Sulfonate, Fragrance, C9-11 Pareth-8, Sodium Laureth Sulfate, Glutaral, Colorants (Red 33, Blue 1)',
 'database_seed', 0),

('All-Purpose Cleaner Free & Clear', 'Seventh Generation', 'cleaning', '732913228621', 88, 'safe',
 'Plant-based formula with no dyes, synthetic fragrances, or harsh chemical fumes. EPA Safer Choice certified. Biodegradable ingredients that are safe around children and pets.',
 'EPA Safer Choice means every ingredient has been reviewed for safety. No fragrance, no dyes, no fumes. It just cleans — which is all you actually need a cleaner to do.',
 'Water, Decyl Glucoside, Sodium Citrate, Lauramine Oxide, Citric Acid, Sodium Chloride',
 'database_seed', 0),

-- =============================================================================
-- COOKWARE (expand from 2 to 4)
-- =============================================================================

('Classic Nonstick 12-Piece Cookware Set', 'Calphalon', 'cookware', NULL, 22, 'toxic',
 'PTFE (Teflon) nonstick coating that releases toxic fumes at high temperatures. Contains PFAS chemicals that are persistent in the environment and human body. Coating degrades over time.',
 'PTFE cookware releases toxic fumes that can kill pet birds and cause "Teflon flu" in humans. When the coating scratches — and it will — you are eating microplastics. Switch to cast iron, stainless, or ceramic.',
 'Aluminum Core, PTFE (Polytetrafluoroethylene) Nonstick Coating, Stainless Steel Handles',
 'database_seed', 0),

('Valencia Pro Ceramic Nonstick 11-Piece Set', 'GreenPan', 'cookware', NULL, 92, 'safe',
 'Thermolon ceramic nonstick coating made from sand. Free from PFAS, PFOA, lead, cadmium, and PTFE. No toxic fumes at any temperature. Hard anodized aluminum body.',
 'GreenPan''s ceramic coating is made from sand — literally. No PFAS, no Teflon, no toxic fumes even if you overheat it. This is what nonstick should have been all along.',
 'Hard Anodized Recycled Aluminum, Thermolon Ceramic Nonstick Coating (Silicon Dioxide-Based), Stainless Steel Handles',
 'database_seed', 0);
