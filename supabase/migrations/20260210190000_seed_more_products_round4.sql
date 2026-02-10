-- =============================================================================
-- Expand curated products database — Round 4
-- More household staples, personal care, and popular brands people scan daily
-- =============================================================================

INSERT INTO public.products (name, brand, category, barcode, score, verdict, summary, dads_take, ingredients_raw, source, scan_count)
VALUES

-- =============================================================================
-- CLEANING (expand — dish soap, dishwasher, Lysol)
-- =============================================================================

('Ultra Dishwashing Liquid Original', 'Dawn', 'cleaning', '037000973027', 40, 'caution',
 'Effective grease cutter but contains methylisothiazolinone (potent allergen and potential neurotoxin), synthetic fragrance, and multiple dyes. The surfactants are petroleum-derived.',
 'Dawn is great at cutting grease — so great that they use it to clean oil-soaked wildlife. But methylisothiazolinone is a serious allergen the EU has restricted in leave-on products. Do you want it on your dishes?',
 'Water, Sodium Lauryl Sulfate, Sodium Laureth Sulfate, Lauramine Oxide, C12-14-16 Dimethyl Amine Oxide, SD Alcohol, Sodium Chloride, Phenoxyethanol, PEI-14 PEG-24/PPG-16 Copolymer, Fragrance, Methylisothiazolinone, Blue 1, Yellow 5',
 'database_seed', 0),

('ActionPacs Dishwasher Detergent Fresh Scent', 'Cascade', 'cleaning', '037000977438', 35, 'toxic',
 'Contains synthetic fragrance, optical brighteners, and multiple enzymes in a PVA film wrapper. The "fresh scent" is synthetic chemicals that coat your dishes and are ingested trace amounts with every meal.',
 'Think about it — the fragrance and chemical residue from your dishwasher detergent stays on your plates, cups, and silverware. You eat off those. Fragrance-free is the way to go for anything touching your food.',
 'Sodium Carbonate, Sodium Carbonate Peroxide, Amylase Enzyme, Polyvinyl Alcohol Polymer, Sodium Silicate, Sodium Polyacrylate, Sodium Sulfate, Protease Enzyme, Subtilisin, Fragrance, Disodium Distyrylbiphenyl Disulfonate (Optical Brightener), Dipropylene Glycol',
 'database_seed', 0),

('All-Purpose Cleaner Lemon Fresh', 'Lysol', 'cleaning', '019200786348', 18, 'toxic',
 'Contains alkyl dimethyl benzyl ammonium chloride (a quaternary ammonium compound linked to respiratory issues), synthetic fragrance, and multiple surfactants. Designed to kill germs but also irritates lungs.',
 '"Quats" (quaternary ammonium compounds) are the active antimicrobial — but they are also respiratory irritants and contribute to antibiotic resistance. Plus synthetic fragrance and dyes. Your lungs don''t want this.',
 'Water, Alkyl (C12-16) Dimethyl Benzyl Ammonium Chloride, Ethanolamine, Fragrance, Sodium C14-16 Olefin Sulfonate, PPG-5 Laureth-5, Sodium Lauryl Sulfate, Yellow 5, Blue 1',
 'database_seed', 0),

('Free & Clear Dish Soap', 'ECOS', 'cleaning', '749174097330', 90, 'safe',
 'Plant-powered dish soap with no synthetic fragrances, dyes, or parabens. Made with renewable plant-based ingredients. Hypoallergenic and pH balanced. Made in a Zero Waste facility.',
 'No fragrance, no dyes, no parabens — just plant-based cleaning agents that cut grease and rinse clean. Made in a zero-waste facility powered by renewable energy. This is how all dish soap should be made.',
 'Water, Sodium Coco Sulfate, Cocamidopropyl Betaine, Sodium Chloride, Citric Acid, Phenoxyethanol, Ethylhexylglycerin',
 'database_seed', 0),

-- =============================================================================
-- ORAL CARE (expand — mouthwash)
-- =============================================================================

