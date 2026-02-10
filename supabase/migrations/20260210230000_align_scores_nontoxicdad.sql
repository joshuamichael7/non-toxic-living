-- =============================================================================
-- Align product scores with NonToxicDad's strict philosophy
-- Key principles: NO synthetic fragrance (even in "clean" brands), NO seed oils,
-- NO PEGs/ethoxylated ingredients, NO dimethicone/silicones in skincare,
-- 18/10 stainless steel = nickel concern, ceramic coatings = caution,
-- conventional oats = glyphosate concern, "natural flavors" = skepticism
-- =============================================================================

-- ============================================================
-- PRODUCTS MOVING FROM "SAFE" TO "CAUTION" (score drops below 67)
-- ============================================================

-- CeraVe Moisturizing Cream: 80 → 58
-- Contains ceteareth-20 (PEG/ethoxylated), dimethicone (silicone), phenoxyethanol
-- NonToxicDad flags PEGs and silicones; "if you can't pronounce it, don't put it on skin"
UPDATE public.products
SET score = 58,
    verdict = 'caution',
    summary = 'Developed with dermatologists and contains beneficial ceramides and hyaluronic acid. However, also contains ceteareth-20 (ethoxylated ingredient with potential 1,4-dioxane contamination), dimethicone (silicone), and phenoxyethanol. Mixed bag of helpful and questionable ingredients.',
    dads_take = 'CeraVe has good active ingredients — ceramides and hyaluronic acid are legit. But the delivery system includes PEG compounds and silicone, which is like getting a healthy meal served on a dirty plate. Cleaner moisturizers deliver the same benefits without the chemical baggage.'
WHERE brand = 'CeraVe' AND name = 'Moisturizing Cream';

-- Cheerios Original: 72 → 62
-- Conventional oats (glyphosate residue documented in testing), modified corn starch, tripotassium phosphate
-- NonToxicDad says "not all oats are created equal" — pesticide concerns
UPDATE public.products
SET score = 62,
    verdict = 'caution',
    summary = 'Whole grain oats are the base, which is positive. However, conventional (non-organic) oats have been repeatedly found to contain glyphosate residue in independent testing. Also contains modified corn starch, sugar, and tripotassium phosphate.',
    dads_take = 'Cheerios seem clean on the surface, but independent testing keeps finding glyphosate residue in conventional oats — it is used as a drying agent before harvest. The organic version is a much safer bet. Modified corn starch and tripotassium phosphate are unnecessary additives.'
WHERE brand = 'General Mills' AND name = 'Cheerios Original';

-- Mrs. Meyer's Clean Day Multi-Surface Cleaner: 68 → 55
-- Contains fragrance — NonToxicDad is strict: NO synthetic fragrance in any cleaning product
UPDATE public.products
SET score = 55,
    verdict = 'caution',
    summary = 'Plant-derived cleaning agents are a step up from conventional cleaners. However, contains "fragrance" which can hide dozens of undisclosed chemicals including potential phthalates and hormone disruptors. The lavender scent is not pure essential oil.',
    dads_take = 'Mrs. Meyer''s looks clean with the farmhouse branding, but flip it over and you see "fragrance" — the one word that can hide hundreds of undisclosed chemicals. A truly clean cleaner does not need synthetic fragrance. Branch Basics and Seventh Generation Free & Clear prove that.'
WHERE brand = 'Mrs. Meyer''s' AND name = 'Clean Day Multi-Surface Cleaner Lavender';

