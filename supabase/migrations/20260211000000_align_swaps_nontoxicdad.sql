-- Align swaps scores with NonToxicDad's strict ingredient philosophy
-- Matches the product alignment done in 20260210230000_align_scores_nontoxicdad.sql
-- Key concerns: synthetic fragrance, PEGs, SLS, seed oils, titanium dioxide,
-- natural flavors, phenoxyethanol, chemical UV filters, nickel in 18/10 stainless,
-- ceramic coatings, carrageenan

-- ============================================================
-- SWAPS MOVING FROM "SAFE" TO "CAUTION" (score drops below 67)
-- ============================================================

-- CeraVe Daily Moisturizing Lotion: 84 → 58
-- Contains PEGs, dimethicone, phenoxyethanol — all on NonToxicDad's avoid list
UPDATE public.swaps SET
  score = 58,
  description = 'Dermatologist-developed lotion with ceramides and hyaluronic acid, but contains PEGs (polyethylene glycols), dimethicone (silicone), and phenoxyethanol — ingredients NonToxicDad flags as endocrine disruptors or irritants. Better than many drugstore options but far from truly clean.',
  why_better = 'Contains ceramides that support the skin barrier, and is fragrance-free. However, the PEGs, dimethicone, and phenoxyethanol are significant concerns. For a truly clean moisturizer, look to brands like Beautycounter, Cocokind, or Herbivore that avoid these ingredients entirely.'
WHERE id = '184ba876-2189-4978-8900-64a39ef566b7';

-- Mrs. Meyer's Clean Day Foaming Hand Soap: 83 → 52
-- Synthetic fragrance despite "clean" branding — classic greenwashing
UPDATE public.swaps SET
  score = 52,
  description = 'Plant-derived hand soap marketed as clean and natural, but contains synthetic fragrance — NonToxicDad''s #1 ingredient to avoid. "Essential oils" on the label doesn''t mean fragrance-free; the undisclosed fragrance blend can contain dozens of hidden chemicals including phthalates and endocrine disruptors.',
  why_better = 'Uses some plant-derived surfactants and avoids parabens. But the synthetic fragrance is a dealbreaker under strict non-toxic standards. Branch Basics, Dr. Bronner''s, or ATTITUDE are truly fragrance-free alternatives that don''t rely on greenwashed marketing.'
WHERE id = 'eeb229f9-8464-4f0b-84a8-ff9c22592375';

-- Mrs. Meyer's Clean Day Soy Candle: 82 → 50
-- Burning synthetic fragrance means actively inhaling chemicals
UPDATE public.swaps SET
  score = 50,
  description = 'Soy wax candle with cotton wick, but scented with synthetic fragrance oils. When you burn a candle with synthetic fragrance, you''re actively heating and inhaling those chemicals — phthalates, synthetic musks, and volatile organic compounds. Mrs. Meyer''s is a textbook greenwashing brand.',
  why_better = 'Soy wax and cotton wick are better than paraffin and lead wicks. But the synthetic fragrance negates the benefit when you''re literally combusting those chemicals into your breathing air. For truly clean candles, use 100% beeswax or soy with only essential oils, like from Fontana Candle Company or simply diffuse organic essential oils instead.'
WHERE id = '13d23523-b871-4c9f-a607-2d62a9b3bb33';

-- Supergoop! Unseen Sunscreen SPF 40: 85 → 55
-- Uses chemical UV filters (avobenzone, homosalate, octisalate, octocrylene) — not mineral
UPDATE public.swaps SET
  score = 55,
  description = 'Invisible-finish sunscreen that uses chemical UV filters (avobenzone, homosalate, octisalate, octocrylene) — NOT a mineral sunscreen despite marketing. Chemical filters are absorbed into the bloodstream and have been detected in breast milk. NonToxicDad strongly recommends mineral-only (zinc oxide) sunscreens.',
  why_better = 'Goes on invisible with no white cast, which is appealing. But the chemical UV filters are absorbed systemically and have endocrine-disrupting potential. Mineral sunscreens from Thinkbaby, Badger, or All Good use zinc oxide that sits on top of the skin and physically blocks UV without absorption.'
WHERE id = 'e751bf95-46b9-4bd4-b158-52a512865919';

-- ============================================================
-- SWAPS STAYING "SAFE" BUT WITH REDUCED SCORES
-- ============================================================

