-- Seed common toxic products into the products table and flag them on the avoid list
-- These are real, widely-available products in the US market

-- Food / Snacks
INSERT INTO public.products (name, brand, category, score, verdict, summary, source, on_avoid_list, avoid_reason)
VALUES
  ('Froot Loops', 'Kellogg''s', 'food', 25, 'toxic',
   'Contains Red 40, Yellow 5, Yellow 6, and Blue 1 — artificial petroleum-based dyes linked to hyperactivity in children.',
   'database_seed', true,
   'Contains multiple artificial petroleum-based dyes (Red 40, Yellow 5, Yellow 6, Blue 1) linked to hyperactivity and behavioral issues in children. Being phased out by the FDA.'),

  ('Flamin'' Hot Cheetos', 'Frito-Lay', 'food', 22, 'toxic',
   'Contains Red 40, Yellow 6, Yellow 5, and TBHQ preservative.',
   'database_seed', true,
   'Contains synthetic dyes (Red 40, Yellow 6, Yellow 5) linked to neurobehavioral problems in children, plus TBHQ preservative — a form of butane flagged by the EWG.'),

  ('Skittles Original', 'Mars/Wrigley', 'food', 20, 'toxic',
   'Contains the full roster of synthetic dyes plus titanium dioxide, banned as a food additive in the EU.',
   'database_seed', true,
   'Contains Red 40, Yellow 5, Yellow 6, Blue 1, Blue 2, and titanium dioxide — banned in the EU due to genotoxicity concerns.'),

  ('Lucky Charms', 'General Mills', 'food', 28, 'toxic',
   'Contains multiple artificial dyes and BHT preservative, a potential endocrine disruptor.',
   'database_seed', true,
   'Contains Red 40, Yellow 5, Yellow 6, Blue 1, and BHT (butylated hydroxytoluene) — flagged as a potential endocrine disruptor and restricted in some countries.'),

  ('Lunchables Turkey & Cheddar', 'Kraft Heinz', 'food', 30, 'toxic',
   'Contains sodium nitrite linked to cancer risk, artificial flavors, and has been flagged for lead and cadmium contamination.',
   'database_seed', true,
   'Contains sodium nitrite (classified as Group 1 carcinogen by WHO in processed meat), artificial flavors. Consumer Reports flagged Lunchables for lead and cadmium contamination.')
ON CONFLICT DO NOTHING;

-- Cleaning Products
INSERT INTO public.products (name, brand, category, score, verdict, summary, source, on_avoid_list, avoid_reason)
VALUES
  ('Fabuloso Multi-Purpose Cleaner', 'Colgate-Palmolive', 'cleaning', 32, 'toxic',
   'Contains undisclosed fragrance chemicals, synthetic colorants, and harsh surfactants.',
   'database_seed', true,
   'Contains synthetic fragrance (can include dozens of undisclosed chemicals including phthalates), synthetic colorants, and harsh surfactants. EWG gives it poor marks.'),

  ('Clorox Disinfecting Wipes', 'Clorox', 'cleaning', 35, 'caution',
   'Contains quaternary ammonium compounds linked to respiratory irritation and undisclosed fragrance chemicals.',
   'database_seed', true,
   'Contains quaternary ammonium compounds (quats) linked to respiratory irritation and occupational asthma, plus undisclosed fragrance chemicals.'),

  ('Lysol Disinfectant Spray', 'Reckitt', 'cleaning', 30, 'toxic',
   'Contains ethanolamine linked to asthma and reproductive toxicity, synthetic fragrance.',
   'database_seed', true,
   'Contains ethanolamine (linked to asthma and reproductive toxicity), synthetic fragrance, and creates airborne chemical particles when sprayed. EWG rates key ingredients as high concern for respiratory effects.'),

  ('Windex Original Glass Cleaner', 'SC Johnson', 'cleaning', 40, 'caution',
   'Contains 2-butoxyethanol which can be absorbed through skin and is linked to liver and kidney damage.',
   'database_seed', true,
   'Contains 2-butoxyethanol, a solvent that can be absorbed through the skin and linked to liver and kidney damage, plus ammonium hydroxide.')
ON CONFLICT DO NOTHING;