-- Method All-Purpose Cleaner: 72 → 62
-- Contains SLS (even plant-derived, it's still SLS) and fragrance
-- NonToxicDad lists SLS and fragrance in his top 10 to avoid
UPDATE public.products
SET score = 62,
    verdict = 'caution',
    summary = 'Plant-based formula in recycled packaging, which is commendable. But contains sodium lauryl sulfate (even plant-derived SLS is still an irritant) and fragrance (even "naturally derived" fragrance can contain undisclosed compounds).',
    dads_take = 'Method gets credit for plant-based surfactants and recycled packaging. But plant-derived SLS is still SLS — it is an irritant. And "naturally derived fragrance" is still fragrance with undisclosed ingredients. Close but not quite clean enough.'
WHERE brand = 'Method' AND name = 'All-Purpose Cleaner Pink Grapefruit';

-- Method Foaming Hand Wash: 72 → 52
-- Contains methylisothiazolinone — a preservative the EU RESTRICTED in leave-on products
-- Also contains fragrance and colorant
UPDATE public.products
SET score = 52,
    verdict = 'caution',
    summary = 'Plant-based soap with naturally derived surfactants, but contains methylisothiazolinone (MI) — a preservative the EU restricted in leave-on products due to high allergic reaction rates. Also contains fragrance and colorant.',
    dads_take = 'Methylisothiazolinone caused so many allergic reactions that the EU restricted it. Method still uses it in their hand soap. Add in fragrance and colorant, and this is not the clean soap the branding suggests. Dr. Bronner''s or EO Products are truly clean.'
WHERE brand = 'Method' AND name = 'Foaming Hand Wash Coconut Water & Mango';

-- Horizon Organic Chocolate Milk: 68 → 60
-- 22g sugar, gellan gum, "organic natural flavor," cocoa processed with alkali
UPDATE public.products
SET score = 60,
    verdict = 'caution',
    summary = 'Organic milk base is good, but contains 22 grams of sugar, gellan gum (thickener), "organic natural flavor" (undisclosed), and cocoa processed with alkali (strips antioxidants). Better than Nesquik but still a sweetened, processed beverage.',
    dads_take = 'Organic milk is great. But 22 grams of added sugar, gellan gum, and "natural flavor" take it down. The cocoa is alkali-processed which destroys the antioxidants. If you want chocolate milk, mix organic milk with real cocoa powder and a touch of honey.'
WHERE brand = 'Horizon Organic' AND name = 'Organic Chocolate Whole Milk';

-- ============================================================
-- PRODUCTS STAYING "SAFE" BUT SCORE REDUCED
-- ============================================================

-- Native Deodorant: 84 → 68
-- Contains synthetic "fragrance" — undisclosed chemicals
-- NonToxicDad is strict: any product with "fragrance" on the label gets dinged
UPDATE public.products
SET score = 68,
    summary = 'Aluminum-free deodorant with coconut oil and tapioca starch. No parabens, sulfates, or phthalates. However, most scented varieties contain synthetic "fragrance" — an undisclosed blend of chemicals. The unscented version is cleaner.',
    dads_take = 'Native gets a lot of credit for being aluminum-free, but most scented versions still use synthetic fragrance — the one ingredient that can hide hundreds of chemicals. The unscented version is the only truly clean option. For scented, look for brands that use only essential oils.'
WHERE brand = 'Native' AND name = 'Deodorant Coconut & Vanilla';

-- Native Shampoo: 82 → 70
-- Contains "fragrance" and acrylates copolymer (synthetic plastic polymer)
UPDATE public.products
SET score = 70,
    summary = 'Sulfate-free and paraben-free, which is a good start. No DMDM hydantoin or formaldehyde releasers. However, contains synthetic "fragrance" (undisclosed chemicals) and acrylates copolymer (synthetic polymer).',
    dads_take = 'Native shampoo avoids the worst offenders — no SLS, no parabens, no formaldehyde releasers. But it still has synthetic fragrance and a plastic polymer. Better than TRESemmé by miles, but truly clean shampoos skip the fragrance entirely.'
WHERE brand = 'Native' AND name = 'Shampoo & Conditioner Coconut & Vanilla';

-- All-Clad D3 Stainless Steel: 94 → 78
-- 18/10 stainless steel contains nickel — NonToxicDad specifically flags this
UPDATE public.products
SET score = 78,
    summary = 'High-quality tri-ply stainless steel with no coatings or chemicals. However, 18/10 grade stainless steel contains 10% nickel, which can leach into food especially with acidic cooking (tomato sauce, vinegar, citrus). For sensitive individuals, 18/0 or carbon steel is safer.',
    dads_take = 'All-Clad is excellent cookware, but 18/10 stainless steel means 10% nickel. Nickel leaches into food when you cook acidic ingredients — tomato sauce, lemon, vinegar. It is still far safer than Teflon, but carbon steel or cast iron are the gold standard for zero-chemical cooking.'
WHERE brand = 'All-Clad' AND name = 'D3 Stainless Steel Fry Pan';

-- GreenPan Ceramic Nonstick: 92 → 82
-- Ceramic coatings — NonToxicDad flags lead leaching risk at extreme heat
UPDATE public.products
SET score = 82,
    summary = 'Thermolon ceramic coating made from silicon dioxide (sand). Free from PFAS, PFOA, lead, and cadmium in testing. However, some ceramic coatings can degrade at very high temperatures, and the long-term safety data is newer compared to cast iron or carbon steel.',
    dads_take = 'GreenPan is a massive upgrade from Teflon — no PFAS, no toxic fumes. But ceramic coatings are relatively new, and some experts raise questions about what happens at extreme heat over time. Cast iron and carbon steel have centuries of proven safety. GreenPan is good; cast iron is bulletproof.'
WHERE brand = 'GreenPan' AND name = 'Valencia Pro Ceramic Nonstick 11-Piece Set';

-- KIND bars: 75 → 68
-- Palm kernel oil, sugar, soy lecithin
UPDATE public.products
SET score = 68,
    summary = 'Whole nuts as the first ingredient is positive. No artificial ingredients, corn syrup, or seed oils. However, contains palm kernel oil, added sugar, and soy lecithin. Cleaner than most bars but not as clean as two-ingredient bars like Lärabar.',
    dads_take = 'KIND is decent — nuts first, no corn syrup. But palm kernel oil is a processed fat, and there is added sugar and soy lecithin. For a truly clean bar, Lärabar uses just two ingredients (cashews and dates). KIND is a B, not an A.'
WHERE brand = 'KIND' AND name = 'Nut Bar Dark Chocolate Nuts & Sea Salt';

-- Applegate Organic Chicken Nuggets: 78 → 72
-- Contains organic expeller-pressed canola oil (still a seed oil)
UPDATE public.products
SET score = 72,
    summary = 'Much cleaner than conventional nuggets — organic chicken, organic bread crumbs, humanely raised. However, uses organic expeller-pressed canola oil, which is still a seed oil even in its organic form. The oil is expeller-pressed (no hexane) which is better.',
    dads_take = 'Applegate is the best frozen chicken nugget on the market. But canola oil is still a seed oil, even organic. Expeller-pressed means no hexane extraction, which helps. If you can bread and bake your own nuggets in avocado oil, that is the cleanest path.'
WHERE brand = 'Applegate Naturals' AND name = 'Organic Chicken Nuggets';

-- Olipop Vintage Cola: 80 → 75
-- Contains "natural flavors" (undisclosed) and stevia
UPDATE public.products
SET score = 75,
    summary = 'Prebiotic soda with only 2g sugar — a massive improvement over conventional soda. Contains cassava root fiber and botanical extracts. However, uses "natural flavors" (undisclosed ingredients) and stevia leaf extract.',
    dads_take = 'Olipop is the best soda alternative out there — 2 grams of sugar vs 39 in Coca-Cola, plus prebiotics. But "natural flavors" is still an umbrella term for undisclosed ingredients. Not a dealbreaker, but truly clean means full transparency.'
WHERE brand = 'Olipop' AND name = 'Vintage Cola';

-- Honest Kids juice: 78 → 72
-- Contains "natural flavor" and juice concentrates
UPDATE public.products
SET score = 72,
    summary = 'USDA Organic with no added sugar or artificial anything. Only 35 calories per box. However, uses "natural flavor" (undisclosed) and juice concentrates rather than whole juice. Better than Capri Sun but still processed.',
    dads_take = 'Best juice box option for kids, hands down. Organic, no added sugar, no dyes. But "natural flavor" is still an undisclosed ingredient, and concentrate is more processed than whole juice. Still, compared to Capri Sun or Kool-Aid, this is a home run.'
WHERE brand = 'Honest Kids' AND name = 'Organic Apple Juice Boxes';

-- Burt's Bees Lip Balm: 85 → 72
-- Contains soybean oil and canola oil (seed oils), plus lanolin
UPDATE public.products
SET score = 72,
    summary = 'Beeswax-based lip balm with coconut oil and peppermint — much better than petroleum-based ChapStick. However, also contains soybean oil and canola oil (seed oils) and lanolin (can cause reactions in some people).',
    dads_take = 'Burt''s Bees is the go-to "natural" lip balm, but check the fine print — soybean oil and canola oil are in there. Those are seed oils going directly onto your lips, which you inevitably lick. Look for lip balms with just beeswax, coconut oil, and shea butter.'
WHERE brand = 'Burt''s Bees' AND name = 'Beeswax Lip Balm';

-- SheaMoisture Shampoo: 78 → 70
-- Contains fragrance, glycol stearate, sodium chloride — some synthetic ingredients
UPDATE public.products
SET score = 70,
    summary = 'Shea butter base is genuinely nourishing, and it uses gentler surfactants than conventional shampoos. No SLS, parabens, or formaldehyde releasers. However, contains "fragrance" (undisclosed chemicals) and glycol stearate.',
    dads_take = 'SheaMoisture is a decent mid-range option — real shea butter, no SLS, no parabens. But "fragrance" on the label means undisclosed chemicals in your shampoo. The brand has good intentions but has not gone fully clean yet.'
WHERE brand = 'SheaMoisture' AND name = 'Coconut & Hibiscus Curl & Shine Shampoo';

-- TheraBreath mouthwash: 82 → 75
-- Contains PEG-40 Hydrogenated Castor Oil and tetrasodium EDTA
-- NonToxicDad flags PEGs as potential carcinogen contaminants
UPDATE public.products
SET score = 75,
    summary = 'Alcohol-free mouthwash with chlorine dioxide that targets odor-causing bacteria. Much better than Listerine. However, contains PEG-40 Hydrogenated Castor Oil (ethoxylated, potential 1,4-dioxane contamination) and tetrasodium EDTA.',
    dads_take = 'Alcohol-free and actually targets bad breath bacteria — that is the right approach. But PEG-40 is an ethoxylated ingredient with potential contamination concerns. It is still leagues better than Listerine, but not quite as clean as it could be.'
WHERE brand = 'TheraBreath' AND name = 'Fresh Breath Oral Rinse Mild Mint';

-- Nature Made Vitamin D3: 82 → 68
-- Contains soybean oil (seed oil!) as the primary carrier
UPDATE public.products
SET score = 68,
    summary = 'Simple vitamin D3 supplement with only a few ingredients. However, uses soybean oil as the primary carrier — a seed oil extracted with hexane solvents. Gelatin capsule is from conventional (non-organic) sources.',
    dads_take = 'Soybean oil is the first ingredient in your vitamin D supplement. It is a seed oil that is likely GMO and extracted with hexane. You are taking a vitamin for health... in a seed oil base. Look for vitamin D3 in olive oil or coconut oil carrier instead.'
WHERE brand = 'Nature Made' AND name = 'Vitamin D3 2000 IU (50 mcg)';

-- Sherwin-Williams Harmony: 85 → 78
-- Contains propylene glycol (NonToxicDad's top 10 avoid list) and titanium dioxide
UPDATE public.products
SET score = 78,
    summary = 'Zero-VOC paint with antimicrobial properties — good for reducing indoor air pollution. However, contains propylene glycol (a skin irritant on NonToxicDad''s avoid list) and titanium dioxide (oxidative stress concerns).',
    dads_take = 'Zero VOC is a great start, and Harmony is better than most paints. But propylene glycol and titanium dioxide are still in the formula. ECOS Paints and Benjamin Moore Natura are cleaner options if you want to go the extra mile.'
WHERE brand = 'Sherwin-Williams' AND name = 'Harmony Interior Acrylic Latex';

-- Earth Breeze laundry sheets: 88 → 80
-- Contains sodium dodecyl sulfate (SDS/SLS - same thing) and primary alcohol ethoxylate
UPDATE public.products
SET score = 80,
    summary = 'Zero-waste laundry sheets that eliminate plastic jugs — great for the environment. Free from parabens, phthalates, phosphates, and dyes. However, contains sodium dodecyl sulfate (another name for SLS) and primary alcohol ethoxylate (ethoxylated ingredient).',
    dads_take = 'Love the zero-waste concept and the elimination of plastic jugs. But sodium dodecyl sulfate IS sodium lauryl sulfate — just a different name. And ethoxylated ingredients carry 1,4-dioxane contamination risk. Branch Basics concentrate is the cleaner laundry option.'
WHERE brand = 'Earth Breeze' AND name = 'Laundry Detergent Sheets Fresh Scent';

-- Every Man Jack conditioner: 80 → 75
-- Contains phenoxyethanol and stearamidopropyl dimethylamine
UPDATE public.products
SET score = 75,
    summary = 'No parabens, phthalates, dyes, or formaldehyde releasers. Uses shea butter and coconut oil for moisture. However, contains phenoxyethanol (synthetic preservative) and stearamidopropyl dimethylamine (synthetic conditioning agent).',
    dads_take = 'Every Man Jack avoids the worst offenders and uses real moisturizing ingredients. Phenoxyethanol is a safer preservative than parabens, but it is still synthetic. Good but not great — for a truly clean conditioner, look for brands with only essential oil preservation.'
WHERE brand = 'Every Man Jack' AND name = 'Daily Moisturizing Conditioner';

-- Babyganics Shampoo: 80 → 72
-- Contains acrylates copolymer (synthetic plastic), polyquaternium-10
UPDATE public.products
SET score = 72,
    summary = 'Fragrance-free baby wash with gentler surfactants than Johnson''s. No parabens, sulfates, or phthalates. However, contains acrylates copolymer (synthetic plastic polymer) and polyquaternium-10 (synthetic conditioning agent).',
    dads_take = 'Babyganics is much better than Johnson''s — fragrance-free is essential for baby products. But synthetic polymers like acrylates copolymer and polyquaternium are still synthetic chemicals on your baby''s skin. Tubby Todd or Earth Mama make even cleaner baby washes.'
WHERE brand = 'Babyganics' AND name = 'Shampoo + Body Wash Fragrance Free';

-- RXBAR: 88 → 82
-- Contains "natural flavors" — undisclosed under strict philosophy
UPDATE public.products
SET score = 82,
    summary = 'Clean protein bar made with egg whites, dates, and nuts. No added sugar, artificial colors, or preservatives. The ingredient list is on the front of the package. Minor concern: contains "natural flavors" (undisclosed).',
    dads_take = 'RXBAR is one of the cleanest bars out there — they literally put the ingredients on the front because they have nothing to hide. The only ding is "natural flavors" which is still undisclosed. Lärabar with just two ingredients edges it out for purity.'
WHERE brand = 'RXBAR' AND name = 'Protein Bar Chocolate Sea Salt';

-- Tom's of Maine toothpaste: 82 → 75
-- Contains carrageenan and SLS in some formulations
UPDATE public.products
SET score = 75,
    summary = 'Uses natural ingredients with fluoride for cavity protection. No artificial colors, flavors, or preservatives. However, contains carrageenan (controversial thickener linked to inflammation in some studies) and glycerin (can coat teeth).',
    dads_take = 'Tom''s is a classic "natural" brand, but the bar has been raised. Carrageenan is debated — some studies link it to gut inflammation. Boka and RiseWell use hydroxyapatite instead of fluoride and skip the carrageenan entirely. Tom''s is good; newer clean brands are better.'
WHERE brand = 'Tom''s of Maine' AND name = 'Whole Care Fluoride Toothpaste Peppermint';

-- Seventh Generation laundry detergent: 85 → 78
-- Contains SLS (plant-derived but still SLS) and lauramine oxide
UPDATE public.products
SET score = 78,
    summary = 'Free from dyes, artificial brighteners, and fragrances — EPA Safer Choice certified. However, contains sodium lauryl sulfate (plant-derived but still SLS, which NonToxicDad flags) and lauramine oxide.',
    dads_take = 'Seventh Generation is the gateway to clean laundry — free and clear, no fragrance, no dyes. But plant-derived SLS is still SLS. Branch Basics uses only coco glucoside and decyl glucoside — gentler plant surfactants. Seventh Gen is good; Branch Basics is great.'
WHERE brand = 'Seventh Generation' AND name = 'Free & Clear Liquid Laundry Detergent';

-- P.F. Candle Co soy candle: 82 → 75
-- Still uses "fine fragrance oils" even if phthalate-free
UPDATE public.products
SET score = 75,
    summary = 'Soy wax and cotton wick are much better than paraffin and lead wicks. Phthalate-free fragrance oils are a step up. However, "fragrance oils" are still synthetic compounds — not pure essential oils. Not fully transparent.',
    dads_take = 'Soy wax and cotton wick — great start. Phthalate-free fragrance oils — better than conventional. But "fragrance oils" are still synthetic, not essential oils from actual plants. For truly clean candles, look for 100% essential oil scented candles or beeswax.'
WHERE brand = 'P.F. Candle Co.' AND name = 'Soy Candle Amber & Moss';

-- Benjamin Moore Natura: 90 → 85
-- Contains propylene glycol and titanium dioxide
UPDATE public.products
SET score = 85,
    summary = 'Zero-VOC, zero-emission paint — excellent for indoor air quality. Asthma and allergy friendly certified. However, contains propylene glycol (irritant) and titanium dioxide (oxidative stress concerns). Still one of the cleanest mainstream paints available.',
    dads_take = 'Natura is one of the best paints you can buy — zero VOC, zero emissions, safe to sleep in the room same day. The propylene glycol and titanium dioxide are minor concerns in a paint context. ECOS Paints is the only cleaner option I know of.'
WHERE brand = 'Benjamin Moore' AND name = 'Natura Interior Paint';

-- Herbal Essences: 50 → 42
-- DMDM hydantoin (formaldehyde releaser) + SLS + synthetic fragrance + dyes
UPDATE public.products
SET score = 42,
    verdict = 'caution',
    summary = 'Despite "Bio:Renew" and botanical branding, still contains DMDM hydantoin (formaldehyde releaser), sodium laureth sulfate, sodium lauryl sulfate (double SLS), synthetic fragrance, and artificial dyes (Blue 1, Red 33). The plant imagery is misleading.',
    dads_take = 'Bio:Renew sounds clean, and the bottle has leaves and plants on it. But flip it over — DMDM hydantoin (formaldehyde releaser), TWO types of SLS, synthetic fragrance, AND artificial dyes. This is greenwashing at its finest. The ingredient list tells the real story.'
WHERE brand = 'Herbal Essences' AND name = 'Bio:Renew Argan Oil Shampoo';