-- Native Classic Deodorant: 85 → 68
-- Uses synthetic fragrance ("fragrance" in ingredient list)
UPDATE public.swaps SET
  score = 68,
  description = 'Aluminum-free deodorant with coconut oil and shea butter, but uses synthetic "fragrance" — an undisclosed blend that can contain dozens of hidden chemicals including phthalates. A decent first step away from antiperspirants but not a truly clean product.',
  why_better = 'Removes aluminum, parabens, and sulfates found in conventional antiperspirants. Widely available at Target and grocery stores, making it an accessible first swap. But the synthetic fragrance keeps it from being truly clean — Primally Pure or Each & Every are better long-term choices.'
WHERE id = '7e05f778-9156-4974-95d9-ec1946b4beda';

-- All-Clad D3 Stainless Steel Fry Pan: 94 → 78
-- 18/10 stainless steel contains nickel, which leaches into food when heated
UPDATE public.swaps SET
  score = 78,
  description = 'American-made tri-ply stainless steel with no chemical coatings, but uses 18/10 stainless steel which contains 10% nickel. Nickel leaches into food during cooking, especially with acidic foods. NonToxicDad recommends carbon steel or cast iron over 18/10 stainless.',
  why_better = 'Eliminates PFAS, PTFE, and all chemical nonstick coatings. Much safer than Teflon. However, the nickel content in 18/10 stainless is a concern for those sensitive to nickel or following strict non-toxic standards. Lodge cast iron or de Buyer carbon steel are the cleanest cookware choices.'
WHERE id = '20373d03-726f-4083-b916-01894dc53614';

-- GreenPan Ceramic Nonstick: 93 → 82
-- Ceramic coatings can degrade at high temperatures, releasing particles
UPDATE public.swaps SET
  score = 82,
  description = 'Thermolon ceramic nonstick coating free from PFAS and PTFE. A significant improvement over Teflon, but ceramic coatings degrade over time and at high temperatures. NonToxicDad notes that no coating is truly permanent — pure ceramic (Xtrema) or seasoned cast iron are safer long-term choices.',
  why_better = 'Eliminates PFAS/PFOA forever chemicals from Teflon cookware. Thermolon coating is mineral-based and doesn''t release toxic fumes. However, ceramic coatings chip and degrade over 1-3 years, potentially releasing particles. For lifetime cookware, choose Lodge cast iron, de Buyer carbon steel, or Xtrema pure ceramic.'
WHERE id = '2e32a701-ec4c-4922-963e-781ce05ef1ae';

-- Caraway Ceramic Cookware: 90 → 82
-- Same ceramic coating concerns as GreenPan
UPDATE public.swaps SET
  score = 82,
  description = 'Stylish ceramic-coated cookware free from PTFE, PFOA, PFAS, lead, and cadmium. Better than Teflon, but uses a mineral-based ceramic coating that degrades over time and at high heat. NonToxicDad prefers uncoated cookware — cast iron, carbon steel, or 100% pure ceramic — for lifelong safety.',
  why_better = 'Removes PFAS forever chemicals and toxic fumes from conventional nonstick. Beautiful design with storage solutions. But ceramic coatings have a 1-3 year lifespan before degrading. For truly permanent non-toxic cookware, choose Lodge cast iron, de Buyer carbon steel, or Xtrema pure ceramic.'
WHERE id = '9e0df756-ea9c-426e-8ba5-d3900e62ca1a';

-- Blue Lizard Sensitive Mineral Sunscreen: 88 → 75
-- Contains titanium dioxide — on NonToxicDad's top 10 avoid list
UPDATE public.swaps SET
  score = 75,
  description = 'Mineral-only sunscreen using zinc oxide AND titanium dioxide. While mineral sunscreens are much safer than chemical UV filters, titanium dioxide is on NonToxicDad''s top 10 ingredients to avoid due to concerns about nanoparticles and potential carcinogenicity when inhaled. Zinc-oxide-only sunscreens are the safest choice.',
  why_better = 'Mineral-only formula is vastly safer than chemical sunscreens with oxybenzone. But the titanium dioxide is a concern — look for zinc-oxide-only sunscreens like Thinkbaby, Badger, or All Good that skip TiO2 entirely for the cleanest sun protection.'
WHERE id = 'c9bd96b0-012e-4fce-97b8-f086ab1632c0';