-- Personal Care / Cosmetics
INSERT INTO public.products (name, brand, category, score, verdict, summary, source, on_avoid_list, avoid_reason)
VALUES
  ('Axe Body Spray', 'Unilever', 'cosmetics', 25, 'toxic',
   'Contains synthetic fragrance rated 8/10 toxicity by EWG, undisclosed phthalates, and propellant chemicals.',
   'database_seed', true,
   'Contains synthetic fragrance (rated 8/10 toxicity by EWG), undisclosed phthalates as fragrance fixatives, and propellant chemicals. Some products recalled for benzene contamination.'),

  ('Secret Antiperspirant Original', 'Procter & Gamble', 'cosmetics', 35, 'caution',
   'Contains aluminum compounds that block sweat glands, synthetic fragrance, and propylene glycol.',
   'database_seed', true,
   'Contains aluminum zirconium tetrachlorohydrex (debated link to breast cancer), synthetic fragrance with undisclosed chemicals, and propylene glycol.'),

  ('Herbal Essences Shampoo', 'Procter & Gamble', 'cosmetics', 38, 'caution',
   'Contains SLES which creates 1,4-dioxane (a known carcinogen) during manufacturing, plus synthetic fragrance.',
   'database_seed', true,
   'Contains sodium laureth sulfate (SLES) — manufactured through ethoxylation that creates traces of 1,4-dioxane, a known carcinogen. Also contains synthetic fragrance and preservatives linked to contact dermatitis.'),

  ('CoverGirl LashBlast Mascara', 'Coty', 'cosmetics', 35, 'caution',
   'Contains parabens (endocrine disruptors that mimic estrogen), BHT, and synthetic fragrance.',
   'database_seed', true,
   'Contains parabens (propylparaben, butylparaben) — known endocrine disruptors that mimic estrogen. The EU has restricted several parabens in cosmetics; the US has not.')
ON CONFLICT DO NOTHING;

-- Baby Products
INSERT INTO public.products (name, brand, category, score, verdict, summary, source, on_avoid_list, avoid_reason)
VALUES
  ('Johnson''s Baby Shampoo', 'Johnson & Johnson', 'baby', 42, 'caution',
   'Historically contained formaldehyde-releasing preservatives. Still uses synthetic fragrance with undisclosed ingredients.',
   'database_seed', true,
   'Historically contained formaldehyde-releasing preservatives and 1,4-dioxane contaminant. Reformulated after pressure, but still uses synthetic fragrance. J&J paid $700M in settlement for consumer deception.'),

  ('Desitin Maximum Strength Diaper Cream', 'Johnson & Johnson', 'baby', 38, 'caution',
   'Contains fragrance, methylparaben, and BHT — applying endocrine disruptors to a baby''s sensitive skin.',
   'database_seed', true,
   'Contains fragrance, methylparaben (endocrine disruptor), and BHT applied to baby''s sensitive diaper area. Fragrance-free alternatives are widely available.')
ON CONFLICT DO NOTHING;

-- Laundry Products
INSERT INTO public.products (name, brand, category, score, verdict, summary, source, on_avoid_list, avoid_reason)
VALUES
  ('Tide Original Liquid Detergent', 'Procter & Gamble', 'laundry', 28, 'toxic',
   'EWG rates Tide as F grade. Contains synthetic fragrance, optical brighteners, sodium borate, and 1,4-dioxane contaminant.',
   'database_seed', true,
   'EWG F grade. Contains synthetic fragrance, optical brighteners that stay on clothes and contact skin all day, sodium borate (hormone concern), and 1,4-dioxane contaminant (carcinogen).'),

  ('Gain Original Liquid Detergent', 'Procter & Gamble', 'laundry', 25, 'toxic',
   'EWG rates Gain as F grade. Heavy synthetic fragrance with undisclosed phthalates.',
   'database_seed', true,
   'EWG F grade. A 2025 lawsuit alleged it contains a likely carcinogen. Heavy synthetic fragrance with undisclosed phthalates. The strong scent comes from a cocktail of synthetic chemicals.'),

  ('Bounce Dryer Sheets', 'Procter & Gamble', 'laundry', 20, 'toxic',
   'When heated in dryer, emits volatile organic compounds including acetaldehyde and benzene — both classified as carcinogens.',
   'database_seed', true,
   'Contains benzyl acetate, limonene, and dichlorobenzene. When heated, emits 25+ toxic compounds including acetaldehyde and benzene — both classified as carcinogens.'),

  ('Downy Fabric Softener April Fresh', 'Procter & Gamble', 'laundry', 30, 'toxic',
   'Coats fabrics with quats that stay in contact with skin. Contains synthetic fragrance with phthalates.',
   'database_seed', true,
   'Active ingredient (a quat) coats fabric fibers and stays in contact with skin. Contains synthetic fragrance with phthalates that function as endocrine disruptors. Linked to skin irritation and respiratory issues.'),

  ('Snuggle Fabric Softener Sheets', 'Henkel', 'laundry', 28, 'toxic',
   'Contains synthetic fragrance, quats, and releases VOCs when heated in dryer.',
   'database_seed', true,
   'Contains synthetic fragrance, quats (quaternary ammonium compounds), and releases VOCs when heated in dryer. Heavy fragrance designed to persist on clothing means prolonged skin contact.')
ON CONFLICT DO NOTHING;