('Cool Mint Antiseptic Mouthwash', 'Listerine', 'oral_care', '312547427715', 32, 'toxic',
 'Contains 21.6% alcohol (higher than wine), synthetic dyes (Green 3, Blue 1), sodium saccharin (artificial sweetener), and benzoic acid. The alcohol can dry out and irritate oral tissue.',
 'Over 21% alcohol — that is stronger than most wines. It kills bacteria, sure, but also destroys your oral microbiome and dries out your mouth. A dry mouth actually leads to more bad breath, not less.',
 'Water, Alcohol 21.6%, Sorbitol, Eucalyptol, Poloxamer 407, Benzoic Acid, Sodium Saccharin, Methyl Salicylate, Thymol, Menthol, Sucralose, Green 3, Blue 1',
 'database_seed', 0),

('Fresh Breath Oral Rinse Mild Mint', 'TheraBreath', 'oral_care', '697029090015', 82, 'safe',
 'Alcohol-free mouthwash with OXYD-8 (stabilized chlorine dioxide) that neutralizes sulfur-producing bacteria. No artificial colors, flavors, or saccharin. Dentist formulated. pH balanced.',
 'No alcohol, no artificial dyes, no saccharin. Uses chlorine dioxide to target the actual bacteria that cause bad breath without nuking your whole oral microbiome. Developed by a dentist who understood the problem.',
 'Water, OXYD-8 (Stabilized Chlorine Dioxide), PEG-40 Hydrogenated Castor Oil, Tetrasodium EDTA, Sodium Bicarbonate, Sodium Benzoate, Natural Peppermint Flavor, Essential Oil of Peppermint',
 'database_seed', 0),

-- =============================================================================
-- FRAGRANCE (expand from 3 to 6)
-- =============================================================================

('Freshmatic Automatic Spray Lavender', 'Air Wick', 'fragrance', '062338939407', 10, 'toxic',
 'Battery-operated device that automatically sprays synthetic fragrance chemicals every 9 minutes. Contains isobutane propellant, synthetic fragrance, and multiple volatile compounds.',
 'This device sprays synthetic chemicals into your air every 9 minutes automatically. You breathe it 24/7. Isobutane is a propellant derived from petroleum. Open a window instead — fresh air is free and non-toxic.',
 'Isobutane (Propellant), Alcohol Denat., Fragrance, Water, Propylene Glycol, MEA-Benzoate, Linalool, Limonene, Coumarin, Benzyl Benzoate',
 'database_seed', 0),

('Original Large Jar Candle Balsam & Cedar', 'Yankee Candle', 'fragrance', '886860299620', 38, 'caution',
 'Made with paraffin wax (petroleum byproduct) and cotton/paper wicks. Paraffin candles release toluene and benzene when burned. Contains "fragrance" — undisclosed chemical blend.',
 'Paraffin wax is a petroleum byproduct. When you burn it, you release toluene and benzene into your home — both are known carcinogens. Switch to soy, beeswax, or coconut wax candles.',
 'Paraffin Wax, Cotton/Paper Wick, Fragrance Oils, Dye',
 'database_seed', 0),

('Organic Essential Oil Lavender', 'Plant Therapy', 'fragrance', '813725023019', 92, 'safe',
 'USDA Organic, 100% pure lavender essential oil. No fillers, additives, bases, or synthetic fragrances. Third-party GC/MS tested for purity. KidSafe line available.',
 'When a product says "lavender fragrance" it can be synthetic chemicals. When it says "100% pure lavender essential oil" — that is actual lavender, nothing else. Third-party tested to prove it.',
 '100% Pure Lavandula Angustifolia (Lavender) Oil',
 'database_seed', 0),

-- =============================================================================
-- MAKEUP (expand from 3 to 6)
-- =============================================================================