-- P.F. Candle Co. Soy Candle: 86 → 75
-- Uses "fine fragrance oils" which are synthetic fragrances
UPDATE public.swaps SET
  score = 75,
  description = 'Hand-poured soy candle with cotton wick and no paraffin. However, uses "fine fragrance oils" — a cleaner-sounding term for synthetic fragrance. While phthalate-free, these fragrance oils still contain undisclosed synthetic chemicals that are heated and released into your air when the candle burns.',
  why_better = 'Soy wax and cotton wick are cleaner than paraffin and lead-core wicks. Phthalate-free fragrance oils are better than conventional fragrance. But for truly clean air, choose 100% beeswax candles scented only with essential oils, or use an ultrasonic essential oil diffuser like Vitruvi.'
WHERE id = '9f18d262-9227-4cda-af84-dfcfb43af445';

-- Earth Breeze Laundry Sheets: 91 → 80
-- Contains SDS (sodium dodecyl sulfate) / SLS and ethoxylated surfactants
UPDATE public.swaps SET
  score = 80,
  description = 'Ultra-concentrated laundry sheets that eliminate plastic jugs. Eco-friendly format, but contains sodium dodecyl sulfate (SDS/SLS) and ethoxylated surfactants which can be contaminated with 1,4-dioxane, a probable carcinogen. A good step forward for waste reduction, but not the cleanest formula.',
  why_better = 'Eliminates plastic waste from detergent jugs and removes many harsh chemicals. But SDS/SLS and ethoxylated surfactants are concerns under strict non-toxic standards. Branch Basics or Molly''s Suds offer cleaner formulas without SLS or ethoxylation contamination risk.'
WHERE id = 'ea191c66-57e8-4311-adae-b3fe0422668e';

-- Seventh Generation Free & Clear Laundry: 90 → 78
-- Contains SLS/sulfates
UPDATE public.swaps SET
  score = 78,
  description = 'EPA Safer Choice certified plant-based laundry detergent, free from dyes and synthetic fragrances. However, contains sodium lauryl sulfate (SLS) and surfactants that can be contaminated with 1,4-dioxane. Better than conventional detergents but not the cleanest option available.',
  why_better = 'Removes synthetic fragrances, optical brighteners, and dyes from your laundry routine. EPA Safer Choice certified. But SLS is on NonToxicDad''s top 10 avoid list, and ethoxylated surfactants carry 1,4-dioxane contamination risk. Branch Basics concentrate is the gold standard.'
WHERE id = 'b4b4e4e3-d14e-458d-84d9-b8efbee23be4';

-- Tom's of Maine Toothpaste: 87 → 75
-- Contains carrageenan, a controversial thickener linked to gut inflammation
UPDATE public.swaps SET
  score = 75,
  description = 'Fluoride-free natural toothpaste with zinc citrate for tartar control. However, contains carrageenan — a seaweed-derived thickener linked to gut inflammation and digestive issues in some studies. NonToxicDad recommends carrageenan-free oral care alternatives.',
  why_better = 'Avoids fluoride, triclosan, SLS, and artificial sweeteners found in conventional toothpaste. But the carrageenan is unnecessary and concerning. RiseWell or Boka hydroxyapatite toothpastes are cleaner alternatives that also actively remineralize enamel.'
WHERE id = 'ad139a57-3f10-4d2a-b793-06b7c988d2a0';

-- Babyganics Moisturizing Daily Lotion: 85 → 72
-- Contains acrylates copolymer (plastic film-forming agent)
UPDATE public.swaps SET
  score = 72,
  description = 'Plant-based baby lotion that is fragrance-free and pediatrician-tested. However, contains acrylates copolymer — a plastic-based film-forming agent — and other synthetic ingredients that are questionable for baby skin. "Babyganics" branding implies pure and natural but the formula has notable synthetic components.',
  why_better = 'Fragrance-free and hypoallergenic, which is important for baby skin. But the acrylates copolymer and other synthetic ingredients are concerning. Tubby Todd, Earth Mama, or California Baby offer truly clean baby lotions with simpler, more natural ingredient lists.'
WHERE id = '32afb62e-7002-4c8e-ab66-c2e8cad895f8';

-- Sherwin-Williams Harmony Interior Paint: 88 → 78
-- Contains propylene glycol and titanium dioxide
UPDATE public.swaps SET
  score = 78,
  description = 'Zero-VOC interior paint with antimicrobial properties and GREENGUARD Gold certification. However, still contains propylene glycol (a skin and respiratory irritant) and titanium dioxide (on NonToxicDad''s top 10 avoid list). Better than conventional paints but not the cleanest option.',
  why_better = 'Zero-VOC is a big improvement over conventional paints with high VOC levels. GREENGUARD Gold certified for low emissions. But propylene glycol and TiO2 are concerns under strict standards. ECOS Paints offers a truly zero-toxin formula without these ingredients.'
WHERE id = 'db6e6dff-6642-4744-848a-0b2e1d5368e9';

-- Benjamin Moore Natura: 90 → 85
-- Contains propylene glycol and titanium dioxide, but smaller amounts
UPDATE public.swaps SET
  score = 85,
  description = 'Zero-VOC, zero-emission interior paint with GREENGUARD Gold certification. One of the cleanest mainstream paint options, though still contains trace propylene glycol and titanium dioxide pigment. Asthma and allergy friendly.',
  why_better = 'Zero-VOC formula with zero emissions from the start. GREENGUARD Gold certified for schools and healthcare. One of the best mainstream options, with only minor concerns about propylene glycol and TiO2 pigment. ECOS Paints is the only clearly cleaner alternative.'
WHERE id = 'c5429874-e2d3-4259-a2a0-fc989169f158';

-- Olipop Vintage Cola: 83 → 75
-- Contains "natural flavors" — undisclosed ingredient blend
UPDATE public.swaps SET
  score = 75,
  description = 'Prebiotic soda with plant fiber and botanicals, only 2-5g sugar per can. A massive improvement over conventional soda, but contains "natural flavors" — an undisclosed blend of chemicals that NonToxicDad flags as a transparency concern. You don''t know what''s actually in it.',
  why_better = 'Contains 9g prebiotic fiber, only 2g sugar vs 39g in Coke, and no artificial sweeteners. A great soda replacement. But "natural flavors" is a catch-all term that can hide hundreds of chemical compounds. For the cleanest fizzy drink, sparkling water with fresh fruit is the gold standard.'
WHERE id = '5d25e3f9-69f1-402d-bf85-269adf59c2a0';

-- RXBAR Protein Bar: 88 → 82
-- Contains "natural flavors"
UPDATE public.swaps SET
  score = 82,
  description = 'Clean protein bar with egg whites, dates, and nuts — minimal ingredient list displayed right on the front. However, most flavors contain "natural flavors" — an undisclosed blend that NonToxicDad flags. Otherwise one of the cleanest protein bars available.',
  why_better = 'Transparent, short ingredient list with real food: egg whites, dates, and nuts. No added sugar, seed oils, artificial sweeteners, or soy protein isolate. The "natural flavors" are the only concern — for those wanting to avoid it entirely, a handful of nuts and dates works just as well.'
WHERE id = '4613b37a-6e39-462c-bb3b-9f6be3ef83da';

-- Applegate Natural Uncured Hot Dogs: 79 → 72
-- Celery powder (natural nitrates), possibly canola oil; "Natural" not "Organic"
UPDATE public.swaps SET
  score = 72,
  description = 'Uncured hot dogs from grass-fed beef with no synthetic nitrates or artificial ingredients. However, uses celery powder as a curing agent — which still converts to nitrates/nitrites in the body. "Natural" line (not Organic) may also use conventional spices and flavoring.',
  why_better = 'Removes synthetic sodium nitrite, artificial colors, and chemical preservatives from conventional hot dogs. Grass-fed beef is better sourced. But celery powder nitrates are chemically identical in the body to synthetic nitrates. True clean eating means reducing processed meats overall.'
WHERE id = '2e39ad9c-47f0-4ee0-8e3e-5512bf4e8aec';

-- Burt's Bees Baby Shampoo & Wash: 88 → 75
-- Contains phenoxyethanol (preservative of concern); owned by Clorox
UPDATE public.swaps SET
  score = 75,
  description = 'Tear-free baby wash with 98.9% natural origin ingredients, sulfate-free and paraben-free. However, contains phenoxyethanol — a synthetic preservative that some studies link to nervous system effects in infants. Owned by Clorox, which has faced scrutiny for greenwashing its "natural" brands.',
  why_better = 'Sulfate-free and fragrance-free, which is better than conventional baby washes with SLS and synthetic fragrance. Widely available. But phenoxyethanol in a baby product is concerning under strict standards. Tubby Todd or Earth Mama offer baby washes without phenoxyethanol.'