('True Match Super-Blendable Foundation', 'L''Oréal Paris', 'makeup', '071249104019', 38, 'caution',
 'Contains dimethicone, synthetic fragrance, BHT, talc, and multiple chemical sunscreens. The shade-matching technology is impressive but the ingredient list is concerning.',
 'L''Oréal packs in dimethicone (silicone), BHT (preservative linked to endocrine disruption), talc, and synthetic fragrance. Your foundation sits on your face all day — 8-12 hours of skin absorption.',
 'Water, Dimethicone, Isododecane, Alcohol Denat., Synthetic Fluorphlogopite, Isopropyl Lauroyl Sarcosinate, Peg-10 Dimethicone, Glycerin, Cetyl PEG/PPG-10/1 Dimethicone, Talc, Phenoxyethanol, BHT, Fragrance, Disteardimonium Hectorite, Magnesium Sulfate, Sodium Hyaluronate',
 'database_seed', 0),

('ColorStay Makeup for Combination/Oily Skin SPF 15', 'Revlon', 'makeup', '309975415056', 30, 'toxic',
 'Contains BHA (possible human carcinogen per NTP), talc, synthetic fragrance, multiple parabens (methylparaben, propylparaben), and dimethicone. Designed to stay on skin for 24 hours.',
 'This foundation is designed to last 24 hours — meaning these chemicals sit on your face an entire day. BHA is flagged as a possible carcinogen. Parabens are endocrine disruptors. And it is on your face.',
 'Water, Cyclopentasiloxane, Titanium Dioxide, Talc, Trimethylsiloxysilicate, Dimethicone, Isododecane, Boron Nitride, Nylon-12, PEG-10 Dimethicone, Phenyl Trimethicone, BHA, Methylparaben, Propylparaben, Fragrance, Tocopheryl Acetate',
 'database_seed', 0),

('Un Cover-Up Cream Foundation', 'RMS Beauty', 'makeup', NULL, 90, 'safe',
 'Made with organic coconut oil, beeswax, and natural pigments. No synthetic chemicals, GMOs, or gluten. Formulated by a makeup artist who worked in the industry and saw the problem firsthand.',
 'Created by a makeup artist who witnessed models getting sick from years of conventional cosmetics. Organic coconut oil as the base, natural pigments for color. Proof that clean makeup can actually perform.',
 'Cocos Nucifera (Coconut) Oil, Beeswax, Jojoba Esters, Rosmarinus Officinalis (Rosemary) Leaf Extract, Tocopherol (Vitamin E), Iron Oxides, Titanium Dioxide',
 'database_seed', 0),

-- =============================================================================
-- PET (expand from 3 to 6)
-- =============================================================================

('Original Choice Dry Cat Food', 'Meow Mix', 'pet', '829274537209', 25, 'toxic',
 'Contains corn, soybean meal, poultry by-product meal, artificial colors (Red 40, Yellow 5, Yellow 6, Blue 2), BHA preservative, and "animal fat" from unspecified sources.',
 'Same problems as cheap dog food — artificial dyes, BHA preservative, by-product meal, and corn as filler. Cats are obligate carnivores who need real meat, not corn and food coloring.',
 'Ground Yellow Corn, Corn Gluten Meal, Chicken By-Product Meal, Soybean Meal, Beef Tallow (Preserved with Mixed Tocopherols), Animal Digest, Turkey By-Product Meal, Salmon Meal, Calcium Carbonate, Phosphoric Acid, Salt, Potassium Chloride, Red 40, Yellow 5, Blue 2, Yellow 6, BHA (Used as a Preservative)',
 'database_seed', 0),

('UltraGuard Pro Flea & Tick Collar for Dogs', 'Hartz', 'pet', '032700108182', 10, 'toxic',
 'Contains tetrachlorvinphos (organophosphate insecticide) which is a likely human carcinogen per EPA assessment. Can cause neurological symptoms in pets and humans. NRDC petitioned to ban it.',
 'Tetrachlorvinphos is an organophosphate nerve agent for fleas — but it''s also toxic to your dog and your family. The NRDC has petitioned the EPA to ban it. There is a collar around your pet''s neck releasing this 24/7.',
 'Active: Tetrachlorvinphos 14.55%. Inert Ingredients: 85.45%',
 'database_seed', 0),