WHERE id = 'ce7dbe01-8b98-412e-ad39-e6a3874d7633';

-- Giovanni 2chic Ultra-Moist Shampoo: 85 → 75
-- Contains phenoxyethanol and potentially harsh sulfonate surfactants
UPDATE public.swaps SET
  score = 75,
  description = 'Sulfate-free shampoo with avocado and olive oils, free from parabens and artificial colors. However, contains phenoxyethanol (a synthetic preservative of concern) and may use sodium C14-16 olefin sulfonate — a harsh surfactant that''s technically "not SLS" but similarly stripping.',
  why_better = 'Avocado and olive oil base is nourishing without synthetic silicones. Free from SLS, parabens, and artificial colors. But phenoxyethanol and potentially harsh sulfonate surfactants keep it from being truly clean. Attitude or Briogeo offer cleaner alternatives.'
WHERE id = '2e8a155c-7f03-4bf9-ba01-a32d205bb4b0';

-- MadeGood Granola Bars: 81 → 75
-- Contains "natural flavors" and sunflower oil (seed oil)
UPDATE public.swaps SET
  score = 75,
  description = 'Organic granola bars with hidden vegetable servings and top-9 allergen-free. Great for school lunches. However, contains "natural flavors" (undisclosed chemicals) and sunflower oil — a seed oil that NonToxicDad recommends avoiding due to its high omega-6 inflammatory profile.',
  why_better = 'Organic, allergen-free, and contains hidden veggies — genuinely better than conventional granola bars with TBHQ, BHT, and artificial colors. But the natural flavors and sunflower oil are concerns under strict standards. Simple Mills or Hu Kitchen snacks use cleaner oils and no natural flavors.'
WHERE id = '470e69f0-b26f-4bf8-8057-9118b750639a';

-- Drunk Elephant Protini Polypeptide Cream: 86 → 80
-- Contains phenoxyethanol preservative
UPDATE public.swaps SET
  score = 80,
  description = 'Protein-powered moisturizer free from the "Suspicious 6" (essential oils, drying alcohols, silicones, chemical sunscreens, fragrances, SLS). However, uses phenoxyethanol as a preservative — a synthetic chemical that some researchers flag for endocrine disruption potential.',
  why_better = 'Avoids silicones, fragrances, and SLS that most moisturizers rely on. Uses signal peptides and amino acids for anti-aging. The phenoxyethanol is the main concern — for a fully clean moisturizer, Beautycounter or Herbivore skip this preservative entirely.'
WHERE id = '6722d94b-5664-4949-be0d-e508578c3159';

-- Acure Curiously Clarifying Shampoo: 88 → 82
-- Contains phenoxyethanol
UPDATE public.swaps SET
  score = 82,
  description = 'Lemongrass and rosemary clarifying shampoo with 100% vegan, Fair Trade organic ingredients. Sulfate-free and paraben-free. Uses phenoxyethanol as a preservative — a synthetic chemical that is a minor concern under strict non-toxic standards, but otherwise a clean formula.',
  why_better = 'Plant-based formula with Fair Trade organic ingredients. Gently clarifies without sulfates, parabens, or silicones. The phenoxyethanol is a minor flag — Attitude or Briogeo offer comparable quality without this preservative.'
WHERE id = 'f4e72096-af88-4b50-9ed1-7afd5c656163';

-- Ecover Zero Dish Soap: 89 → 82
-- Owned by SC Johnson; may contain SLS-related plant-based surfactants
UPDATE public.swaps SET
  score = 82,
  description = 'Plant-based, fragrance-free dish soap in recycled packaging. Biodegradable formula. However, owned by SC Johnson (a conventional chemical company) and uses plant-based surfactants that may include SLS-derived ingredients. "Zero" fragrance is good but the surfactant base warrants scrutiny.',
  why_better = 'Fragrance-free and dye-free with biodegradable plant-based surfactants — better than Dawn or Palmolive. But corporate ownership by SC Johnson and potentially SLS-adjacent surfactants are concerns. Branch Basics or ATTITUDE Baby Bottle Wash are cleaner alternatives.'
WHERE id = 'a8a5d7ec-b37a-41d7-b28f-a036a0cf4351';