('Minced Chicken Recipe in Bone Broth', 'The Honest Kitchen', 'pet', NULL, 88, 'safe',
 'Human-grade cat food with real chicken as the first ingredient, cooked in bone broth. No by-products, artificial preservatives, colors, or flavors. Made in a human food facility.',
 'Human-grade means this food is literally made in a human food facility to human food standards. Real chicken in bone broth, no by-products, no dyes. Your cat is eating better than most Americans.',
 'Chicken, Chicken Broth, Water, Chicken Liver, Flaxseed, Potassium Chloride, Salt, Guar Gum, Minerals (Zinc Proteinate, Iron Proteinate, Manganese Proteinate, Copper Proteinate, Sodium Selenite, Potassium Iodide), Vitamins (Vitamin E, Thiamine Mononitrate, Niacin, Vitamin A, Calcium Pantothenate)',
 'database_seed', 0),

-- =============================================================================
-- SUPPLEMENT (expand from 3 to 6)
-- =============================================================================

('Complete Children''s Multivitamin', 'Flintstones', 'supplement', '016500549901', 28, 'toxic',
 'Children''s vitamin loaded with artificial colors (Red 40, Blue 2, Yellow 6), aspartame, cupric oxide (poorly absorbed copper form), and hydrogenated soybean oil. Marketed to kids with cartoon characters.',
 'They put artificial dyes, aspartame, and hydrogenated soybean oil in a children''s vitamin. Red 40 and Yellow 6 are linked to hyperactivity in kids. These are supposed to make children healthier?',
 'Sucrose, Sodium Ascorbate, Gelatin, Stearic Acid, Ferrous Fumarate, Vitamin E Acetate, Cupric Oxide, Artificial Flavors, Aspartame, Hydrogenated Soybean Oil, FD&C Red No. 40, FD&C Blue No. 2, FD&C Yellow No. 6, BHT',
 'database_seed', 0),

('Women''s Multivitamin', 'One A Day', 'supplement', '016500549307', 48, 'caution',
 'Contains synthetic vitamin forms (dl-alpha tocopheryl acetate, cyanocobalamin), artificial colors (FD&C Red 40, Blue 2), BHT, hydrogenated palm oil, and talc as filler.',
 'Better than Flintstones but still has artificial dyes and cheap synthetic vitamin forms your body struggles to absorb. dl-alpha is the synthetic form of vitamin E — your body prefers d-alpha from food.',
 'Dibasic Calcium Phosphate, Magnesium Oxide, Ascorbic Acid, Ferrous Fumarate, dl-Alpha Tocopheryl Acetate, Crospovidone, Stearic Acid, Gelatin, Silicon Dioxide, Niacinamide, Zinc Oxide, Cyanocobalamin, Calcium Pantothenate, BHT, Titanium Dioxide, FD&C Red No. 40, FD&C Blue No. 2, Hydrogenated Palm Oil',
 'database_seed', 0),

('Essential for Women Multivitamin 18+', 'Ritual', 'supplement', NULL, 91, 'safe',
 'Delayed-release capsule with traceable, bioavailable nutrient forms. No synthetic fillers, colorants, or mystery additives. Vegan, non-GMO, third-party tested. Beadlet-in-oil technology for absorption.',
 'Ritual is transparent about where every single ingredient comes from — you can trace each one to its source. No artificial dyes, no BHT, no talc. Bioavailable forms your body can actually use.',
 'Methylated Folate, Vitamin D3 (Lichen-Sourced), Vitamin K2, Vitamin B12 (Methylcobalamin), Iron (Ferrous Bisglycinate), Omega-3 DHA (Microalgae), Boron, Vitamin E (Mixed Tocopherols), Vegan Capsule (Cellulose, Water)',
 'database_seed', 0),

-- =============================================================================
-- STORAGE (expand from 3 to 5)
-- =============================================================================

('Freezer Bags Gallon', 'Ziploc', 'storage', '025700003861', 40, 'caution',
 'Made from polyethylene plastic — BPA-free but still single-use plastic. Potential for microplastic leaching, especially with heat or acidic foods. Environmental waste concern.',
 'Ziploc is BPA-free, which is good, but it is still single-use plastic. Heating food in plastic bags releases microplastics. And every single bag ends up in a landfill. Reusable silicone or glass containers are the move.',
 'Low-Density Polyethylene (LDPE)',
 'database_seed', 0),

('Reusable Food Wraps Assorted 3-Pack', 'Bee''s Wrap', 'storage', '855104006003', 88, 'safe',
 'Made from organic cotton, beeswax, organic jojoba oil, and tree resin. Replaces plastic wrap. Naturally antibacterial. Compostable at end of life. Lasts up to a year with proper care.',
 'Cotton + beeswax + jojoba oil = a food wrap that actually works, naturally resists bacteria, and composts when you are done with it. Your great-grandparents stored food like this before plastic existed.',
 'GOTS Certified Organic Cotton, Beeswax, Organic Jojoba Oil, Tree Resin',
 'database_seed', 0),

-- =============================================================================
-- PERSONAL CARE — BODY WASH (in soap category)
-- =============================================================================

('Body Wash Dark Temptation', 'Axe', 'soap', '079400550804', 20, 'toxic',
 'Contains sodium laureth sulfate (potential 1,4-dioxane contamination), synthetic fragrance, DMDM hydantoin (formaldehyde releaser), tetrasodium EDTA, and multiple artificial colors.',
 'DMDM hydantoin — formaldehyde releaser — in a body wash you lather all over your skin. Your skin is your largest organ and absorbs what you put on it. The heavy synthetic fragrance is the cherry on top.',
 'Water, Sodium Laureth Sulfate, Cocamidopropyl Betaine, Fragrance, Sodium Chloride, Glycol Distearate, Cocamide MEA, Sodium Benzoate, Guar Hydroxypropyltrimonium Chloride, PPG-9, DMDM Hydantoin, Tetrasodium EDTA, Citric Acid, BHT, Red 33, Yellow 5',
 'database_seed', 0),

('Baby Mild Pure-Castile Liquid Soap', 'Dr. Bronner''s', 'soap', '018787775189', 95, 'safe',
 'Unscented castile soap for sensitive skin and babies. Made with organic coconut, olive, and hemp oils. No synthetic preservatives, detergents, or foaming agents. Certified Fair Trade.',
 'If the regular peppermint Dr. Bronner''s is too intense, this baby mild version is completely unscented. Same organic castile formula, just without the essential oils. Safe for literally everyone.',
 'Water, Organic Coconut Oil, Potassium Hydroxide, Organic Palm Kernel Oil, Organic Olive Oil, Organic Hemp Seed Oil, Organic Jojoba Oil, Citric Acid, Tocopherol (Vitamin E)',
 'database_seed', 0),

-- =============================================================================
-- LIP CARE (in skincare category)
-- =============================================================================

('Classic Original Lip Balm', 'ChapStick', 'skincare', '305731600100', 42, 'caution',
 'Contains petrolatum (petroleum), mineral oil, artificial flavor, and chemical sunscreen (oxybenzone in SPF versions). Multiple synthetic preservatives including BHT and phenyl trimethicone.',
 'You apply this directly to your lips and inevitably swallow trace amounts all day. Petrolatum, mineral oil, artificial flavor — going straight into your mouth. Beeswax lip balms do the same job without petroleum.',
 'White Petrolatum 45.0%, Arachidyl Propionate, Camphor, Carnauba Wax, Cetyl Alcohol, Fragrance, Isopropyl Lanolate, Isopropyl Myristate, Lanolin, Light Mineral Oil, Methylparaben, Octyldodecanol, Oleyl Alcohol, Paraffin, Phenyl Trimethicone, Propylparaben, Titanium Dioxide, White Wax',
 'database_seed', 0),

('Beeswax Lip Balm', 'Burt''s Bees', 'skincare', '792850710016', 85, 'safe',
 'Made with beeswax, coconut oil, sunflower oil, and peppermint oil. No petrolatum, parabens, phthalates, or SLS. 100% natural origin ingredients. Recyclable tube.',
 'Beeswax, coconut oil, and peppermint. That is lip balm. No petroleum, no parabens, no artificial flavors. You will lick your lips and actually be fine about it.',
 'Cera Alba (Beeswax), Cocos Nucifera (Coconut) Oil, Helianthus Annuus (Sunflower) Seed Oil, Mentha Piperita (Peppermint) Oil, Rosmarinus Officinalis (Rosemary) Leaf Extract, Glycine Soja (Soybean) Oil, Canola Oil, Tocopherol (Vitamin E), Lanolin',
 'database_seed', 0),

-- =============================================================================
-- BEVERAGES — ENERGY DRINKS
-- =============================================================================

('Energy Drink Original', 'Red Bull', 'beverage', '611269991000', 18, 'toxic',
 'Contains synthetic taurine, artificial colors, 27 grams of sugar, and high caffeine. Also uses sucrose and glucose rather than natural sources. The "energy" comes from sugar and caffeine, not vitamins.',
 '27 grams of sugar and 80mg of caffeine in a small can. The taurine is synthetic, the B vitamins are there in marketing quantities. This is sugar water with caffeine and a massive marketing budget.',
 'Carbonated Water, Sucrose, Glucose, Citric Acid, Taurine, Sodium Bicarbonate, Magnesium Carbonate, Caffeine, Niacinamide, Calcium Pantothenate, Pyridoxine HCl, Vitamin B12, Natural and Artificial Flavors, Colors',
 'database_seed', 0),

('Energy Drink Original', 'Monster', 'beverage', '070847811169', 12, 'toxic',
 'Contains 54 grams of sugar per can, artificial colors, sucralose, and a proprietary "energy blend" with undisclosed amounts of individual stimulants. One of the most sugar-loaded beverages available.',
 '54 grams of sugar. In one can. That is almost 14 teaspoons. Plus a proprietary energy blend where you have no idea how much of each stimulant you are getting. Your heart doesn''t want this.',
 'Carbonated Water, Sugar, Glucose, Citric Acid, Natural Flavors, Taurine, Sodium Citrate, Color Added, Panax Ginseng Root Extract, L-Carnitine, Caffeine, Sorbic Acid, Benzoic Acid, Niacinamide, Sucralose, Salt, D-Glucuronolactone, Guarana Seed Extract, Inositol, Pyridoxine HCl, Riboflavin, Cyanocobalamin',
 'database_seed', 0),

('Essential Energy Drink Sparkling Orange', 'Celsius', 'beverage', '889392000566', 62, 'caution',
 'No sugar, no artificial colors or flavors, and uses green tea caffeine. However contains sucralose (artificial sweetener) and a proprietary MetaPlus blend with undisclosed individual amounts.',
 'Better than Red Bull or Monster by a mile — no sugar, no artificial colors. But the sucralose is debatable and the MetaPlus proprietary blend means you don''t know exact amounts. A step in the right direction.',
 'Carbonated Filtered Water, Citric Acid, Vegetable Juice (Color), Taurine, Natural Flavor, Caffeine (200mg), Guarana Seed Extract, Green Tea Leaf Extract, Ginger Root Extract, Chromium Chelate, Sucralose',
 'database_seed', 0),

-- =============================================================================
-- BABY (expand — wipes)
-- =============================================================================

('Baby Wipes Complete Clean Unscented', 'Pampers', 'baby', '037000863786', 50, 'caution',
 'Unscented is better than scented, but still contains phenoxyethanol, citric acid, and multiple synthetic surfactants. The fabric is made from polypropylene (plastic) — not biodegradable.',
 'At least these are unscented, which is a step up from scented wipes. But they are still made from plastic fabric with synthetic preservatives. Water wipes or organic cotton wipes are cleaner options.',
 'Water, Citric Acid, PEG-40 Hydrogenated Castor Oil, Phenoxyethanol, Sodium Citrate, Sodium Benzoate, Xanthan Gum, Disodium EDTA, Bis-PEG/PPG-16/16 PEG/PPG-16/16 Dimethicone, Caprylic/Capric Triglyceride, Ethylhexylglycerin, Aloe Barbadensis Leaf Juice',
 'database_seed', 0),

('99.9% Water Baby Wipes', 'WaterWipes', 'baby', '5099514002006', 92, 'safe',
 'Made with 99.9% purified water and a drop of fruit extract (grapefruit seed). No fragrance, parabens, sulfates, or alcohol. Accepted by the National Eczema Association and Allergy UK.',
 'This is as close to wiping with pure water as you can get. 99.9% water, one drop of grapefruit seed extract. That is it. Endorsed by allergy organizations and dermatologists worldwide. The gold standard for baby wipes.',
 '99.9% Purified Water, 0.1% Grapefruit Seed Extract',
 'database_seed', 0),

-- =============================================================================
-- HAND SANITIZER (in cleaning category)
-- =============================================================================

('Advanced Hand Sanitizer Refreshing Gel', 'Purell', 'cleaning', '073852012620', 55, 'caution',
 'Ethyl alcohol 70% (effective germ killer) with tocopheryl acetate and fragrance. The alcohol base is fine but the added fragrance is unnecessary and the glycerin/carbomer base is synthetic.',
 'The 70% alcohol does the job — that is the active ingredient. But they add synthetic fragrance for no good reason. Your hands don''t need to smell like chemicals to be clean. Look for fragrance-free versions.',
 'Active: Ethyl Alcohol 70%. Inactive: Water, Isopropyl Myristate, Glycerin, Carbomer, Aminomethyl Propanol, Fragrance, Tocopheryl Acetate',
 'database_seed', 0),

('Organic Hand Sanitizer Spray Lavender', 'Dr. Bronner''s', 'cleaning', '018787950036', 82, 'safe',
 'Organic ethyl alcohol with organic lavender oil, organic glycerin, and organic jojoba oil. No synthetic fragrance, no triclosan, no benzalkonium chloride. USDA Organic.',
 'Same germ-killing alcohol base, but with organic lavender oil instead of synthetic fragrance, and organic glycerin that actually moisturizes instead of drying out your hands. Clean and effective.',
 'Active: Organic Ethyl Alcohol 62%. Inactive: Water, Organic Glycerin, Organic Lavandula Angustifolia (Lavender) Oil, Organic Simmondsia Chinensis (Jojoba) Seed Oil',
 'database_seed', 0),

-- =============================================================================
-- GARDEN (expand — bug spray)
-- =============================================================================

('Deep Woods Insect Repellent', 'OFF!', 'garden', '046500018404', 30, 'toxic',
 'Contains 25% DEET — highly effective but a potent synthetic chemical that can damage plastics, dissolve certain fabrics, and may cause neurological effects with heavy use. Also contains fragrance.',
 'DEET works against mosquitoes and ticks — no question. But it dissolves plastic and synthetic fabric, which tells you something about its potency. For everyday use, plant-based repellents are a safer choice. Save DEET for deep woods.',
 'Active: DEET 25%. Inactive: Ethanol, Water, Fragrance, BHT, Propylene Glycol, Propellant: Isobutane',
 'database_seed', 0),

('Lemon Eucalyptus Insect Repellent', 'Murphy''s Naturals', 'garden', '851853006167', 82, 'safe',
 'Plant-based insect repellent with oil of lemon eucalyptus (CDC-recognized as effective as DEET for mosquitoes). No DEET, synthetic chemicals, or petroleum. DEET-free and family-friendly.',
 'Oil of lemon eucalyptus is the only plant-based repellent the CDC recognizes as effective as DEET. No synthetic chemicals on your skin. Murphy''s Naturals is B Corp certified and uses clean ingredients.',
 'Active: Oil of Lemon Eucalyptus (OLE) 30%. Inactive: Water, Glycerin, Xanthan Gum, Lecithin, Citric Acid',
 'database_seed', 0);
