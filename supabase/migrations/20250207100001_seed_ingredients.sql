-- ============================================================================
-- Seed ingredients database with ~306 common toxic/concerning ingredients
-- Categories: preservative, sweetener, color, additive, flavor, emulsifier,
-- fragrance, surfactant, solvent, pesticide, heavy_metal, plastic, other
-- Upsert pattern: INSERT ON CONFLICT (slug) DO UPDATE
-- ============================================================================

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Butylated Hydroxyanisole',
  'bha',
  ARRAY['BHA', 'E320', 'tert-Butyl-4-hydroxyanisole', 'tert-butyl-4-methoxyphenol'],
  'preservative',
  8,
  ARRAY['possible carcinogen', 'endocrine disruptor', 'organ toxicity'],
  '{"acute": "May cause skin irritation and allergic reactions", "chronic": "Classified as reasonably anticipated to be a human carcinogen by NTP; linked to endocrine disruption and reproductive toxicity in animal studies", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "GRAS (limited to 0.02% of fat content)", "eu": "restricted", "notes": "Banned in Japan for certain uses; California requires warning labels under Prop 65"}',
  ARRAY['vitamin E (tocopherols)', 'rosemary extract', 'ascorbic acid'],
  ARRAY['cereals', 'snack foods', 'chewing gum', 'butter', 'cosmetics', 'rubber products'],
  ARRAY['NTP', 'IARC', 'EFSA', 'FDA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Butylated Hydroxytoluene',
  'bht',
  ARRAY['BHT', 'E321', 'dibutylhydroxytoluene', '2,6-di-tert-butyl-4-methylphenol', 'DBPC'],
  'preservative',
  7,
  ARRAY['possible carcinogen', 'endocrine disruptor', 'organ toxicity', 'developmental toxicity'],
  '{"acute": "May cause skin and eye irritation; allergic reactions in sensitive individuals", "chronic": "Some animal studies link to liver and kidney damage, thyroid disruption, and tumor promotion; mixed evidence on carcinogenicity", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "GRAS (limited to 0.02% of fat content)", "eu": "approved with limits", "notes": "Permitted in food in most countries with quantity limits; some studies show antioxidant benefits at low doses"}',
  ARRAY['vitamin E (tocopherols)', 'rosemary extract', 'ascorbic acid'],
  ARRAY['cereals', 'snack foods', 'chewing gum', 'cosmetics', 'packaging materials'],
  ARRAY['EFSA', 'FDA', 'EWG', 'CSPI', 'NTP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Tertiary Butylhydroquinone',
  'tbhq',
  ARRAY['TBHQ', 'E319', 'tert-Butylhydroquinone', 'tBHQ', 'tertiary butylhydroquinone'],
  'preservative',
  7,
  ARRAY['possible carcinogen', 'immune system effects', 'behavioral effects'],
  '{"acute": "Nausea, vomiting, tinnitus, and delirium at high doses (5g+)", "chronic": "Animal studies show stomach tumors at high doses; may impair immune response and worsen allergies; linked to hyperactivity in children", "vulnerable_groups": ["children", "individuals with allergies"]}',
  '{"fda": "GRAS (limited to 0.02% of fat content)", "eu": "approved with limits", "notes": "Banned in Japan; restricted in some countries; commonly used in fast food frying oils"}',
  ARRAY['vitamin E (tocopherols)', 'rosemary extract', 'citric acid'],
  ARRAY['fast food', 'frozen foods', 'crackers', 'microwave popcorn', 'cooking oils'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'EWG', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Benzoate',
  'sodium-benzoate',
  ARRAY['E211', 'benzoate of soda', 'sodium salt of benzoic acid'],
  'preservative',
  5,
  ARRAY['benzene formation with vitamin C', 'hyperactivity in children', 'allergic reactions'],
  '{"acute": "Generally well tolerated; may trigger hives or asthma in sensitive individuals", "chronic": "When combined with ascorbic acid (vitamin C), can form benzene, a known carcinogen; Southampton study linked to hyperactivity in children", "vulnerable_groups": ["children", "asthmatics", "individuals with urticaria"]}',
  '{"fda": "GRAS (up to 0.1%)", "eu": "approved (E211) with limits", "notes": "EU requires warning label when used with certain colorants: may have an adverse effect on activity and attention in children"}',
  ARRAY['potassium sorbate (lower risk)', 'citric acid', 'rosemary extract'],
  ARRAY['soft drinks', 'fruit juices', 'pickles', 'salad dressings', 'condiments', 'cosmetics'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Southampton University', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Potassium Sorbate',
  'potassium-sorbate',
  ARRAY['E202', 'sorbic acid potassium salt', 'potassium (E,E)-hexa-2,4-dienoate'],
  'preservative',
  3,
  ARRAY['mild skin irritant', 'rare allergic reactions', 'genotoxicity concerns at very high doses'],
  '{"acute": "Generally well tolerated; rare skin or eye irritation on direct contact", "chronic": "Considered one of the safer preservatives; some in-vitro studies show genotoxic potential at concentrations far above food-use levels, but not confirmed in vivo", "vulnerable_groups": ["individuals with sensitive skin"]}',
  '{"fda": "GRAS", "eu": "approved (E202)", "notes": "Widely regarded as one of the safest synthetic preservatives; approved globally with generous limits"}',
  ARRAY['rosemary extract', 'citric acid', 'fermented filtrates'],
  ARRAY['cheese', 'wine', 'baked goods', 'dried fruits', 'personal care products'],
  ARRAY['FDA', 'EFSA', 'WHO', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Nitrite',
  'sodium-nitrite',
  ARRAY['E250', 'nitrous acid sodium salt', 'NaNO2'],
  'preservative',
  8,
  ARRAY['nitrosamine formation', 'probable carcinogen', 'methemoglobinemia'],
  '{"acute": "Toxic at high doses; can cause methemoglobinemia (blue baby syndrome), headache, dizziness, nausea", "chronic": "Reacts with amines in meat to form nitrosamines, classified as probable carcinogens by IARC (Group 2A); strongly linked to colorectal cancer risk", "vulnerable_groups": ["children", "infants", "pregnant women"]}',
  '{"fda": "approved (limited to 200 ppm in finished product)", "eu": "approved (E250) with strict limits", "notes": "IARC classified processed meat (preserved with nitrites) as Group 1 carcinogen; essential for preventing botulism in cured meats"}',
  ARRAY['celery powder (natural nitrite source)', 'cherry powder', 'uncured/nitrite-free meats'],
  ARRAY['bacon', 'hot dogs', 'deli meats', 'ham', 'sausages', 'cured meats'],
  ARRAY['IARC', 'WHO', 'FDA', 'EFSA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Nitrate',
  'sodium-nitrate',
  ARRAY['E251', 'Chile saltpeter', 'NaNO3', 'soda niter'],
  'preservative',
  7,
  ARRAY['converts to nitrite in body', 'nitrosamine formation', 'carcinogen risk'],
  '{"acute": "Can cause nausea, vomiting, and diarrhea at high doses; contributes to methemoglobinemia", "chronic": "Converts to sodium nitrite in the body, which can then form carcinogenic nitrosamines; associated with increased colorectal cancer risk", "vulnerable_groups": ["children", "infants", "pregnant women"]}',
  '{"fda": "approved (limited to 500 ppm in finished product)", "eu": "approved (E251) with limits", "notes": "Often used alongside sodium nitrite in cured meats; also found naturally in vegetables like spinach and beets at higher levels"}',
  ARRAY['celery powder', 'sea salt', 'uncured meat alternatives'],
  ARRAY['cured meats', 'bacon', 'jerky', 'corned beef', 'smoked fish'],
  ARRAY['IARC', 'WHO', 'FDA', 'EFSA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Methylparaben',
  'methylparaben',
  ARRAY['E218', 'methyl 4-hydroxybenzoate', 'methyl parahydroxybenzoate', 'Nipagin M', 'methyl p-hydroxybenzoate'],
  'preservative',
  6,
  ARRAY['endocrine disruptor', 'estrogenic activity', 'skin sensitizer'],
  '{"acute": "Generally low acute toxicity; may cause skin irritation or allergic contact dermatitis in sensitive individuals", "chronic": "Exhibits weak estrogenic activity; detected in breast tumor tissue (though causal link not established); may interfere with reproductive hormones", "vulnerable_groups": ["children", "pregnant women", "infants"]}',
  '{"fda": "GRAS for food use; approved in cosmetics", "eu": "approved with concentration limits (0.4% single / 0.8% mixture in cosmetics)", "notes": "Considered the least concerning of the parabens due to shorter carbon chain; EU banned in leave-on products for children under 3 (for propyl/butylparaben, not methyl)"}',
  ARRAY['phenoxyethanol', 'sodium benzoate', 'potassium sorbate', 'ethylhexylglycerin'],
  ARRAY['moisturizers', 'shampoos', 'shaving gels', 'personal lubricants', 'topical pharmaceuticals', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'EWG', 'CIR', 'SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Propylparaben',
  'propylparaben',
  ARRAY['E216', 'propyl 4-hydroxybenzoate', 'propyl parahydroxybenzoate', 'Nipasol M', 'propyl p-hydroxybenzoate'],
  'preservative',
  7,
  ARRAY['endocrine disruptor', 'estrogenic activity', 'reproductive toxicity', 'skin sensitizer'],
  '{"acute": "Low acute toxicity; potential skin sensitizer and allergen", "chronic": "Stronger estrogenic activity than methylparaben; linked to decreased sperm counts in animal studies; detected in breast cancer tissue; may affect fertility", "vulnerable_groups": ["children", "pregnant women", "infants", "adolescents"]}',
  '{"fda": "GRAS for food use", "eu": "restricted (banned in leave-on cosmetics for children under 3; max 0.14% in cosmetics)", "notes": "Denmark banned propylparaben and butylparaben in products for children under 3 in 2011; EU followed with restrictions"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate', 'natural preservative systems'],
  ARRAY['cosmetics', 'lotions', 'sunscreens', 'shampoos', 'food products', 'pharmaceuticals'],
  ARRAY['FDA', 'EFSA', 'SCCS', 'EWG', 'Danish EPA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Butylparaben',
  'butylparaben',
  ARRAY['butyl 4-hydroxybenzoate', 'butyl parahydroxybenzoate', 'Butaben', 'butyl p-hydroxybenzoate'],
  'preservative',
  8,
  ARRAY['endocrine disruptor', 'strong estrogenic activity', 'reproductive toxicity', 'developmental toxicity'],
  '{"acute": "Low acute toxicity; potential allergen and skin sensitizer", "chronic": "Strongest estrogenic activity among common parabens; linked to reproductive harm, decreased testosterone, altered sperm in animal studies; associated with breast cancer cell proliferation in vitro", "vulnerable_groups": ["children", "pregnant women", "infants", "adolescents"]}',
  '{"fda": "approved for cosmetics use", "eu": "restricted (max 0.14% in cosmetics; banned in leave-on products for children under 3)", "notes": "Banned in Denmark for children''s products; some major retailers have voluntarily removed from products; ASEAN countries have restrictions"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate', 'natural preservative systems'],
  ARRAY['cosmetics', 'lotions', 'foundations', 'eye shadows', 'moisturizers'],
  ARRAY['SCCS', 'EWG', 'FDA', 'Danish EPA', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ethylparaben',
  'ethylparaben',
  ARRAY['E214', 'ethyl 4-hydroxybenzoate', 'ethyl parahydroxybenzoate', 'Nipagin A', 'ethyl p-hydroxybenzoate'],
  'preservative',
  6,
  ARRAY['endocrine disruptor', 'estrogenic activity', 'skin sensitizer'],
  '{"acute": "Low acute toxicity; potential skin irritant and allergen", "chronic": "Weak estrogenic activity similar to methylparaben; less studied than methyl and propylparaben but shares class concerns; detected in human urine and breast tissue", "vulnerable_groups": ["children", "pregnant women", "infants"]}',
  '{"fda": "GRAS for food use; approved in cosmetics", "eu": "approved with concentration limits (0.4% single / 0.8% mixture)", "notes": "Considered moderate risk among parabens; fewer restrictions than propyl/butylparaben but same class of concern"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'potassium sorbate'],
  ARRAY['cosmetics', 'skin care', 'beverages', 'baked goods', 'pharmaceuticals'],
  ARRAY['FDA', 'EFSA', 'SCCS', 'EWG', 'CIR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Formaldehyde',
  'formaldehyde',
  ARRAY['methanal', 'methylene oxide', 'formalin', 'formol', 'CH2O'],
  'preservative',
  10,
  ARRAY['known carcinogen', 'respiratory irritant', 'skin sensitizer', 'immune toxicant'],
  '{"acute": "Severe eye, nose, and throat irritation; coughing; wheezing; skin burns and allergic contact dermatitis", "chronic": "IARC Group 1 known human carcinogen (nasopharyngeal cancer, leukemia); causes respiratory sensitization; associated with asthma", "vulnerable_groups": ["children", "pregnant women", "asthmatics", "workers with occupational exposure"]}',
  '{"fda": "not approved as direct food additive", "eu": "banned in cosmetics as intentional ingredient; limited as releaser (max 0.1% free formaldehyde)", "notes": "IARC Group 1 carcinogen; banned in cosmetics in EU, Japan, Sweden; still permitted in some products via formaldehyde-releasing preservatives"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate', 'formaldehyde-free keratin treatments'],
  ARRAY['nail polish', 'hair straightening treatments', 'building materials', 'pressed wood', 'some cosmetics'],
  ARRAY['IARC', 'NTP', 'OSHA', 'FDA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'DMDM Hydantoin',
  'dmdm-hydantoin',
  ARRAY['dimethylol dimethyl hydantoin', '1,3-bis(hydroxymethyl)-5,5-dimethylimidazolidine-2,4-dione', 'Glydant'],
  'preservative',
  8,
  ARRAY['formaldehyde releaser', 'carcinogen risk', 'skin sensitizer', 'allergen'],
  '{"acute": "Skin irritation, allergic contact dermatitis, eye irritation", "chronic": "Releases formaldehyde over time, a known carcinogen; continuous low-level exposure raises cancer concerns; common cause of contact allergy", "vulnerable_groups": ["children", "individuals with eczema", "sensitive skin"]}',
  '{"fda": "approved in cosmetics", "eu": "allowed with warning label (contains formaldehyde); restricted to 0.1% free formaldehyde", "notes": "Subject of major class-action lawsuits against Johnson & Johnson (2021); increasingly being removed from consumer products"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate', 'sorbic acid'],
  ARRAY['shampoos', 'conditioners', 'body wash', 'bubble bath', 'baby products'],
  ARRAY['FDA', 'EU SCCS', 'EWG', 'CIR', 'American Contact Dermatitis Society']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Imidazolidinyl Urea',
  'imidazolidinyl-urea',
  ARRAY['Germall 115', 'imidurea', 'N,N-methylenebis[N-[3-(hydroxymethyl)-2,5-dioxo-4-imidazolidinyl]urea]'],
  'preservative',
  7,
  ARRAY['formaldehyde releaser', 'skin sensitizer', 'allergen', 'contact dermatitis'],
  '{"acute": "Contact dermatitis, skin irritation, and allergic reactions", "chronic": "Releases formaldehyde gradually; associated with increased sensitization rates; one of the most common cosmetic allergens after fragrances", "vulnerable_groups": ["children", "individuals with eczema or sensitive skin"]}',
  '{"fda": "approved in cosmetics", "eu": "allowed with restrictions (must declare formaldehyde if above 0.05%)", "notes": "Named Contact Allergen of the Year by ACDS; being phased out by many clean beauty brands"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate', 'potassium sorbate'],
  ARRAY['lotions', 'creams', 'shampoos', 'baby wipes', 'cosmetics'],
  ARRAY['FDA', 'EU SCCS', 'EWG', 'CIR', 'ACDS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diazolidinyl Urea',
  'diazolidinyl-urea',
  ARRAY['Germall II', 'N-[1,3-bis(hydroxymethyl)-2,5-dioxo-4-imidazolidinyl]-N,N-bis(hydroxymethyl)urea'],
  'preservative',
  8,
  ARRAY['formaldehyde releaser', 'skin sensitizer', 'allergen', 'higher formaldehyde release than imidazolidinyl urea'],
  '{"acute": "Contact dermatitis, skin irritation, eye irritation, allergic reactions", "chronic": "Releases more formaldehyde than imidazolidinyl urea; significant sensitization risk; chronic exposure linked to formaldehyde-related carcinogenicity concerns", "vulnerable_groups": ["children", "individuals with sensitive skin", "eczema sufferers"]}',
  '{"fda": "approved in cosmetics", "eu": "allowed with restrictions and labeling requirements", "notes": "Releases more formaldehyde than Germall 115; being removed from many product lines; CIR approved with concentration limits"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'gluconolactone', 'sodium benzoate'],
  ARRAY['cosmetics', 'hair care', 'skin care', 'sunscreens', 'facial cleansers'],
  ARRAY['FDA', 'EU SCCS', 'EWG', 'CIR', 'ACDS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Quaternium-15',
  'quaternium-15',
  ARRAY['Dowicil 200', 'Dowicil 75', 'N-(3-chloroallyl)hexaminium chloride', 'cis-1-(3-chloroallyl)-3,5,7-triaza-1-azoniaadamantane chloride'],
  'preservative',
  9,
  ARRAY['formaldehyde releaser', 'potent sensitizer', 'known allergen', 'contact dermatitis'],
  '{"acute": "Strong skin sensitizer; causes contact dermatitis, irritation, and allergic reactions", "chronic": "Releases the most formaldehyde of all formaldehyde-releasing preservatives; chronic exposure increases cancer risk; top cosmetic allergen", "vulnerable_groups": ["children", "individuals with eczema", "sensitive skin", "occupational workers"]}',
  '{"fda": "approved in cosmetics", "eu": "restricted; labeling required", "notes": "Releases the highest amount of formaldehyde among common releasers; banned in some countries; ACDS Allergen of the Year 2005"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate', 'benzisothiazolinone'],
  ARRAY['shampoos', 'cosmetics', 'industrial products', 'latex paints', 'polishes'],
  ARRAY['FDA', 'EU SCCS', 'EWG', 'ACDS', 'CIR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Bronopol',
  'bronopol',
  ARRAY['2-bromo-2-nitropropane-1,3-diol', 'BNPD', 'Bronidox', 'E200 (cosmetic)', 'Myacide BT'],
  'preservative',
  7,
  ARRAY['formaldehyde releaser', 'nitrosamine formation', 'skin sensitizer', 'environmental toxicant'],
  '{"acute": "Skin and eye irritation; allergic contact dermatitis", "chronic": "Releases formaldehyde and can form nitrosamines (carcinogenic); environmental persistence concerns; toxic to aquatic organisms", "vulnerable_groups": ["children", "individuals with sensitive skin", "aquatic ecosystems"]}',
  '{"fda": "approved in cosmetics", "eu": "restricted (max 0.1% in cosmetics); must not form nitrosamines", "notes": "Must not be used with amines that could form nitrosamines; increasingly replaced in cosmetics formulations"}',
  ARRAY['phenoxyethanol', 'ethylhexylglycerin', 'sodium benzoate'],
  ARRAY['shampoos', 'wet wipes', 'cosmetics', 'industrial biocides', 'topical medications'],
  ARRAY['EU SCCS', 'FDA', 'EWG', 'CIR', 'ECHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Sulfite',
  'sodium-sulfite',
  ARRAY['E221', 'Na2SO3', 'sulfurous acid disodium salt', 'sodium sulphite'],
  'preservative',
  5,
  ARRAY['sulfite sensitivity', 'asthma trigger', 'allergic reactions', 'destroys vitamin B1'],
  '{"acute": "Can trigger severe asthmatic reactions, hives, flushing, and anaphylaxis in sulfite-sensitive individuals (affects ~1% of population, ~5% of asthmatics)", "chronic": "Destroys thiamine (vitamin B1); may contribute to nutritional deficiencies with heavy dietary exposure", "vulnerable_groups": ["asthmatics", "sulfite-sensitive individuals", "children"]}',
  '{"fda": "GRAS with labeling required above 10 ppm", "eu": "approved (E221) with limits and labeling", "notes": "FDA banned sulfites on fresh fruits and vegetables in 1986 after deaths; mandatory labeling when above 10 ppm"}',
  ARRAY['ascorbic acid', 'citric acid', 'rosemary extract'],
  ARRAY['wine', 'dried fruits', 'canned foods', 'photo processing', 'shrimp'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Bisulfite',
  'sodium-bisulfite',
  ARRAY['E222', 'sodium hydrogen sulfite', 'NaHSO3', 'sodium acid sulfite', 'sodium bisulphite'],
  'preservative',
  5,
  ARRAY['sulfite sensitivity', 'asthma trigger', 'allergic reactions', 'destroys vitamin B1'],
  '{"acute": "Severe asthmatic reactions, hives, and anaphylaxis in sulfite-sensitive individuals; eye and skin irritant on contact", "chronic": "Destroys thiamine (vitamin B1); potential for chronic respiratory issues with occupational exposure", "vulnerable_groups": ["asthmatics", "sulfite-sensitive individuals", "children"]}',
  '{"fda": "GRAS with labeling required above 10 ppm", "eu": "approved (E222) with limits", "notes": "Same class of concern as all sulfites; FDA labeling mandate applies"}',
  ARRAY['ascorbic acid', 'citric acid', 'rosemary extract'],
  ARRAY['wine', 'beer', 'dried fruits', 'canned vegetables', 'condiments'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Metabisulfite',
  'sodium-metabisulfite',
  ARRAY['E223', 'sodium pyrosulfite', 'Na2S2O5', 'disodium metabisulfite', 'sodium disulfite'],
  'preservative',
  5,
  ARRAY['sulfite sensitivity', 'asthma trigger', 'allergic reactions', 'skin irritant'],
  '{"acute": "Triggers severe asthma, bronchospasm, and anaphylaxis in sulfite-sensitive individuals; strong skin and eye irritant", "chronic": "Destroys thiamine; chronic inhalation exposure may cause respiratory damage", "vulnerable_groups": ["asthmatics", "sulfite-sensitive individuals", "children"]}',
  '{"fda": "GRAS with labeling requirements", "eu": "approved (E223) with limits", "notes": "Most commonly used sulfite in food and wine; same labeling and restriction requirements as other sulfites"}',
  ARRAY['ascorbic acid', 'citric acid', 'natural fermentation methods'],
  ARRAY['wine', 'dried fruits', 'fruit juices', 'pickled foods', 'potato products'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Potassium Metabisulfite',
  'potassium-metabisulfite',
  ARRAY['E224', 'potassium pyrosulfite', 'K2S2O5', 'dipotassium disulfite'],
  'preservative',
  5,
  ARRAY['sulfite sensitivity', 'asthma trigger', 'allergic reactions'],
  '{"acute": "Triggers asthma attacks, bronchospasm, and anaphylaxis in sulfite-sensitive individuals; skin and eye irritant", "chronic": "Destroys thiamine; same chronic concerns as other sulfiting agents", "vulnerable_groups": ["asthmatics", "sulfite-sensitive individuals", "children"]}',
  '{"fda": "GRAS with labeling requirements", "eu": "approved (E224) with limits", "notes": "Commonly used in winemaking; releases SO2 which acts as the active preservative"}',
  ARRAY['ascorbic acid', 'citric acid', 'natural preservation methods'],
  ARRAY['wine', 'beer', 'cider', 'dried fruits', 'fruit preparations'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Propionate',
  'calcium-propionate',
  ARRAY['E282', 'calcium propanoate', 'calcium salt of propionic acid'],
  'preservative',
  3,
  ARRAY['behavioral effects in children', 'migraine trigger', 'gastrointestinal irritation'],
  '{"acute": "Generally well tolerated; may cause headaches, migraines, and GI discomfort in sensitive individuals", "chronic": "Australian research linked to irritability, restlessness, inattention, and sleep disturbances in children; generally considered safe at approved levels", "vulnerable_groups": ["children", "migraine sufferers"]}',
  '{"fda": "GRAS", "eu": "approved (E282)", "notes": "Propionic acid occurs naturally in Swiss cheese at much higher levels than food additive use; widely used and generally accepted as safe"}',
  ARRAY['vinegar', 'cultured dough', 'raisin juice concentrate', 'natamycin (for surface mold)'],
  ARRAY['bread', 'baked goods', 'tortillas', 'cheese', 'animal feed'],
  ARRAY['FDA', 'EFSA', 'WHO', 'FSANZ']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Propionic Acid',
  'propionic-acid',
  ARRAY['E280', 'propanoic acid', 'ethylformic acid', 'methylacetic acid', 'C3H6O2'],
  'preservative',
  3,
  ARRAY['skin irritant', 'corrosive in concentrated form', 'migraine trigger'],
  '{"acute": "Concentrated form is corrosive to skin and eyes; food-grade levels generally safe; may trigger migraines", "chronic": "Naturally produced in the human gut; at food-additive levels considered very safe; some research suggests potential behavioral effects in children at high levels", "vulnerable_groups": ["migraine sufferers", "children sensitive to propionates"]}',
  '{"fda": "GRAS", "eu": "approved (E280)", "notes": "Naturally occurring in Swiss cheese (up to 1%); produced by gut bacteria; one of the safer food preservatives"}',
  ARRAY['vinegar', 'cultured wheat starch', 'natural fermentation'],
  ARRAY['bread', 'baked goods', 'cheese', 'animal feed', 'grain preservation'],
  ARRAY['FDA', 'EFSA', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Benzoic Acid',
  'benzoic-acid',
  ARRAY['E210', 'benzenecarboxylic acid', 'phenylformic acid', 'carboxybenzene', 'dracylic acid'],
  'preservative',
  4,
  ARRAY['benzene formation with vitamin C', 'asthma trigger', 'hyperactivity link'],
  '{"acute": "May cause hives, asthma, and rhinitis in sensitive individuals; generally well tolerated", "chronic": "Like sodium benzoate, can form benzene when combined with ascorbic acid; linked to hyperactivity in children in Southampton study; naturally occurring in many fruits", "vulnerable_groups": ["asthmatics", "children", "individuals with urticaria"]}',
  '{"fda": "GRAS (up to 0.1%)", "eu": "approved (E210) with limits", "notes": "Naturally occurs in cranberries, plums, cinnamon, and other foods; the parent acid of sodium benzoate"}',
  ARRAY['citric acid', 'rosemary extract', 'natural fermentation'],
  ARRAY['fruit juices', 'carbonated drinks', 'pickles', 'jams', 'cosmetics'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sorbic Acid',
  'sorbic-acid',
  ARRAY['E200', '2,4-hexadienoic acid', 'trans,trans-2,4-hexadienoic acid'],
  'preservative',
  2,
  ARRAY['rare skin sensitizer', 'mild irritant at high concentrations'],
  '{"acute": "Very low toxicity; rare skin irritation or sensitization on direct contact", "chronic": "Considered one of the safest food preservatives; metabolized like other fatty acids; no significant chronic toxicity concerns at approved levels", "vulnerable_groups": ["individuals with extremely sensitive skin"]}',
  '{"fda": "GRAS", "eu": "approved (E200)", "notes": "Named after the rowan berry (Sorbus aucuparia) where it was first discovered; widely considered the safest organic acid preservative"}',
  ARRAY['no major concerns; already considered a safe option', 'rosemary extract for those seeking natural alternatives'],
  ARRAY['cheese', 'wine', 'baked goods', 'fruit products', 'cosmetics'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Nisin',
  'nisin',
  ARRAY['E234', 'nisin A', 'nisaplin'],
  'preservative',
  1,
  ARRAY['very rare allergic reactions'],
  '{"acute": "Extremely low toxicity; no significant adverse effects reported at food-use levels", "chronic": "Naturally produced by Lactococcus lactis bacteria; no evidence of chronic toxicity; does not contribute to antibiotic resistance", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E234)", "notes": "Natural antimicrobial peptide; used safely for over 50 years; effective against Listeria and Clostridium; WHO approved"}',
  ARRAY['already considered one of the safest natural preservatives'],
  ARRAY['cheese', 'canned foods', 'processed meats', 'beverages', 'dairy products'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Natamycin',
  'natamycin',
  ARRAY['E235', 'pimaricin', 'natamycine', 'tennecetin'],
  'preservative',
  1,
  ARRAY['very rare allergic reactions'],
  '{"acute": "Very low toxicity; poorly absorbed from the GI tract so systemic exposure is minimal", "chronic": "No significant chronic toxicity; does not contribute to antifungal resistance at food-use levels; has been used safely for decades", "vulnerable_groups": []}',
  '{"fda": "approved for cheese and other foods", "eu": "approved (E235)", "notes": "Natural antifungal produced by Streptomyces natalensis; primarily used as surface treatment on cheese and sausages; WHO approved"}',
  ARRAY['already considered a safe natural preservative'],
  ARRAY['cheese', 'sausage casings', 'yogurt', 'wine', 'juice'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Hexamethylenetetramine',
  'hexamethylenetetramine',
  ARRAY['E239', 'methenamine', 'hexamine', 'urotropine', 'HMTA'],
  'preservative',
  6,
  ARRAY['formaldehyde releaser', 'skin sensitizer', 'urinary tract effects'],
  '{"acute": "May cause GI irritation, skin rash, and allergic reactions; releases formaldehyde in acidic conditions", "chronic": "Decomposes to formaldehyde in acidic environment of the stomach; formaldehyde is a known carcinogen; may cause bladder irritation", "vulnerable_groups": ["children", "pregnant women", "individuals with kidney issues"]}',
  '{"fda": "not approved as food additive in US", "eu": "approved only for Provolone cheese (E239); being phased out", "notes": "Banned as food additive in most countries; EU restricts to single use in Provolone cheese; still used in some cosmetics"}',
  ARRAY['potassium sorbate', 'natamycin', 'nisin'],
  ARRAY['Provolone cheese', 'some cosmetics', 'industrial products'],
  ARRAY['EFSA', 'FDA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Dehydroacetate',
  'sodium-dehydroacetate',
  ARRAY['E266', 'DHA-S', 'sodium salt of dehydroacetic acid', 'dehydroacetic acid sodium salt'],
  'preservative',
  4,
  ARRAY['limited safety data', 'skin irritant', 'potential toxicity at high doses'],
  '{"acute": "May cause skin and eye irritation on direct contact; relatively low oral toxicity", "chronic": "Limited long-term studies; some evidence of kidney effects at high doses in animals; generally considered safe at approved levels", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved for cut or peeled squash", "eu": "approved (E266) with limits", "notes": "Limited food use in US; more common in Japan and Asia; widely used in cosmetics globally"}',
  ARRAY['potassium sorbate', 'sodium benzoate', 'citric acid'],
  ARRAY['cosmetics', 'squash', 'personal care products', 'wet wipes'],
  ARRAY['FDA', 'EFSA', 'JECFA', 'CIR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Dimethyl Dicarbonate',
  'dimethyl-dicarbonate',
  ARRAY['E242', 'DMDC', 'Velcorin', 'dimethyl pyrocarbonate'],
  'preservative',
  3,
  ARRAY['methanol formation', 'toxic in undiluted form', 'handling hazards'],
  '{"acute": "Undiluted DMDC is toxic and corrosive; however, it hydrolyzes completely to methanol and CO2 within hours of addition to beverages; resulting methanol levels are below those naturally found in fruit juice", "chronic": "No residual chemical remains in the product; methanol generated is far below toxic thresholds; considered safe in the final product", "vulnerable_groups": []}',
  '{"fda": "approved for beverages (max 250 ppm)", "eu": "approved (E242) for beverages", "notes": "Self-destructing preservative; completely breaks down before consumption; primarily a handling hazard for workers, not consumers"}',
  ARRAY['pasteurization', 'sodium benzoate', 'potassium sorbate'],
  ARRAY['wine', 'fruit beverages', 'iced tea', 'sports drinks', 'flavored water'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ethylene Oxide',
  'ethylene-oxide',
  ARRAY['EtO', 'oxirane', 'epoxyethane', '1,2-epoxyethane', 'C2H4O'],
  'preservative',
  10,
  ARRAY['known carcinogen', 'mutagenic', 'reproductive toxicant', 'neurotoxic'],
  '{"acute": "Causes nausea, vomiting, neurological effects, pulmonary edema; skin and eye burns; highly toxic by inhalation", "chronic": "IARC Group 1 known human carcinogen (lymphoma, leukemia); mutagenic; causes reproductive harm including spontaneous abortion; neurotoxic with chronic exposure", "vulnerable_groups": ["everyone", "especially workers", "pregnant women", "children"]}',
  '{"fda": "approved only as fumigant for spices with strict residue limits", "eu": "banned in food (zero tolerance for residues)", "notes": "Major EU recalls of sesame seeds from India due to EtO contamination (2020+); IARC Group 1 carcinogen; strictly regulated worldwide"}',
  ARRAY['steam sterilization', 'irradiation', 'high-pressure processing'],
  ARRAY['spice fumigation', 'medical device sterilization', 'sesame seeds (contamination)'],
  ARRAY['IARC', 'EPA', 'OSHA', 'FDA', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Propylene Oxide',
  'propylene-oxide',
  ARRAY['PO', 'methyloxirane', '1,2-epoxypropane', '1,2-propylene oxide'],
  'preservative',
  9,
  ARRAY['probable carcinogen', 'mutagenic', 'respiratory irritant', 'neurotoxic'],
  '{"acute": "Eye and respiratory irritation; CNS depression at high concentrations; skin irritation and possible burns", "chronic": "IARC Group 2B possible human carcinogen; mutagenic in bacterial assays; associated with nasal tumors in animal studies", "vulnerable_groups": ["workers with occupational exposure", "pregnant women", "children"]}',
  '{"fda": "approved as fumigant for certain foods (cocoa, spices, nutmeats)", "eu": "not permitted as food additive", "notes": "Used as fumigant to control Salmonella in nuts and cocoa; residues must be below specified limits"}',
  ARRAY['steam sterilization', 'high-pressure processing', 'irradiation'],
  ARRAY['nutmeats', 'cocoa beans', 'spices', 'starch modification'],
  ARRAY['IARC', 'EPA', 'FDA', 'NTP', 'OSHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Erythorbate',
  'sodium-erythorbate',
  ARRAY['E316', 'sodium isoascorbate', 'sodium D-isoascorbate', 'erythorbic acid sodium salt'],
  'preservative',
  2,
  ARRAY['may cause headaches in sensitive individuals', 'minor GI effects at very high doses'],
  '{"acute": "Very low toxicity; may cause mild headaches, dizziness, or GI discomfort in rare cases at high intake", "chronic": "No significant chronic toxicity concerns; acts as antioxidant preventing nitrosamine formation in cured meats; does not have vitamin C activity", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E316)", "notes": "Stereoisomer of sodium ascorbate; actually reduces harm from nitrites by preventing nitrosamine formation; widely regarded as safe"}',
  ARRAY['ascorbic acid (vitamin C)', 'rosemary extract'],
  ARRAY['cured meats', 'hot dogs', 'bacon', 'deli meats', 'poultry'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Erythorbic Acid',
  'erythorbic-acid',
  ARRAY['E315', 'D-isoascorbic acid', 'D-araboascorbic acid', 'isoascorbic acid'],
  'preservative',
  2,
  ARRAY['may reduce iron absorption at very high doses', 'minor GI effects'],
  '{"acute": "Very low toxicity; safe at food-use levels", "chronic": "No significant chronic concerns; prevents nitrosamine formation in cured meats; stereoisomer of ascorbic acid with about 5% of its vitamin C activity", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E315)", "notes": "Widely used as safer alternative to reduce nitrosamine formation; considered one of the safest food additives"}',
  ARRAY['ascorbic acid (vitamin C)', 'rosemary extract', 'tocopherols'],
  ARRAY['cured meats', 'frozen fruits', 'beverages', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Phosphoric Acid',
  'phosphoric-acid',
  ARRAY['E338', 'orthophosphoric acid', 'H3PO4', 'trihydroxidooxidophosphorus'],
  'preservative',
  4,
  ARRAY['tooth enamel erosion', 'calcium depletion', 'kidney stone risk', 'bone health concerns'],
  '{"acute": "Concentrated form is corrosive; at food levels causes dental enamel erosion and acid reflux", "chronic": "High dietary intake linked to lower bone density, increased kidney stone risk, and calcium-phosphorus imbalance; cola consumption studies show reduced bone mineral density", "vulnerable_groups": ["children", "adolescents (bone development)", "individuals with kidney disease", "osteoporosis risk groups"]}',
  '{"fda": "GRAS", "eu": "approved (E338) with ADI", "notes": "Primary acidulant in cola drinks; concern is mainly from excessive consumption rather than inherent toxicity"}',
  ARRAY['citric acid', 'malic acid', 'tartaric acid'],
  ARRAY['cola drinks', 'processed foods', 'jams', 'dairy products', 'rust removers'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Citric Acid (preservative use)',
  'citric-acid-preservative',
  ARRAY['E330', 'citric acid', '2-hydroxypropane-1,2,3-tricarboxylic acid', 'hydrogen citrate', 'C6H8O7'],
  'preservative',
  1,
  ARRAY['tooth enamel erosion at high concentrations', 'rare sensitivity reactions'],
  '{"acute": "Very safe; may cause minor mouth or throat irritation at high concentrations; mild tooth enamel erosion with frequent acidic food/drink consumption", "chronic": "No significant chronic health concerns; naturally present in citrus fruits; metabolized normally by the body; some people report sensitivity to manufactured citric acid (from Aspergillus niger fermentation)", "vulnerable_groups": ["individuals with citric acid sensitivity (very rare)"]}',
  '{"fda": "GRAS", "eu": "approved (E330)", "notes": "One of the most widely used and safest food additives; naturally occurring in citrus fruits; also used as pH adjuster and flavor enhancer"}',
  ARRAY['already considered very safe; lemon juice for natural alternative'],
  ARRAY['soft drinks', 'candy', 'canned foods', 'frozen foods', 'cosmetics', 'cleaning products'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Disodium EDTA',
  'calcium-disodium-edta',
  ARRAY['E385', 'calcium disodium ethylenediaminetetraacetate', 'CaNa2EDTA', 'edetate calcium disodium', 'Versene CA'],
  'preservative',
  4,
  ARRAY['mineral depletion', 'kidney stress', 'reproductive concerns at high doses'],
  '{"acute": "Generally safe at food levels; high doses may cause GI upset, muscle cramps", "chronic": "Chelates essential minerals (zinc, iron, calcium) which may contribute to depletion; animal studies show reproductive effects and kidney damage at high doses; concerns about persistent environmental accumulation", "vulnerable_groups": ["individuals with mineral deficiencies", "kidney disease patients", "pregnant women"]}',
  '{"fda": "GRAS (limited to 25-800 ppm depending on food)", "eu": "approved (E385) with strict limits", "notes": "Used medically for lead poisoning treatment at much higher doses; food use is primarily to prevent discoloration and rancidity from metal catalysis"}',
  ARRAY['citric acid', 'ascorbic acid', 'rosemary extract', 'phytic acid'],
  ARRAY['canned beans', 'soft drinks', 'mayonnaise', 'salad dressings', 'pickled foods'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Disodium EDTA',
  'disodium-edta',
  ARRAY['disodium ethylenediaminetetraacetate', 'Na2EDTA', 'edetate disodium', 'EDTA disodium salt', 'Versene NA'],
  'preservative',
  4,
  ARRAY['mineral chelation', 'skin penetration enhancer', 'environmental persistence'],
  '{"acute": "May cause skin and eye irritation; at high IV doses can cause dangerous calcium depletion (medical context, not food)", "chronic": "Chelates essential minerals; enhances skin absorption of other chemicals (concern in cosmetics); poor biodegradability raises environmental concerns", "vulnerable_groups": ["individuals with mineral deficiencies", "those using products with other concerning ingredients (EDTA enhances absorption)"]}',
  '{"fda": "approved in cosmetics and some foods", "eu": "approved with limits", "notes": "In cosmetics, concern is that it enhances penetration of other ingredients through skin; environmentally persistent; used in both food and personal care"}',
  ARRAY['citric acid', 'phytic acid', 'ascorbic acid', 'gluconic acid'],
  ARRAY['cosmetics', 'shampoos', 'soaps', 'canned foods', 'salad dressings'],
  ARRAY['FDA', 'CIR', 'EFSA', 'EWG', 'ECHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Diacetate',
  'sodium-diacetate',
  ARRAY['E262(ii)', 'sodium hydrogen diacetate', 'dykon', 'sodium acid acetate'],
  'preservative',
  2,
  ARRAY['mild GI irritation at high doses', 'vinegar-like taste'],
  '{"acute": "Very low toxicity; may cause mild GI irritation at high intake; essentially a mixture of sodium acetate and acetic acid", "chronic": "No significant chronic concerns; acetic acid is naturally occurring (vinegar); widely considered safe", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E262)", "notes": "Essentially a sodium acetate-acetic acid compound; imparts vinegar flavor; one of the safest food preservatives available"}',
  ARRAY['vinegar', 'sodium acetate'],
  ARRAY['bread', 'snack foods', 'meat products', 'salad dressings', 'seasonings'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Dehydroacetic Acid',
  'dehydroacetic-acid',
  ARRAY['DHA', '3-acetyl-6-methyl-2H-pyran-2,4(3H)-dione', 'methylacetopyranone'],
  'preservative',
  4,
  ARRAY['limited safety data', 'skin irritant', 'possible toxicity at high doses'],
  '{"acute": "Skin and eye irritation on direct contact; convulsions reported in animals at very high doses", "chronic": "Limited long-term safety data; some evidence of kidney and liver effects at high doses in animal studies; generally considered safe at cosmetic use levels", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved as preservative for cut squash", "eu": "allowed in cosmetics (max 0.6%)", "notes": "More commonly used in cosmetics than food; limited food applications in most countries"}',
  ARRAY['potassium sorbate', 'sodium benzoate', 'phenoxyethanol'],
  ARRAY['cosmetics', 'squash', 'personal care products', 'sunscreens'],
  ARRAY['FDA', 'EFSA', 'CIR', 'SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Aspartame',
  'aspartame',
  ARRAY['E951', 'NutraSweet', 'Equal', 'Canderel', 'APM', 'aspartyl-phenylalanine-1-methyl ester'],
  'sweetener',
  7,
  ARRAY['possible carcinogen', 'headaches', 'neurotoxicity concerns', 'phenylketonuria risk'],
  '{"acute": "Headaches, dizziness, and GI symptoms reported by some individuals; dangerous for people with phenylketonuria (PKU) due to phenylalanine content", "chronic": "IARC classified as Group 2B possible carcinogen (2023); some studies link to increased cancer risk, mood disorders, and neurological effects; heavily debated in scientific community", "vulnerable_groups": ["individuals with PKU", "children", "pregnant women"]}',
  '{"fda": "approved (ADI 50 mg/kg/day)", "eu": "approved (E951, ADI 40 mg/kg/day)", "notes": "IARC classified as Group 2B possible carcinogen in July 2023; JECFA maintained existing ADI; one of the most studied food additives; 200x sweeter than sugar"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol', 'allulose'],
  ARRAY['diet sodas', 'sugar-free gum', 'tabletop sweeteners', 'sugar-free yogurt', 'light beverages'],
  ARRAY['IARC', 'JECFA', 'FDA', 'EFSA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sucralose',
  'sucralose',
  ARRAY['E955', 'Splenda', '1,6-dichloro-1,6-dideoxy-beta-D-fructofuranosyl-4-chloro-4-deoxy-alpha-D-galactopyranoside', 'trichlorogalactosucrose'],
  'sweetener',
  5,
  ARRAY['gut microbiome disruption', 'DNA damage when heated', 'glucose tolerance effects', 'chlorinated compound'],
  '{"acute": "Generally well tolerated; some individuals report GI distress, bloating, headaches", "chronic": "2023 research linked to DNA damage (genotoxicity) and gut lining damage, particularly when heated; alters gut microbiome composition; some studies show impaired glucose and insulin response", "vulnerable_groups": ["children", "individuals with gut conditions", "diabetics"]}',
  '{"fda": "approved (ADI 5 mg/kg/day)", "eu": "approved (E955, ADI 15 mg/kg/day)", "notes": "600x sweeter than sugar; chlorinated sugar molecule; CSPI downgraded from safe to caution (2023); should not be used in cooking/baking due to thermal decomposition"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol', 'allulose'],
  ARRAY['diet drinks', 'sugar-free products', 'protein powders', 'baked goods', 'tabletop sweeteners'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'WHO', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Acesulfame Potassium',
  'acesulfame-potassium',
  ARRAY['E950', 'Ace-K', 'acesulfame K', 'Sunett', 'Sweet One'],
  'sweetener',
  5,
  ARRAY['possible carcinogen', 'inadequate testing', 'often paired with aspartame'],
  '{"acute": "Generally well tolerated at approved levels", "chronic": "CSPI considers it poorly tested; early studies showed potential carcinogenicity in animals; contains methylene chloride as manufacturing byproduct; often combined with aspartame", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved (ADI 15 mg/kg/day)", "eu": "approved (E950, ADI 9 mg/kg/day)", "notes": "200x sweeter than sugar; CSPI recommends avoidance due to inadequate cancer testing; commonly blended with other sweeteners to mask bitter aftertaste"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol'],
  ARRAY['diet sodas', 'sugar-free gum', 'frozen desserts', 'tabletop sweeteners', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Saccharin',
  'saccharin',
  ARRAY['E954', 'Sweet''N Low', 'sodium saccharin', 'benzoic sulfimide', 'saccharine'],
  'sweetener',
  5,
  ARRAY['historical carcinogen concerns', 'bitter metallic aftertaste', 'bladder cancer link in rodents'],
  '{"acute": "Generally well tolerated; may cause allergic reactions in those sensitive to sulfonamides", "chronic": "Caused bladder cancer in rats (mechanism not applicable to humans); removed from NTP carcinogen list in 2000; long history of use with current scientific consensus of safety at approved levels", "vulnerable_groups": ["individuals with sulfonamide allergies"]}',
  '{"fda": "approved (ADI 15 mg/kg/day); delisted as carcinogen in 2000", "eu": "approved (E954, ADI 5 mg/kg/day)", "notes": "300-500x sweeter than sugar; oldest artificial sweetener (1879); was on carcinogen list from 1981-2000; mechanism in rats (high pH, high calcium) not relevant to humans"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol'],
  ARRAY['tabletop sweeteners', 'diet drinks', 'toothpaste', 'medications', 'lip balms'],
  ARRAY['FDA', 'EFSA', 'NTP', 'IARC', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'High Fructose Corn Syrup',
  'high-fructose-corn-syrup',
  ARRAY['HFCS', 'HFCS-55', 'HFCS-42', 'glucose-fructose syrup', 'isoglucose', 'corn sugar'],
  'sweetener',
  7,
  ARRAY['obesity', 'metabolic syndrome', 'fatty liver disease', 'insulin resistance', 'diabetes risk'],
  '{"acute": "Rapid blood sugar spike; GI distress in fructose-sensitive individuals", "chronic": "Strongly associated with obesity epidemic, non-alcoholic fatty liver disease (NAFLD), type 2 diabetes, metabolic syndrome, and cardiovascular disease; fructose metabolized primarily by liver similar to alcohol; promotes visceral fat accumulation", "vulnerable_groups": ["children", "diabetics", "individuals with metabolic syndrome", "those with fatty liver disease"]}',
  '{"fda": "GRAS", "eu": "approved (production quotas until 2017, now unrestricted)", "notes": "Not chemically identical to table sugar; higher fructose content in HFCS-55 (most common in beverages); American consumption has increased 1000%+ since 1970; core driver of processed food industry"}',
  ARRAY['honey', 'maple syrup', 'coconut sugar', 'date sugar', 'whole fruit'],
  ARRAY['soft drinks', 'juice drinks', 'candy', 'bread', 'condiments', 'cereals', 'yogurt'],
  ARRAY['FDA', 'AHA', 'WHO', 'CSPI', 'Harvard School of Public Health']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Neotame',
  'neotame',
  ARRAY['E961', 'Newtame', 'N-[N-(3,3-dimethylbutyl)-L-alpha-aspartyl]-L-phenylalanine 1-methyl ester'],
  'sweetener',
  4,
  ARRAY['limited long-term studies', 'aspartame derivative', 'gut microbiome concerns'],
  '{"acute": "No significant acute effects at approved levels; does not require PKU warning despite being aspartame derivative (rapidly metabolized)", "chronic": "Limited independent long-term studies; some concern about gut microbiome effects similar to other artificial sweeteners; derivative of aspartame but considered safer due to different metabolism", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved (ADI 0.3 mg/kg/day)", "eu": "approved (E961, ADI 0 mg/kg/day - no limit set)", "notes": "7,000-13,000x sweeter than sugar; approved in 2002; no PKU warning required unlike aspartame; very little used in consumer products; primarily industrial"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol'],
  ARRAY['processed foods', 'beverages', 'chewing gum', 'frozen desserts', 'puddings'],
  ARRAY['FDA', 'EFSA', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Advantame',
  'advantame',
  ARRAY['E969', 'N-[N-[3-(3-hydroxy-4-methoxyphenyl)propyl]-alpha-aspartyl]-L-phenylalanine 1-methyl ester'],
  'sweetener',
  3,
  ARRAY['very limited long-term data', 'aspartame derivative'],
  '{"acute": "No significant adverse effects reported at approved levels", "chronic": "Very limited long-term human data due to recent approval; derived from aspartame but does not require PKU warning; used in extremely small quantities due to extreme potency", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved (2014, ADI 32.8 mg/kg/day)", "eu": "approved (E969, ADI 5 mg/kg/day)", "notes": "20,000x sweeter than sugar; newest artificial sweetener; approved by FDA in 2014; used in vanishingly small quantities; does not require PKU warning"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol'],
  ARRAY['beverages', 'chewing gum', 'candy', 'frozen desserts', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cyclamate',
  'cyclamate',
  ARRAY['E952', 'sodium cyclamate', 'calcium cyclamate', 'cyclamic acid', 'Sucaryl'],
  'sweetener',
  6,
  ARRAY['banned in US', 'bladder cancer concerns', 'testicular atrophy in animals'],
  '{"acute": "Generally well tolerated in countries where approved", "chronic": "Banned in US since 1969 due to bladder cancer in rats; some studies show testicular atrophy and reduced sperm count in animals; may be converted to cyclohexylamine (toxic) by gut bacteria", "vulnerable_groups": ["children", "pregnant women", "individuals with impaired kidney function"]}',
  '{"fda": "banned (since 1969)", "eu": "approved (E952, ADI 7 mg/kg/day)", "notes": "30-50x sweeter than sugar; banned in US but approved in 55+ countries including EU and Canada; FDA ban based on 1969 rat study; petitions to re-approve have been filed"}',
  ARRAY['stevia', 'monk fruit extract', 'erythritol'],
  ARRAY['tabletop sweeteners (outside US)', 'diet drinks (outside US)', 'medications'],
  ARRAY['FDA', 'EFSA', 'WHO', 'Health Canada']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sorbitol',
  'sorbitol',
  ARRAY['E420', 'D-glucitol', 'D-sorbitol', 'sorbit'],
  'sweetener',
  2,
  ARRAY['laxative effect', 'GI distress', 'bloating and gas'],
  '{"acute": "Doses above 10g may cause bloating, gas, and diarrhea due to osmotic effect in intestines; laxative effect is dose-dependent", "chronic": "No significant chronic toxicity; may cause chronic GI issues in individuals consuming large amounts; lower glycemic impact than sugar; does not promote tooth decay", "vulnerable_groups": ["individuals with IBS or fructose malabsorption"]}',
  '{"fda": "GRAS", "eu": "approved (E420)", "notes": "0.6x sweetness of sugar; naturally found in stone fruits; caloric (2.6 kcal/g vs 4 for sugar); must carry laxative warning in US if food could cause consumption of 50g/day"}',
  ARRAY['erythritol (better tolerated)', 'xylitol', 'allulose'],
  ARRAY['sugar-free candy', 'chewing gum', 'diet foods', 'toothpaste', 'medications'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Mannitol',
  'mannitol',
  ARRAY['E421', 'D-mannitol', 'mannit', 'manna sugar'],
  'sweetener',
  2,
  ARRAY['laxative effect', 'GI distress', 'bloating'],
  '{"acute": "Osmotic laxative effect at doses above 10-20g; bloating, cramps, and diarrhea", "chronic": "No significant chronic toxicity; does not promote tooth decay; lower caloric value than sugar; may cause chronic GI issues with excessive consumption", "vulnerable_groups": ["individuals with IBS", "children (more susceptible to laxative effect)"]}',
  '{"fda": "GRAS", "eu": "approved (E421)", "notes": "0.5-0.7x sweetness of sugar; naturally found in seaweed, mushrooms, and tree bark; used in pharmaceuticals as excipient; 1.6 kcal/g"}',
  ARRAY['erythritol', 'xylitol', 'allulose'],
  ARRAY['sugar-free candy', 'chewing gum', 'pharmaceuticals', 'dusting powder for gum'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Xylitol',
  'xylitol',
  ARRAY['E967', 'birch sugar', 'wood sugar', 'D-xylitol'],
  'sweetener',
  2,
  ARRAY['GI distress at high doses', 'extremely toxic to dogs', 'cardiovascular concerns at high intake'],
  '{"acute": "Doses above 30-40g may cause bloating, gas, and diarrhea; extremely toxic to dogs (can cause liver failure and death)", "chronic": "Promotes dental health (reduces cavities); some recent research suggests high blood levels may be associated with increased cardiovascular event risk; generally well tolerated long-term at moderate intake", "vulnerable_groups": ["dog owners (extreme danger to dogs)", "individuals with IBS"]}',
  '{"fda": "approved", "eu": "approved (E967)", "notes": "Equal sweetness to sugar; 2.4 kcal/g; actively prevents dental caries; recommended by dental associations; naturally found in fruits and vegetables; LETHAL TO DOGS"}',
  ARRAY['erythritol', 'allulose', 'stevia'],
  ARRAY['sugar-free gum', 'mints', 'toothpaste', 'nasal sprays', 'sugar-free candy'],
  ARRAY['FDA', 'EFSA', 'WHO', 'ADA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Erythritol',
  'erythritol',
  ARRAY['E968', 'meso-erythritol', '1,2,3,4-butanetetrol'],
  'sweetener',
  3,
  ARRAY['cardiovascular event risk at high blood levels', 'platelet aggregation', 'GI effects at very high doses'],
  '{"acute": "Best tolerated of all sugar alcohols; minimal GI effects at normal intake; doses above 50g may cause nausea", "chronic": "2023 Cleveland Clinic study linked high blood erythritol levels to increased risk of cardiovascular events (heart attack, stroke) and enhanced platelet clotting; naturally produced by body in small amounts; more research needed", "vulnerable_groups": ["individuals with cardiovascular disease", "those at risk for blood clots"]}',
  '{"fda": "GRAS", "eu": "approved (E968)", "notes": "0.7x sweetness of sugar; virtually zero calories (0.2 kcal/g); best GI tolerance of sugar alcohols; 2023 cardiovascular findings are concerning but preliminary; naturally found in fruits and fermented foods"}',
  ARRAY['allulose', 'stevia', 'monk fruit extract'],
  ARRAY['keto products', 'sugar-free beverages', 'baking blends', 'protein bars', 'tabletop sweeteners'],
  ARRAY['FDA', 'EFSA', 'Cleveland Clinic', 'Nature Medicine', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Maltitol',
  'maltitol',
  ARRAY['E965', 'maltitol syrup', '4-O-alpha-D-glucopyranosyl-D-sorbitol', 'hydrogenated maltose'],
  'sweetener',
  3,
  ARRAY['significant GI distress', 'high glycemic impact for sugar alcohol', 'laxative effect'],
  '{"acute": "Notorious for causing severe GI distress (bloating, gas, diarrhea) even at moderate doses (30-40g); stronger laxative effect than most sugar alcohols", "chronic": "Higher glycemic index (35-52) than other sugar alcohols; may not be ideal for diabetics despite sugar-free labeling; caloric content close to sugar (2.1-3 kcal/g)", "vulnerable_groups": ["individuals with IBS", "diabetics (may spike blood sugar)", "children"]}',
  '{"fda": "GRAS", "eu": "approved (E965)", "notes": "0.75-0.9x sweetness of sugar; most commonly used sugar alcohol in sugar-free candy due to similar taste to sugar; infamous for GI side effects at moderate intake"}',
  ARRAY['erythritol', 'allulose', 'stevia', 'monk fruit extract'],
  ARRAY['sugar-free chocolate', 'sugar-free candy', 'ice cream', 'baked goods', 'protein bars'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Isomalt',
  'isomalt',
  ARRAY['E953', 'Palatinit', 'isomaltitol', 'hydrogenated isomaltulose'],
  'sweetener',
  2,
  ARRAY['GI distress at high doses', 'laxative effect'],
  '{"acute": "Laxative effect at doses above 30-40g; bloating and gas at moderate intake", "chronic": "No significant chronic health concerns; tooth-friendly; low glycemic index (9); slowly and incompletely absorbed", "vulnerable_groups": ["individuals with IBS"]}',
  '{"fda": "GRAS", "eu": "approved (E953)", "notes": "0.45-0.65x sweetness of sugar; 2 kcal/g; popular in sugar-free hard candies; derived from beet sugar; tooth-friendly certification"}',
  ARRAY['erythritol', 'allulose', 'monk fruit extract'],
  ARRAY['sugar-free hard candy', 'throat lozenges', 'chocolate', 'baked goods', 'pharmaceuticals'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lactitol',
  'lactitol',
  ARRAY['E966', '4-O-beta-D-galactopyranosyl-D-glucitol', 'lactit', 'lactobiosit'],
  'sweetener',
  2,
  ARRAY['GI distress', 'laxative effect', 'not suitable for lactose-intolerant individuals'],
  '{"acute": "Laxative effect at doses above 20g; used medically as a laxative (Pizensy); bloating and flatulence common", "chronic": "No significant chronic toxicity; prebiotic properties may support gut health; very low glycemic response; approved as medical laxative", "vulnerable_groups": ["lactose-intolerant individuals (though lactitol is not lactose)", "individuals with IBS"]}',
  '{"fda": "GRAS; also FDA-approved as prescription laxative", "eu": "approved (E966)", "notes": "0.3-0.4x sweetness of sugar; 2 kcal/g; derived from lactose; has prebiotic effects; dual use as sweetener and laxative medication"}',
  ARRAY['erythritol', 'allulose', 'stevia'],
  ARRAY['sugar-free chocolate', 'baked goods', 'ice cream', 'pharmaceuticals', 'chewing gum'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Stevia',
  'stevia',
  ARRAY['E960', 'steviol glycosides', 'stevia rebaudiana', 'Reb A', 'rebaudioside A', 'stevioside', 'Truvia', 'PureVia'],
  'sweetener',
  1,
  ARRAY['slight bitter aftertaste', 'possible blood pressure lowering effect'],
  '{"acute": "No significant adverse effects at normal intake; may lower blood pressure slightly", "chronic": "No carcinogenicity, genotoxicity, or reproductive toxicity at approved levels; may have beneficial effects on blood pressure and blood sugar; long history of use in South America and Japan", "vulnerable_groups": []}',
  '{"fda": "GRAS (purified steviol glycosides; crude stevia leaf not approved)", "eu": "approved (E960)", "notes": "200-350x sweeter than sugar; zero calories; derived from Stevia rebaudiana plant; only purified extracts (Reb A, stevioside) are FDA approved, not whole leaf; used in Japan since 1970s"}',
  ARRAY['already considered one of the safest sweetener options'],
  ARRAY['tabletop sweeteners', 'beverages', 'yogurt', 'baked goods', 'protein powders'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Monk Fruit Extract',
  'monk-fruit-extract',
  ARRAY['luo han guo', 'Siraitia grosvenorii', 'mogrosides', 'mogroside V', 'Swingle fruit extract', 'lo han kuo'],
  'sweetener',
  1,
  ARRAY['very rare allergic reactions in those allergic to Cucurbitaceae family'],
  '{"acute": "No known adverse effects at normal intake", "chronic": "No evidence of carcinogenicity, genotoxicity, or chronic toxicity; used in traditional Chinese medicine for centuries; antioxidant properties; zero calories", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "novel food application pending; available as supplement", "notes": "150-300x sweeter than sugar; zero calories; sweetness from mogrosides (antioxidant compounds); no aftertaste issues like stevia; used in China for centuries; gaining rapid popularity"}',
  ARRAY['already considered one of the safest sweetener options'],
  ARRAY['tabletop sweeteners', 'beverages', 'baking blends', 'protein powders', 'keto products'],
  ARRAY['FDA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Allulose',
  'allulose',
  ARRAY['D-psicose', 'D-allulose', 'psicose', 'rare sugar'],
  'sweetener',
  1,
  ARRAY['GI distress at very high doses', 'relatively new to market'],
  '{"acute": "Mild GI discomfort possible at doses above 54g in a single sitting; well tolerated at moderate intake", "chronic": "No significant chronic concerns; may have beneficial effects on blood sugar regulation and fat metabolism; 70% sweetness of sugar with 90% fewer calories; not metabolized by the body", "vulnerable_groups": []}',
  '{"fda": "GRAS; excluded from total and added sugars on Nutrition Facts label", "eu": "novel food authorization pending", "notes": "0.7x sweetness of sugar; ~0.4 kcal/g; rare sugar found naturally in figs, raisins, and maple syrup; FDA allows exclusion from sugar count on labels; does not raise blood glucose or insulin"}',
  ARRAY['already considered one of the safest sweetener options'],
  ARRAY['keto products', 'baking blends', 'beverages', 'ice cream', 'protein bars'],
  ARRAY['FDA', 'JECFA', 'Journal of Food Science']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Tagatose',
  'tagatose',
  ARRAY['D-tagatose', 'D-lyxo-hexulose'],
  'sweetener',
  2,
  ARRAY['GI distress at high doses', 'laxative effect', 'limited long-term data'],
  '{"acute": "Laxative effect and GI discomfort at doses above 30g; flatulence and bloating at moderate doses", "chronic": "No significant chronic toxicity; prebiotic properties; minimal impact on blood glucose; may have anti-plaque dental benefits", "vulnerable_groups": ["individuals with IBS"]}',
  '{"fda": "GRAS", "eu": "approved as novel food", "notes": "0.92x sweetness of sugar; 1.5 kcal/g; naturally found in dairy products; low glycemic index; prebiotic effects; tooth-friendly"}',
  ARRAY['allulose', 'erythritol', 'stevia'],
  ARRAY['sugar-free products', 'cereals', 'beverages', 'dairy products', 'dietary supplements'],
  ARRAY['FDA', 'EFSA', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Thaumatin',
  'thaumatin',
  ARRAY['E957', 'talin', 'thaumatine', 'Thaumatococcus daniellii extract'],
  'sweetener',
  1,
  ARRAY['very rare allergic reactions'],
  '{"acute": "No significant adverse effects reported", "chronic": "No evidence of chronic toxicity; naturally occurring plant protein; completely metabolized as a protein; used in small quantities", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E957)", "notes": "2,000-3,000x sweeter than sugar; natural protein extracted from West African katemfe fruit; primarily used as flavor enhancer rather than bulk sweetener; also used as flavor modifier to mask bitterness"}',
  ARRAY['already considered a very safe natural sweetener'],
  ARRAY['chewing gum', 'beverages', 'dairy products', 'pharmaceuticals', 'pet food'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Glycyrrhizin',
  'glycyrrhizin',
  ARRAY['glycyrrhizinic acid', 'glycyrrhizic acid', 'licorice extract', 'licorice root sweetener'],
  'sweetener',
  5,
  ARRAY['hypertension', 'hypokalemia', 'edema', 'hormonal effects'],
  '{"acute": "At high intake causes water retention, elevated blood pressure, and potassium depletion", "chronic": "Chronic consumption of >100mg/day linked to pseudoaldosteronism (hypertension, hypokalemia, edema); may affect cortisol metabolism; associated with preterm birth at high intake", "vulnerable_groups": ["pregnant women", "individuals with hypertension", "those with heart or kidney disease", "individuals on potassium-depleting medications"]}',
  '{"fda": "GRAS as flavoring; not approved as primary sweetener", "eu": "requires labeling if >100mg/kg in food", "notes": "30-50x sweeter than sugar; natural compound from licorice root; WHO recommends max 100mg/day; EU requires health warning at high concentrations"}',
  ARRAY['stevia', 'monk fruit extract', 'anise flavoring (for taste)'],
  ARRAY['licorice candy', 'herbal teas', 'traditional medicines', 'tobacco products', 'some beers'],
  ARRAY['FDA', 'EFSA', 'WHO', 'EMA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sugar Alcohols (General)',
  'sugar-alcohols-general',
  ARRAY['polyols', 'polyhydric alcohols', 'sugar replacers'],
  'sweetener',
  2,
  ARRAY['GI distress', 'laxative effect', 'bloating and gas'],
  '{"acute": "Dose-dependent GI distress including bloating, gas, cramping, and diarrhea; osmotic laxative effect draws water into intestines", "chronic": "Generally safe for long-term use; do not promote tooth decay; lower glycemic impact than sugar; caloric content varies (0.2-3 kcal/g depending on type)", "vulnerable_groups": ["individuals with IBS or FODMAP sensitivity", "children"]}',
  '{"fda": "GRAS (individual approvals vary)", "eu": "approved (must carry laxative warning above certain amounts)", "notes": "Class includes sorbitol, mannitol, xylitol, erythritol, maltitol, isomalt, lactitol; erythritol best tolerated; maltitol worst tolerated; not actually alcohols despite the name"}',
  ARRAY['erythritol (best tolerated)', 'allulose', 'stevia', 'monk fruit extract'],
  ARRAY['sugar-free candy', 'chewing gum', 'diet foods', 'diabetic products', 'toothpaste'],
  ARRAY['FDA', 'EFSA', 'WHO', 'ADA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Corn Syrup',
  'corn-syrup',
  ARRAY['glucose syrup', 'corn syrup solids', 'glucose-fructose syrup', 'maize syrup'],
  'sweetener',
  5,
  ARRAY['obesity', 'blood sugar spikes', 'empty calories', 'metabolic effects'],
  '{"acute": "Rapid blood sugar spike; contributes to energy crashes", "chronic": "High caloric density with no nutritional value; contributes to obesity, type 2 diabetes, and dental caries; less concerning than HFCS as it is primarily glucose (less fructose burden on liver)", "vulnerable_groups": ["children", "diabetics", "individuals with metabolic syndrome"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Primarily glucose (unlike HFCS which has added fructose); used as thickener and sweetener; less sweet than sugar; high glycemic index; different from HFCS despite similar name"}',
  ARRAY['honey', 'maple syrup', 'brown rice syrup', 'date syrup'],
  ARRAY['candy', 'baked goods', 'ice cream', 'processed foods', 'sauces', 'cereals'],
  ARRAY['FDA', 'AHA', 'WHO', 'USDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Dextrose',
  'dextrose',
  ARRAY['D-glucose', 'grape sugar', 'corn sugar', 'glucose', 'blood sugar'],
  'sweetener',
  4,
  ARRAY['blood sugar spikes', 'empty calories', 'obesity contribution', 'dental caries'],
  '{"acute": "Rapid blood sugar elevation; important for treating hypoglycemia; may cause GI discomfort if consumed in large quantities", "chronic": "Excess consumption contributes to obesity, type 2 diabetes, and dental caries; high glycemic index (100); no nutritional value beyond energy", "vulnerable_groups": ["diabetics", "children", "individuals with insulin resistance"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Identical to blood glucose; glycemic index of 100 (reference standard); 0.7x sweetness of sucrose; used medically in IV solutions; naturally occurring in fruits and honey"}',
  ARRAY['honey', 'coconut sugar', 'whole fruit', 'stevia-based blends'],
  ARRAY['sports drinks', 'baked goods', 'candy', 'processed meats', 'infant formula'],
  ARRAY['FDA', 'AHA', 'WHO', 'USDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Maltodextrin',
  'maltodextrin',
  ARRAY['MDX', 'modified starch derivative', 'maltodextrine'],
  'sweetener',
  4,
  ARRAY['very high glycemic index', 'blood sugar spikes', 'gut microbiome disruption', 'may promote E. coli growth'],
  '{"acute": "Rapid blood sugar spike (glycemic index 85-105, higher than table sugar); may cause bloating and GI discomfort", "chronic": "Very high glycemic index can worsen insulin resistance; research suggests it may suppress beneficial gut bacteria and promote growth of E. coli; may worsen intestinal inflammation (concern for Crohn''s disease patients)", "vulnerable_groups": ["diabetics", "individuals with Crohn''s disease or IBD", "celiac patients (if wheat-derived)"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Not truly sweet (mildly sweet); derived from corn, rice, potato, or wheat starch; used as filler, thickener, and carbohydrate source; extremely common in processed foods and supplements; glycemic index higher than sugar"}',
  ARRAY['arrowroot powder', 'tapioca starch', 'whole food carbohydrate sources'],
  ARRAY['protein powders', 'meal replacements', 'sports drinks', 'infant formula', 'sauces', 'salad dressings', 'snack foods'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Journal of Nutritional Science']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Red 40 (Allura Red)',
  'red-40',
  ARRAY['E129', 'Allura Red AC', 'FD&C Red No. 40', 'CI 16035', 'Red 40 Lake', 'Allura Red'],
  'color',
  8,
  ARRAY['hyperactivity in children', 'behavioral effects', 'allergic reactions', 'possible carcinogen contaminants'],
  '{"acute": "May trigger hyperactivity, attention problems, and behavioral issues in sensitive children; can cause hives and allergic reactions", "chronic": "Most consumed food dye in the US; linked to hyperactivity in children (Southampton study); may contain carcinogenic contaminants (benzidine, 4-aminobiphenyl); CSPI petitioned FDA for ban", "vulnerable_groups": ["children", "individuals with ADHD", "aspirin-sensitive individuals"]}',
  '{"fda": "approved (certified, batch-tested)", "eu": "approved (E129) with mandatory warning label", "notes": "EU requires warning: may have an adverse effect on activity and attention in children; most widely used food dye in US; petroleum-derived; California law requires warning label starting 2028"}',
  ARRAY['beet juice', 'paprika oleoresin', 'lycopene', 'anthocyanins', 'carmine'],
  ARRAY['candy', 'cereals', 'fruit snacks', 'sports drinks', 'gelatin desserts', 'sauces'],
  ARRAY['CSPI', 'FDA', 'EFSA', 'Southampton University', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Red 3 (Erythrosine)',
  'red-3',
  ARRAY['E127', 'Erythrosine', 'FD&C Red No. 3', 'CI 45430', 'erythrosine B'],
  'color',
  9,
  ARRAY['thyroid tumors in animals', 'endocrine disruptor', 'banned in cosmetics', 'hyperactivity'],
  '{"acute": "May trigger hyperactivity and behavioral changes in children; possible allergic reactions", "chronic": "Caused thyroid tumors in male rats; already banned in cosmetics and externally applied drugs by FDA (1990); recognized as thyroid carcinogen in animals; FDA ban in food delayed for decades", "vulnerable_groups": ["children", "individuals with thyroid conditions", "pregnant women"]}',
  '{"fda": "approved in food (banned in cosmetics since 1990); FDA announced ban in food effective 2027", "eu": "approved (E127) with restrictions", "notes": "FDA banned in cosmetics in 1990 due to thyroid cancer in animals but inexplicably kept in food; California banned in food (2023); FDA finally announced food ban effective January 2027"}',
  ARRAY['beet juice', 'paprika', 'carmine', 'anthocyanins'],
  ARRAY['maraschino cherries', 'candy', 'popsicles', 'cake decorations', 'sausage casings'],
  ARRAY['FDA', 'CSPI', 'EFSA', 'California OEHHA', 'NTP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Yellow 5 (Tartrazine)',
  'yellow-5',
  ARRAY['E102', 'Tartrazine', 'FD&C Yellow No. 5', 'CI 19140', 'Yellow 5 Lake'],
  'color',
  8,
  ARRAY['hyperactivity in children', 'allergic reactions', 'asthma trigger', 'aspirin cross-sensitivity'],
  '{"acute": "Can trigger hives, asthma attacks, and anaphylaxis in sensitive individuals; cross-reactivity with aspirin sensitivity; behavioral effects in children", "chronic": "Linked to hyperactivity in children (Southampton study); one of the most allergenic food dyes; may cause purpura (bleeding under skin) in rare cases; petroleum-derived", "vulnerable_groups": ["children", "aspirin-sensitive individuals", "asthmatics", "individuals with ADHD"]}',
  '{"fda": "approved (requires specific label declaration by name)", "eu": "approved (E102) with mandatory warning label", "notes": "Only food dye that FDA requires to be listed by name on labels (since 1980s) due to allergy concerns; EU warning label required; second most used food dye in the US"}',
  ARRAY['turmeric', 'beta-carotene', 'annatto', 'saffron', 'paprika'],
  ARRAY['candy', 'cereals', 'snack foods', 'soft drinks', 'pickles', 'mustard', 'medications'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Southampton University', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Yellow 6 (Sunset Yellow)',
  'yellow-6',
  ARRAY['E110', 'Sunset Yellow FCF', 'FD&C Yellow No. 6', 'CI 15985', 'Orange Yellow S'],
  'color',
  8,
  ARRAY['hyperactivity in children', 'allergic reactions', 'possible carcinogen contaminants', 'adrenal tumors in animals'],
  '{"acute": "May cause hives, rhinitis, nasal congestion, and allergic reactions; behavioral effects in sensitive children", "chronic": "Linked to hyperactivity in children (Southampton study); may contain carcinogenic contaminants; associated with adrenal tumors in animal studies; petroleum-derived", "vulnerable_groups": ["children", "aspirin-sensitive individuals", "individuals with ADHD"]}',
  '{"fda": "approved (certified)", "eu": "approved (E110) with mandatory warning label", "notes": "Third most used food dye in US; EU warning label required; part of Southampton Six dyes linked to hyperactivity; California warning label law applies"}',
  ARRAY['turmeric', 'beta-carotene', 'annatto', 'paprika oleoresin'],
  ARRAY['candy', 'cereals', 'baked goods', 'gelatin desserts', 'sauces', 'snack foods'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Southampton University', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Blue 1 (Brilliant Blue)',
  'blue-1',
  ARRAY['E133', 'Brilliant Blue FCF', 'FD&C Blue No. 1', 'CI 42090', 'Blue 1 Lake'],
  'color',
  6,
  ARRAY['hyperactivity in children', 'chromosomal damage in vitro', 'allergic reactions'],
  '{"acute": "May cause allergic reactions including hives and asthma in sensitive individuals; rarely reported anaphylaxis", "chronic": "Some in-vitro studies show chromosomal damage; linked to hyperactivity in children; poorly absorbed from GI tract which limits systemic exposure; petroleum-derived", "vulnerable_groups": ["children", "individuals with ADHD", "aspirin-sensitive individuals"]}',
  '{"fda": "approved (certified)", "eu": "approved (E133)", "notes": "Used in beverages, candy, and ice cream; gives blue color to many products; also used to detect aspiration in tube-fed patients (discontinued due to toxicity concerns at high medical doses)"}',
  ARRAY['spirulina', 'butterfly pea flower', 'red cabbage juice (at alkaline pH)'],
  ARRAY['candy', 'beverages', 'ice cream', 'canned peas', 'dairy products', 'cereals'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Blue 2 (Indigotine)',
  'blue-2',
  ARRAY['E132', 'Indigotine', 'Indigo Carmine', 'FD&C Blue No. 2', 'CI 73015'],
  'color',
  6,
  ARRAY['possible brain tumors in animals', 'hyperactivity in children', 'allergic reactions'],
  '{"acute": "May cause nausea, vomiting, hypertension, and allergic reactions in sensitive individuals; can cause skin irritation", "chronic": "Some animal studies showed increased incidence of brain gliomas (tumors), though statistical significance debated; linked to hyperactivity; petroleum-derived", "vulnerable_groups": ["children", "individuals with ADHD"]}',
  '{"fda": "approved (certified)", "eu": "approved (E132)", "notes": "Synthetic version of indigo dye; used in candy, beverages, and pet food; less commonly used than Blue 1; also used as medical diagnostic dye"}',
  ARRAY['spirulina', 'butterfly pea flower', 'blueberry juice concentrate'],
  ARRAY['candy', 'beverages', 'pet food', 'cereals', 'frozen treats'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Green 3 (Fast Green)',
  'green-3',
  ARRAY['E143', 'Fast Green FCF', 'FD&C Green No. 3', 'CI 42053', 'Food Green 3'],
  'color',
  6,
  ARRAY['possible bladder tumors', 'poorly tested', 'mutagenic concerns'],
  '{"acute": "May cause allergic reactions in sensitive individuals", "chronic": "Some animal studies suggest possible bladder and testes tumors; mutagenic in some in-vitro tests; relatively poorly studied compared to other dyes; petroleum-derived", "vulnerable_groups": ["children"]}',
  '{"fda": "approved (certified)", "eu": "approved (E143) but rarely used", "notes": "Least commonly used of the approved FD&C dyes; rarely used in food; more common in cosmetics and medications; banned in some EU countries despite E-number approval"}',
  ARRAY['chlorophyll', 'spirulina', 'matcha', 'spinach extract'],
  ARRAY['candy', 'beverages', 'ice cream', 'cosmetics', 'medications'],
  ARRAY['FDA', 'EFSA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Orange B',
  'orange-b',
  ARRAY['CI 19235', 'FD&C Orange B', '1-(4-sulfophenyl)-3-ethylcarboxy-4-(4-sulfonaphthylazo)-5-hydroxypyrazole'],
  'color',
  7,
  ARRAY['very limited safety data', 'restricted use', 'azo dye concerns'],
  '{"acute": "Limited data; potential for allergic reactions as with other azo dyes", "chronic": "Very limited safety studies; approved only for hot dog and sausage casings; azo dye class raises concerns about carcinogenicity; essentially not studied adequately by modern standards", "vulnerable_groups": ["children", "aspirin-sensitive individuals"]}',
  '{"fda": "approved only for hot dog and sausage casings (max 150 ppm)", "eu": "not approved", "notes": "Extremely restricted use; only approved for coloring hot dog and sausage casings; rarely if ever actually used in practice; not approved in EU; one of the least studied approved dyes"}',
  ARRAY['paprika oleoresin', 'annatto', 'beta-carotene'],
  ARRAY['hot dog casings', 'sausage casings'],
  ARRAY['FDA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Citrus Red 2',
  'citrus-red-2',
  ARRAY['CI 12156', 'Citrus Red No. 2', '1-(2,5-dimethoxyphenylazo)-2-naphthol'],
  'color',
  8,
  ARRAY['possible carcinogen', 'very restricted use', 'bladder tumors in animals', 'azo dye'],
  '{"acute": "Not directly consumed in significant quantities (applied to orange peels only)", "chronic": "Caused bladder tumors in animal studies; possible carcinogen; only applied to orange peels (not for consumption) but can transfer to hands and potentially to food", "vulnerable_groups": ["children", "individuals handling oranges"]}',
  '{"fda": "approved only for coloring orange peels (max 2 ppm)", "eu": "not approved", "notes": "Only approved for coloring the skin of oranges not intended for processing; almost never used in practice as consumer preference shifted away; caused bladder tumors in mice"}',
  ARRAY['no coloring needed for orange peels'],
  ARRAY['orange peels (surface only)'],
  ARRAY['FDA', 'CSPI', 'IARC']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Caramel Color (Class III)',
  'caramel-color-class-iii',
  ARRAY['E150c', 'ammonia caramel', 'caramel color III', 'ammonia process caramel'],
  'color',
  5,
  ARRAY['4-MEI contaminant', 'possible carcinogen', 'immunotoxicity'],
  '{"acute": "No significant acute effects from the caramel itself at food levels", "chronic": "Contains 4-methylimidazole (4-MEI), a possible carcinogen; ammonia process creates higher 4-MEI levels than Class IV; animal studies showed immunotoxic effects including reduced white blood cell counts", "vulnerable_groups": ["children", "immunocompromised individuals"]}',
  '{"fda": "approved", "eu": "approved (E150c) with limits on 4-MEI", "notes": "Made by heating sugar with ammonia compounds; contains 4-MEI contaminant; used in beer, soy sauce, and some confections; Class III has higher immunotoxicity concerns than Class IV"}',
  ARRAY['beet sugar caramel', 'molasses', 'blackstrap syrup', 'date syrup coloring'],
  ARRAY['beer', 'soy sauce', 'confections', 'baked goods', 'pet food'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'IARC', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Caramel Color (Class IV)',
  'caramel-color-class-iv',
  ARRAY['E150d', 'sulfite ammonia caramel', 'caramel color IV', 'ammonia sulfite process caramel'],
  'color',
  6,
  ARRAY['4-MEI contaminant', 'possible carcinogen', 'most commonly used class'],
  '{"acute": "No significant acute effects at food levels", "chronic": "Contains 4-methylimidazole (4-MEI), classified as possibly carcinogenic to humans by IARC; California Prop 65 lists 4-MEI; most widely consumed caramel color globally; found in virtually all colas", "vulnerable_groups": ["children", "heavy cola drinkers"]}',
  '{"fda": "approved", "eu": "approved (E150d) with limits on 4-MEI", "notes": "Most commonly used caramel color worldwide; primary colorant in cola beverages; California Prop 65 forced Coca-Cola and Pepsi to reduce 4-MEI levels in 2014; made with ammonia and sulfite compounds"}',
  ARRAY['beet sugar caramel', 'molasses', 'date syrup coloring'],
  ARRAY['cola drinks', 'soy sauce', 'gravies', 'dark breads', 'vinegars', 'coffee-flavored products'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'IARC', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Titanium Dioxide',
  'titanium-dioxide',
  ARRAY['E171', 'TiO2', 'CI 77891', 'titanium white', 'pigment white 6'],
  'color',
  7,
  ARRAY['possible carcinogen by inhalation', 'nanoparticle concerns', 'gut inflammation', 'banned in EU food'],
  '{"acute": "No significant acute oral toxicity; inhalation of dust is hazardous", "chronic": "IARC Group 2B possible carcinogen (by inhalation); nanoparticle form can cross intestinal barrier; associated with gut inflammation and microbiome disruption; may damage DNA; banned in EU food since 2022", "vulnerable_groups": ["children", "individuals with IBD or gut conditions"]}',
  '{"fda": "approved (max 1% by weight of food)", "eu": "banned in food (since August 2022, E171)", "notes": "Banned in EU food since 2022 due to genotoxicity concerns; still allowed in US food, cosmetics, and pharmaceuticals; EFSA concluded it can no longer be considered safe; used as whitening agent"}',
  ARRAY['calcium carbonate', 'rice starch', 'tapioca starch', 'zinc oxide (cosmetics)'],
  ARRAY['candy coatings', 'chewing gum', 'coffee creamers', 'icing', 'sunscreen', 'toothpaste', 'medications'],
  ARRAY['EFSA', 'IARC', 'FDA', 'CSPI', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Carbon Black',
  'carbon-black',
  ARRAY['E153', 'vegetable carbon', 'charcoal color', 'CI 77266', 'lamp black'],
  'color',
  5,
  ARRAY['possible carcinogen by inhalation', 'PAH contamination', 'limited food safety data'],
  '{"acute": "No significant acute oral toxicity; inhalation of dust is hazardous (occupational concern)", "chronic": "IARC Group 2B possible carcinogen (by inhalation); may contain polycyclic aromatic hydrocarbons (PAHs) as contaminants; limited oral toxicity data", "vulnerable_groups": ["workers with inhalation exposure"]}',
  '{"fda": "not approved for food use in US; approved in cosmetics", "eu": "approved in food (E153) with purity requirements", "notes": "Not approved as food colorant in US; approved in EU as E153 (vegetable carbon); used in cosmetics and some food products outside US; distinct from activated charcoal"}',
  ARRAY['activated charcoal (food grade)', 'squid ink', 'black cocoa powder'],
  ARRAY['confections (EU)', 'cheese rinds (EU)', 'cosmetics', 'food coloring (outside US)'],
  ARRAY['IARC', 'FDA', 'EFSA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Iron Oxide Red',
  'iron-oxide-red',
  ARRAY['E172', 'CI 77491', 'ferric oxide', 'Fe2O3', 'red iron oxide', 'red ochre'],
  'color',
  2,
  ARRAY['minimal concerns at food-use levels', 'nanoparticle size concerns in some formulations'],
  '{"acute": "Very low oral toxicity; may cause minor GI irritation at very high doses", "chronic": "Generally considered safe; naturally occurring mineral; inert in the body; some concern about nanoparticle-sized particles but minimal at food-use levels", "vulnerable_groups": []}',
  '{"fda": "approved for cosmetics and drugs; exempt from certification", "eu": "approved (E172)", "notes": "Natural mineral pigment; approved in cosmetics in US but not technically as food colorant (approved in EU); widely used in supplements, cosmetics, and food globally"}',
  ARRAY['beet juice', 'paprika oleoresin', 'carmine'],
  ARRAY['cosmetics', 'dietary supplements', 'food products (EU)', 'pet food'],
  ARRAY['FDA', 'EFSA', 'EWG', 'CIR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Iron Oxide Yellow',
  'iron-oxide-yellow',
  ARRAY['E172', 'CI 77492', 'ferric hydroxide oxide', 'FeO(OH)', 'yellow iron oxide', 'yellow ochre'],
  'color',
  2,
  ARRAY['minimal concerns at food-use levels'],
  '{"acute": "Very low oral toxicity; inert mineral pigment", "chronic": "Generally considered safe; naturally occurring mineral; no significant chronic toxicity concerns at approved levels", "vulnerable_groups": []}',
  '{"fda": "approved for cosmetics and drugs; exempt from certification", "eu": "approved (E172)", "notes": "Natural mineral pigment; same regulatory status as red iron oxide; commonly used in cosmetics and supplements"}',
  ARRAY['turmeric', 'beta-carotene', 'annatto'],
  ARRAY['cosmetics', 'dietary supplements', 'food products (EU)', 'pet food'],
  ARRAY['FDA', 'EFSA', 'EWG', 'CIR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Iron Oxide Black',
  'iron-oxide-black',
  ARRAY['E172', 'CI 77499', 'ferrosoferric oxide', 'Fe3O4', 'black iron oxide', 'magnetite'],
  'color',
  2,
  ARRAY['minimal concerns at food-use levels'],
  '{"acute": "Very low oral toxicity; inert mineral pigment", "chronic": "Generally considered safe; naturally occurring mineral (magnetite); no significant chronic toxicity concerns at approved levels", "vulnerable_groups": []}',
  '{"fda": "approved for cosmetics and drugs; exempt from certification", "eu": "approved (E172)", "notes": "Natural mineral pigment; same class as other iron oxides; commonly used in cosmetics for dark shades; minimal health concerns"}',
  ARRAY['activated charcoal', 'squid ink', 'black cocoa powder'],
  ARRAY['cosmetics', 'dietary supplements', 'food products (EU)', 'mascara', 'eyeliner'],
  ARRAY['FDA', 'EFSA', 'EWG', 'CIR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Annatto',
  'annatto',
  ARRAY['E160b', 'annatto extract', 'bixin', 'norbixin', 'achiote', 'CI 75120', 'annatto color'],
  'color',
  2,
  ARRAY['rare allergic reactions', 'possible IBS trigger'],
  '{"acute": "Rare allergic reactions including urticaria and angioedema; may trigger IBS symptoms in sensitive individuals", "chronic": "Generally considered safe; used for centuries in Latin American cuisine; natural carotenoid; rare reports of food intolerance", "vulnerable_groups": ["individuals with annatto sensitivity (rare)", "those with IBS"]}',
  '{"fda": "exempt from certification (natural color)", "eu": "approved (E160b)", "notes": "Natural color from seeds of achiote tree (Bixa orellana); one of the most widely used natural food colors; provides yellow-orange color; used traditionally for centuries"}',
  ARRAY['turmeric', 'beta-carotene', 'paprika oleoresin', 'saffron'],
  ARRAY['cheese', 'butter', 'margarine', 'snack foods', 'cereals', 'ice cream'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Beta-Carotene',
  'beta-carotene',
  ARRAY['E160a', 'provitamin A', 'CI 75130', 'beta carotene', 'betacarotene', 'natural orange color'],
  'color',
  1,
  ARRAY['skin discoloration at very high doses', 'increased lung cancer risk in smokers (supplements)'],
  '{"acute": "No significant acute toxicity; excessive intake causes harmless carotenodermia (orange skin)", "chronic": "Safe from food sources; however, high-dose beta-carotene SUPPLEMENTS increased lung cancer risk in smokers (ATBC and CARET trials); from food sources considered beneficial and safe", "vulnerable_groups": ["smokers should avoid high-dose supplements"]}',
  '{"fda": "exempt from certification (natural color); GRAS", "eu": "approved (E160a)", "notes": "Provitamin A; converts to vitamin A in the body; naturally found in carrots, sweet potatoes, and leafy greens; food-derived beta-carotene is safe; only supplement form at high doses is concerning for smokers"}',
  ARRAY['already considered a very safe natural colorant'],
  ARRAY['margarine', 'cheese', 'beverages', 'baked goods', 'dietary supplements', 'infant formula'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA', 'NCI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Paprika Oleoresin',
  'paprika-oleoresin',
  ARRAY['E160c', 'paprika extract', 'capsanthin', 'capsorubin', 'paprika color'],
  'color',
  1,
  ARRAY['very rare allergic reactions in nightshade-sensitive individuals'],
  '{"acute": "No significant adverse effects; very rare allergic reactions in those with nightshade sensitivity", "chronic": "No chronic toxicity concerns; contains beneficial carotenoids and capsaicinoids; antioxidant properties", "vulnerable_groups": ["individuals with nightshade allergies (very rare)"]}',
  '{"fda": "exempt from certification (natural color)", "eu": "approved (E160c)", "notes": "Natural extract from paprika peppers (Capsicum annuum); provides red-orange color; contains capsanthin and capsorubin carotenoids; widely considered safe"}',
  ARRAY['already considered a very safe natural colorant'],
  ARRAY['sausages', 'cheese', 'snack foods', 'dressings', 'seasonings', 'processed meats'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Turmeric',
  'turmeric',
  ARRAY['E100', 'curcumin', 'curcuma longa', 'CI 75300', 'turmeric extract', 'turmeric oleoresin'],
  'color',
  1,
  ARRAY['may interfere with iron absorption at very high doses', 'rare allergic reactions'],
  '{"acute": "No significant adverse effects at food-color levels; very high supplement doses may cause GI discomfort", "chronic": "No chronic toxicity concerns at food-use levels; curcumin has anti-inflammatory and antioxidant properties; extensively studied for health benefits; traditional spice used for millennia", "vulnerable_groups": ["individuals with gallbladder issues at very high supplement doses"]}',
  '{"fda": "exempt from certification (natural color); GRAS as spice", "eu": "approved (E100)", "notes": "Natural yellow-orange color from turmeric root; curcumin is the active pigment; widely used as both food color and spice; extensive positive health research; one of the safest food colors"}',
  ARRAY['already considered one of the safest natural colorants'],
  ARRAY['mustard', 'curry', 'cheese', 'margarine', 'beverages', 'baked goods', 'snack foods'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Riboflavin',
  'riboflavin',
  ARRAY['E101', 'vitamin B2', 'lactoflavin', 'riboflavine'],
  'color',
  1,
  ARRAY['bright yellow urine (harmless)'],
  '{"acute": "No toxicity concerns; excess is excreted in urine (causing bright yellow color); water-soluble vitamin", "chronic": "Essential vitamin (B2); no chronic toxicity; deficiency is more of a concern than excess; safe as both nutrient and colorant", "vulnerable_groups": []}',
  '{"fda": "GRAS; exempt from certification", "eu": "approved (E101)", "notes": "Essential B vitamin used as yellow food color; completely safe; naturally found in milk, eggs, meat, and green vegetables; excess harmlessly excreted"}',
  ARRAY['already considered one of the safest colorants (it is a vitamin)'],
  ARRAY['cereals', 'baby foods', 'pasta', 'cheese', 'nutritional supplements', 'energy drinks'],
  ARRAY['FDA', 'EFSA', 'WHO', 'NIH']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Carmine (Cochineal)',
  'carmine',
  ARRAY['E120', 'cochineal extract', 'carminic acid', 'CI 75470', 'Natural Red 4', 'crimson lake'],
  'color',
  3,
  ARRAY['allergic reactions', 'anaphylaxis risk', 'not vegan/vegetarian'],
  '{"acute": "Can cause severe allergic reactions including anaphylaxis in sensitive individuals; FDA requires label declaration due to allergy risk", "chronic": "No significant chronic toxicity; allergenic potential is the primary concern; derived from crushed cochineal insects which is an ethical/dietary concern for vegans and vegetarians", "vulnerable_groups": ["individuals with cochineal allergy", "asthmatics", "vegans/vegetarians"]}',
  '{"fda": "exempt from certification; must be declared on label by name", "eu": "approved (E120)", "notes": "Natural red dye from crushed cochineal insects; FDA mandated label declaration in 2009 due to allergy reports; not suitable for vegan/vegetarian/halal/kosher diets; Starbucks stopped using it in 2012 after backlash"}',
  ARRAY['beet juice', 'anthocyanins', 'paprika oleoresin', 'lycopene'],
  ARRAY['yogurt', 'candy', 'fruit drinks', 'cosmetics', 'lipstick', 'ice cream'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Spirulina',
  'spirulina',
  ARRAY['spirulina extract', 'phycocyanin', 'blue spirulina', 'Arthrospira platensis extract'],
  'color',
  1,
  ARRAY['contamination risk from poor-quality sources', 'very rare allergic reactions'],
  '{"acute": "No significant adverse effects from color use; contamination with microcystins or heavy metals is a concern with poor-quality spirulina supplements (not relevant to purified color extract)", "chronic": "No chronic toxicity from purified color extract; spirulina itself is considered a superfood with beneficial properties; phycocyanin has antioxidant and anti-inflammatory properties", "vulnerable_groups": ["individuals with phenylketonuria (spirulina contains phenylalanine)", "those with autoimmune conditions (may stimulate immune system)"]}',
  '{"fda": "exempt from certification (color additive approved 2013)", "eu": "approved as natural color", "notes": "Blue-green algae extract; provides natural blue color (phycocyanin); FDA approved as color additive in 2013; increasingly popular replacement for synthetic Blue 1; considered a superfood"}',
  ARRAY['already considered one of the safest natural blue colorants'],
  ARRAY['candy', 'ice cream', 'beverages', 'yogurt', 'confections', 'smoothie bowls'],
  ARRAY['FDA', 'EFSA', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Chlorophyll',
  'chlorophyll',
  ARRAY['E140', 'chlorophyllin', 'E141', 'copper chlorophyllin', 'CI 75810', 'natural green 3'],
  'color',
  1,
  ARRAY['may cause green discoloration of stool (harmless)', 'photosensitivity with copper chlorophyllin supplements'],
  '{"acute": "No significant adverse effects; may cause green stool (harmless); copper chlorophyllin supplements may cause photosensitivity", "chronic": "No chronic toxicity concerns; may have beneficial antioxidant properties; naturally present in all green plants", "vulnerable_groups": []}',
  '{"fda": "exempt from certification (natural color)", "eu": "approved (E140 chlorophyll, E141 copper chlorophyllin)", "notes": "Natural green pigment found in all plants; E140 is natural chlorophyll; E141 is copper chlorophyllin (more stable); both considered very safe"}',
  ARRAY['already considered one of the safest natural green colorants'],
  ARRAY['pasta', 'beverages', 'candy', 'dairy products', 'supplements', 'cosmetics'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Anthocyanins',
  'anthocyanins',
  ARRAY['E163', 'grape skin extract', 'elderberry color', 'black carrot extract', 'purple sweet potato color'],
  'color',
  1,
  ARRAY['very rare allergic reactions'],
  '{"acute": "No significant adverse effects; very well tolerated", "chronic": "Beneficial antioxidant properties; associated with cardiovascular health benefits; naturally occurring in many fruits and vegetables; extensively studied with positive health outcomes", "vulnerable_groups": []}',
  '{"fda": "exempt from certification (natural color)", "eu": "approved (E163)", "notes": "Natural pigments responsible for red, purple, and blue colors in fruits and vegetables; potent antioxidants; health-promoting properties; grape skin extract is most common commercial source"}',
  ARRAY['already considered one of the safest natural colorants with health benefits'],
  ARRAY['beverages', 'yogurt', 'candy', 'ice cream', 'jams', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Beet Juice Color',
  'beet-juice-color',
  ARRAY['E162', 'beetroot red', 'betanin', 'beet juice concentrate', 'betacyanin'],
  'color',
  1,
  ARRAY['red urine/stool (harmless beeturia)', 'very rare allergic reactions'],
  '{"acute": "No significant adverse effects; may cause beeturia (red-colored urine and stool) which is harmless and affects about 10-14% of population", "chronic": "No chronic toxicity concerns; betanin has antioxidant and anti-inflammatory properties; naturally occurring in beets", "vulnerable_groups": []}',
  '{"fda": "exempt from certification (natural color)", "eu": "approved (E162)", "notes": "Natural red color from beetroot; one of the most popular natural alternatives to synthetic red dyes; heat and pH sensitive; provides vibrant red/pink color; increasingly used as Red 40 alternative"}',
  ARRAY['already considered one of the safest natural red colorants'],
  ARRAY['yogurt', 'ice cream', 'candy', 'beverages', 'sauces', 'plant-based meats'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Saffron',
  'saffron',
  ARRAY['Crocus sativus extract', 'crocin', 'safranal', 'saffron color'],
  'color',
  1,
  ARRAY['toxic at extremely high doses (unlikely from food use)', 'very expensive'],
  '{"acute": "Safe at culinary doses; toxic at 5g+ (would require enormous amounts as food color); abortifacient at very high doses", "chronic": "No chronic concerns at food-use levels; crocin and safranal have demonstrated neuroprotective, antioxidant, and antidepressant properties in research", "vulnerable_groups": ["pregnant women should avoid medicinal/supplement doses"]}',
  '{"fda": "GRAS as spice and color", "eu": "approved", "notes": "Most expensive spice in the world; provides golden-yellow color; used for millennia; health benefits extensively researched; safe at all culinary levels; toxic dose is impractically large"}',
  ARRAY['already considered one of the safest natural colorants'],
  ARRAY['rice dishes', 'baked goods', 'beverages', 'confections', 'liqueurs'],
  ARRAY['FDA', 'EFSA', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lycopene',
  'lycopene',
  ARRAY['E160d', 'psi,psi-carotene', 'tomato extract color', 'natural red carotenoid'],
  'color',
  1,
  ARRAY['harmless skin discoloration at very high intake', 'very rare GI discomfort'],
  '{"acute": "No significant adverse effects; very high intake may cause lycopenodermia (harmless orange skin discoloration)", "chronic": "Associated with reduced risk of prostate cancer and cardiovascular disease; potent antioxidant; no chronic toxicity concerns; beneficial health effects well documented", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E160d)", "notes": "Natural red carotenoid pigment from tomatoes; potent antioxidant; extensively researched for health benefits including reduced cancer and heart disease risk; absorption enhanced with cooking and fat"}',
  ARRAY['already considered one of the safest natural colorants with health benefits'],
  ARRAY['beverages', 'dairy products', 'sauces', 'supplements', 'processed foods'],
  ARRAY['FDA', 'EFSA', 'WHO', 'NCI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lutein',
  'lutein',
  ARRAY['E161b', 'xanthophyll', 'marigold extract color', 'tagetes extract'],
  'color',
  1,
  ARRAY['harmless skin discoloration at extremely high doses'],
  '{"acute": "No significant adverse effects at food-use levels", "chronic": "Beneficial carotenoid essential for eye health; reduces risk of age-related macular degeneration; antioxidant properties; no chronic toxicity concerns", "vulnerable_groups": []}',
  '{"fda": "GRAS; exempt from certification", "eu": "approved (E161b)", "notes": "Natural yellow carotenoid from marigold flowers and green vegetables; essential for eye health; commonly used in dietary supplements for macular degeneration prevention; naturally found in egg yolks"}',
  ARRAY['already considered one of the safest natural colorants with health benefits'],
  ARRAY['supplements', 'baked goods', 'beverages', 'dairy products', 'infant formula'],
  ARRAY['FDA', 'EFSA', 'WHO', 'NEI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Canthaxanthin',
  'canthaxanthin',
  ARRAY['E161g', 'CI 40850', 'beta,beta-carotene-4,4''-dione', 'canthaxanthine'],
  'color',
  4,
  ARRAY['retinal crystal deposits', 'eye damage at high doses', 'restricted use'],
  '{"acute": "Generally safe at food-color levels", "chronic": "High doses (as in tanning pills) cause canthaxanthin retinopathy (crystal deposits in the retina); reversible upon discontinuation; EFSA set low ADI due to eye concerns", "vulnerable_groups": ["individuals using tanning pills (banned use)", "those with pre-existing eye conditions"]}',
  '{"fda": "approved for food use only (not as tanning agent); max 30 ppm in food", "eu": "approved (E161g) with strict ADI of 0.03 mg/kg/day", "notes": "Natural carotenoid found in mushrooms, crustaceans, and fish; used to color farm-raised salmon; banned as tanning pill ingredient; very low ADI due to eye crystal concerns at high doses"}',
  ARRAY['astaxanthin', 'paprika oleoresin', 'beta-carotene'],
  ARRAY['farm-raised salmon feed', 'sausages', 'candy', 'supplements'],
  ARRAY['FDA', 'EFSA', 'WHO', 'JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Monosodium Glutamate',
  'monosodium-glutamate',
  ARRAY['MSG', 'E621', 'Sodium Glutamate', 'Glutamic Acid Monosodium Salt', 'Yeast Extract (hidden MSG)', 'Ajinomoto'],
  'additive',
  4,
  ARRAY['excitotoxin', 'headaches', 'allergic-type reactions', 'appetite stimulation'],
  '{"acute": "May cause headaches, flushing, sweating, numbness, and chest pain in sensitive individuals (MSG symptom complex)", "chronic": "Debated links to obesity through appetite stimulation and potential excitotoxic effects on neurons at high doses", "vulnerable_groups": ["children", "asthmatics", "MSG-sensitive individuals"]}',
  '{"fda": "GRAS", "eu": "approved with limits (E621, max 10g/kg)", "notes": "FDA requires labeling when added as ingredient; hidden sources like yeast extract and hydrolyzed protein do not require MSG labeling"}',
  ARRAY['herbs and spices', 'nutritional yeast', 'mushroom powder', 'coconut aminos', 'sea salt'],
  ARRAY['chips', 'instant noodles', 'frozen meals', 'canned soups', 'seasoning mixes', 'fast food'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI', 'Journal of Headache and Pain']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Carrageenan',
  'carrageenan',
  ARRAY['E407', 'Irish Moss Extract', 'Chondrus Crispus', 'Iota Carrageenan', 'Kappa Carrageenan', 'Lambda Carrageenan'],
  'additive',
  6,
  ARRAY['gut inflammation', 'gastrointestinal distress', 'potential carcinogen (degraded form)', 'immune suppression'],
  '{"acute": "May cause bloating, irritable bowel symptoms, and gastrointestinal inflammation in sensitive individuals", "chronic": "Degraded carrageenan (poligeenan) is a known carcinogen; food-grade carrageenan may degrade in acidic stomach conditions, raising concerns about chronic gut inflammation and potential tumor promotion", "vulnerable_groups": ["infants", "individuals with IBD or IBS", "immunocompromised individuals"]}',
  '{"fda": "GRAS", "eu": "approved (E407), banned in infant formula", "notes": "The EU banned carrageenan in infant formula in 2018; the National Organic Standards Board voted to remove it from organic foods but USDA overruled; Cornucopia Institute has petitioned for its removal"}',
  ARRAY['guar gum', 'locust bean gum', 'gellan gum', 'agar agar', 'sunflower lecithin'],
  ARRAY['plant-based milks', 'ice cream', 'yogurt', 'deli meats', 'infant formula', 'cottage cheese', 'chocolate milk'],
  ARRAY['CSPI', 'EFSA', 'Cornucopia Institute', 'IARC', 'Journal of Environmental Health Perspectives']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polysorbate 80',
  'polysorbate-80',
  ARRAY['E433', 'Tween 80', 'Polyoxyethylene Sorbitan Monooleate', 'PEG-80 Sorbitan Monooleate'],
  'additive',
  5,
  ARRAY['gut microbiome disruption', 'intestinal inflammation', 'potential reproductive effects', 'anaphylactoid reactions'],
  '{"acute": "Rare anaphylactoid reactions reported, particularly in injectable formulations; mild gastrointestinal discomfort possible", "chronic": "Animal studies show gut microbiome disruption, intestinal inflammation, metabolic syndrome, and promotion of colitis; may increase intestinal permeability (leaky gut)", "vulnerable_groups": ["individuals with IBD", "children", "individuals with autoimmune conditions"]}',
  '{"fda": "GRAS (up to 1% in food)", "eu": "approved (E433) with ADI of 25 mg/kg body weight", "notes": "Also used in vaccines and pharmaceuticals as an excipient; Georgia State University research linked it to colitis and metabolic syndrome in mice"}',
  ARRAY['sunflower lecithin', 'gum arabic', 'agar agar'],
  ARRAY['ice cream', 'salad dressings', 'sauces', 'baked goods', 'gelatin desserts', 'vaccines'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Nature journal', 'Georgia State University']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polysorbate 60',
  'polysorbate-60',
  ARRAY['E435', 'Tween 60', 'Polyoxyethylene Sorbitan Monostearate', 'PEG-60 Sorbitan Monostearate'],
  'additive',
  4,
  ARRAY['gut microbiome disruption', 'potential contaminants (ethylene oxide, 1,4-dioxane)', 'intestinal inflammation'],
  '{"acute": "Generally well tolerated at food-use levels; rare hypersensitivity reactions possible", "chronic": "Similar concerns to polysorbate 80 regarding gut microbiome disruption; may contain trace contaminants from ethoxylation process including ethylene oxide (carcinogen) and 1,4-dioxane", "vulnerable_groups": ["children", "individuals with IBD"]}',
  '{"fda": "GRAS", "eu": "approved (E435) with combined ADI for polysorbates", "notes": "Less studied than polysorbate 80 but shares similar chemical structure and concerns"}',
  ARRAY['sunflower lecithin', 'gum arabic', 'beeswax'],
  ARRAY['whipped toppings', 'baked goods', 'cake mixes', 'frozen desserts', 'imitation cream'],
  ARRAY['FDA', 'EFSA', 'EWG', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polysorbate 20',
  'polysorbate-20',
  ARRAY['E432', 'Tween 20', 'Polyoxyethylene Sorbitan Monolaurate', 'PEG-20 Sorbitan Monolaurate'],
  'additive',
  4,
  ARRAY['gut microbiome disruption', 'ethylene oxide contamination risk', 'intestinal permeability'],
  '{"acute": "Generally well tolerated; mild GI discomfort at high doses", "chronic": "Shares concerns with other polysorbates regarding gut barrier disruption and microbiome alteration; potential trace contamination with ethylene oxide and 1,4-dioxane from manufacturing", "vulnerable_groups": ["children", "individuals with GI conditions"]}',
  '{"fda": "GRAS", "eu": "approved (E432)", "notes": "Widely used in food and cosmetics; part of the polysorbate family with shared safety concerns"}',
  ARRAY['sunflower lecithin', 'quillaja extract', 'gum arabic'],
  ARRAY['salad dressings', 'baked goods', 'ice cream', 'chewing gum', 'beverages'],
  ARRAY['FDA', 'EFSA', 'EWG', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Aluminum Phosphate',
  'sodium-aluminum-phosphate',
  ARRAY['E541', 'SALP', 'Sodium Aluminium Phosphate'],
  'additive',
  6,
  ARRAY['aluminum exposure', 'neurotoxicity', 'bone toxicity', 'kidney stress'],
  '{"acute": "Generally considered low acute toxicity at food-use levels", "chronic": "Contributes to dietary aluminum burden; chronic aluminum exposure linked to neurodegenerative diseases including Alzheimer''s; aluminum accumulates in bone and brain tissue; kidney-impaired individuals cannot efficiently excrete aluminum", "vulnerable_groups": ["children", "elderly", "individuals with kidney disease", "pregnant women"]}',
  '{"fda": "GRAS", "eu": "approved (E541) with restrictions", "notes": "EFSA reduced the tolerable weekly intake for aluminum in 2008; aluminum-containing additives are a significant source of dietary aluminum exposure"}',
  ARRAY['cream of tartar', 'monocalcium phosphate', 'aluminum-free baking powder'],
  ARRAY['baking powder', 'self-rising flour', 'pancake mix', 'biscuit mix', 'processed cheese'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'Alzheimer''s Association', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Disodium EDTA',
  'calcium-disodium-edta',
  ARRAY['E385', 'Disodium Calcium EDTA', 'Edetate Calcium Disodium', 'CaNa2EDTA', 'Calcium Disodium Ethylenediaminetetraacetate'],
  'additive',
  4,
  ARRAY['mineral depletion', 'kidney stress', 'cytotoxicity at high doses', 'reproductive concerns'],
  '{"acute": "Low acute toxicity at food-use levels; used medically for lead poisoning chelation", "chronic": "May chelate essential minerals (zinc, iron, calcium) leading to deficiencies with chronic intake; animal studies show kidney damage and reproductive effects at high doses; concerns about mineral depletion in children", "vulnerable_groups": ["children", "pregnant women", "individuals with mineral deficiencies"]}',
  '{"fda": "GRAS (limited to 33-800 ppm depending on food)", "eu": "approved (E385) with ADI of 2.5 mg/kg", "notes": "Primarily used as a preservative to chelate metal ions that would catalyze oxidation; also used in personal care products"}',
  ARRAY['rosemary extract', 'citric acid', 'ascorbic acid', 'tocopherols (vitamin E)'],
  ARRAY['canned beans', 'salad dressings', 'mayonnaise', 'soft drinks', 'pickled foods', 'sandwich spreads'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Propylene Glycol',
  'propylene-glycol',
  ARRAY['E1520', 'PG', '1,2-Propanediol', 'Methyl Ethyl Glycol', 'Propane-1,2-diol'],
  'additive',
  4,
  ARRAY['skin irritant', 'potential neurotoxicity at high doses', 'cardiovascular effects', 'lactic acidosis risk'],
  '{"acute": "Generally low toxicity; high doses can cause CNS depression, lactic acidosis, and hyperosmolality; skin and eye irritant in concentrated forms", "chronic": "Chronic exposure linked to contact dermatitis; animal studies show mild kidney and liver effects; accumulation risk in individuals with impaired kidney or liver function", "vulnerable_groups": ["infants", "individuals with kidney or liver disease", "eczema sufferers"]}',
  '{"fda": "GRAS (food), approved as food additive", "eu": "approved (E1520) with ADI of 25 mg/kg", "notes": "Also used as antifreeze, in e-cigarettes, and extensively in cosmetics; FDA considers food use safe but EU has set lower limits; banned in cat food due to feline sensitivity"}',
  ARRAY['vegetable glycerin', 'organic cane alcohol', 'water-based alternatives'],
  ARRAY['ice cream', 'soft drinks', 'salad dressings', 'baked goods', 'food coloring', 'flavoring extracts', 'medications'],
  ARRAY['FDA', 'EFSA', 'WHO', 'EWG', 'Agency for Toxic Substances and Disease Registry']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Butylene Glycol',
  'butylene-glycol',
  ARRAY['1,3-Butanediol', 'BG', 'Butane-1,3-diol', '1,3-Butylene Glycol'],
  'additive',
  3,
  ARRAY['skin irritation (concentrated)', 'penetration enhancer', 'mild toxicity at high doses'],
  '{"acute": "Low acute toxicity; may cause mild skin and eye irritation in concentrated forms", "chronic": "Limited chronic toxicity data in food use; primarily a cosmetic ingredient; acts as penetration enhancer which may increase absorption of other chemicals through skin", "vulnerable_groups": ["individuals with sensitive skin", "infants"]}',
  '{"fda": "approved as indirect food additive", "eu": "approved for cosmetic use", "notes": "More commonly found in cosmetics and personal care than in food; CIR reviewed and found safe in cosmetic formulations up to 50%"}',
  ARRAY['vegetable glycerin', 'hyaluronic acid', 'aloe vera'],
  ARRAY['cosmetics', 'personal care products', 'food flavoring systems', 'hair care products'],
  ARRAY['FDA', 'CIR', 'EWG', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polyethylene Glycol',
  'polyethylene-glycol',
  ARRAY['PEG', 'Macrogol', 'PEG-400', 'PEG-3350', 'Polyethylene Oxide', 'Carbowax'],
  'additive',
  5,
  ARRAY['ethylene oxide contamination', '1,4-dioxane contamination', 'organ toxicity at high doses', 'allergic reactions'],
  '{"acute": "Low acute toxicity at typical doses; used medicinally as laxative (MiraLAX); rare anaphylactic reactions reported", "chronic": "Manufacturing process may leave residual ethylene oxide (known carcinogen) and 1,4-dioxane (probable carcinogen); high molecular weight PEGs are poorly absorbed but low molecular weight PEGs may cause kidney toxicity; accumulation concerns with chronic use", "vulnerable_groups": ["children", "individuals with kidney disease", "individuals with GI disorders"]}',
  '{"fda": "approved as food additive and drug excipient", "eu": "approved with molecular weight restrictions", "notes": "Widely used in pharmaceuticals as excipient; PEG-3350 is the active ingredient in MiraLAX which has raised concerns for pediatric use; FDA investigating neuropsychiatric events in children"}',
  ARRAY['vegetable glycerin', 'coconut oil-based alternatives', 'beeswax'],
  ARRAY['medications', 'supplements', 'processed foods', 'laxatives', 'cosmetics', 'toothpaste'],
  ARRAY['FDA', 'EFSA', 'EWG', 'WHO', 'Journal of Pharmaceutical Sciences']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Carboxymethylcellulose',
  'sodium-carboxymethylcellulose',
  ARRAY['E466', 'CMC', 'Cellulose Gum', 'Carboxymethyl Cellulose Sodium', 'NaCMC'],
  'additive',
  4,
  ARRAY['gut microbiome disruption', 'intestinal inflammation', 'metabolic effects'],
  '{"acute": "Generally well tolerated; may cause bloating and gas in sensitive individuals", "chronic": "Georgia State University research showed CMC promotes intestinal inflammation and metabolic syndrome in animal models; alters gut microbiota composition; may thin the protective mucus layer of the intestine", "vulnerable_groups": ["individuals with IBD", "children", "individuals with metabolic syndrome"]}',
  '{"fda": "GRAS", "eu": "approved (E466)", "notes": "One of the most widely used food additives; recent research from Chassaing et al. (2015, Nature) raised significant concerns about its effect on gut health"}',
  ARRAY['guar gum', 'acacia gum', 'psyllium husk', 'chia seeds'],
  ARRAY['ice cream', 'gluten-free baked goods', 'salad dressings', 'candy', 'syrups', 'diet foods'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Nature journal', 'Georgia State University']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Microcrystalline Cellulose',
  'microcrystalline-cellulose',
  ARRAY['E460i', 'MCC', 'Cellulose Gel', 'Avicel'],
  'additive',
  2,
  ARRAY['filler ingredient', 'reduced nutrient absorption', 'not digestible'],
  '{"acute": "No significant acute toxicity; passes through digestive tract unabsorbed", "chronic": "Generally considered safe; some concerns about its use as a filler reducing the effective amount of active ingredients in supplements; indigestible fiber that passes through the body", "vulnerable_groups": ["individuals seeking maximum nutrient absorption from supplements"]}',
  '{"fda": "GRAS", "eu": "approved (E460i)", "notes": "Derived from wood pulp; widely used as anti-caking agent and filler in supplements and pharmaceuticals; considered one of the safer food additives"}',
  ARRAY['rice flour', 'tapioca starch', 'organic fillers'],
  ARRAY['supplements', 'tablets', 'capsules', 'shredded cheese', 'fiber supplements', 'low-calorie foods'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'USP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Silicon Dioxide',
  'silicon-dioxide',
  ARRAY['E551', 'Silica', 'SiO2', 'Colloidal Silicon Dioxide', 'Amorphous Silica'],
  'additive',
  2,
  ARRAY['nanoparticle concerns', 'potential accumulation', 'inhalation risk (occupational)'],
  '{"acute": "No significant acute toxicity from oral ingestion at food-use levels", "chronic": "Generally considered safe for oral consumption; nanoparticle forms raise emerging concerns about gut absorption and accumulation in organs; crystalline silica is a known carcinogen via inhalation but amorphous food-grade form is distinct", "vulnerable_groups": ["workers handling powdered forms (inhalation)"]}',
  '{"fda": "GRAS (up to 2% by weight)", "eu": "approved (E551), under re-evaluation for nano forms", "notes": "EFSA initiated re-evaluation of nano-silica safety in 2018; food-grade amorphous silica is different from crystalline silica which causes silicosis"}',
  ARRAY['rice flour', 'arrowroot powder', 'tapioca starch'],
  ARRAY['supplements', 'spice blends', 'powdered foods', 'coffee creamers', 'shredded cheese', 'protein powders'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Magnesium Stearate',
  'magnesium-stearate',
  ARRAY['E470b', 'Magnesium Salt of Stearic Acid', 'Octadecanoic Acid Magnesium Salt'],
  'additive',
  2,
  ARRAY['reduced nutrient absorption (debated)', 'immune suppression (debated)', 'filler concerns'],
  '{"acute": "No significant acute toxicity; well tolerated at food and supplement use levels", "chronic": "Some alternative health claims about immune suppression and nutrient absorption reduction are not well supported by peer-reviewed science; stearic acid is a naturally occurring fatty acid found in cocoa butter and meat", "vulnerable_groups": ["individuals with very sensitive digestion"]}',
  '{"fda": "GRAS", "eu": "approved (E470b)", "notes": "One of the most common supplement excipients; controversy largely driven by a single in-vitro study on stearic acid and T-cells that has not been replicated in vivo; generally considered very safe"}',
  ARRAY['rice bran extract', 'organic rice concentrate', 'vegetable-based lubricants'],
  ARRAY['supplements', 'tablets', 'capsules', 'pharmaceuticals', 'confections'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CIR', 'USP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Stearic Acid',
  'stearic-acid',
  ARRAY['E570', 'Octadecanoic Acid', 'n-Octadecanoic Acid'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'naturally occurring fatty acid'],
  '{"acute": "No significant acute toxicity; naturally occurring saturated fatty acid found in many foods", "chronic": "Unlike other saturated fatty acids, stearic acid has a neutral effect on cholesterol levels; rapidly converted to oleic acid in the body; considered one of the safest food additives", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E570)", "notes": "Found naturally in cocoa butter, beef tallow, and shea butter; considered safe by all major regulatory bodies; does not raise LDL cholesterol like other saturated fats"}',
  ARRAY['no alternatives needed - naturally occurring and safe'],
  ARRAY['chocolate', 'supplements', 'baked goods', 'chewing gum', 'candy'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'American Heart Association']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Stearoyl Lactylate',
  'sodium-stearoyl-lactylate',
  ARRAY['E481', 'SSL', 'Sodium Stearoyl-2-Lactylate'],
  'additive',
  2,
  ARRAY['mild GI effects at high doses', 'processed food indicator'],
  '{"acute": "No significant acute toxicity; well tolerated", "chronic": "Considered one of the safer emulsifier additives; metabolized to stearic acid and lactic acid, both naturally occurring; no significant chronic toxicity concerns at food-use levels", "vulnerable_groups": ["individuals with dairy allergies (contains lactylate derived from lactic acid, though not from milk)"]}',
  '{"fda": "GRAS", "eu": "approved (E481) with ADI of 22 mg/kg", "notes": "Despite the name, lactic acid in SSL is typically produced by fermentation and is vegan; widely considered safe by regulatory bodies"}',
  ARRAY['sunflower lecithin', 'egg-based emulsifiers'],
  ARRAY['bread', 'baked goods', 'tortillas', 'pancake mix', 'coffee creamers', 'snack foods'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Stearoyl Lactylate',
  'calcium-stearoyl-lactylate',
  ARRAY['E482', 'CSL', 'Calcium Stearoyl-2-Lactylate'],
  'additive',
  2,
  ARRAY['mild GI effects at high doses', 'processed food indicator'],
  '{"acute": "No significant acute toxicity; well tolerated at food-use levels", "chronic": "Metabolized to stearic acid and lactic acid; no significant chronic toxicity concerns identified; considered safe by major regulatory bodies", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E482) with ADI of 22 mg/kg", "notes": "Functionally similar to sodium stearoyl lactylate; commonly used in baked goods for dough strengthening and crumb softening"}',
  ARRAY['sunflower lecithin', 'egg-based emulsifiers'],
  ARRAY['bread', 'baked goods', 'crackers', 'cereals', 'dehydrated potatoes'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Caseinate',
  'sodium-caseinate',
  ARRAY['Casein Sodium Salt', 'Sodium Casein'],
  'additive',
  2,
  ARRAY['dairy allergen', 'hidden dairy source', 'not labeled as dairy in non-dairy products'],
  '{"acute": "Safe for non-allergic individuals; can cause severe allergic reactions in those with milk protein allergy (distinct from lactose intolerance)", "chronic": "No significant chronic toxicity for non-allergic individuals; concern is primarily allergenicity; may be found in products labeled as non-dairy or dairy-free", "vulnerable_groups": ["individuals with milk protein allergy", "infants with CMPA (cow''s milk protein allergy)"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "FDA does not consider caseinates as dairy for labeling purposes in some contexts, which has caused confusion and allergic reactions; must be declared as allergen per FALCPA"}',
  ARRAY['pea protein', 'oat-based alternatives', 'coconut cream'],
  ARRAY['coffee creamers', 'non-dairy whipped toppings', 'protein bars', 'processed meats', 'infant formula'],
  ARRAY['FDA', 'EFSA', 'FARE (Food Allergy Research & Education)', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Caseinate',
  'calcium-caseinate',
  ARRAY['Casein Calcium Salt', 'Calcium Casein'],
  'additive',
  2,
  ARRAY['dairy allergen', 'hidden dairy source'],
  '{"acute": "Safe for non-allergic individuals; severe allergic reactions possible in those with milk protein allergy", "chronic": "No chronic toxicity concerns for non-allergic individuals; primary concern is allergenicity and presence in supposedly non-dairy products", "vulnerable_groups": ["individuals with milk protein allergy", "infants with CMPA"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Similar regulatory status and concerns as sodium caseinate; must be declared as milk allergen"}',
  ARRAY['pea protein', 'rice protein', 'hemp protein'],
  ARRAY['protein powders', 'meal replacements', 'processed meats', 'baked goods', 'nutritional supplements'],
  ARRAY['FDA', 'EFSA', 'FARE']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Guar Gum',
  'guar-gum',
  ARRAY['E412', 'Guaran', 'Guar Flour', 'Cyamopsis Tetragonoloba Gum'],
  'additive',
  2,
  ARRAY['bloating', 'gas', 'GI discomfort in sensitive individuals'],
  '{"acute": "May cause bloating, gas, and cramping in some individuals, particularly when consumed in large amounts or when first introduced to the diet", "chronic": "Generally considered safe; actually provides some prebiotic fiber benefits; historical concerns about contaminated guar gum supplements causing esophageal obstruction have been addressed", "vulnerable_groups": ["individuals with SIBO", "individuals with IBS"]}',
  '{"fda": "GRAS", "eu": "approved (E412)", "notes": "Widely used and generally well-regarded; provides soluble fiber; FDA banned its use in diet pills in 1990s due to swelling/obstruction risk but food use is considered safe"}',
  ARRAY['chia seeds', 'flaxseed meal', 'psyllium husk', 'arrowroot powder'],
  ARRAY['ice cream', 'gluten-free baked goods', 'sauces', 'yogurt', 'plant-based milks', 'canned soups'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Xanthan Gum',
  'xanthan-gum',
  ARRAY['E415', 'Xanthan', 'Corn Sugar Gum'],
  'additive',
  2,
  ARRAY['bloating', 'gas', 'corn allergen cross-reactivity', 'laxative effect at high doses'],
  '{"acute": "May cause bloating and gas; laxative effect at high doses (typically 15g+/day)", "chronic": "Generally considered safe; produced by fermentation of corn sugar by Xanthomonas campestris bacteria; may act as soluble fiber with mild prebiotic benefits", "vulnerable_groups": ["individuals with severe corn allergies (rare cross-reactivity)", "premature infants (NEC risk)"]}',
  '{"fda": "GRAS", "eu": "approved (E415)", "notes": "SimplyThick brand (containing xanthan gum) was linked to necrotizing enterocolitis (NEC) in premature infants; FDA warned against use in premature infants in 2011; safe for general population"}',
  ARRAY['chia seeds', 'flaxseed meal', 'psyllium husk', 'agar agar'],
  ARRAY['gluten-free baked goods', 'salad dressings', 'sauces', 'ice cream', 'plant-based milks', 'toothpaste'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Locust Bean Gum',
  'locust-bean-gum',
  ARRAY['E410', 'Carob Bean Gum', 'Carob Gum', 'Ceratonia Siliqua Gum', 'LBG'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'mild GI effects at high doses'],
  '{"acute": "Well tolerated; mild GI effects (gas, bloating) possible at high doses", "chronic": "No significant chronic toxicity concerns; derived from carob tree seeds; provides soluble fiber; historically used for centuries", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E410)", "notes": "One of the oldest and safest food thickeners; derived from the carob tree (Ceratonia siliqua); often used synergistically with other gums like xanthan or carrageenan"}',
  ARRAY['no alternatives needed - naturally derived and safe'],
  ARRAY['ice cream', 'yogurt', 'cream cheese', 'baked goods', 'infant formula', 'pet food'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Gellan Gum',
  'gellan-gum',
  ARRAY['E418', 'Gellan', 'Phytagel'],
  'additive',
  2,
  ARRAY['mild GI effects', 'relatively new additive'],
  '{"acute": "Well tolerated at food-use levels; may cause mild bloating or gas", "chronic": "No significant chronic toxicity identified; produced by fermentation of Sphingomonas elodea bacteria; relatively newer additive compared to other gums but well studied", "vulnerable_groups": []}',
  '{"fda": "approved food additive", "eu": "approved (E418)", "notes": "Approved for use in food since the 1990s; used as vegan gelatin alternative; comes in high-acyl and low-acyl forms with different gelling properties"}',
  ARRAY['agar agar', 'pectin', 'locust bean gum'],
  ARRAY['plant-based milks', 'jellies', 'jams', 'confections', 'beverages', 'vegan desserts'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Pectin',
  'pectin',
  ARRAY['E440', 'Fruit Pectin', 'Apple Pectin', 'Citrus Pectin'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'natural fruit-derived'],
  '{"acute": "No significant acute toxicity; may cause mild gas or bloating when consumed in large amounts", "chronic": "Considered very safe; natural component of fruit cell walls; provides soluble fiber; may have beneficial effects on cholesterol and blood sugar regulation", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E440)", "notes": "Naturally derived from fruit (primarily citrus peel and apple pomace); one of the most widely accepted and safest food additives; also studied for potential health benefits including heavy metal chelation"}',
  ARRAY['no alternatives needed - naturally derived and safe'],
  ARRAY['jams', 'jellies', 'fruit snacks', 'yogurt', 'beverages', 'gummy candies', 'bakery fillings'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Agar',
  'agar',
  ARRAY['E406', 'Agar-Agar', 'Kanten', 'Japanese Gelatin', 'China Grass'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'natural seaweed-derived'],
  '{"acute": "No significant acute toxicity; may have mild laxative effect in large quantities due to high fiber content", "chronic": "Considered very safe; derived from red algae; used for centuries in Asian cuisine; provides soluble fiber; no chronic toxicity concerns identified", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E406)", "notes": "One of the safest food additives available; derived from red seaweed; widely used as vegan gelatin substitute; also used in microbiology for culture media"}',
  ARRAY['no alternatives needed - naturally derived and safe'],
  ARRAY['vegan desserts', 'jellies', 'puddings', 'ice cream', 'soups', 'confections'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cellulose Gum',
  'cellulose-gum',
  ARRAY['E466', 'CMC', 'Carboxymethylcellulose', 'Sodium CMC'],
  'additive',
  3,
  ARRAY['gut microbiome disruption', 'intestinal inflammation', 'processed food indicator'],
  '{"acute": "Generally well tolerated; mild bloating and gas possible", "chronic": "Research suggests potential disruption of gut microbiome and intestinal mucus layer; animal studies show promotion of low-grade inflammation; functionally identical to sodium carboxymethylcellulose", "vulnerable_groups": ["individuals with IBD", "children"]}',
  '{"fda": "GRAS", "eu": "approved (E466)", "notes": "Same substance as sodium carboxymethylcellulose; commonly listed as cellulose gum on food labels; derived from cellulose treated with chloroacetic acid"}',
  ARRAY['guar gum', 'acacia gum', 'psyllium husk'],
  ARRAY['ice cream', 'salad dressings', 'baked goods', 'syrups', 'diet foods', 'toothpaste'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'Nature journal']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Hydroxypropyl Methylcellulose',
  'hydroxypropyl-methylcellulose',
  ARRAY['E464', 'HPMC', 'Hypromellose', 'Hydroxypropyl Cellulose Ether'],
  'additive',
  2,
  ARRAY['mild GI effects', 'processed food indicator'],
  '{"acute": "No significant acute toxicity; well tolerated at food-use levels", "chronic": "Considered safe; not absorbed from the GI tract; may actually have beneficial effects on cholesterol and blood sugar when used as dietary fiber supplement", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E464)", "notes": "Widely used in pharmaceutical capsules as vegetarian alternative to gelatin; considered one of the safer cellulose derivatives; used in construction as well as food"}',
  ARRAY['gelatin (for capsules)', 'agar agar', 'pectin'],
  ARRAY['vegetarian capsules', 'baked goods', 'sauces', 'ice cream', 'gluten-free products', 'pharmaceutical tablets'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'USP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Alginate',
  'sodium-alginate',
  ARRAY['E401', 'Alginic Acid Sodium Salt', 'Alginate', 'Algin'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'natural seaweed-derived'],
  '{"acute": "No significant acute toxicity; well tolerated", "chronic": "Considered very safe; derived from brown seaweed; provides soluble fiber; used in wound dressings and acid reflux medications (Gaviscon); may reduce heavy metal absorption", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E401)", "notes": "Derived from brown algae (kelp); used in molecular gastronomy for spherification; also used medically in wound care and as acid reflux barrier"}',
  ARRAY['no alternatives needed - naturally derived and safe'],
  ARRAY['ice cream', 'salad dressings', 'beer', 'fruit juice', 'wound dressings', 'dental impressions'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Chloride',
  'calcium-chloride',
  ARRAY['E509', 'CaCl2', 'Calcium Dichloride'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'may cause mild irritation at high concentrations'],
  '{"acute": "Very low acute toxicity at food-use levels; concentrated solutions can cause irritation to skin and mucous membranes", "chronic": "No chronic toxicity concerns at food-use levels; provides bioavailable calcium; naturally present in some mineral waters", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E509)", "notes": "Widely used as firming agent in canned vegetables and fruits; used in cheese making; also used in molecular gastronomy for spherification with sodium alginate"}',
  ARRAY['no alternatives needed - safe mineral salt'],
  ARRAY['canned vegetables', 'tofu', 'cheese', 'beer', 'sports drinks', 'bottled water'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Potassium Chloride',
  'potassium-chloride',
  ARRAY['E508', 'KCl', 'Potassium Salt', 'Muriate of Potash'],
  'additive',
  2,
  ARRAY['bitter taste', 'hyperkalemia risk at very high doses', 'GI irritation at high doses'],
  '{"acute": "Safe at food-use levels; excessive intake can cause hyperkalemia (dangerously high potassium) particularly in those with kidney impairment; may cause GI irritation in concentrated supplement form", "chronic": "Generally safe and can be beneficial as potassium supplement and sodium replacement; excessive chronic intake dangerous for those with kidney disease", "vulnerable_groups": ["individuals with kidney disease", "individuals on potassium-sparing diuretics or ACE inhibitors"]}',
  '{"fda": "GRAS", "eu": "approved (E508)", "notes": "Commonly used as salt substitute for sodium reduction; essential mineral; FDA encourages its use in processed foods to reduce sodium content"}',
  ARRAY['sea salt (reduced sodium blends)', 'herb blends'],
  ARRAY['low-sodium foods', 'salt substitutes', 'sports drinks', 'infant formula', 'canned vegetables', 'frozen meals'],
  ARRAY['FDA', 'EFSA', 'WHO', 'American Heart Association']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Sulfate',
  'calcium-sulfate',
  ARRAY['E516', 'Gypsum', 'Plaster of Paris', 'CaSO4', 'Calcium Sulphate'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'natural mineral'],
  '{"acute": "No significant acute toxicity at food-use levels", "chronic": "Considered very safe; natural mineral used in food production for millennia; provides bioavailable calcium; traditionally used in tofu making", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E516)", "notes": "Used in tofu making for over 2000 years in China; also used as flour treatment agent and dough conditioner; natural mineral source of calcium"}',
  ARRAY['no alternatives needed - natural mineral salt'],
  ARRAY['tofu', 'bread', 'flour', 'canned vegetables', 'beer', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ammonium Sulfate',
  'ammonium-sulfate',
  ARRAY['E517', 'Ammonium Sulphate', '(NH4)2SO4', 'Diammonium Sulfate'],
  'additive',
  3,
  ARRAY['synthetic nitrogen source', 'GI irritation at high doses', 'fertilizer chemical'],
  '{"acute": "Low toxicity at food-use levels; may cause nausea and GI distress at high doses", "chronic": "Generally considered safe at approved food levels; also widely used as fertilizer which raises consumer perception concerns; provides nitrogen for yeast in baking", "vulnerable_groups": ["individuals with sulfite sensitivity"]}',
  '{"fda": "GRAS", "eu": "approved (E517)", "notes": "Used as yeast food in bread baking and as dough conditioner; also used as fertilizer and in flame retardants; food-grade quality is distinct from industrial grade"}',
  ARRAY['organic yeast nutrients', 'malted barley flour'],
  ARRAY['bread', 'rolls', 'baked goods', 'beer', 'yeast products'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ammonium Chloride',
  'ammonium-chloride',
  ARRAY['E510', 'Sal Ammoniac', 'NH4Cl', 'Salmiac'],
  'additive',
  3,
  ARRAY['metabolic acidosis risk at high doses', 'GI irritation', 'kidney stress'],
  '{"acute": "May cause nausea, vomiting, and GI irritation at high doses; acidifying agent", "chronic": "Generally safe at food-use levels; high chronic intake can cause metabolic acidosis; used medicinally as expectorant and urinary acidifier; may stress kidneys with chronic high intake", "vulnerable_groups": ["individuals with kidney disease", "individuals with liver disease"]}',
  '{"fda": "GRAS", "eu": "approved (E510)", "notes": "Popular in Nordic salty licorice (salmiak); used as yeast food in baking; also used in cough medicine; distinctive sharp salty taste"}',
  ARRAY['sea salt', 'potassium chloride'],
  ARRAY['licorice candy', 'bread', 'baked goods', 'cough drops'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Phosphate',
  'sodium-phosphate',
  ARRAY['E339', 'Monosodium Phosphate', 'Disodium Phosphate', 'Trisodium Phosphate', 'MSP', 'DSP', 'TSP'],
  'additive',
  5,
  ARRAY['cardiovascular risk', 'kidney damage', 'bone loss', 'accelerated aging'],
  '{"acute": "Generally well tolerated at low levels; high doses cause GI distress and electrolyte imbalances", "chronic": "Excessive phosphate intake linked to cardiovascular calcification, kidney damage, bone mineral loss, and accelerated aging; high dietary phosphate associated with increased mortality in kidney disease patients; disrupts calcium-phosphorus balance", "vulnerable_groups": ["individuals with kidney disease", "elderly", "individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E339) with group ADI of 40 mg/kg for phosphates", "notes": "EFSA re-evaluated phosphate additives in 2019 and set a new group ADI; phosphate additives are a significant source of dietary phosphorus which is more bioavailable than natural food phosphorus"}',
  ARRAY['citric acid', 'cream of tartar', 'phosphate-free alternatives'],
  ARRAY['processed meats', 'baked goods', 'soft drinks', 'frozen meals', 'cheese products', 'cereals'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'American Journal of Clinical Nutrition', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Dipotassium Phosphate',
  'dipotassium-phosphate',
  ARRAY['E340ii', 'DKP', 'Potassium Hydrogen Phosphate', 'Dibasic Potassium Phosphate'],
  'additive',
  4,
  ARRAY['phosphate burden', 'cardiovascular concerns', 'kidney stress'],
  '{"acute": "Generally well tolerated; may cause GI discomfort at high doses", "chronic": "Contributes to total dietary phosphate burden with associated cardiovascular and renal concerns; inorganic phosphates from additives are nearly 100% absorbed vs 40-60% from natural food sources", "vulnerable_groups": ["individuals with kidney disease", "individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E340ii) under group phosphate ADI", "notes": "Used as buffering agent and emulsifier; part of the phosphate additive group that EFSA reviewed and assigned a group ADI of 40 mg/kg/day in 2019"}',
  ARRAY['citric acid', 'sodium bicarbonate'],
  ARRAY['coffee creamers', 'powdered beverages', 'processed cheese', 'infant formula', 'sports drinks'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Trisodium Phosphate',
  'trisodium-phosphate',
  ARRAY['E339iii', 'TSP', 'Sodium Phosphate Tribasic', 'Na3PO4'],
  'additive',
  5,
  ARRAY['highly alkaline', 'cardiovascular risk', 'kidney damage', 'GI irritation', 'industrial cleaner ingredient'],
  '{"acute": "Highly alkaline; can cause irritation to GI tract at elevated doses; used in small amounts in food but also as industrial cleaner and degreaser", "chronic": "Contributes to phosphate overload; chronic high phosphate intake associated with vascular calcification, kidney disease progression, and increased mortality risk; consumer concern heightened by its dual use as cleaning agent", "vulnerable_groups": ["individuals with kidney disease", "children", "elderly"]}',
  '{"fda": "GRAS", "eu": "approved (E339iii)", "notes": "Found in some breakfast cereals (notably Cheerios); also used as heavy-duty cleaner/degreaser which raises consumer concern; food-grade concentrations are very low compared to cleaning applications"}',
  ARRAY['sodium bicarbonate', 'cream of tartar', 'citric acid'],
  ARRAY['breakfast cereals', 'processed cheese', 'canned soups', 'lunch meats'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Hexametaphosphate',
  'sodium-hexametaphosphate',
  ARRAY['E452i', 'SHMP', 'Calgon', 'Sodium Polymetaphosphate'],
  'additive',
  5,
  ARRAY['phosphate burden', 'mineral chelation', 'cardiovascular risk', 'kidney stress'],
  '{"acute": "Low acute toxicity at food-use levels; may cause mild GI effects", "chronic": "Contributes significantly to dietary phosphate burden; chelates essential minerals (calcium, magnesium, iron); chronic high intake associated with cardiovascular calcification and renal damage", "vulnerable_groups": ["individuals with kidney disease", "children", "individuals with mineral deficiencies"]}',
  '{"fda": "GRAS", "eu": "approved (E452i) under group phosphate ADI", "notes": "Used as water softener as well as food additive; particularly effective at sequestering calcium and other divalent cations; used in processed seafood to retain moisture"}',
  ARRAY['citric acid', 'ascorbic acid'],
  ARRAY['processed seafood', 'processed meats', 'canned vegetables', 'breakfast cereals', 'beverages', 'ice cream'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Tripolyphosphate',
  'sodium-tripolyphosphate',
  ARRAY['E451i', 'STPP', 'Sodium Triphosphate', 'Na5P3O10', 'Pentasodium Triphosphate'],
  'additive',
  5,
  ARRAY['phosphate burden', 'water retention in meats', 'cardiovascular risk', 'kidney stress'],
  '{"acute": "Low acute toxicity; may cause GI irritation at high doses", "chronic": "Major contributor to dietary phosphate excess; used to increase water retention in seafood and meats (increases weight by 10-30%); chronic phosphate overload linked to vascular calcification, kidney damage, and bone mineral loss", "vulnerable_groups": ["individuals with kidney disease", "elderly", "individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E451i) under group phosphate ADI", "notes": "Widely used in seafood processing to retain moisture; also the main ingredient in many dishwasher detergents; consumers often unknowingly consume significant amounts through processed seafood"}',
  ARRAY['salt water brine', 'citric acid', 'phosphate-free processing'],
  ARRAY['frozen seafood', 'processed meats', 'chicken nuggets', 'surimi', 'pet food'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Aluminum Sulfate',
  'aluminum-sulfate',
  ARRAY['E520', 'Aluminium Sulphate', 'Al2(SO4)3', 'Alum'],
  'additive',
  7,
  ARRAY['aluminum exposure', 'neurotoxicity', 'bone toxicity', 'kidney stress'],
  '{"acute": "May cause GI irritation; nausea and vomiting at high doses", "chronic": "Significant source of dietary aluminum; aluminum accumulates in brain and bone tissue; chronic aluminum exposure associated with neurodegenerative diseases; impairs kidney function at high exposure levels; crosses blood-brain barrier", "vulnerable_groups": ["children", "elderly", "individuals with kidney disease", "pregnant women"]}',
  '{"fda": "GRAS (with limitations)", "eu": "approved (E520) with restrictions", "notes": "EFSA set a tolerable weekly intake (TWI) of 1 mg/kg for aluminum; many people exceed this through combined dietary and non-dietary sources; used in water purification and as pickling agent"}',
  ARRAY['cream of tartar', 'aluminum-free baking powder', 'citric acid'],
  ARRAY['pickled vegetables', 'baking powder', 'processed cheese', 'water treatment'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Peroxide',
  'calcium-peroxide',
  ARRAY['E930', 'CaO2', 'Calcium Dioxide'],
  'additive',
  4,
  ARRAY['oxidizing agent', 'GI irritation', 'bleaching agent'],
  '{"acute": "May cause GI irritation; strong oxidizer that releases oxygen and calcium hydroxide in contact with water", "chronic": "Limited chronic toxicity data in food use; used as dough conditioner and bleaching agent; decomposes to calcium hydroxide and oxygen during baking", "vulnerable_groups": ["individuals with GI sensitivity"]}',
  '{"fda": "approved food additive (flour treatment)", "eu": "approved (E930) for flour treatment only", "notes": "Used as flour bleaching and maturing agent; also used in environmental remediation; less controversial than potassium bromate"}',
  ARRAY['unbleached flour', 'ascorbic acid', 'enzyme-based dough conditioners'],
  ARRAY['flour', 'bread', 'baked goods', 'rolls'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Azodicarbonamide',
  'azodicarbonamide',
  ARRAY['E927a', 'ADA', 'Azo(bis)formamide', 'Dough Conditioner ADA'],
  'additive',
  7,
  ARRAY['respiratory sensitizer', 'carcinogenic breakdown product (semicarbazide)', 'banned in many countries', 'industrial chemical'],
  '{"acute": "Occupational exposure can cause respiratory sensitization and asthma; at food-use levels the compound decomposes during baking", "chronic": "Breaks down during baking to semicarbazide (SEM) which has shown carcinogenic and reproductive toxic effects in animal studies; also used in yoga mats and shoe soles as industrial foaming agent", "vulnerable_groups": ["bakers (occupational inhalation)", "children", "pregnant women"]}',
  '{"fda": "approved (up to 45 ppm in flour)", "eu": "banned since 2005", "notes": "Banned in EU, UK, Australia, Singapore, and many other countries; WHO linked it to respiratory issues; CSPI petitioned FDA for ban; still legal in US"}',
  ARRAY['ascorbic acid (vitamin C)', 'enzyme-based dough conditioners', 'unbleached flour'],
  ARRAY['commercial bread', 'hamburger buns', 'hot dog buns', 'tortillas', 'pastries'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI', 'EWG', 'IARC']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Potassium Bromate',
  'potassium-bromate',
  ARRAY['E924', 'KBrO3', 'Bromic Acid Potassium Salt'],
  'additive',
  9,
  ARRAY['carcinogen', 'kidney toxicity', 'banned in most countries', 'DNA damage'],
  '{"acute": "High doses cause nausea, vomiting, diarrhea, kidney failure, and hearing loss", "chronic": "Classified as Group 2B possible human carcinogen by IARC; causes kidney tumors, thyroid tumors, and peritoneal mesothelioma in animal studies; genotoxic and mutagenic; causes oxidative DNA damage", "vulnerable_groups": ["children", "individuals with kidney disease", "pregnant women", "everyone - no safe level established"]}',
  '{"fda": "approved but not GRAS (voluntary withdrawal encouraged since 1991)", "eu": "banned since 1990", "notes": "Banned in EU, UK, Canada, China, Brazil, India, and most countries worldwide; California requires Prop 65 warning label; still found in some US bread products"}',
  ARRAY['ascorbic acid (vitamin C)', 'enzyme-based improvers', 'unbleached unbromated flour'],
  ARRAY['commercial bread', 'flour', 'rolls', 'baked goods'],
  ARRAY['FDA', 'IARC', 'EFSA', 'CSPI', 'EWG', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Iodate',
  'calcium-iodate',
  ARRAY['E916', 'Ca(IO3)2', 'Calcium Iodate Monohydrate'],
  'additive',
  3,
  ARRAY['iodine excess risk', 'thyroid disruption at high doses', 'oxidizing agent'],
  '{"acute": "Safe at typical food fortification levels; excessive iodine intake can cause thyroid dysfunction", "chronic": "At food-use levels provides beneficial iodine for thyroid function; excessive chronic iodine intake can cause hypothyroidism or hyperthyroidism in susceptible individuals", "vulnerable_groups": ["individuals with thyroid disorders", "individuals with autoimmune thyroid disease"]}',
  '{"fda": "GRAS (for dough conditioning and iodine fortification)", "eu": "approved (E916) with restrictions", "notes": "Used as flour treatment agent and dough conditioner; also serves as iodine source; less controversial than potassium bromate which it sometimes replaces"}',
  ARRAY['ascorbic acid', 'enzyme-based dough conditioners'],
  ARRAY['bread', 'flour', 'baked goods', 'iodized salt'],
  ARRAY['FDA', 'EFSA', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'L-Cysteine',
  'l-cysteine',
  ARRAY['E920', 'Cysteine', 'L-Cys', 'Cysteine Hydrochloride'],
  'additive',
  3,
  ARRAY['sourced from human hair or duck feathers', 'ethical concerns', 'reducing agent'],
  '{"acute": "No significant acute toxicity; naturally occurring amino acid", "chronic": "Considered safe from a toxicological standpoint; primary concerns are ethical/source-related; traditionally derived from human hair or duck feathers; synthetic and fermentation-derived forms now available", "vulnerable_groups": ["vegans/vegetarians (source concerns)", "those with religious dietary restrictions"]}',
  '{"fda": "GRAS", "eu": "approved (E920)", "notes": "Used as dough conditioner to speed up industrial bread production; can be derived from human hair, duck feathers, hog hair, or produced synthetically/by fermentation"}',
  ARRAY['longer fermentation times', 'ascorbic acid', 'enzyme-based conditioners'],
  ARRAY['commercial bread', 'bagels', 'pizza dough', 'tortillas', 'baked goods'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Transglutaminase',
  'transglutaminase',
  ARRAY['TG', 'Meat Glue', 'Microbial Transglutaminase', 'mTG', 'Activa'],
  'additive',
  4,
  ARRAY['deceptive food binding', 'potential autoimmune trigger', 'celiac disease concerns', 'food safety risk'],
  '{"acute": "No significant acute toxicity; enzyme is deactivated by cooking", "chronic": "Emerging research suggests microbial transglutaminase may trigger or exacerbate celiac disease and other autoimmune conditions by modifying gluten peptides; can bind meat scraps into what appears to be a single cut", "vulnerable_groups": ["individuals with celiac disease", "individuals with autoimmune conditions", "individuals with gluten sensitivity"]}',
  '{"fda": "GRAS", "eu": "approved as processing aid", "notes": "Known as meat glue in culinary circles; can bind different pieces of meat, fish, or poultry together; not required to be labeled in EU when used as processing aid"}',
  ARRAY['natural meat cuts', 'traditional binding methods (eggs, breadcrumbs)'],
  ARRAY['restructured meats', 'imitation crab', 'fish balls', 'sausages', 'restaurant meats', 'dairy products'],
  ARRAY['FDA', 'EFSA', 'Frontiers in Pediatrics', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Stearate',
  'calcium-stearate',
  ARRAY['E470a', 'Calcium Salt of Stearic Acid', 'Calcium Octadecanoate'],
  'additive',
  2,
  ARRAY['filler/flow agent', 'processed food indicator'],
  '{"acute": "No significant acute toxicity; well tolerated", "chronic": "Considered safe; metabolized to stearic acid and calcium, both naturally occurring; used as anti-caking agent and lubricant in tablets", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E470a)", "notes": "Widely used in supplements and pharmaceuticals as tablet lubricant; also found in food as anti-caking agent; considered very safe"}',
  ARRAY['rice bran extract', 'organic rice concentrate'],
  ARRAY['supplements', 'confections', 'baked goods', 'spice blends'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Mono and Diglycerides',
  'mono-and-diglycerides',
  ARRAY['E471', 'Monoglycerides', 'Diglycerides', 'Glycerol Monostearate', 'GMS', 'Glycerol Esters of Fatty Acids'],
  'additive',
  4,
  ARRAY['may contain trans fats', 'not regulated as trans fat', 'gut microbiome disruption', 'processed food indicator'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "May contain trans fatty acids NOT captured by trans fat labeling requirements (classified as emulsifiers, not fats); trans fats associated with cardiovascular disease; also shown to affect gut microbiome in animal studies", "vulnerable_groups": ["individuals with cardiovascular disease", "children"]}',
  '{"fda": "GRAS", "eu": "approved (E471)", "notes": "Important regulatory gap: trans fats in mono and diglycerides are exempt from trans fat labeling; FDA ban on partially hydrogenated oils does NOT apply to mono and diglycerides"}',
  ARRAY['sunflower lecithin', 'egg yolks', 'mustard'],
  ARRAY['bread', 'baked goods', 'margarine', 'ice cream', 'peanut butter', 'whipped toppings', 'candy'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'American Heart Association', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'DATEM',
  'datem',
  ARRAY['E472e', 'Diacetyl Tartaric Acid Esters of Mono- and Diglycerides', 'DTAEM'],
  'additive',
  3,
  ARRAY['may contain trans fats', 'processed food indicator', 'heart health concerns'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Like mono and diglycerides, may contain trans fatty acids exempt from labeling; some studies suggest effects on gut health; metabolized to tartaric acid, glycerol, and fatty acids", "vulnerable_groups": ["individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E472e)", "notes": "Common dough strengthener in commercial bread; shares the trans fat labeling loophole with mono and diglycerides"}',
  ARRAY['longer fermentation', 'ascorbic acid', 'enzyme-based improvers'],
  ARRAY['bread', 'tortillas', 'baked goods', 'crackers'],
  ARRAY['FDA', 'EFSA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Acid Pyrophosphate',
  'sodium-acid-pyrophosphate',
  ARRAY['E450i', 'SAPP', 'Disodium Dihydrogen Pyrophosphate', 'Disodium Pyrophosphate'],
  'additive',
  4,
  ARRAY['phosphate burden', 'cardiovascular risk', 'kidney stress', 'sodium content'],
  '{"acute": "Generally well tolerated; may cause mild GI effects at high doses", "chronic": "Contributes to dietary phosphate overload; chronic excessive phosphate intake linked to cardiovascular calcification and kidney damage; also adds sodium to diet", "vulnerable_groups": ["individuals with kidney disease", "individuals with cardiovascular disease", "individuals on sodium-restricted diets"]}',
  '{"fda": "GRAS", "eu": "approved (E450i) under group phosphate ADI", "notes": "Commonly used as leavening agent in baking and to prevent discoloration in potatoes; one of the most common phosphate additives in processed foods"}',
  ARRAY['cream of tartar', 'aluminum-free baking powder', 'citric acid'],
  ARRAY['frozen potatoes', 'baked goods', 'pancake mix', 'canned seafood', 'processed meats', 'instant pudding'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Carbonate',
  'calcium-carbonate',
  ARRAY['E170', 'CaCO3', 'Chalk', 'Limestone', 'Precipitated Calcium Carbonate'],
  'additive',
  1,
  ARRAY['generally recognized as safe', 'natural mineral', 'antacid'],
  '{"acute": "Very safe at food-use levels; used therapeutically as antacid; excessive intake can cause hypercalcemia and constipation", "chronic": "Considered very safe; essential mineral supplement; provides bioavailable calcium; excessive supplementation (>2000mg/day) may increase kidney stone risk in susceptible individuals", "vulnerable_groups": ["individuals prone to kidney stones (excessive intake)", "individuals with hypercalcemia"]}',
  '{"fda": "GRAS", "eu": "approved (E170)", "notes": "One of the most common and safest food additives; used as calcium supplement, antacid, food coloring (white), and anti-caking agent; naturally occurring mineral"}',
  ARRAY['no alternatives needed - natural mineral and generally safe'],
  ARRAY['supplements', 'antacids', 'fortified foods', 'cereals', 'orange juice', 'bread', 'toothpaste'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'NIH Office of Dietary Supplements']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diacetyl',
  'diacetyl',
  ARRAY['2,3-Butanedione', 'Butane-2,3-dione', 'Biacetyl'],
  'flavor',
  7,
  ARRAY['popcorn lung (bronchiolitis obliterans)', 'respiratory damage', 'neurotoxicity', 'occupational hazard'],
  '{"acute": "Inhalation causes severe respiratory irritation; oral ingestion at food levels generally tolerated", "chronic": "Inhalation exposure causes bronchiolitis obliterans (popcorn lung), an irreversible and potentially fatal lung disease; occupational exposure in microwave popcorn factories led to numerous cases; animal studies show neurotoxicity and potential link to Alzheimer''s-type brain changes", "vulnerable_groups": ["factory workers (inhalation)", "heavy microwave popcorn consumers", "e-cigarette users", "children"]}',
  '{"fda": "GRAS for food use (ingestion)", "eu": "approved for food use", "notes": "No FDA regulation on inhalation exposure in consumer products; NIOSH issued warnings about occupational exposure; many major popcorn brands voluntarily removed diacetyl after lawsuits; still found in some e-cigarette liquids"}',
  ARRAY['real butter', 'natural butter flavoring without diacetyl'],
  ARRAY['microwave popcorn', 'artificial butter flavoring', 'margarine', 'e-cigarette liquids', 'baked goods', 'candy'],
  ARRAY['FDA', 'NIOSH', 'CDC', 'EWG', 'Occupational and Environmental Medicine']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Acetoin',
  'acetoin',
  ARRAY['3-Hydroxy-2-butanone', 'Acetyl Methyl Carbinol', 'Dimethylketol'],
  'flavor',
  4,
  ARRAY['diacetyl precursor', 'respiratory concerns', 'converts to diacetyl'],
  '{"acute": "Low acute toxicity via ingestion; respiratory irritation possible with inhalation of vapors", "chronic": "Can convert to diacetyl under certain conditions, raising similar respiratory concerns; used as diacetyl replacement but may not be significantly safer for inhalation exposure; less studied than diacetyl", "vulnerable_groups": ["factory workers (inhalation)", "e-cigarette users"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Often used as diacetyl replacement in butter flavorings; NIOSH has expressed concern that acetoin may convert to diacetyl in some conditions; naturally produced during fermentation"}',
  ARRAY['real butter', 'natural fermentation flavors'],
  ARRAY['butter flavoring', 'microwave popcorn', 'baked goods', 'e-cigarette liquids', 'margarine'],
  ARRAY['FDA', 'NIOSH', 'EWG', 'FEMA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Artificial Vanilla (Vanillin)',
  'artificial-vanillin',
  ARRAY['Vanillin', 'Synthetic Vanillin', 'Methyl Vanillin', '4-Hydroxy-3-methoxybenzaldehyde'],
  'flavor',
  2,
  ARRAY['synthetic origin', 'derived from petrochemicals or wood pulp', 'may contain residual solvents'],
  '{"acute": "No significant acute toxicity; well tolerated at food-use levels", "chronic": "Generally considered safe toxicologically; primary concern is synthetic origin (petroleum, wood pulp, or guaiacol derived) rather than health effects; some studies suggest mild antioxidant properties; lacks the complex flavor profile and minor beneficial compounds of real vanilla", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved", "notes": "About 99% of vanilla flavoring used globally is synthetic vanillin; derived from guaiacol (petroleum), lignin (wood pulp), or eugenol (clove oil); chemically identical to the primary flavor compound in real vanilla but lacks 200+ other compounds found in natural vanilla extract"}',
  ARRAY['pure vanilla extract', 'vanilla bean', 'vanilla bean paste'],
  ARRAY['ice cream', 'baked goods', 'chocolate', 'candy', 'beverages', 'yogurt', 'protein powders'],
  ARRAY['FDA', 'EFSA', 'FEMA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ethyl Vanillin',
  'ethyl-vanillin',
  ARRAY['3-Ethoxy-4-hydroxybenzaldehyde', 'Bourbonal', 'Ethovan'],
  'flavor',
  3,
  ARRAY['synthetic compound', '3x stronger than vanillin', 'not found in nature', 'potential allergen'],
  '{"acute": "Low acute toxicity; may cause skin sensitization in some individuals", "chronic": "Limited long-term toxicity data compared to vanillin; entirely synthetic (not found in natural vanilla); approximately 3-4 times more potent than vanillin; some concerns about chronic exposure to a purely synthetic molecule", "vulnerable_groups": ["individuals with fragrance sensitivities"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Unlike vanillin, ethyl vanillin does not occur naturally in vanilla; used when a stronger vanilla flavor is desired at lower cost; commonly combined with vanillin in artificial vanilla flavorings"}',
  ARRAY['pure vanilla extract', 'vanilla bean', 'natural vanillin'],
  ARRAY['chocolate', 'baked goods', 'ice cream', 'candy', 'beverages', 'perfumes'],
  ARRAY['FDA', 'EFSA', 'FEMA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Natural Flavors',
  'natural-flavors',
  ARRAY['Natural Flavoring', 'Natural Flavor Extract', 'FTNF (From The Named Fruit)'],
  'flavor',
  3,
  ARRAY['lack of transparency', 'may contain up to 100 chemicals', 'potential allergens', 'proprietary formulations', 'MSG-containing'],
  '{"acute": "Individual components are generally GRAS; however, proprietary nature means consumers cannot assess individual sensitivities", "chronic": "Umbrella term that can contain up to 100+ chemical compounds including solvents, preservatives, and emulsifiers; may contain MSG, propylene glycol, or other additives without disclosure; lack of transparency prevents informed consumer choice", "vulnerable_groups": ["individuals with food allergies", "individuals with chemical sensitivities", "MSG-sensitive individuals"]}',
  '{"fda": "approved (defined in 21 CFR 101.22 as derived from natural sources)", "eu": "approved with stricter definition than US", "notes": "FDA definition requires derivation from natural sources (plant, animal, fermentation) but allows extensive chemical processing; a single natural flavor can contain dozens of undisclosed ingredients; EU definition is stricter requiring closer connection to source material"}',
  ARRAY['whole food ingredients', 'real fruit', 'herbs and spices', 'organic extracts'],
  ARRAY['nearly all processed foods', 'beverages', 'snacks', 'yogurt', 'cereals', 'frozen meals'],
  ARRAY['FDA', 'EWG', 'CSPI', 'FEMA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Artificial Flavors',
  'artificial-flavors',
  ARRAY['Artificial Flavoring', 'Synthetic Flavors', 'Imitation Flavors'],
  'flavor',
  4,
  ARRAY['synthetic chemicals', 'lack of transparency', 'potential neurotoxicity', 'allergenicity', 'behavioral effects in children'],
  '{"acute": "Individual components are approved but proprietary blends prevent consumer assessment of sensitivities", "chronic": "Entirely synthetic compounds not found in nature; some artificial flavoring chemicals have shown neurotoxic or carcinogenic properties in animal studies at high doses; linked to behavioral issues in children (Southampton study on food additives); often contain multiple undisclosed chemical components", "vulnerable_groups": ["children", "individuals with ADHD", "individuals with chemical sensitivities", "pregnant women"]}',
  '{"fda": "approved (individual components evaluated by FEMA GRAS)", "eu": "approved but more restricted than US; EU banned several artificial flavorings still used in US", "notes": "FEMA (Flavor and Extract Manufacturers Association) self-regulates flavor safety through its GRAS program; not all artificial flavor chemicals have been individually evaluated by FDA; over 3,000 flavor chemicals in use"}',
  ARRAY['whole food ingredients', 'real fruit and spices', 'organic extracts', 'natural flavors (with caveats)'],
  ARRAY['candy', 'soft drinks', 'snacks', 'baked goods', 'frozen meals', 'cereals', 'gum'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'EWG', 'FEMA', 'Southampton Study']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Maltol',
  'maltol',
  ARRAY['3-Hydroxy-2-methyl-4-pyrone', 'Larixinic Acid', 'E636'],
  'flavor',
  2,
  ARRAY['generally recognized as safe', 'naturally occurring'],
  '{"acute": "No significant acute toxicity; well tolerated at food-use levels", "chronic": "Generally considered safe; naturally found in bread crust, roasted malt, and chicory; enhances sweetness and aroma of foods; some in-vitro studies suggest metal chelation properties but no demonstrated health concerns at food-use levels", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E636)", "notes": "Naturally occurring in bark of larch tree, in bread crust, and roasted malt; used to enhance sweetness perception; one of the safer flavor additives; also used in e-cigarettes"}',
  ARRAY['no alternatives needed - naturally occurring and safe at food-use levels'],
  ARRAY['baked goods', 'candy', 'chocolate', 'beverages', 'ice cream', 'e-cigarette liquids'],
  ARRAY['FDA', 'EFSA', 'FEMA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ethyl Maltol',
  'ethyl-maltol',
  ARRAY['2-Ethyl-3-hydroxy-4-pyranone', 'E637'],
  'flavor',
  2,
  ARRAY['synthetic compound', 'not found in nature', 'sweetness enhancer'],
  '{"acute": "No significant acute toxicity at food-use levels", "chronic": "Limited long-term studies; synthetic derivative of maltol approximately 4-6 times sweeter; generally considered safe at food-use levels; used to enhance sweetness and mask bitter tastes", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E637)", "notes": "Unlike maltol, ethyl maltol does not occur naturally; about 4-6 times more potent as flavor enhancer than maltol; commonly used in e-cigarette liquids to add sweetness"}',
  ARRAY['maltol', 'natural sweeteners'],
  ARRAY['candy', 'baked goods', 'beverages', 'chocolate', 'e-cigarette liquids', 'wine'],
  ARRAY['FDA', 'EFSA', 'FEMA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Castoreum',
  'castoreum',
  ARRAY['Beaver Anal Secretion', 'Castor Fiber Extract', 'Castor Canadensis Extract'],
  'flavor',
  3,
  ARRAY['animal-derived (beaver)', 'ethical concerns', 'lack of labeling transparency', 'disguised as natural flavor'],
  '{"acute": "No significant acute toxicity; rarely used in modern food production due to cost and supply", "chronic": "No significant health concerns identified; primary concerns are ethical (derived from beaver castor sacs near the anal glands) and transparency (labeled simply as natural flavor); extremely rare in food today due to expense; more commonly used in perfumery", "vulnerable_groups": ["vegans/vegetarians (animal source)", "individuals with ethical concerns about animal products"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Despite viral internet claims, castoreum is extremely rarely used in food today (global production is only about 300 lbs/year, mostly for perfume); can legally be labeled as natural flavor; primarily of concern for ethical reasons rather than health"}',
  ARRAY['real vanilla extract', 'real raspberry or strawberry extract'],
  ARRAY['vanilla flavoring (rare)', 'raspberry flavoring (rare)', 'strawberry flavoring (rare)', 'perfumes'],
  ARRAY['FDA', 'FEMA', 'Fenaroli''s Handbook of Flavor Ingredients']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Smoke Flavoring',
  'smoke-flavoring',
  ARRAY['Liquid Smoke', 'Smoke Flavor', 'Natural Smoke Flavor', 'Condensed Smoke'],
  'flavor',
  4,
  ARRAY['PAHs (polycyclic aromatic hydrocarbons)', 'potential carcinogens', 'genotoxicity concerns'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Contains polycyclic aromatic hydrocarbons (PAHs) some of which are known carcinogens; EFSA identified genotoxicity concerns for several smoke flavoring preparations; levels of PAHs vary widely between products and are not typically disclosed to consumers", "vulnerable_groups": ["children", "pregnant women", "individuals with cancer risk factors"]}',
  '{"fda": "GRAS", "eu": "approved with restrictions (evaluated individually)", "notes": "EFSA has evaluated smoke flavorings and found genotoxicity concerns for some preparations; EU requires individual safety evaluation of each smoke flavoring; US has no such requirement; smoked paprika and chipotle peppers provide similar flavor with more control over PAH levels"}',
  ARRAY['smoked paprika', 'chipotle peppers', 'actual wood smoking (controlled)', 'smoked salt'],
  ARRAY['BBQ sauces', 'smoked meats', 'bacon', 'hot dogs', 'jerky', 'smoked cheese', 'snacks'],
  ARRAY['FDA', 'EFSA', 'WHO', 'IARC']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Liquid Smoke',
  'liquid-smoke',
  ARRAY['Condensed Smoke', 'Wood Smoke Condensate', 'Hickory Smoke Flavor', 'Mesquite Smoke Flavor'],
  'flavor',
  4,
  ARRAY['PAHs (polycyclic aromatic hydrocarbons)', 'potential carcinogens', 'variable quality'],
  '{"acute": "Generally well tolerated; may cause GI irritation in sensitive individuals at high concentrations", "chronic": "Contains varying levels of PAHs depending on manufacturing process and filtration; some brands filter more effectively than others; EFSA found genotoxicity concerns in some preparations; real wood smoke condensate contains the same carcinogenic compounds found in tobacco smoke", "vulnerable_groups": ["children", "pregnant women", "frequent consumers"]}',
  '{"fda": "GRAS", "eu": "approved with individual product evaluation", "notes": "Made by condensing actual wood smoke; higher quality brands filter out more harmful compounds; Wright''s and Colgin are common US brands; EU requires individual safety assessment for each product"}',
  ARRAY['smoked paprika', 'chipotle peppers', 'smoked salt', 'real smoking with temperature control'],
  ARRAY['BBQ sauces', 'marinades', 'smoked meats', 'bacon', 'jerky', 'Worcestershire sauce'],
  ARRAY['FDA', 'EFSA', 'IARC']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Monosodium Glutamate (Flavor Use)',
  'monosodium-glutamate-flavor',
  ARRAY['MSG', 'E621', 'Umami Seasoning', 'Accent Seasoning', 'Vetsin'],
  'flavor',
  4,
  ARRAY['excitotoxin concerns', 'headaches', 'appetite stimulation', 'hidden in many ingredients'],
  '{"acute": "MSG symptom complex: headaches, flushing, sweating, chest pain, numbness in sensitive individuals; effects are dose-dependent and individually variable", "chronic": "Debated links to obesity through appetite stimulation; concerns about excitotoxicity at high doses; often hidden under names like yeast extract, hydrolyzed protein, autolyzed yeast, and natural flavors", "vulnerable_groups": ["children", "asthmatics", "MSG-sensitive individuals"]}',
  '{"fda": "GRAS", "eu": "approved (E621) with max 10g/kg", "notes": "When used as flavoring, MSG enhances umami taste; free glutamate occurs naturally in tomatoes, parmesan cheese, and mushrooms; sensitivity appears to affect a subset of the population; double-blind studies have shown mixed results on MSG sensitivity"}',
  ARRAY['mushroom powder', 'nutritional yeast', 'coconut aminos', 'tomato paste', 'parmesan cheese'],
  ARRAY['Chinese food', 'chips', 'seasoning mixes', 'instant noodles', 'canned soups', 'fast food'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Disodium Inosinate',
  'disodium-inosinate',
  ARRAY['E631', 'IMP', 'Inosinic Acid Disodium Salt', 'Disodium 5''-Inosinate'],
  'flavor',
  3,
  ARRAY['MSG synergist', 'purine source (gout concern)', 'often paired with MSG'],
  '{"acute": "Well tolerated at food-use levels; rarely used alone", "chronic": "Generally considered safe; works synergistically with MSG to enhance umami flavor (allows less MSG to be used); as a purine, may contribute to uric acid levels in individuals prone to gout; typically used in combination with disodium guanylate as I+G", "vulnerable_groups": ["individuals with gout", "individuals with purine sensitivity", "MSG-sensitive individuals"]}',
  '{"fda": "GRAS", "eu": "approved (E631)", "notes": "Almost always used in combination with disodium guanylate (together called I+G); synergistic with MSG allowing 10-15x reduction in MSG needed; derived from meat, fish, or fermentation; not suitable for vegetarians unless fermentation-derived"}',
  ARRAY['mushroom powder', 'nutritional yeast', 'tomato paste'],
  ARRAY['chips', 'instant noodles', 'seasoning mixes', 'snack foods', 'processed meats', 'frozen meals'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'FEMA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Disodium Guanylate',
  'disodium-guanylate',
  ARRAY['E627', 'GMP', 'Guanylic Acid Disodium Salt', 'Disodium 5''-Guanylate'],
  'flavor',
  3,
  ARRAY['MSG synergist', 'purine source (gout concern)', 'often paired with MSG'],
  '{"acute": "Well tolerated at food-use levels; rarely used alone", "chronic": "Generally considered safe; works synergistically with MSG; as a purine, may contribute to elevated uric acid levels in gout-prone individuals; typically used in combination with disodium inosinate", "vulnerable_groups": ["individuals with gout", "individuals with purine sensitivity", "MSG-sensitive individuals"]}',
  '{"fda": "GRAS", "eu": "approved (E627)", "notes": "Almost always used with disodium inosinate; the combination (I+G) is one of the most effective umami enhancers; can be derived from yeast, seaweed, or fish; the combination allows significant reduction in MSG usage while maintaining flavor"}',
  ARRAY['mushroom powder', 'nutritional yeast', 'tomato paste', 'seaweed'],
  ARRAY['chips', 'instant noodles', 'seasoning mixes', 'snack foods', 'processed meats', 'frozen meals'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'FEMA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Hydrolyzed Vegetable Protein',
  'hydrolyzed-vegetable-protein',
  ARRAY['HVP', 'Hydrolyzed Soy Protein', 'Hydrolyzed Plant Protein', 'Hydrolyzed Corn Protein', 'Hydrolyzed Wheat Protein'],
  'flavor',
  4,
  ARRAY['hidden MSG source', 'contains free glutamate', '3-MCPD contamination', 'allergen concerns'],
  '{"acute": "May trigger MSG-type reactions in sensitive individuals due to free glutamate content", "chronic": "Contains significant free glutamic acid (MSG equivalent) without requiring MSG labeling; acid hydrolysis process can produce 3-MCPD (3-monochloropropane-1,2-diol), a probable carcinogen; also potential allergen source (soy, wheat, corn)", "vulnerable_groups": ["MSG-sensitive individuals", "individuals with soy/wheat/corn allergies", "children"]}',
  '{"fda": "GRAS", "eu": "approved with 3-MCPD limits", "notes": "Major source of hidden free glutamate; FDA does not require MSG labeling for HVP despite containing significant free glutamate; EU has set limits for 3-MCPD contamination; produced by acid or enzymatic hydrolysis of plant proteins"}',
  ARRAY['nutritional yeast', 'mushroom powder', 'coconut aminos', 'tamari', 'real bone broth'],
  ARRAY['bouillon cubes', 'canned soups', 'instant noodles', 'seasoning mixes', 'soy sauce', 'processed meats', 'snack foods'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'EWG', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lecithin (Soy)',
  'lecithin-soy',
  ARRAY['E322', 'Soy Lecithin', 'Soya Lecithin', 'Phosphatidylcholine (Soy)'],
  'emulsifier',
  2,
  ARRAY['soy allergen', 'GMO source', 'hexane extraction residues'],
  '{"acute": "Generally well tolerated; rare allergic reactions in individuals with severe soy allergy, though lecithin contains minimal soy protein", "chronic": "Considered safe; provides phosphatidylcholine which is a component of cell membranes; concerns are primarily about GMO soy sourcing, hexane residues from extraction, and allergenicity; most allergists consider soy lecithin safe for soy-allergic individuals due to minimal protein content", "vulnerable_groups": ["individuals with severe soy allergy (rare reactions)", "those avoiding GMOs"]}',
  '{"fda": "GRAS", "eu": "approved (E322)", "notes": "One of the most widely used food emulsifiers; most soy lecithin is from GMO soy unless specified organic/non-GMO; hexane is used in extraction but residues are minimal in final product; EU requires allergen labeling for soy lecithin"}',
  ARRAY['sunflower lecithin', 'egg lecithin', 'rapeseed lecithin'],
  ARRAY['chocolate', 'baked goods', 'margarine', 'salad dressings', 'infant formula', 'supplements'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'FARE']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lecithin (Sunflower)',
  'lecithin-sunflower',
  ARRAY['Sunflower Lecithin', 'Helianthus Annuus Lecithin', 'Phosphatidylcholine (Sunflower)'],
  'emulsifier',
  1,
  ARRAY['generally recognized as safe', 'allergen-free alternative'],
  '{"acute": "No significant acute toxicity; very well tolerated", "chronic": "Considered very safe; non-GMO; allergen-free (not a major allergen); provides beneficial phospholipids; extracted mechanically without hexane (cold-pressed); increasingly preferred over soy lecithin", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved", "notes": "Preferred alternative to soy lecithin for those avoiding soy, GMOs, or hexane-extracted ingredients; more expensive than soy lecithin; extracted by cold-pressing sunflower seeds; growing in popularity in clean-label products"}',
  ARRAY['no alternatives needed - this IS the preferred clean alternative'],
  ARRAY['chocolate', 'baked goods', 'plant-based milks', 'supplements', 'protein bars', 'nut butters'],
  ARRAY['FDA', 'EFSA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polysorbate 80 (Emulsifier Use)',
  'polysorbate-80-emulsifier',
  ARRAY['E433', 'Tween 80', 'Polyoxyethylene (20) Sorbitan Monooleate'],
  'emulsifier',
  5,
  ARRAY['gut microbiome disruption', 'intestinal inflammation', 'metabolic syndrome', 'anaphylactoid reactions'],
  '{"acute": "Rare anaphylactoid reactions reported; mild GI discomfort possible", "chronic": "Georgia State University research showed PS80 promotes intestinal inflammation, gut microbiome disruption, and metabolic syndrome in mice; may increase intestinal permeability; widely used in both food and pharmaceuticals", "vulnerable_groups": ["individuals with IBD", "children", "individuals with autoimmune conditions"]}',
  '{"fda": "GRAS (up to 1%)", "eu": "approved (E433) with ADI of 25 mg/kg", "notes": "One of the most studied emulsifiers for gut health effects; Chassaing et al. (2015, Nature) research was groundbreaking in showing emulsifier-gut interaction; also used in vaccines and injectable drugs"}',
  ARRAY['sunflower lecithin', 'gum arabic', 'egg lecithin'],
  ARRAY['ice cream', 'salad dressings', 'sauces', 'baked goods', 'cosmetics', 'vaccines'],
  ARRAY['FDA', 'EFSA', 'Nature journal', 'Georgia State University', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Glycerol Monostearate',
  'glycerol-monostearate',
  ARRAY['E471', 'GMS', 'Glyceryl Monostearate', 'Monostearin'],
  'emulsifier',
  3,
  ARRAY['may contain trans fats', 'processed food indicator', 'gut effects'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "May contain trans fatty acids exempt from labeling; metabolized to glycerol and stearic acid; less studied for gut microbiome effects than polysorbate 80 or CMC but shares similar emulsifier class concerns", "vulnerable_groups": ["individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E471)", "notes": "One of the most common food emulsifiers globally; falls under the mono and diglycerides category; trans fat labeling exemption is a concern; used in baked goods to improve texture and shelf life"}',
  ARRAY['sunflower lecithin', 'egg yolks'],
  ARRAY['bread', 'baked goods', 'ice cream', 'whipped toppings', 'margarine', 'confections'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sorbitan Monostearate',
  'sorbitan-monostearate',
  ARRAY['E491', 'Span 60', 'SMS', 'Sorbitan Stearate'],
  'emulsifier',
  3,
  ARRAY['synthetic emulsifier', 'gut effects', 'potential contaminants'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Limited chronic toxicity data specific to this compound; as a sorbitan ester, shares general class concerns about gut microbiome effects; metabolized to sorbitol and stearic acid", "vulnerable_groups": ["individuals with GI sensitivities"]}',
  '{"fda": "approved food additive", "eu": "approved (E491) with ADI of 25 mg/kg for total sorbitan esters", "notes": "Used primarily as water-in-oil emulsifier; often used with polysorbates for optimal emulsification; also used in cosmetics and pharmaceuticals"}',
  ARRAY['sunflower lecithin', 'beeswax', 'gum arabic'],
  ARRAY['chocolate', 'cake mixes', 'whipped toppings', 'margarine', 'cosmetics'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sorbitan Tristearate',
  'sorbitan-tristearate',
  ARRAY['E492', 'Span 65', 'STS'],
  'emulsifier',
  3,
  ARRAY['synthetic emulsifier', 'processed food indicator'],
  '{"acute": "Generally well tolerated", "chronic": "Limited specific chronic toxicity data; metabolized to sorbitol and stearic acid; shares class concerns with other sorbitan esters; ADI applies to total sorbitan ester intake", "vulnerable_groups": []}',
  '{"fda": "approved food additive", "eu": "approved (E492) under combined sorbitan ester ADI", "notes": "Less commonly used than sorbitan monostearate; primarily used in chocolate and confectionery coatings; oil-soluble emulsifier"}',
  ARRAY['sunflower lecithin', 'cocoa butter'],
  ARRAY['chocolate coatings', 'confections', 'vegetable oil spreads', 'cake decorations'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Stearoyl-2-Lactylate',
  'sodium-stearoyl-2-lactylate',
  ARRAY['E481', 'SSL', 'Sodium Stearoyl Lactylate'],
  'emulsifier',
  2,
  ARRAY['mild GI effects at high doses', 'processed food indicator'],
  '{"acute": "No significant acute toxicity; well tolerated", "chronic": "Considered one of the safer emulsifier additives; metabolized to stearic acid and lactic acid, both naturally occurring; no significant chronic toxicity concerns identified", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E481) with ADI of 22 mg/kg", "notes": "Widely used as dough strengthener and crumb softener; lactic acid component is typically from fermentation, not dairy; considered safe by all major regulatory bodies"}',
  ARRAY['sunflower lecithin', 'egg-based emulsifiers'],
  ARRAY['bread', 'tortillas', 'baked goods', 'coffee creamers', 'snack foods'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Calcium Stearoyl-2-Lactylate',
  'calcium-stearoyl-2-lactylate',
  ARRAY['E482', 'CSL', 'Calcium Stearoyl Lactylate'],
  'emulsifier',
  2,
  ARRAY['mild GI effects at high doses', 'processed food indicator'],
  '{"acute": "No significant acute toxicity", "chronic": "Metabolized to stearic acid and lactic acid; no significant chronic toxicity concerns; functionally similar to sodium stearoyl lactylate", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E482) with ADI of 22 mg/kg", "notes": "Used as dough conditioner and crumb softener; often interchangeable with SSL; generally well-regarded for safety"}',
  ARRAY['sunflower lecithin', 'egg-based emulsifiers'],
  ARRAY['bread', 'baked goods', 'crackers', 'cereals'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sucrose Esters',
  'sucrose-esters',
  ARRAY['E473', 'Sucrose Esters of Fatty Acids', 'Sugar Esters', 'Sucrose Stearate', 'Sucrose Palmitate'],
  'emulsifier',
  2,
  ARRAY['mild GI effects', 'relatively new in widespread use'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Considered relatively safe; metabolized to sucrose and fatty acids; less studied for gut microbiome effects than some other emulsifiers; growing in popularity as clean-label alternative", "vulnerable_groups": []}',
  '{"fda": "GRAS", "eu": "approved (E473) with ADI of 40 mg/kg", "notes": "Gaining popularity in clean-label formulations; derived from sugar and vegetable fats; considered more natural than many synthetic emulsifiers; Japan has used sucrose esters extensively for decades"}',
  ARRAY['sunflower lecithin', 'acacia gum'],
  ARRAY['baked goods', 'beverages', 'ice cream', 'confections', 'chewing gum', 'coffee creamers'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polyglycerol Polyricinoleate',
  'polyglycerol-polyricinoleate',
  ARRAY['E476', 'PGPR', 'Polyglycerol Esters of Interesterified Ricinoleic Acid'],
  'emulsifier',
  3,
  ARRAY['synthetic emulsifier', 'GI effects at high doses', 'cost-cutting ingredient in chocolate'],
  '{"acute": "May cause GI effects (diarrhea, nausea) at high doses; generally well tolerated at normal food use levels", "chronic": "EFSA set a relatively low ADI of 7.5 mg/kg, suggesting some concern about chronic intake; primarily used in chocolate to reduce cocoa butter content (cost savings for manufacturers); limited long-term studies", "vulnerable_groups": ["children (high chocolate consumers)", "individuals with GI sensitivities"]}',
  '{"fda": "GRAS", "eu": "approved (E476) with ADI of 7.5 mg/kg", "notes": "Primarily used in chocolate manufacturing as partial replacement for cocoa butter; allows chocolate makers to use less expensive cocoa butter; some consumers view it as indicator of lower-quality chocolate; derived from castor oil and glycerol"}',
  ARRAY['extra cocoa butter', 'sunflower lecithin'],
  ARRAY['chocolate', 'chocolate coatings', 'candy bars', 'chocolate spreads', 'salad dressings'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ammonium Phosphatide',
  'ammonium-phosphatide',
  ARRAY['E442', 'Ammonium Phospholipids', 'YN'],
  'emulsifier',
  2,
  ARRAY['synthetic emulsifier', 'limited safety data'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Limited long-term data; EFSA evaluated and considered acceptable at current use levels; derived from rapeseed oil; metabolized to glycerol, fatty acids, and phosphoric acid", "vulnerable_groups": []}',
  '{"fda": "approved food additive", "eu": "approved (E442)", "notes": "Used primarily in chocolate as alternative to soy lecithin; particularly useful for allergen-free chocolate formulations; less well-known than other emulsifiers; Cargill markets it as alternative for soy-free products"}',
  ARRAY['sunflower lecithin'],
  ARRAY['chocolate', 'chocolate coatings', 'confections'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diacetyl Tartaric Acid Esters',
  'diacetyl-tartaric-acid-esters',
  ARRAY['E472e', 'DATEM', 'DTAEM', 'Diacetyl Tartaric Acid Esters of Mono- and Diglycerides'],
  'emulsifier',
  3,
  ARRAY['may contain trans fats', 'processed food indicator'],
  '{"acute": "Generally well tolerated", "chronic": "Like other mono and diglyceride derivatives, may contain trans fatty acids exempt from nutrition labeling; metabolized to tartaric acid, glycerol, and fatty acids; widely used but shares the trans fat labeling gap", "vulnerable_groups": ["individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E472e)", "notes": "One of the most common dough strengtheners in commercial bread baking; the emulsifier form of DATEM; helps create uniform crumb structure and volume in bread"}',
  ARRAY['longer fermentation', 'enzyme-based dough improvers', 'ascorbic acid'],
  ARRAY['bread', 'rolls', 'tortillas', 'baked goods', 'crackers'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Propylene Glycol Esters',
  'propylene-glycol-esters',
  ARRAY['E477', 'Propylene Glycol Esters of Fatty Acids', 'PGMS', 'Propylene Glycol Monostearate'],
  'emulsifier',
  4,
  ARRAY['propylene glycol component', 'synthetic emulsifier', 'potential allergen'],
  '{"acute": "Generally well tolerated; propylene glycol component may cause reactions in sensitive individuals", "chronic": "Contributes to total propylene glycol intake; propylene glycol has its own set of concerns including contact dermatitis and CNS effects at high doses; metabolized to propylene glycol and fatty acids", "vulnerable_groups": ["infants", "individuals with kidney/liver disease", "propylene glycol-sensitive individuals"]}',
  '{"fda": "GRAS", "eu": "approved (E477)", "notes": "Combines concerns of propylene glycol with emulsifier effects; used primarily in cake mixes and whipped toppings; less commonly used than other emulsifiers"}',
  ARRAY['sunflower lecithin', 'glycerol-based emulsifiers'],
  ARRAY['cake mixes', 'whipped toppings', 'baked goods', 'coffee whiteners'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Stearyl Citrate',
  'stearyl-citrate',
  ARRAY['E484', 'Stearyl Monoglyceridyl Citrate'],
  'emulsifier',
  2,
  ARRAY['limited use', 'processed food indicator'],
  '{"acute": "No significant acute toxicity at food-use levels", "chronic": "Limited chronic toxicity data due to limited use; metabolized to stearic acid and citric acid, both naturally occurring; considered safe at current use levels", "vulnerable_groups": []}',
  '{"fda": "approved food additive", "eu": "approved (E484)", "notes": "Relatively uncommon emulsifier; used as synergist with other emulsifiers; derived from stearic acid and citric acid; limited use means limited safety data but metabolites are well-characterized"}',
  ARRAY['sunflower lecithin', 'citric acid'],
  ARRAY['margarine', 'vegetable oil spreads', 'shortenings'],
  ARRAY['FDA', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Mono and Diglycerides (Emulsifier)',
  'mono-and-diglycerides-emulsifier',
  ARRAY['E471', 'Monoglycerides', 'Diglycerides', 'Glycerides', 'Glycerol Esters'],
  'emulsifier',
  4,
  ARRAY['hidden trans fats', 'trans fat labeling loophole', 'gut microbiome effects', 'cardiovascular concerns'],
  '{"acute": "Generally well tolerated", "chronic": "Major concern: may contain trans fatty acids that are completely exempt from nutrition label trans fat declarations; FDA ban on partially hydrogenated oils does NOT cover mono and diglycerides; this regulatory loophole allows hidden trans fats in many processed foods; gut microbiome disruption shown in animal studies", "vulnerable_groups": ["individuals with cardiovascular disease", "children", "pregnant women"]}',
  '{"fda": "GRAS", "eu": "approved (E471)", "notes": "The trans fat loophole is the most significant concern; these emulsifiers can be made from partially hydrogenated oils and contain significant trans fats without any labeling requirement; one of the most common food additives globally"}',
  ARRAY['sunflower lecithin', 'egg yolks', 'mustard powder'],
  ARRAY['bread', 'baked goods', 'margarine', 'ice cream', 'peanut butter', 'candy', 'whipped toppings'],
  ARRAY['FDA', 'EFSA', 'CSPI', 'American Heart Association', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Acetylated Monoglycerides',
  'acetylated-monoglycerides',
  ARRAY['E472a', 'Acetic Acid Esters of Mono- and Diglycerides', 'ACETEM'],
  'emulsifier',
  3,
  ARRAY['synthetic emulsifier', 'may contain trans fats', 'processed food indicator'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Shares trans fat labeling exemption with other mono/diglyceride derivatives; metabolized to acetic acid, glycerol, and fatty acids; limited specific chronic toxicity data", "vulnerable_groups": ["individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E472a)", "notes": "Used as coating agent for fruits and confections; also used as release agent; forms flexible, moisture-resistant films; less commonly used than DATEM"}',
  ARRAY['beeswax', 'carnauba wax', 'sunflower lecithin'],
  ARRAY['confection coatings', 'fruit coatings', 'baked goods', 'chewing gum'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lactylated Monoglycerides',
  'lactylated-monoglycerides',
  ARRAY['E472b', 'Lactic Acid Esters of Mono- and Diglycerides', 'LACTEM'],
  'emulsifier',
  3,
  ARRAY['synthetic emulsifier', 'may contain trans fats', 'processed food indicator'],
  '{"acute": "Generally well tolerated", "chronic": "Similar profile to other mono/diglyceride derivatives; metabolized to lactic acid, glycerol, and fatty acids; shares the trans fat labeling exemption; limited specific chronic data", "vulnerable_groups": ["individuals with cardiovascular disease"]}',
  '{"fda": "GRAS", "eu": "approved (E472b)", "notes": "Used as dough conditioner and emulsifier; the lactic acid component improves dough handling properties; despite the name, not derived from dairy milk (lactic acid is from fermentation)"}',
  ARRAY['sunflower lecithin', 'longer fermentation'],
  ARRAY['bread', 'baked goods', 'tortillas', 'coffee whiteners'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ethoxylated Mono and Diglycerides',
  'ethoxylated-mono-and-diglycerides',
  ARRAY['Ethoxylated Monoglycerides', 'Polyoxyethylene Monostearate', 'PEG Glyceryl Stearate'],
  'emulsifier',
  5,
  ARRAY['ethylene oxide contamination', '1,4-dioxane contamination', 'synthetic processing', 'poorly studied'],
  '{"acute": "Generally tolerated at food-use levels; potential for ethylene oxide residues", "chronic": "Ethoxylation process introduces risk of ethylene oxide (known carcinogen) and 1,4-dioxane (probable carcinogen) contamination; combines concerns of PEG compounds with mono/diglyceride concerns; less commonly used but more concerning than non-ethoxylated forms", "vulnerable_groups": ["children", "pregnant women", "individuals with chemical sensitivities"]}',
  '{"fda": "approved food additive", "eu": "more restricted than US", "notes": "The ethoxylation process is the primary concern as it can leave residual ethylene oxide and 1,4-dioxane; used as dough conditioner and whipping agent; less common in modern formulations as cleaner alternatives gain popularity"}',
  ARRAY['sunflower lecithin', 'non-ethoxylated emulsifiers', 'egg-based emulsifiers'],
  ARRAY['bread', 'baked goods', 'whipped toppings', 'cake mixes'],
  ARRAY['FDA', 'EFSA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Succinylated Monoglycerides',
  'succinylated-monoglycerides',
  ARRAY['E472g', 'Succinic Acid Esters of Monoglycerides', 'SMG'],
  'emulsifier',
  3,
  ARRAY['synthetic emulsifier', 'limited safety data', 'may contain trans fats'],
  '{"acute": "Generally well tolerated at food-use levels", "chronic": "Limited specific chronic toxicity data; metabolized to succinic acid, glycerol, and fatty acids; shares the trans fat labeling exemption with other mono/diglyceride derivatives; relatively rarely used compared to other emulsifiers", "vulnerable_groups": ["individuals with cardiovascular disease"]}',
  '{"fda": "approved food additive", "eu": "approved (E472g)", "notes": "Used primarily as dough conditioner; creates strong complexes with gluten proteins; relatively uncommon compared to SSL or DATEM; limited use means less safety data available"}',
  ARRAY['sunflower lecithin', 'SSL', 'enzyme-based dough conditioners'],
  ARRAY['bread', 'baked goods', 'tortillas'],
  ARRAY['FDA', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Phosphate (Emulsifier)',
  'sodium-phosphate-emulsifier',
  ARRAY['E339', 'Disodium Phosphate', 'DSP', 'Sodium Phosphate Dibasic'],
  'emulsifier',
  5,
  ARRAY['phosphate overload', 'cardiovascular calcification', 'kidney damage', 'bone loss'],
  '{"acute": "Generally tolerated at food levels; excessive intake causes electrolyte imbalances", "chronic": "When used as emulsifier (particularly in processed cheese), contributes significantly to dietary phosphate burden; inorganic phosphate from additives is nearly 100% bioavailable vs 40-60% from natural foods; chronic excess linked to vascular calcification, accelerated aging, kidney damage, and increased mortality", "vulnerable_groups": ["individuals with kidney disease", "elderly", "individuals with cardiovascular disease", "children"]}',
  '{"fda": "GRAS", "eu": "approved (E339) with group phosphate ADI of 40 mg/kg", "notes": "Phosphate emulsifiers are the key ingredient that makes processed cheese melt and maintain uniform texture; EFSA set group ADI for all phosphate additives in 2019; hidden phosphate in processed foods is a growing public health concern"}',
  ARRAY['citric acid', 'cream of tartar', 'real cheese (no emulsifiers needed)'],
  ARRAY['processed cheese', 'cheese spreads', 'cheese sauces', 'frozen meals', 'processed meats'],
  ARRAY['FDA', 'EFSA', 'WHO/JECFA', 'CSPI', 'American Journal of Clinical Nutrition']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Galaxolide',
  'galaxolide',
  ARRAY['HHCB', '1,3,4,6,7,8-Hexahydro-4,6,6,7,8,8-hexamethylcyclopenta[g]-2-benzopyran', 'Abbalide', 'Pearlide'],
  'fragrance',
  7,
  ARRAY['endocrine disruption', 'bioaccumulation', 'aquatic toxicity', 'persistence in environment'],
  '{"acute": "Skin sensitization and irritation in some individuals", "chronic": "Suspected endocrine disruptor; bioaccumulates in human fat tissue and breast milk; persistent in waterways", "vulnerable_groups": ["pregnant women", "infants", "breastfeeding mothers"]}',
  '{"fda": "approved", "eu": "restricted", "notes": "Detected in human blood, breast milk, and fat tissue. EU has proposed restrictions under REACH regulation."}',
  ARRAY['essential oils', 'plant-based musks', 'macrocyclic musks like Exaltolide'],
  ARRAY['perfumes', 'laundry detergent', 'fabric softener', 'body lotion', 'shampoo'],
  ARRAY['EWG', 'EFSA', 'ECHA', 'OSPAR Commission']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Tonalide',
  'tonalide',
  ARRAY['AHTN', '7-Acetyl-1,1,3,4,4,6-hexamethyl-1,2,3,4-tetrahydronaphthalene', 'Fixolide'],
  'fragrance',
  7,
  ARRAY['endocrine disruption', 'bioaccumulation', 'aquatic toxicity', 'environmental persistence'],
  '{"acute": "Mild skin and eye irritation possible", "chronic": "Suspected endocrine disruptor; accumulates in adipose tissue and breast milk; persistent environmental pollutant", "vulnerable_groups": ["pregnant women", "infants", "breastfeeding mothers"]}',
  '{"fda": "approved", "eu": "restricted", "notes": "Found in human tissue samples worldwide. Listed as a substance of very high concern candidate under EU REACH."}',
  ARRAY['essential oils', 'plant-based musks', 'macrocyclic musks'],
  ARRAY['perfumes', 'cologne', 'laundry detergent', 'air freshener', 'body wash'],
  ARRAY['EWG', 'EFSA', 'ECHA', 'OSPAR Commission']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diethyl Phthalate',
  'diethyl-phthalate',
  ARRAY['DEP', 'Phthalic acid diethyl ester', 'Ethyl phthalate', 'CAS 84-66-2'],
  'fragrance',
  6,
  ARRAY['endocrine disruption', 'reproductive toxicity', 'developmental effects'],
  '{"acute": "Low acute toxicity; may cause mild skin irritation", "chronic": "Endocrine disruptor affecting androgen signaling; linked to reduced sperm quality and altered reproductive development in animal studies", "vulnerable_groups": ["pregnant women", "children", "developing fetuses"]}',
  '{"fda": "approved", "eu": "approved", "notes": "Often hidden under generic fragrance listing. Not individually restricted in most jurisdictions but classified as an endocrine disruptor by some agencies."}',
  ARRAY['phthalate-free fragrances', 'essential oil blends', 'natural isolates'],
  ARRAY['perfumes', 'cologne', 'deodorant', 'hair spray', 'nail polish'],
  ARRAY['EWG', 'FDA', 'EFSA', 'ECHA', 'CSPI']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Dibutyl Phthalate',
  'dibutyl-phthalate',
  ARRAY['DBP', 'Di-n-butyl phthalate', 'Butyl phthalate', 'CAS 84-74-2'],
  'fragrance',
  8,
  ARRAY['endocrine disruption', 'reproductive toxicity', 'developmental toxicity', 'teratogenicity'],
  '{"acute": "Skin and eye irritation; nausea if ingested", "chronic": "Potent endocrine disruptor; causes testicular atrophy and reduced fertility in animal studies; linked to birth defects in male reproductive system (hypospadias, cryptorchidism)", "vulnerable_groups": ["pregnant women", "developing fetuses", "infants", "children"]}',
  '{"fda": "restricted in some cosmetics", "eu": "banned in cosmetics", "notes": "Classified as CMR (carcinogenic, mutagenic, reprotoxic) Category 1B in EU. Banned in EU cosmetics since 2004. Listed on California Prop 65."}',
  ARRAY['phthalate-free nail polish', 'water-based nail polish', 'essential oil fragrances'],
  ARRAY['nail polish', 'hair spray', 'perfume', 'insect repellent', 'plastic packaging'],
  ARRAY['EWG', 'FDA', 'EFSA', 'ECHA', 'WHO', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Di(2-Ethylhexyl) Phthalate',
  'dehp',
  ARRAY['DEHP', 'Bis(2-ethylhexyl) phthalate', 'Dioctyl phthalate', 'DOP', 'CAS 117-81-7'],
  'fragrance',
  9,
  ARRAY['endocrine disruption', 'reproductive toxicity', 'carcinogenicity', 'liver toxicity', 'developmental toxicity'],
  '{"acute": "Low acute toxicity via skin; irritation possible", "chronic": "Strong endocrine disruptor; classified as reasonably anticipated to be a human carcinogen; causes liver damage, testicular atrophy, and reduced fertility in animals; linked to asthma and obesity in epidemiological studies", "vulnerable_groups": ["pregnant women", "developing fetuses", "infants", "children", "neonates in NICU"]}',
  '{"fda": "restricted", "eu": "banned in cosmetics", "notes": "Classified as SVHC under EU REACH. Banned in children''s toys and childcare articles in EU and US. IARC Group 2B carcinogen. Listed on California Prop 65."}',
  ARRAY['DINCH', 'DEHT', 'citrate plasticizers', 'adipate plasticizers'],
  ARRAY['PVC products', 'vinyl flooring', 'medical tubing', 'food packaging', 'fragrance formulations'],
  ARRAY['EWG', 'FDA', 'EFSA', 'ECHA', 'WHO', 'IARC', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Formaldehyde (Cosmetics)',
  'formaldehyde-cosmetics',
  ARRAY['Methanal', 'Methyl aldehyde', 'Formalin', 'Formol', 'CAS 50-00-0'],
  'fragrance',
  9,
  ARRAY['carcinogenicity', 'skin sensitization', 'respiratory irritation', 'immune system toxicity'],
  '{"acute": "Strong irritant to eyes, skin, and respiratory tract; causes allergic contact dermatitis", "chronic": "IARC Group 1 known human carcinogen (nasopharyngeal cancer, leukemia); causes chronic respiratory disease and immune sensitization", "vulnerable_groups": ["children", "asthmatics", "salon workers", "immunocompromised individuals"]}',
  '{"fda": "approved with limits", "eu": "banned as intentional ingredient in cosmetics; restricted as preservative to 0.1%", "notes": "IARC Group 1 carcinogen. Banned in EU cosmetics since 2024 except trace amounts. Still found in US products including Brazilian blowout treatments."}',
  ARRAY['formaldehyde-free keratin treatments', 'phenoxyethanol', 'potassium sorbate', 'sodium benzoate'],
  ARRAY['hair straightening treatments', 'nail hardeners', 'eyelash glue', 'hair gel', 'body wash'],
  ARRAY['IARC', 'FDA', 'EFSA', 'EWG', 'OSHA', 'NTP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  '1,4-Dioxane',
  '1-4-dioxane',
  ARRAY['Dioxane', 'Diethylene dioxide', 'Diethylene ether', 'p-Dioxane', 'CAS 123-91-1'],
  'fragrance',
  8,
  ARRAY['carcinogenicity', 'organ toxicity', 'contamination byproduct', 'environmental persistence'],
  '{"acute": "Irritation to eyes and respiratory tract; central nervous system depression at high doses", "chronic": "IARC Group 2B probable human carcinogen; causes liver and kidney tumors in animals; persistent groundwater contaminant", "vulnerable_groups": ["children", "infants", "those with liver or kidney disease"]}',
  '{"fda": "not intentionally added; no limit set but FDA monitors levels", "eu": "restricted as contaminant", "notes": "Not intentionally added but forms as byproduct of ethoxylation process in many cosmetics. FDA has not set limits. Found in shampoos, body wash, and baby products."}',
  ARRAY['products made without ethoxylation', 'truly natural surfactants', 'coconut-derived cleansers'],
  ARRAY['shampoo', 'body wash', 'bubble bath', 'baby wash', 'liquid soap'],
  ARRAY['EWG', 'FDA', 'IARC', 'EPA', 'Campaign for Safe Cosmetics']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Triclosan',
  'triclosan',
  ARRAY['Irgasan DP-300', '5-Chloro-2-(2,4-dichlorophenoxy)phenol', 'Microban', 'Biofresh', 'CAS 3380-34-5'],
  'fragrance',
  8,
  ARRAY['endocrine disruption', 'antibiotic resistance', 'aquatic toxicity', 'thyroid disruption', 'microbiome disruption'],
  '{"acute": "Generally low acute toxicity; mild skin irritation", "chronic": "Disrupts thyroid hormone signaling; promotes antibiotic-resistant bacteria; linked to liver fibrosis and tumors in animal studies; alters gut microbiome", "vulnerable_groups": ["pregnant women", "children", "infants", "those with thyroid conditions"]}',
  '{"fda": "banned in OTC antiseptic wash products (2016)", "eu": "banned in cosmetics (2014)", "notes": "FDA banned in consumer antibacterial soaps in 2016. Still allowed in some toothpastes, hospital settings. EU banned in cosmetics. Minnesota banned in consumer products."}',
  ARRAY['benzalkonium chloride (limited use)', 'plain soap and water', 'alcohol-based sanitizers', 'thymol'],
  ARRAY['antibacterial soap', 'toothpaste', 'deodorant', 'cutting boards', 'yoga mats'],
  ARRAY['FDA', 'EWG', 'EPA', 'EFSA', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Oxybenzone',
  'oxybenzone',
  ARRAY['Benzophenone-3', 'BP-3', '2-Hydroxy-4-methoxybenzophenone', 'Eusolex 4360', 'Escalol 567', 'CAS 131-57-7'],
  'fragrance',
  7,
  ARRAY['endocrine disruption', 'coral reef toxicity', 'photoallergy', 'skin absorption'],
  '{"acute": "Photoallergic contact dermatitis; skin irritation in sensitive individuals", "chronic": "Readily absorbed through skin; detected in 97% of Americans tested; mimics estrogen; linked to altered birth weight and hormone levels; highly toxic to coral reefs", "vulnerable_groups": ["pregnant women", "children", "coral reef ecosystems"]}',
  '{"fda": "approved up to 6%", "eu": "approved up to 6%", "notes": "Banned in Hawaii and Key West for coral reef damage. FDA requested additional safety data in 2019. Detected in breast milk, amniotic fluid, and urine."}',
  ARRAY['zinc oxide', 'titanium dioxide', 'non-nano mineral sunscreens'],
  ARRAY['sunscreen', 'moisturizer with SPF', 'lip balm with SPF', 'foundation', 'anti-aging cream'],
  ARRAY['EWG', 'FDA', 'NOAA', 'Hawaii Legislature', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Octinoxate',
  'octinoxate',
  ARRAY['Ethylhexyl Methoxycinnamate', 'OMC', 'Octyl Methoxycinnamate', 'Escalol 557', 'Uvinul MC 80', 'CAS 5466-77-3'],
  'fragrance',
  7,
  ARRAY['endocrine disruption', 'coral reef toxicity', 'thyroid disruption', 'reproductive effects'],
  '{"acute": "Generally well tolerated; rare photoallergic reactions", "chronic": "Estrogenic and anti-androgenic activity; disrupts thyroid function; toxic to coral larvae at low concentrations; detected in breast milk", "vulnerable_groups": ["pregnant women", "children", "coral reef ecosystems"]}',
  '{"fda": "approved up to 7.5%", "eu": "approved up to 10%", "notes": "Banned in Hawaii and Palau for coral reef damage. FDA requested additional safety data. Degrades in sunlight releasing free radicals."}',
  ARRAY['zinc oxide', 'titanium dioxide', 'non-nano mineral sunscreens'],
  ARRAY['sunscreen', 'moisturizer with SPF', 'BB cream', 'foundation', 'lip balm'],
  ARRAY['EWG', 'FDA', 'NOAA', 'Hawaii Legislature', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Homosalate',
  'homosalate',
  ARRAY['Homomenthyl salicylate', '3,3,5-Trimethylcyclohexyl salicylate', 'HMS', 'Heliopan', 'CAS 118-56-9'],
  'fragrance',
  6,
  ARRAY['endocrine disruption', 'skin absorption', 'estrogenic activity'],
  '{"acute": "Generally low irritation; rare allergic reactions", "chronic": "Disrupts estrogen, androgen, and progesterone signaling; accumulates in the body faster than eliminated; enhances absorption of other chemicals including pesticides", "vulnerable_groups": ["pregnant women", "children", "adolescents"]}',
  '{"fda": "approved up to 15%", "eu": "approved up to 10% (reduced from 15%)", "notes": "EU SCCS reduced maximum concentration due to safety concerns. FDA requested additional safety data in 2019 proposed rule."}',
  ARRAY['zinc oxide', 'titanium dioxide', 'mineral-only sunscreens'],
  ARRAY['sunscreen', 'moisturizer with SPF', 'makeup with SPF', 'lip products'],
  ARRAY['EWG', 'FDA', 'EFSA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Octocrylene',
  'octocrylene',
  ARRAY['2-Ethylhexyl 2-cyano-3,3-diphenylacrylate', 'Uvinul N-539', 'CAS 6197-30-4'],
  'fragrance',
  6,
  ARRAY['endocrine disruption', 'photoallergy', 'benzophenone contamination', 'aquatic toxicity'],
  '{"acute": "Photoallergic contact dermatitis in sensitive individuals", "chronic": "Degrades into benzophenone (a suspected carcinogen and endocrine disruptor) over time; estrogenic activity; accumulates in aquatic organisms", "vulnerable_groups": ["children", "those with eczema or sensitive skin"]}',
  '{"fda": "approved up to 10%", "eu": "approved up to 10%", "notes": "French regulatory agency ANSM found degradation to benzophenone in aged sunscreens. EU SCCS reviewing safety. Hawaii considering ban for coral reef protection."}',
  ARRAY['zinc oxide', 'titanium dioxide', 'mineral sunscreens'],
  ARRAY['sunscreen', 'anti-aging cream', 'moisturizer with SPF', 'hair products with UV protection'],
  ARRAY['EWG', 'FDA', 'EFSA', 'ANSM', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Avobenzone',
  'avobenzone',
  ARRAY['Butyl Methoxydibenzoylmethane', 'Parsol 1789', 'Eusolex 9020', 'CAS 70356-09-1'],
  'fragrance',
  4,
  ARRAY['photodegradation', 'free radical generation', 'skin absorption'],
  '{"acute": "Low irritation potential; rare contact allergy", "chronic": "Degrades rapidly in sunlight generating free radicals; absorbed through skin and detected in blood; less endocrine activity than other chemical filters but still systemically absorbed", "vulnerable_groups": ["those with sensitive skin"]}',
  '{"fda": "approved up to 3%", "eu": "approved up to 5%", "notes": "Most effective UVA chemical filter available in US. Unstable alone but stabilized by octocrylene or other agents. FDA requested additional safety data."}',
  ARRAY['zinc oxide', 'titanium dioxide', 'mineral sunscreens'],
  ARRAY['sunscreen', 'moisturizer with SPF', 'foundation with SPF', 'lip balm with SPF'],
  ARRAY['EWG', 'FDA', 'EFSA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Benzophenone-3',
  'benzophenone-3',
  ARRAY['BP-3', 'Oxybenzone', '2-Hydroxy-4-methoxybenzophenone', 'CAS 131-57-7'],
  'fragrance',
  7,
  ARRAY['endocrine disruption', 'coral reef toxicity', 'photoallergy', 'systemic absorption'],
  '{"acute": "Photoallergic dermatitis; contact urticaria in sensitized individuals", "chronic": "Detected in 97% of Americans; mimics estrogen; linked to endometriosis, low birth weight, and Hirschsprung''s disease in epidemiological studies; bleaches and kills coral", "vulnerable_groups": ["pregnant women", "children", "coral reef ecosystems"]}',
  '{"fda": "approved up to 6%", "eu": "approved up to 6%", "notes": "Identical to oxybenzone. Banned in Hawaii, US Virgin Islands, Key West, Palau, Aruba, and Bonaire for coral reef protection. FDA GRASE determination pending."}',
  ARRAY['zinc oxide', 'titanium dioxide', 'non-nano mineral sunscreens'],
  ARRAY['sunscreen', 'moisturizer with SPF', 'nail polish', 'fragrances', 'hair spray'],
  ARRAY['EWG', 'FDA', 'NOAA', 'Hawaii Legislature', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Methylisothiazolinone',
  'methylisothiazolinone',
  ARRAY['MIT', 'MI', '2-Methyl-4-isothiazolin-3-one', 'Neolone 950', 'CAS 2682-20-4'],
  'fragrance',
  8,
  ARRAY['severe skin sensitization', 'neurotoxicity', 'contact dermatitis', 'allergic reactions'],
  '{"acute": "Strong skin sensitizer; causes severe allergic contact dermatitis even at low concentrations", "chronic": "Neurotoxic in cell studies; causes persistent allergic sensitization; named Contact Allergen of the Year 2013 by ACDS", "vulnerable_groups": ["children", "those with eczema", "those with sensitive skin"]}',
  '{"fda": "approved", "eu": "banned in leave-on cosmetics; restricted to 15 ppm in rinse-off", "notes": "EU banned in leave-on products in 2016 due to epidemic of allergic reactions. Named Allergen of the Year by American Contact Dermatitis Society (2013). Still widely used in US products."}',
  ARRAY['phenoxyethanol', 'sodium benzoate', 'potassium sorbate', 'ethylhexylglycerin'],
  ARRAY['shampoo', 'conditioner', 'body wash', 'wet wipes', 'paint', 'cleaning products'],
  ARRAY['EWG', 'FDA', 'EFSA', 'EU SCCS', 'ACDS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Methylchloroisothiazolinone',
  'methylchloroisothiazolinone',
  ARRAY['MCI', 'CMIT', '5-Chloro-2-methyl-4-isothiazolin-3-one', 'Kathon CG (with MIT)', 'CAS 26172-55-4'],
  'fragrance',
  8,
  ARRAY['severe skin sensitization', 'cytotoxicity', 'contact dermatitis', 'immune system effects'],
  '{"acute": "Potent skin sensitizer; causes severe allergic contact dermatitis and chemical burns at higher concentrations", "chronic": "Persistent sensitization; cytotoxic; causes occupational contact dermatitis in workers; environmental toxin to aquatic organisms", "vulnerable_groups": ["children", "those with eczema", "salon and cleaning workers"]}',
  '{"fda": "approved in combination with MIT (max 15 ppm)", "eu": "banned in leave-on cosmetics; restricted in rinse-off to 15 ppm (MCI/MI 3:1 ratio)", "notes": "Always used in 3:1 ratio with MIT (Kathon CG). Banned in EU leave-on products. Major cause of cosmetic contact allergy worldwide."}',
  ARRAY['phenoxyethanol', 'sodium benzoate', 'potassium sorbate', 'ethylhexylglycerin'],
  ARRAY['shampoo', 'conditioner', 'liquid soap', 'cleaning products', 'paint', 'adhesives'],
  ARRAY['EWG', 'FDA', 'EFSA', 'EU SCCS', 'ACDS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Benzalkonium Chloride',
  'benzalkonium-chloride',
  ARRAY['BAC', 'BKC', 'Alkyldimethylbenzylammonium chloride', 'ADBAC', 'Zephiran', 'BZK', 'CAS 8001-54-5'],
  'fragrance',
  6,
  ARRAY['skin sensitization', 'respiratory irritation', 'antimicrobial resistance', 'ocular toxicity'],
  '{"acute": "Causes skin and eye irritation; respiratory irritation when inhaled; caustic at concentrated levels", "chronic": "Promotes antimicrobial resistance; disrupts skin barrier function; cytotoxic to corneal cells; occupational asthma trigger in healthcare workers", "vulnerable_groups": ["asthmatics", "contact lens wearers", "healthcare workers", "children"]}',
  '{"fda": "approved for limited OTC antiseptic uses; under review", "eu": "approved with restrictions", "notes": "FDA deferred final ruling on its safety in healthcare antiseptics. Common preservative in eye drops linked to dry eye and corneal damage. Under increasing scrutiny for antimicrobial resistance."}',
  ARRAY['polyhexamethylene biguanide', 'preservative-free formulations', 'hydrogen peroxide-based cleaners'],
  ARRAY['eye drops', 'nasal sprays', 'disinfectant wipes', 'hand sanitizer', 'cosmetic preservative'],
  ARRAY['FDA', 'EWG', 'EPA', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cetrimonium Bromide',
  'cetrimonium-bromide',
  ARRAY['CTAB', 'Cetyltrimethylammonium bromide', 'Hexadecyltrimethylammonium bromide', 'CAS 57-09-0'],
  'fragrance',
  5,
  ARRAY['skin irritation', 'eye irritation', 'aquatic toxicity', 'cytotoxicity'],
  '{"acute": "Skin and eye irritation; may cause allergic reactions in sensitive individuals", "chronic": "Cytotoxic at higher concentrations; toxic to aquatic organisms; can damage skin barrier with prolonged use", "vulnerable_groups": ["those with sensitive skin", "those with eczema"]}',
  '{"fda": "approved", "eu": "approved", "notes": "Generally considered safe at low concentrations used in cosmetics (typically under 0.25%). More toxic at higher concentrations. CIR panel found safe as used in current practices."}',
  ARRAY['behentrimonium methosulfate', 'cetearyl alcohol', 'plant-based conditioning agents'],
  ARRAY['conditioner', 'hair mask', 'antiseptic cream', 'detangling spray'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diethanolamine',
  'diethanolamine',
  ARRAY['DEA', '2,2''-Iminobisethanol', 'Bis(2-hydroxyethyl)amine', 'Diolamine', 'CAS 111-42-2'],
  'fragrance',
  7,
  ARRAY['carcinogenicity', 'organ toxicity', 'nitrosamine formation', 'skin absorption'],
  '{"acute": "Skin and eye irritation; may cause nausea if ingested", "chronic": "Reacts with nitrosating agents to form NDEA (a potent carcinogen); causes liver and kidney toxicity in animal studies; IARC Group 2B possible carcinogen; readily absorbed through skin", "vulnerable_groups": ["children", "pregnant women", "those with liver disease"]}',
  '{"fda": "approved but monitored for nitrosamine contamination", "eu": "restricted; prohibited with nitrosating systems", "notes": "IARC classifies as Group 2B possible human carcinogen. California Prop 65 listed. EU restricts use with nitrosating agents. NTP found clear evidence of carcinogenicity in animals."}',
  ARRAY['coconut-derived surfactants', 'glucosides', 'amino acid-based cleansers'],
  ARRAY['shampoo', 'body wash', 'bubble bath', 'cosmetics', 'industrial cleaners'],
  ARRAY['IARC', 'NTP', 'EWG', 'FDA', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Triethanolamine',
  'triethanolamine',
  ARRAY['TEA', '2,2'',2''''-Nitrilotriethanol', 'Trolamine', 'Triethylolamine', 'CAS 102-71-6'],
  'fragrance',
  5,
  ARRAY['nitrosamine formation', 'skin sensitization', 'pH dependent toxicity'],
  '{"acute": "Mild skin and eye irritant; may cause contact dermatitis in sensitive individuals", "chronic": "Can react with nitrosating agents to form carcinogenic nitrosamines; skin sensitizer with repeated exposure; lower concern than DEA but still forms nitrosamines", "vulnerable_groups": ["those with sensitive skin", "those with eczema"]}',
  '{"fda": "approved", "eu": "restricted; max 2.5%; prohibited with nitrosating agents; must be free of nitrosamines", "notes": "CIR panel found safe when formulated to be non-irritating and not combined with nitrosating agents. EU strictly limits concentration and purity."}',
  ARRAY['aminomethyl propanol', 'sodium hydroxide', 'potassium hydroxide', 'arginine'],
  ARRAY['moisturizer', 'foundation', 'eye cream', 'sunscreen', 'shaving cream', 'hair dye'],
  ARRAY['EWG', 'FDA', 'CIR', 'EFSA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Monoethanolamine',
  'monoethanolamine',
  ARRAY['MEA', 'Ethanolamine', '2-Aminoethanol', 'Colamine', 'CAS 141-43-5'],
  'fragrance',
  6,
  ARRAY['respiratory irritation', 'skin sensitization', 'organ toxicity', 'nitrosamine formation'],
  '{"acute": "Corrosive to skin and eyes at higher concentrations; respiratory irritant; can cause chemical burns", "chronic": "Occupational asthma trigger; liver and kidney effects in chronic animal studies; can form nitrosamines in certain formulations", "vulnerable_groups": ["salon workers", "cleaning staff", "asthmatics"]}',
  '{"fda": "approved", "eu": "restricted; max 0.5% free MEA in finished products", "notes": "Commonly used as pH adjuster and in hair dye formulations. EU restricts free MEA concentration. OSHA has workplace exposure limits."}',
  ARRAY['aminomethyl propanol', 'sodium hydroxide', 'amino acid-based pH adjusters'],
  ARRAY['hair color', 'permanent wave solutions', 'cleaning products', 'metalworking fluids'],
  ARRAY['EWG', 'FDA', 'OSHA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cocamide DEA',
  'cocamide-dea',
  ARRAY['Coconut oil diethanolamide', 'Cocamide diethanolamine', 'Coconut diethanolamide', 'CAS 68603-42-9'],
  'fragrance',
  7,
  ARRAY['carcinogenicity', 'nitrosamine contamination', 'skin sensitization'],
  '{"acute": "Mild skin irritation; eye irritation at higher concentrations", "chronic": "IARC Group 2B possible human carcinogen; contaminated with carcinogenic nitrosamines (NDEA); linked to liver tumors in animal studies via contamination pathway", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved", "eu": "restricted; must be free of nitrosamines", "notes": "IARC classified as Group 2B possible carcinogen in 2012. California Prop 65 listed. Widely used as foam booster in shampoos. Can contain or form carcinogenic nitrosamines."}',
  ARRAY['coco glucoside', 'decyl glucoside', 'cocamidopropyl betaine (lower concern)', 'plant-based foam boosters'],
  ARRAY['shampoo', 'body wash', 'dish soap', 'bubble bath', 'hand soap'],
  ARRAY['IARC', 'EWG', 'California OEHHA', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lauramide DEA',
  'lauramide-dea',
  ARRAY['Lauric acid diethanolamide', 'Lauric diethanolamide', 'Lauryl diethanolamide', 'CAS 120-40-1'],
  'fragrance',
  7,
  ARRAY['carcinogenicity', 'nitrosamine formation', 'skin sensitization'],
  '{"acute": "Mild skin and eye irritation", "chronic": "Can form carcinogenic nitrosamines (NDEA); IARC Group 2B possible carcinogen (as part of coconut oil DEA class); linked to organ toxicity in chronic exposure", "vulnerable_groups": ["children", "pregnant women"]}',
  '{"fda": "approved", "eu": "restricted; must be nitrosamine-free", "notes": "Part of the DEA family classified by IARC. California Prop 65 listed under Cocamide DEA. Used as foam booster and thickener."}',
  ARRAY['coco glucoside', 'decyl glucoside', 'caprylyl/capryl glucoside'],
  ARRAY['shampoo', 'body wash', 'facial cleanser', 'bubble bath'],
  ARRAY['IARC', 'EWG', 'FDA', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Petroleum Distillates',
  'petroleum-distillates',
  ARRAY['Petrolatum distillate', 'Naphtha', 'Mineral spirits', 'Stoddard solvent', 'Petroleum hydrocarbons'],
  'fragrance',
  7,
  ARRAY['carcinogenicity', 'neurotoxicity', 'respiratory irritation', 'organ toxicity'],
  '{"acute": "Respiratory irritation; central nervous system depression; dizziness and headache from inhalation; aspiration hazard if swallowed", "chronic": "Some fractions contain carcinogenic PAHs (polycyclic aromatic hydrocarbons); chronic exposure linked to kidney damage and neurological effects; occupational cancer risk", "vulnerable_groups": ["children", "pregnant women", "workers with occupational exposure"]}',
  '{"fda": "allowed in cosmetics if refined to remove carcinogens", "eu": "restricted based on refining process", "notes": "EU restricts use unless full refining history is known and carcinogenic substances removed. Cosmetic grade is highly refined but industrial grades are hazardous."}',
  ARRAY['plant-based oils', 'jojoba oil', 'squalane', 'coconut oil'],
  ARRAY['mascara', 'foundation', 'lip products', 'hair styling products', 'cleaning products'],
  ARRAY['EWG', 'FDA', 'IARC', 'OSHA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Synthetic Fragrance',
  'synthetic-fragrance',
  ARRAY['Fragrance', 'Parfum', 'Aroma', 'Perfume', 'Flavor (when used in cosmetics)'],
  'fragrance',
  7,
  ARRAY['undisclosed chemicals', 'allergens', 'endocrine disruptors', 'respiratory irritation', 'sensitization'],
  '{"acute": "Headaches, migraines, respiratory irritation, allergic contact dermatitis, triggering asthma attacks", "chronic": "May contain hidden phthalates, musks, and aldehydes; linked to endocrine disruption, reproductive effects, and chronic sensitization; trade secret protection prevents disclosure of up to 3,000+ chemicals", "vulnerable_groups": ["children", "pregnant women", "asthmatics", "those with chemical sensitivities", "migraine sufferers"]}',
  '{"fda": "approved; exempt from ingredient disclosure under trade secret law", "eu": "26 specific allergens must be disclosed; IFRA standards apply", "notes": "FDA does not require disclosure of individual fragrance ingredients. A single ''fragrance'' can contain hundreds of undisclosed chemicals. IFRA self-regulates the industry. EU requires disclosure of 26 known allergens."}',
  ARRAY['essential oils', 'plant-derived isolates', 'fragrance-free products', 'products with full ingredient disclosure'],
  ARRAY['perfume', 'cologne', 'lotion', 'shampoo', 'detergent', 'candles', 'air freshener', 'cleaning products'],
  ARRAY['EWG', 'FDA', 'IFRA', 'Campaign for Safe Cosmetics', 'Women''s Voices for the Earth']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Styrene',
  'styrene',
  ARRAY['Vinylbenzene', 'Ethenylbenzene', 'Phenylethylene', 'Cinnamene', 'CAS 100-42-5'],
  'fragrance',
  8,
  ARRAY['carcinogenicity', 'neurotoxicity', 'respiratory toxicity', 'reproductive effects'],
  '{"acute": "Eye and respiratory irritation; central nervous system depression; headache, fatigue, dizziness", "chronic": "IARC Group 2A probable human carcinogen; NTP reasonably anticipated carcinogen; causes hearing loss and neurological damage in occupational exposure; lymphohematopoietic cancers", "vulnerable_groups": ["workers in manufacturing", "pregnant women", "children"]}',
  '{"fda": "not directly regulated in cosmetics", "eu": "restricted in some applications", "notes": "IARC upgraded to Group 2A probable carcinogen in 2018. NTP 15th Report on Carcinogens lists as reasonably anticipated. Found as contaminant in polystyrene food packaging and some cosmetics."}',
  ARRAY['styrene-free packaging', 'glass containers', 'natural rubber alternatives'],
  ARRAY['polystyrene packaging', 'fragrances', 'tobacco smoke', 'building materials'],
  ARRAY['IARC', 'NTP', 'EPA', 'OSHA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Acetaldehyde',
  'acetaldehyde',
  ARRAY['Ethanal', 'Acetic aldehyde', 'Ethyl aldehyde', 'CAS 75-07-0'],
  'fragrance',
  8,
  ARRAY['carcinogenicity', 'respiratory irritation', 'mucosal irritation'],
  '{"acute": "Strong irritant to eyes, skin, and respiratory tract; causes nausea and headache at moderate exposures", "chronic": "IARC Group 2B possible human carcinogen (Group 1 when associated with alcohol consumption); damages DNA; linked to upper aerodigestive tract cancers", "vulnerable_groups": ["workers with occupational exposure", "those who consume alcohol", "children"]}',
  '{"fda": "GRAS as flavoring at low levels", "eu": "classified as Category 1B carcinogen under CLP", "notes": "IARC Group 1 carcinogen associated with alcoholic beverages, Group 2B on its own. EU classified as CMR 1B. Found as contaminant in some fragrances and formed during combustion."}',
  ARRAY['natural flavorings', 'acetaldehyde-free fragrance formulations'],
  ARRAY['fragrances', 'nail products', 'tobacco smoke', 'alcoholic beverages', 'some food flavorings'],
  ARRAY['IARC', 'NTP', 'FDA', 'EFSA', 'OSHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Benzene (Fragrance Contaminant)',
  'benzene-fragrance-contaminant',
  ARRAY['Benzol', 'Cyclohexatriene', 'Phenyl hydride', 'CAS 71-43-2'],
  'fragrance',
  10,
  ARRAY['carcinogenicity', 'bone marrow toxicity', 'leukemia', 'hematotoxicity'],
  '{"acute": "Central nervous system depression; dizziness, drowsiness, tremors; respiratory failure at high concentrations", "chronic": "IARC Group 1 known human carcinogen; causes acute myeloid leukemia (AML) and other blood cancers; destroys bone marrow; causes aplastic anemia; no safe threshold established", "vulnerable_groups": ["everyone", "children", "pregnant women", "workers with occupational exposure"]}',
  '{"fda": "not permitted as intentional ingredient; no limit for contamination in cosmetics", "eu": "banned as intentional ingredient", "notes": "IARC Group 1 known carcinogen. Found as contaminant in some sunscreens, body sprays, and dry shampoos (2021 Valisure petition). FDA recalled contaminated products. No safe level of exposure."}',
  ARRAY['benzene-free formulations', 'products tested for benzene contamination'],
  ARRAY['some sunscreens (contaminant)', 'dry shampoo (contaminant)', 'body spray (contaminant)', 'hand sanitizer (contaminant)'],
  ARRAY['IARC', 'NTP', 'FDA', 'EPA', 'OSHA', 'Valisure']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Toluene (Fragrance)',
  'toluene-fragrance',
  ARRAY['Methylbenzene', 'Toluol', 'Phenyl methane', 'CAS 108-88-3'],
  'fragrance',
  8,
  ARRAY['neurotoxicity', 'reproductive toxicity', 'developmental toxicity', 'respiratory irritation'],
  '{"acute": "Headache, dizziness, nausea; central nervous system depression; respiratory irritation", "chronic": "Neurotoxic causing cognitive impairment and hearing loss; reproductive toxicant causing spontaneous abortion and fetal growth retardation; chronic solvent encephalopathy with long-term exposure", "vulnerable_groups": ["pregnant women", "developing fetuses", "nail salon workers", "children"]}',
  '{"fda": "restricted; not allowed in nail products in some states", "eu": "restricted to 25% in nail products", "notes": "Part of the ''toxic trio'' in nail products (toluene, formaldehyde, DBP). California restricts workplace exposure in nail salons. EU limits concentration. Can cause ''painter''s syndrome'' with chronic exposure."}',
  ARRAY['ethyl acetate', 'butyl acetate', 'water-based nail polish', 'toluene-free formulations'],
  ARRAY['nail polish', 'nail treatments', 'hair dye', 'fragrances', 'paint'],
  ARRAY['EWG', 'FDA', 'OSHA', 'EPA', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lilial',
  'lilial',
  ARRAY['Butylphenyl Methylpropional', 'BMHCA', '2-(4-tert-Butylbenzyl)propionaldehyde', 'Lysmeral', 'CAS 80-54-6'],
  'fragrance',
  8,
  ARRAY['reproductive toxicity', 'endocrine disruption', 'skin sensitization', 'developmental toxicity'],
  '{"acute": "Skin sensitizer; causes allergic contact dermatitis", "chronic": "Classified as reprotoxic Category 1B; causes reproductive and developmental toxicity in animal studies; endocrine disrupting properties", "vulnerable_groups": ["pregnant women", "developing fetuses", "those with fragrance allergies"]}',
  '{"fda": "approved", "eu": "banned in cosmetics since March 2022", "notes": "EU banned in all cosmetics effective March 2022 after classification as CMR 1B (reprotoxic). Was one of the most widely used fragrance ingredients. Still allowed in US products. Must be labeled in EU if present above 0.001% in leave-on or 0.01% in rinse-off products."}',
  ARRAY['natural lily-of-the-valley extracts', 'alternative floral fragrance compounds', 'essential oil blends'],
  ARRAY['perfume', 'body lotion', 'shower gel', 'deodorant', 'laundry detergent', 'shampoo'],
  ARRAY['ECHA', 'EU SCCS', 'EWG', 'IFRA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Hydroxycitronellal',
  'hydroxycitronellal',
  ARRAY['7-Hydroxycitronellal', '3,7-Dimethyl-7-hydroxyoctanal', 'Laurine', 'Cyclalia', 'CAS 107-75-5'],
  'fragrance',
  6,
  ARRAY['skin sensitization', 'contact dermatitis', 'allergic reactions'],
  '{"acute": "Common fragrance allergen; causes allergic contact dermatitis; skin and eye irritation", "chronic": "One of the most common causes of fragrance allergy; persistent sensitization once developed; cross-reacts with other fragrance allergens", "vulnerable_groups": ["those with fragrance allergies", "those with eczema", "those with sensitive skin"]}',
  '{"fda": "approved", "eu": "must be declared on label above 0.001% (leave-on) or 0.01% (rinse-off)", "notes": "One of 26 EU-designated fragrance allergens requiring individual labeling. IFRA restricts use levels. Very common cause of contact allergy in dermatology patch testing."}',
  ARRAY['natural citronella oil', 'alternative floral fragrance compounds', 'fragrance-free products'],
  ARRAY['perfume', 'cologne', 'body lotion', 'shower gel', 'deodorant', 'soap'],
  ARRAY['EU SCCS', 'IFRA', 'EWG', 'ACDS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Lauryl Sulfate',
  'sodium-lauryl-sulfate',
  ARRAY['SLS', 'Sodium dodecyl sulfate', 'SDS', 'Sodium monododecyl sulfate', 'CAS 151-21-3'],
  'surfactant',
  5,
  ARRAY['skin irritation', 'eye irritation', 'mucous membrane irritation', 'skin barrier disruption'],
  '{"acute": "Significant skin and eye irritant; causes contact dermatitis; strips natural oils from skin", "chronic": "Disrupts skin barrier function with repeated use; exacerbates eczema and rosacea; may cause canker sores when used in toothpaste; enhances penetration of other chemicals through skin", "vulnerable_groups": ["those with eczema", "those with rosacea", "those with sensitive skin", "children"]}',
  '{"fda": "GRAS", "eu": "approved", "notes": "CIR panel found safe in brief-use rinse-off products. Not a carcinogen despite internet myths. Primary concern is irritation potential. Concentration matters - safe at low levels but irritating above 2% in leave-on products."}',
  ARRAY['sodium cocoyl isethionate', 'decyl glucoside', 'coco glucoside', 'sodium cocoyl glutamate'],
  ARRAY['shampoo', 'toothpaste', 'body wash', 'facial cleanser', 'dish soap', 'laundry detergent'],
  ARRAY['EWG', 'CIR', 'FDA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Laureth Sulfate',
  'sodium-laureth-sulfate',
  ARRAY['SLES', 'Sodium lauryl ether sulfate', 'Sodium lauryl polyoxyethylene ether sulfate', 'CAS 9004-82-4', 'CAS 68585-34-2'],
  'surfactant',
  5,
  ARRAY['skin irritation', '1,4-dioxane contamination', 'eye irritation', 'skin barrier disruption'],
  '{"acute": "Milder than SLS but still irritating; eye irritation; can cause contact dermatitis", "chronic": "May contain 1,4-dioxane (IARC Group 2B carcinogen) as ethoxylation byproduct; disrupts skin barrier with repeated use; less irritating than SLS due to larger molecular size", "vulnerable_groups": ["those with eczema", "those with sensitive skin", "children"]}',
  '{"fda": "approved", "eu": "approved; 1,4-dioxane levels monitored", "notes": "CIR panel found safe in rinse-off products when formulated to be non-irritating. The primary concern beyond irritation is 1,4-dioxane contamination from manufacturing. Vacuum stripping can remove dioxane."}',
  ARRAY['sodium cocoyl isethionate', 'decyl glucoside', 'coco glucoside', 'sodium lauroyl sarcosinate'],
  ARRAY['shampoo', 'body wash', 'bubble bath', 'hand soap', 'facial cleanser'],
  ARRAY['EWG', 'CIR', 'FDA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ammonium Lauryl Sulfate',
  'ammonium-lauryl-sulfate',
  ARRAY['ALS', 'Ammonium dodecyl sulfate', 'CAS 2235-54-3'],
  'surfactant',
  5,
  ARRAY['skin irritation', 'eye irritation', 'mucous membrane irritation'],
  '{"acute": "Skin and eye irritant similar to SLS; may be slightly less irritating than sodium salt form", "chronic": "Disrupts skin barrier with chronic use; may exacerbate eczema and dermatitis; strips natural oils", "vulnerable_groups": ["those with eczema", "those with sensitive skin", "children"]}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe in rinse-off products when formulated to be non-irritating. Similar toxicity profile to SLS. Used as alternative to SLS in some formulations."}',
  ARRAY['decyl glucoside', 'coco glucoside', 'sodium cocoyl isethionate', 'sodium cocoyl glutamate'],
  ARRAY['shampoo', 'body wash', 'facial cleanser', 'hand soap'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ammonium Laureth Sulfate',
  'ammonium-laureth-sulfate',
  ARRAY['ALES', 'Ammonium lauryl ether sulfate', 'CAS 32612-48-9'],
  'surfactant',
  5,
  ARRAY['skin irritation', '1,4-dioxane contamination', 'eye irritation'],
  '{"acute": "Moderate skin and eye irritant; milder than ALS due to ethoxylation", "chronic": "May contain 1,4-dioxane as ethoxylation contaminant; chronic skin barrier disruption with repeated use", "vulnerable_groups": ["those with eczema", "those with sensitive skin"]}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe as used in rinse-off products. Similar concerns to SLES regarding 1,4-dioxane contamination. Milder than non-ethoxylated form."}',
  ARRAY['decyl glucoside', 'coco glucoside', 'sodium cocoyl isethionate'],
  ARRAY['shampoo', 'body wash', 'bubble bath', 'hand soap'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cocamidopropyl Betaine',
  'cocamidopropyl-betaine',
  ARRAY['CAPB', 'Coco betaine', 'Coconut betaine', 'CAS 61789-40-0', 'CAS 86438-79-1'],
  'surfactant',
  3,
  ARRAY['contact dermatitis', 'impurity-related sensitization', 'eye irritation'],
  '{"acute": "Generally mild; rare allergic contact dermatitis often due to manufacturing impurities (DMAPA, amidoamine)", "chronic": "Named Contact Allergen of the Year 2004 by ACDS; sensitization typically due to impurities rather than the compound itself; well-tolerated by most people", "vulnerable_groups": ["those with coconut allergy", "those with contact dermatitis history"]}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe as used. Named Allergen of the Year 2004 but sensitization is primarily from impurities (dimethylaminopropylamine). Widely used as gentle alternative to sulfate surfactants. High-purity grades are well tolerated."}',
  ARRAY['decyl glucoside', 'coco glucoside', 'sodium cocoyl isethionate', 'babassuamidopropyl betaine'],
  ARRAY['shampoo', 'body wash', 'facial cleanser', 'baby wash', 'intimate wash'],
  ARRAY['EWG', 'CIR', 'ACDS', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Decyl Glucoside',
  'decyl-glucoside',
  ARRAY['Decyl D-glucoside', 'Decyl polyglucose', 'CAS 68515-73-1', 'CAS 141464-42-8'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Very mild; low irritation potential; well tolerated by sensitive skin", "chronic": "No significant chronic concerns; biodegradable; derived from renewable resources (coconut and corn); no endocrine disruption", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "Considered one of the safest surfactants available. Derived from coconut oil and glucose from corn. Readily biodegradable. EWG score 1. Approved for use in certified organic and natural products (COSMOS, Ecocert)."}',
  ARRAY[]::TEXT[],
  ARRAY['baby wash', 'facial cleanser', 'natural shampoo', 'organic body wash', 'sensitive skin products'],
  ARRAY['EWG', 'CIR', 'COSMOS', 'Ecocert']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lauryl Glucoside',
  'lauryl-glucoside',
  ARRAY['Lauryl polyglucose', 'Dodecyl glucoside', 'CAS 110615-47-9'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Very mild surfactant; low irritation potential", "chronic": "No significant chronic health concerns; readily biodegradable; plant-derived", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "Considered very safe. Derived from coconut and corn. Approved for certified organic formulations. CIR found safe as used. Excellent environmental profile with ready biodegradability."}',
  ARRAY[]::TEXT[],
  ARRAY['baby wash', 'facial cleanser', 'natural shampoo', 'organic body wash', 'intimate wash'],
  ARRAY['EWG', 'CIR', 'COSMOS', 'Ecocert']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Coco Glucoside',
  'coco-glucoside',
  ARRAY['Coconut glucoside', 'Coco polyglucose', 'CAS 110615-47-9', 'CAS 68515-73-1'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Very gentle; minimal irritation; suitable for the most sensitive skin types", "chronic": "No known chronic health effects; fully biodegradable; derived from renewable coconut and sugar sources", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "One of the gentlest surfactants available. COSMOS and Ecocert approved for organic products. EWG best rating. CIR found safe as used in cosmetics."}',
  ARRAY[]::TEXT[],
  ARRAY['baby products', 'facial cleanser', 'natural shampoo', 'organic body wash', 'micellar water'],
  ARRAY['EWG', 'CIR', 'COSMOS', 'Ecocert']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Cocoyl Isethionate',
  'sodium-cocoyl-isethionate',
  ARRAY['SCI', 'Cocoyl isethionate', 'CAS 61789-32-0', 'CAS 58969-27-0'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Very mild; often called the champagne of surfactants for its gentleness; minimal irritation", "chronic": "No significant chronic health concerns; well tolerated by sensitive and atopic skin; does not disrupt skin barrier like sulfates", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe as used. Widely regarded as one of the mildest synthetic surfactants. Derived from coconut oil. Used in Dove beauty bars since the 1950s. Excellent for sensitive skin formulations."}',
  ARRAY[]::TEXT[],
  ARRAY['beauty bars', 'shampoo bars', 'facial cleanser', 'baby wash', 'sensitive skin products'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Cocoyl Glutamate',
  'sodium-cocoyl-glutamate',
  ARRAY['Cocoyl glutamic acid sodium salt', 'Amisoft CS-11', 'CAS 68187-32-6'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Extremely mild; pH close to skin; virtually non-irritating", "chronic": "No significant chronic health concerns; amino acid-based surfactant with excellent skin compatibility; biodegradable", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "Amino acid-based surfactant derived from coconut oil and glutamic acid (an amino acid). CIR found safe. One of the mildest surfactants available. Approved for organic formulations."}',
  ARRAY[]::TEXT[],
  ARRAY['facial cleanser', 'baby wash', 'sensitive skin cleanser', 'premium shampoo', 'natural body wash'],
  ARRAY['EWG', 'CIR', 'COSMOS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Disodium Laureth Sulfosuccinate',
  'disodium-laureth-sulfosuccinate',
  ARRAY['DLSS', 'Disodium lauryl sulfosuccinate', 'CAS 39354-45-5', 'CAS 40754-59-4'],
  'surfactant',
  2,
  ARRAY['mild irritation potential', 'possible 1,4-dioxane trace contamination'],
  '{"acute": "Very mild surfactant; minimal skin and eye irritation; much gentler than sulfates", "chronic": "May contain trace 1,4-dioxane from ethoxylation but generally well tolerated; no significant chronic health concerns at typical use levels", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe as used in cosmetics. Considered a mild surfactant suitable for sensitive skin. Ethoxylated variant may contain traces of 1,4-dioxane."}',
  ARRAY['decyl glucoside', 'sodium cocoyl isethionate'],
  ARRAY['baby shampoo', 'gentle facial cleanser', 'sensitive skin body wash', 'bubble bath'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Lauroyl Sarcosinate',
  'sodium-lauroyl-sarcosinate',
  ARRAY['Sarkosyl NL', 'Lauroyl sarcosine sodium salt', 'CAS 137-16-6'],
  'surfactant',
  2,
  ARRAY['mild skin irritation', 'potential nitrosamine formation'],
  '{"acute": "Mild surfactant; low irritation potential; well tolerated by most skin types", "chronic": "Can theoretically form nitrosamines under certain conditions; generally considered safe at typical cosmetic concentrations; does not bioaccumulate", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved; must be nitrosamine-free", "notes": "CIR panel found safe when formulated to avoid nitrosamine formation. Amino acid-derived surfactant (from sarcosine). EU requires formulations to be free of nitrosamines."}',
  ARRAY['sodium cocoyl glutamate', 'decyl glucoside', 'sodium cocoyl isethionate'],
  ARRAY['toothpaste', 'shampoo', 'facial cleanser', 'shaving cream', 'body wash'],
  ARRAY['EWG', 'CIR', 'FDA', 'EU SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Methyl Cocoyl Taurate',
  'sodium-methyl-cocoyl-taurate',
  ARRAY['SMCT', 'Cocoyl methyl taurine sodium salt', 'CAS 12765-39-8'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Very mild; excellent skin and eye tolerance; minimal irritation even at higher concentrations", "chronic": "No significant chronic health concerns; amino acid-derived; biodegradable; excellent safety profile", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "Derived from taurine (amino acid) and coconut fatty acids. CIR found safe as used. Considered one of the mildest anionic surfactants. Popular in sulfate-free and gentle formulations."}',
  ARRAY[]::TEXT[],
  ARRAY['sulfate-free shampoo', 'gentle cleanser', 'baby wash', 'sensitive skin body wash'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cocamidopropyl Hydroxysultaine',
  'cocamidopropyl-hydroxysultaine',
  ARRAY['CAS 68139-30-0', 'Coco hydroxysultaine', 'Cocamidopropyl hydroxysulfobetaine'],
  'surfactant',
  2,
  ARRAY['mild sensitization potential'],
  '{"acute": "Very mild amphoteric surfactant; low irritation; good foam properties", "chronic": "Rare allergic contact dermatitis; generally well tolerated; may contain trace impurities from manufacturing", "vulnerable_groups": ["those with known surfactant sensitivities"]}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe as used in cosmetics. Amphoteric surfactant that is milder than cocamidopropyl betaine. Used as foam booster and viscosity builder."}',
  ARRAY['decyl glucoside', 'sodium cocoyl isethionate'],
  ARRAY['shampoo', 'body wash', 'facial cleanser', 'baby products', 'hand soap'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'PEG-80 Sorbitan Laurate',
  'peg-80-sorbitan-laurate',
  ARRAY['Polysorbate 80 variant', 'Polyoxyethylene sorbitan monolaurate', 'CAS 9005-64-5'],
  'surfactant',
  4,
  ARRAY['1,4-dioxane contamination', 'ethylene oxide contamination', 'skin sensitization'],
  '{"acute": "Generally mild; low irritation at typical concentrations", "chronic": "PEG compounds may be contaminated with 1,4-dioxane and ethylene oxide (both carcinogens) from ethoxylation process; may enhance skin penetration of other ingredients", "vulnerable_groups": ["those with damaged skin", "those with sensitive skin"]}',
  '{"fda": "approved", "eu": "approved; contamination levels monitored", "notes": "CIR panel found safe when manufactured to minimize ethylene oxide and 1,4-dioxane contamination. Should not be used on damaged or broken skin as it enhances penetration."}',
  ARRAY['sorbitan laurate (non-ethoxylated)', 'glyceryl laurate', 'plant-derived emulsifiers'],
  ARRAY['shampoo', 'body wash', 'cosmetics', 'pharmaceutical preparations'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'PEG-150 Distearate',
  'peg-150-distearate',
  ARRAY['Polyethylene glycol 150 distearate', 'PEG-6000 distearate', 'CAS 9005-08-7'],
  'surfactant',
  4,
  ARRAY['1,4-dioxane contamination', 'ethylene oxide contamination', 'enhanced skin penetration'],
  '{"acute": "Low irritation; used primarily as thickener and emulsifier", "chronic": "May contain 1,4-dioxane and ethylene oxide residues from manufacturing; high molecular weight PEGs are generally less concerning but contamination is the issue", "vulnerable_groups": ["those with damaged or broken skin"]}',
  '{"fda": "approved", "eu": "approved; contamination monitored", "notes": "CIR found PEGs safe when formulated to be non-irritating and manufactured to remove ethylene oxide and 1,4-dioxane. Higher molecular weight PEGs have less skin penetration."}',
  ARRAY['cetearyl alcohol', 'glyceryl stearate', 'plant-derived thickeners'],
  ARRAY['shampoo', 'conditioner', 'body wash', 'liquid soap'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Olefin Sulfonate',
  'olefin-sulfonate',
  ARRAY['Sodium C14-16 olefin sulfonate', 'AOS', 'Alpha olefin sulfonate', 'CAS 68439-57-6'],
  'surfactant',
  4,
  ARRAY['skin irritation', 'eye irritation', 'skin drying'],
  '{"acute": "Moderate skin and eye irritant; comparable to or slightly milder than SLS; good foaming properties", "chronic": "Can dry skin and disrupt barrier function with repeated use; less studied than SLS/SLES; no significant systemic toxicity concerns", "vulnerable_groups": ["those with eczema", "those with dry or sensitive skin"]}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR panel found safe as used in rinse-off products. Often marketed as sulfate-free alternative but can still be irritating. Petroleum-derived. Moderate environmental persistence."}',
  ARRAY['decyl glucoside', 'coco glucoside', 'sodium cocoyl isethionate'],
  ARRAY['sulfate-free shampoo', 'body wash', 'facial cleanser', 'hand soap'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ceteareth-20',
  'ceteareth-20',
  ARRAY['Cetearyl alcohol ethoxylated', 'PEG-20 cetearyl ether', 'Polyoxyethylene cetostearyl ether', 'CAS 68439-49-6'],
  'surfactant',
  4,
  ARRAY['1,4-dioxane contamination', 'ethylene oxide contamination', 'enhanced penetration'],
  '{"acute": "Low irritation potential at typical concentrations; used as emulsifier", "chronic": "May contain ethylene oxide and 1,4-dioxane residues from ethoxylation; enhances skin penetration of other ingredients; no inherent chronic toxicity concerns", "vulnerable_groups": ["those with damaged or broken skin"]}',
  '{"fda": "approved", "eu": "approved; contamination levels monitored", "notes": "CIR found safe when manufactured to minimize contaminants. Widely used nonionic emulsifier. Ethoxylated compounds carry inherent risk of 1,4-dioxane contamination."}',
  ARRAY['cetearyl alcohol', 'glyceryl stearate', 'plant-derived emulsifiers', 'cetearyl olivate'],
  ARRAY['moisturizer', 'conditioner', 'body lotion', 'cream', 'sunscreen'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Laureth-4',
  'laureth-4',
  ARRAY['Polyoxyethylene (4) lauryl ether', 'PEG-4 lauryl ether', 'CAS 5274-68-0', 'CAS 9002-92-0'],
  'surfactant',
  4,
  ARRAY['skin irritation', '1,4-dioxane contamination', 'enhanced skin penetration'],
  '{"acute": "Moderate skin irritant; more irritating than higher-ethoxylated laureths", "chronic": "Low molecular weight ethoxylated compound; may contain 1,4-dioxane; enhances skin absorption of other chemicals; can disrupt skin barrier", "vulnerable_groups": ["those with sensitive or damaged skin"]}',
  '{"fda": "approved", "eu": "approved", "notes": "CIR found safe as used in cosmetics. Lower ethoxylation number means greater skin penetration ability and higher irritation potential compared to laureth-23 etc."}',
  ARRAY['decyl glucoside', 'coco glucoside', 'plant-based emulsifiers'],
  ARRAY['shampoo', 'hair color', 'body wash', 'cleansing products'],
  ARRAY['EWG', 'CIR', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Nonylphenol Ethoxylate',
  'nonylphenol-ethoxylate',
  ARRAY['NPE', 'NPnEO', 'Nonoxynol', 'Polyoxyethylene nonylphenol', 'CAS 9016-45-9', 'CAS 26027-38-3'],
  'surfactant',
  9,
  ARRAY['endocrine disruption', 'aquatic toxicity', 'environmental persistence', 'reproductive toxicity'],
  '{"acute": "Skin and eye irritation; moderate acute toxicity to aquatic organisms", "chronic": "Degrades to nonylphenol, a potent xenoestrogen; bioaccumulates in aquatic food chains; linked to feminization of fish; reproductive and developmental toxicity in mammals; persistent environmental pollutant", "vulnerable_groups": ["aquatic ecosystems", "pregnant women", "developing fetuses", "children"]}',
  '{"fda": "not regulated in cosmetics specifically", "eu": "banned in most applications under REACH", "notes": "EU restricted under REACH since 2005. Listed as priority hazardous substance in EU Water Framework Directive. Banned in EU textile processing. Canada listed as toxic under CEPA. Still used in some US industrial and consumer products."}',
  ARRAY['alcohol ethoxylates', 'alkyl polyglucosides', 'decyl glucoside', 'coco glucoside'],
  ARRAY['industrial cleaners', 'laundry detergent', 'textile processing', 'pesticide formulations', 'some personal care products'],
  ARRAY['EPA', 'ECHA', 'Environment Canada', 'EWG', 'OSPAR Commission']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Octylphenol Ethoxylate',
  'octylphenol-ethoxylate',
  ARRAY['OPE', 'Triton X-100', 'Polyoxyethylene octylphenol', 'CAS 9002-93-1', 'CAS 9036-19-5'],
  'surfactant',
  9,
  ARRAY['endocrine disruption', 'aquatic toxicity', 'environmental persistence', 'reproductive toxicity'],
  '{"acute": "Skin and eye irritation; toxic to aquatic organisms", "chronic": "Degrades to octylphenol, a potent endocrine disruptor; bioaccumulates; causes reproductive harm in fish at very low concentrations; persistent in environment; estrogenic activity", "vulnerable_groups": ["aquatic ecosystems", "pregnant women", "developing fetuses"]}',
  '{"fda": "not specifically regulated in cosmetics", "eu": "restricted under REACH", "notes": "EU restricted under REACH. Identified as endocrine disruptor under EU Biocidal Products Regulation. OSPAR listed as chemical for priority action. Breaks down to persistent octylphenol in environment."}',
  ARRAY['alcohol ethoxylates', 'alkyl polyglucosides', 'decyl glucoside'],
  ARRAY['industrial cleaners', 'laboratory detergents', 'pesticide formulations', 'textile processing'],
  ARRAY['EPA', 'ECHA', 'OSPAR Commission', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Linear Alkylbenzene Sulfonate',
  'linear-alkylbenzene-sulfonate',
  ARRAY['LAS', 'LABS', 'Sodium dodecylbenzenesulfonate', 'CAS 25155-30-0', 'CAS 68411-30-3'],
  'surfactant',
  4,
  ARRAY['skin irritation', 'aquatic toxicity', 'eye irritation'],
  '{"acute": "Moderate skin and eye irritant; can cause contact dermatitis at higher concentrations", "chronic": "Biodegradable but toxic to aquatic organisms during degradation process; can cause chronic skin irritation and dryness; one of the most widely used surfactants globally", "vulnerable_groups": ["those with sensitive skin", "aquatic organisms"]}',
  '{"fda": "approved", "eu": "approved", "notes": "Most widely used anionic surfactant globally. Biodegradable (unlike branched-chain predecessors). EU allows use but monitors aquatic impact. EPA classifies as moderate toxicity to aquatic life."}',
  ARRAY['alkyl polyglucosides', 'sodium cocoyl isethionate', 'plant-based surfactants'],
  ARRAY['laundry detergent', 'dish soap', 'all-purpose cleaner', 'industrial cleaners'],
  ARRAY['EPA', 'ECHA', 'EWG', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Xylene Sulfonate',
  'sodium-xylene-sulfonate',
  ARRAY['SXS', 'Sodium xylenesulfonate', 'CAS 1300-72-7'],
  'surfactant',
  3,
  ARRAY['skin irritation', 'eye irritation'],
  '{"acute": "Mild to moderate skin and eye irritant; primarily used as hydrotrope (solubilizer) rather than cleanser", "chronic": "Limited chronic toxicity data; primarily functions as a coupling agent in formulations; biodegradable; low bioaccumulation potential", "vulnerable_groups": ["those with sensitive skin"]}',
  '{"fda": "approved", "eu": "approved", "notes": "Used primarily as a hydrotrope to improve solubility of other ingredients rather than as a primary surfactant. CIR data limited. Generally considered low hazard at typical use levels."}',
  ARRAY['sodium cumenesulfonate', 'plant-derived solubilizers', 'polysorbates'],
  ARRAY['liquid detergent', 'all-purpose cleaner', 'hand soap', 'shampoo'],
  ARRAY['EWG', 'EPA', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Sodium Toluene Sulfonate',
  'sodium-toluene-sulfonate',
  ARRAY['STS', 'Sodium toluenesulfonate', 'Sodium p-toluenesulfonate', 'CAS 12068-03-0', 'CAS 657-04-5'],
  'surfactant',
  3,
  ARRAY['skin irritation', 'eye irritation'],
  '{"acute": "Mild to moderate irritant; used as hydrotrope and coupling agent", "chronic": "Limited toxicological data; low systemic toxicity expected; primarily a formulation aid rather than active surfactant; biodegradable", "vulnerable_groups": ["those with sensitive skin"]}',
  '{"fda": "approved", "eu": "approved", "notes": "Functions as a hydrotrope to keep formulations stable. CIR panel found limited data but concluded low risk at typical use levels. Not a primary cleansing agent."}',
  ARRAY['sodium cumenesulfonate', 'plant-derived solubilizers'],
  ARRAY['liquid detergent', 'all-purpose cleaner', 'bleach formulations', 'industrial cleaners'],
  ARRAY['EWG', 'EPA', 'FDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Alkyl Polyglycosides',
  'alkyl-polyglycosides',
  ARRAY['APG', 'Alkyl polyglucoside', 'C8-16 alkyl polyglucoside', 'CAS 68515-73-1', 'CAS 110615-47-9'],
  'surfactant',
  1,
  ARRAY['minimal concerns'],
  '{"acute": "Very mild; low irritation; excellent skin tolerance; biodegradable", "chronic": "No significant chronic health concerns; derived from renewable resources (plant sugars and fatty alcohols); excellent environmental profile; readily biodegradable", "vulnerable_groups": []}',
  '{"fda": "approved", "eu": "approved", "notes": "Derived from renewable raw materials (glucose and fatty alcohols from coconut/palm). Readily and completely biodegradable. COSMOS and Ecocert approved. Considered among the safest surfactant class available."}',
  ARRAY[]::TEXT[],
  ARRAY['natural cleaners', 'organic personal care', 'baby products', 'eco-friendly detergent', 'agricultural adjuvants'],
  ARRAY['EWG', 'EPA DfE', 'COSMOS', 'Ecocert']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Glyphosate',
  'glyphosate',
  ARRAY['N-(phosphonomethyl)glycine', 'Roundup', 'glyphosate-isopropylamine salt', 'glyphosate-potassium salt', 'CAS 1071-83-6'],
  'pesticide',
  9,
  ARRAY['probable carcinogen', 'endocrine disruption', 'microbiome disruption', 'environmental persistence', 'water contamination'],
  '{"acute": "Skin and eye irritation, nausea, vomiting, diarrhea upon ingestion", "chronic": "Classified as probably carcinogenic to humans (IARC Group 2A), non-Hodgkin lymphoma risk, kidney and liver damage, disruption of gut microbiome, potential endocrine disruption", "vulnerable_groups": ["children", "pregnant women", "agricultural workers", "people with compromised immune systems"]}',
  '{"fda": "approved with tolerances", "eu": "approved until 2033 with restrictions", "iarc": "Group 2A probable carcinogen", "epa": "registered, not likely carcinogenic (disputed)", "notes": "Banned or restricted in over 30 countries. Subject of major litigation (Monsanto/Bayer lawsuits). EU renewal controversial."}',
  ARRAY['organic herbicides', 'vinegar-based weed killers', 'manual weeding', 'cover cropping', 'corn gluten meal'],
  ARRAY['conventional produce', 'cereals', 'oats', 'wheat products', 'lentils', 'chickpeas', 'soy products', 'municipal water'],
  ARRAY['IARC', 'WHO', 'EPA', 'EFSA', 'EWG', 'USDA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Chlorpyrifos',
  'chlorpyrifos',
  ARRAY['O,O-diethyl O-3,5,6-trichloro-2-pyridyl phosphorothioate', 'Dursban', 'Lorsban', 'CAS 2921-88-2'],
  'pesticide',
  10,
  ARRAY['neurotoxin', 'developmental neurotoxicity', 'cholinesterase inhibitor', 'endocrine disruption', 'water contamination'],
  '{"acute": "Nausea, dizziness, confusion, muscle twitching, excessive salivation, respiratory distress; severe exposure can cause seizures and death", "chronic": "Irreversible brain damage in children, reduced IQ, attention deficits, autism spectrum associations, Parkinson''s disease risk, endocrine disruption, immune system suppression", "vulnerable_groups": ["children", "infants", "pregnant women", "farmworkers"]}',
  '{"fda": "banned for food use (2022)", "eu": "banned (2020)", "epa": "revoked all food tolerances (2022)", "notes": "Banned from all food uses in the US and EU. One of the most studied and harmful organophosphate pesticides. Still used in some developing countries."}',
  ARRAY['organic pest management', 'integrated pest management (IPM)', 'neem oil', 'Bacillus thuringiensis (Bt)', 'beneficial insects'],
  ARRAY['conventional fruits', 'conventional vegetables', 'golf courses', 'non-organic apples', 'non-organic citrus'],
  ARRAY['EPA', 'EFSA', 'WHO', 'Columbia University studies', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Atrazine',
  'atrazine',
  ARRAY['2-chloro-4-ethylamino-6-isopropylamino-1,3,5-triazine', 'Aatrex', 'Gesaprim', 'CAS 1912-24-9'],
  'pesticide',
  9,
  ARRAY['endocrine disruption', 'water contamination', 'reproductive toxicity', 'probable carcinogen', 'amphibian harm'],
  '{"acute": "Skin and eye irritation, nausea, diarrhea, respiratory irritation upon inhalation", "chronic": "Potent endocrine disruptor at extremely low doses (0.1 ppb), feminization of male frogs, prostate cancer risk, breast cancer risk, reproductive abnormalities, birth defects, thyroid disruption", "vulnerable_groups": ["pregnant women", "infants", "children", "agricultural communities"]}',
  '{"fda": "approved with tolerances", "eu": "banned (2004)", "epa": "registered, under review", "notes": "Banned in EU since 2004 due to groundwater contamination. One of the most commonly detected pesticides in US drinking water. Manufacturer Syngenta settled lawsuits over water contamination."}',
  ARRAY['organic farming practices', 'cover crops', 'crop rotation', 'mechanical cultivation', 'organic corn'],
  ARRAY['corn', 'sorghum', 'sugarcane', 'municipal drinking water', 'well water near farms'],
  ARRAY['EPA', 'EFSA', 'Tyrone Hayes UC Berkeley research', 'NRDC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  '2,4-Dichlorophenoxyacetic Acid',
  '2-4-d',
  ARRAY['2,4-D', '2,4-dichlorophenoxyacetic acid', 'Weedone', 'Agent Orange component', 'CAS 94-75-7'],
  'pesticide',
  8,
  ARRAY['possible carcinogen', 'endocrine disruption', 'neurotoxicity', 'reproductive toxicity', 'environmental contamination'],
  '{"acute": "Skin and eye irritation, nausea, vomiting, diarrhea, headache, confusion, muscle twitching", "chronic": "Possible carcinogen (IARC Group 2B), non-Hodgkin lymphoma association, soft tissue sarcoma risk, thyroid disruption, reproductive effects, neurotoxicity in chronic exposure", "vulnerable_groups": ["children", "pregnant women", "farmworkers", "pet owners (lawn applications)"]}',
  '{"fda": "approved with tolerances", "eu": "approved with restrictions", "iarc": "Group 2B possibly carcinogenic", "epa": "registered", "notes": "One of the oldest and most widely used herbicides. Was a component of Agent Orange (in contaminated form with dioxin). Widely used on lawns, grain crops, and pastures."}',
  ARRAY['organic weed control', 'vinegar-based herbicides', 'manual weeding', 'corn gluten meal', 'mulching'],
  ARRAY['conventional wheat', 'lawns', 'pastures', 'residential yards', 'grain crops', 'rights-of-way'],
  ARRAY['IARC', 'EPA', 'EFSA', 'NTP', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Malathion',
  'malathion',
  ARRAY['diethyl 2-dimethoxyphosphinothioylsulfanylbutanedioate', 'Maldison', 'carbophos', 'CAS 121-75-5', 'organophosphate'],
  'pesticide',
  7,
  ARRAY['cholinesterase inhibitor', 'possible carcinogen', 'neurotoxicity', 'respiratory irritant', 'environmental toxicity'],
  '{"acute": "Nausea, vomiting, diarrhea, headache, dizziness, excessive sweating, muscle twitching, difficulty breathing", "chronic": "Possible carcinogen (IARC Group 2A), cholinesterase inhibition, neurobehavioral effects, potential endocrine disruption, immune system effects", "vulnerable_groups": ["children", "pregnant women", "farmworkers", "people with respiratory conditions"]}',
  '{"fda": "approved with tolerances", "eu": "not approved (2008)", "iarc": "Group 2A probably carcinogenic", "epa": "registered", "notes": "Widely used in agriculture and public health mosquito control programs. No longer approved in the EU. IARC upgraded classification to probably carcinogenic in 2015."}',
  ARRAY['organic pest management', 'neem oil', 'insecticidal soaps', 'Bacillus thuringiensis (Bt)', 'diatomaceous earth'],
  ARRAY['conventional fruits', 'conventional vegetables', 'mosquito control spraying', 'stored grain', 'head lice treatments'],
  ARRAY['IARC', 'EPA', 'WHO', 'EFSA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diazinon',
  'diazinon',
  ARRAY['O,O-diethyl O-[4-methyl-6-(propan-2-yl)pyrimidin-2-yl] phosphorothioate', 'Basudin', 'Spectracide', 'CAS 333-41-5'],
  'pesticide',
  8,
  ARRAY['cholinesterase inhibitor', 'neurotoxicity', 'water contamination', 'wildlife toxicity', 'endocrine disruption'],
  '{"acute": "Headache, nausea, vomiting, abdominal cramps, diarrhea, blurred vision, muscle twitching, respiratory distress", "chronic": "Cholinesterase inhibition, neurobehavioral effects, potential reproductive toxicity, immune system suppression, possible link to leukemia in children", "vulnerable_groups": ["children", "infants", "pregnant women", "farmworkers"]}',
  '{"fda": "banned for residential use (2004), restricted agricultural use", "eu": "not approved", "epa": "residential use banned 2004, agricultural phaseout ongoing", "notes": "Banned for home and garden use in the US since 2004. Phased out of most agricultural uses. Highly toxic to aquatic organisms and birds."}',
  ARRAY['organic pest management', 'integrated pest management', 'beneficial insects', 'neem oil', 'pyrethrin (natural)'],
  ARRAY['conventional crops (historical)', 'residential lawns (historical)', 'pet flea products (historical)', 'imported produce'],
  ARRAY['EPA', 'EFSA', 'WHO', 'NPIC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Carbaryl',
  'carbaryl',
  ARRAY['1-naphthyl methylcarbamate', 'Sevin', 'CAS 63-25-2', 'carbamate insecticide'],
  'pesticide',
  7,
  ARRAY['cholinesterase inhibitor', 'possible carcinogen', 'endocrine disruption', 'reproductive toxicity', 'bee toxicity'],
  '{"acute": "Nausea, vomiting, diarrhea, excessive salivation, sweating, blurred vision, muscle weakness, respiratory distress", "chronic": "Possible carcinogen (EPA Group C), cholinesterase inhibition, endocrine disruption, reproductive effects including reduced sperm quality, immune suppression", "vulnerable_groups": ["children", "pregnant women", "farmworkers", "beekeepers"]}',
  '{"fda": "approved with tolerances", "eu": "not approved (2007)", "epa": "registered, classified as likely carcinogen", "notes": "One of the most widely used carbamate insecticides. Not approved in EU. EPA classifies as likely carcinogenic. Highly toxic to bees and aquatic invertebrates."}',
  ARRAY['organic pest management', 'neem oil', 'Bacillus thuringiensis (Bt)', 'insecticidal soap', 'row covers'],
  ARRAY['conventional fruits', 'conventional vegetables', 'garden insecticides', 'lawn care products', 'pet flea powders (historical)'],
  ARRAY['EPA', 'EFSA', 'WHO', 'NPIC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Permethrin',
  'permethrin',
  ARRAY['3-phenoxybenzyl (1RS)-cis,trans-3-(2,2-dichlorovinyl)-2,2-dimethylcyclopropanecarboxylate', 'CAS 52645-53-1', 'Nix', 'Elimite', 'synthetic pyrethroid'],
  'pesticide',
  6,
  ARRAY['neurotoxicity', 'endocrine disruption', 'cat toxicity', 'aquatic toxicity', 'possible carcinogen'],
  '{"acute": "Skin tingling and burning, itching, numbness, headache, nausea, dizziness; highly toxic to cats", "chronic": "Possible carcinogen (EPA Group C), endocrine disruption, neurodevelopmental effects in children, potential link to ADHD and behavioral issues, Parkinson''s disease association", "vulnerable_groups": ["children", "cats (lethal)", "pregnant women", "aquatic organisms"]}',
  '{"fda": "approved for topical lice/scabies treatment", "eu": "approved with restrictions", "epa": "registered, possible carcinogen", "notes": "Widely used synthetic pyrethroid. FDA-approved for lice and scabies. Extremely toxic to cats. Common in treated clothing and mosquito nets."}',
  ARRAY['natural pyrethrin', 'neem oil', 'diatomaceous earth', 'essential oil repellents (citronella, lemongrass)', 'manual removal (for lice)'],
  ARRAY['lice treatments', 'scabies treatments', 'insect repellent clothing', 'mosquito nets', 'garden sprays', 'flea treatments (dogs only)'],
  ARRAY['EPA', 'FDA', 'WHO', 'NPIC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cypermethrin',
  'cypermethrin',
  ARRAY['(RS)-alpha-cyano-3-phenoxybenzyl (1RS)-cis,trans-3-(2,2-dichlorovinyl)-2,2-dimethylcyclopropanecarboxylate', 'CAS 52315-07-8', 'Demon', 'Cynoff', 'synthetic pyrethroid'],
  'pesticide',
  7,
  ARRAY['neurotoxicity', 'endocrine disruption', 'reproductive toxicity', 'aquatic toxicity', 'possible carcinogen'],
  '{"acute": "Skin and eye irritation, tingling, numbness, headache, nausea, dizziness, tremors at high exposure", "chronic": "Possible carcinogen, endocrine disruption, neurotoxicity, potential reproductive effects, immunotoxicity, developmental toxicity", "vulnerable_groups": ["children", "pregnant women", "cats", "aquatic organisms", "farmworkers"]}',
  '{"fda": "tolerances established for food crops", "eu": "approved with restrictions", "epa": "registered, possible carcinogen", "notes": "Widely used in agriculture and residential pest control. More toxic than permethrin. Extremely toxic to fish and aquatic invertebrates."}',
  ARRAY['neem oil', 'Bacillus thuringiensis (Bt)', 'diatomaceous earth', 'integrated pest management', 'beneficial insects'],
  ARRAY['conventional cotton', 'conventional vegetables', 'household insect sprays', 'ant and roach killers', 'professional pest control'],
  ARRAY['EPA', 'WHO', 'EFSA', 'NPIC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Bifenthrin',
  'bifenthrin',
  ARRAY['2-methylbiphenyl-3-ylmethyl (Z)-(1RS)-cis-3-(2-chloro-3,3,3-trifluoroprop-1-enyl)-2,2-dimethylcyclopropanecarboxylate', 'CAS 82657-04-3', 'Talstar', 'Brigade', 'synthetic pyrethroid'],
  'pesticide',
  7,
  ARRAY['neurotoxicity', 'possible carcinogen', 'endocrine disruption', 'aquatic toxicity', 'environmental persistence'],
  '{"acute": "Skin tingling and irritation, headache, dizziness, nausea, tremors at high doses", "chronic": "Possible carcinogen (EPA), endocrine disruption, neurodevelopmental effects, highly persistent in soil and sediment, bioaccumulative potential", "vulnerable_groups": ["children", "pregnant women", "cats", "aquatic organisms"]}',
  '{"fda": "tolerances established", "eu": "not approved", "epa": "registered, possible carcinogen (Group C)", "notes": "Not approved in the EU. Very persistent in the environment. One of the most commonly detected pyrethroids in urban waterways. Extremely toxic to fish."}',
  ARRAY['organic pest management', 'neem oil', 'diatomaceous earth', 'boric acid (for indoor pests)', 'beneficial nematodes'],
  ARRAY['lawn and garden insecticides', 'termite treatments', 'professional pest control', 'conventional produce', 'fire ant treatments'],
  ARRAY['EPA', 'EFSA', 'NPIC', 'USGS', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Imidacloprid',
  'imidacloprid',
  ARRAY['1-(6-chloro-3-pyridylmethyl)-N-nitroimidazolidin-2-ylideneamine', 'CAS 138261-41-3', 'Admire', 'Gaucho', 'Confidor', 'Merit', 'neonicotinoid'],
  'pesticide',
  7,
  ARRAY['pollinator toxicity', 'neurotoxicity', 'water contamination', 'endocrine disruption', 'environmental persistence'],
  '{"acute": "Nausea, vomiting, headache, dizziness, disorientation, tremors in severe cases", "chronic": "Neurotoxicity, potential developmental neurotoxicity in children, thyroid disruption, reduced fertility, highly toxic to bees and pollinators contributing to colony collapse disorder", "vulnerable_groups": ["children", "pregnant women", "bees and pollinators", "aquatic invertebrates"]}',
  '{"fda": "tolerances established", "eu": "banned for outdoor use (2018)", "epa": "registered, under review", "notes": "Banned for all outdoor uses in the EU since 2018 due to unacceptable risk to bees. Most widely used insecticide worldwide. Major contributor to pollinator decline."}',
  ARRAY['organic pest management', 'neem oil', 'Bacillus thuringiensis (Bt)', 'beneficial insects', 'crop rotation'],
  ARRAY['conventional produce', 'seed treatments', 'lawn care products', 'flea treatments for pets', 'tree injections'],
  ARRAY['EFSA', 'EPA', 'WHO', 'Task Force on Systemic Pesticides', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Thiamethoxam',
  'thiamethoxam',
  ARRAY['3-(2-chloro-1,3-thiazol-5-ylmethyl)-5-methyl-1,3,5-oxadiazinan-4-ylidene(nitro)amine', 'CAS 153719-23-4', 'Actara', 'Cruiser', 'Platinum', 'neonicotinoid'],
  'pesticide',
  7,
  ARRAY['pollinator toxicity', 'water contamination', 'endocrine disruption', 'environmental persistence', 'neurotoxicity'],
  '{"acute": "Nausea, headache, dizziness, tremors, fatigue; relatively low acute toxicity to mammals", "chronic": "Liver toxicity, potential carcinogenicity, thyroid disruption, reproductive effects, devastating toxicity to bees and pollinators, neurodevelopmental concerns", "vulnerable_groups": ["children", "pregnant women", "bees and pollinators", "aquatic organisms"]}',
  '{"fda": "tolerances established", "eu": "banned for outdoor use (2018)", "epa": "registered, under biological evaluation", "notes": "Banned for outdoor use in EU alongside imidacloprid and clothianidin. Converts to clothianidin in the environment. Widely detected in surface and groundwater."}',
  ARRAY['organic farming', 'integrated pest management', 'beneficial insects', 'neem oil', 'crop rotation'],
  ARRAY['seed treatments', 'conventional crops', 'foliar sprays', 'soil treatments', 'greenhouse applications'],
  ARRAY['EFSA', 'EPA', 'WHO', 'Task Force on Systemic Pesticides', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Clothianidin',
  'clothianidin',
  ARRAY['(E)-1-(2-chloro-1,3-thiazol-5-ylmethyl)-3-methyl-2-nitroguanidine', 'CAS 210880-92-5', 'Poncho', 'Clutch', 'Belay', 'neonicotinoid'],
  'pesticide',
  7,
  ARRAY['pollinator toxicity', 'neurotoxicity', 'water contamination', 'environmental persistence', 'reproductive toxicity'],
  '{"acute": "Headache, nausea, dizziness, fatigue; relatively low acute mammalian toxicity", "chronic": "Developmental neurotoxicity, liver effects, reproductive toxicity, potential carcinogenicity, extremely toxic to bees and aquatic invertebrates, persistent in soil for years", "vulnerable_groups": ["children", "pregnant women", "bees and pollinators", "aquatic organisms"]}',
  '{"fda": "tolerances established", "eu": "banned for outdoor use (2018)", "epa": "registered, under review", "notes": "Banned for outdoor use in EU since 2018. Metabolite of thiamethoxam. Extremely persistent in soil (half-life up to 1,386 days). Key driver of pollinator decline."}',
  ARRAY['organic farming', 'cover crops', 'beneficial insects', 'Bacillus thuringiensis (Bt)', 'integrated pest management'],
  ARRAY['corn seed treatments', 'canola seed treatments', 'cereal crops', 'sugar beets', 'turf grass'],
  ARRAY['EFSA', 'EPA', 'WHO', 'Task Force on Systemic Pesticides', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Fipronil',
  'fipronil',
  ARRAY['5-amino-1-[2,6-dichloro-4-(trifluoromethyl)phenyl]-4-[(trifluoromethyl)sulfinyl]pyrazole-3-carbonitrile', 'CAS 120068-37-3', 'Frontline', 'Regent', 'Termidor', 'phenylpyrazole'],
  'pesticide',
  7,
  ARRAY['neurotoxicity', 'endocrine disruption', 'thyroid disruption', 'environmental persistence', 'aquatic toxicity'],
  '{"acute": "Headache, dizziness, nausea, vomiting, seizures in severe poisoning cases", "chronic": "Thyroid tumors in animal studies, liver toxicity, neurotoxicity, potential carcinogen (EPA Group C), reproductive effects, highly toxic to bees and aquatic organisms", "vulnerable_groups": ["children", "pregnant women", "bees", "aquatic organisms", "cats (sensitive)"]}',
  '{"fda": "not approved for food-producing animals", "eu": "banned for crop use, restricted for biocides", "epa": "registered, possible carcinogen", "notes": "Caused major food safety scandal in 2017 (EU egg contamination). Banned for crop use in EU. Still widely used in pet flea treatments and termite control in the US."}',
  ARRAY['essential oil flea treatments', 'diatomaceous earth', 'flea combs', 'beneficial nematodes (for lawns)', 'borate termite treatments'],
  ARRAY['pet flea and tick treatments', 'termite treatments', 'roach baits', 'turf insecticides', 'conventional rice (some regions)'],
  ARRAY['EPA', 'EFSA', 'WHO', 'NPIC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Metolachlor',
  'metolachlor',
  ARRAY['2-chloro-N-(2-ethyl-6-methylphenyl)-N-(2-methoxy-1-methylethyl)acetamide', 'CAS 51218-45-2', 'Dual', 'Dual Magnum', 'S-metolachlor', 'CAS 87392-12-9'],
  'pesticide',
  6,
  ARRAY['water contamination', 'possible carcinogen', 'endocrine disruption', 'liver toxicity', 'environmental persistence'],
  '{"acute": "Skin and eye irritation, nausea, vomiting; moderate acute toxicity", "chronic": "Possible carcinogen (EPA Group C), liver tumors in animal studies, potential endocrine disruption, chronic liver and kidney effects, widespread groundwater contamination", "vulnerable_groups": ["children", "pregnant women", "agricultural communities", "people relying on well water"]}',
  '{"fda": "tolerances established", "eu": "S-metolachlor approved with restrictions", "epa": "registered, possible carcinogen", "notes": "One of the most heavily used herbicides in the US. Frequently detected in groundwater and surface water. S-metolachlor is the refined isomer used more commonly today."}',
  ARRAY['organic weed management', 'cover crops', 'crop rotation', 'mechanical cultivation', 'mulching'],
  ARRAY['corn', 'soybeans', 'sorghum', 'peanuts', 'municipal water supplies'],
  ARRAY['EPA', 'EFSA', 'USGS', 'NPIC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Dicamba',
  'dicamba',
  ARRAY['3,6-dichloro-2-methoxybenzoic acid', 'CAS 1918-00-9', 'Banvel', 'Clarity', 'XtendiMax', 'Engenia'],
  'pesticide',
  7,
  ARRAY['drift damage', 'water contamination', 'endocrine disruption', 'possible carcinogen', 'reproductive toxicity'],
  '{"acute": "Skin and eye irritation, nausea, vomiting, diarrhea, muscle twitching, shortness of breath", "chronic": "Possible carcinogen, liver and kidney effects, reproductive toxicity, potential developmental effects, thyroid disruption", "vulnerable_groups": ["children", "pregnant women", "neighboring farmers (drift)", "rural communities"]}',
  '{"fda": "tolerances established", "eu": "not approved", "epa": "registered, subject to ongoing litigation", "notes": "Controversial due to massive off-target drift damage to millions of acres of crops. Court vacated EPA registration in 2020 but it was re-registered. Not approved in EU. Paired with dicamba-tolerant GMO crops."}',
  ARRAY['organic weed management', 'cover crops', 'mechanical cultivation', 'mulching', 'flame weeding'],
  ARRAY['dicamba-tolerant soybeans', 'dicamba-tolerant cotton', 'corn', 'small grains', 'pastures'],
  ARRAY['EPA', 'EFSA', 'NPIC', 'Center for Biological Diversity', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Paraquat',
  'paraquat',
  ARRAY['1,1''-dimethyl-4,4''-bipyridinium dichloride', 'methyl viologen', 'Gramoxone', 'CAS 1910-42-5', 'paraquat dichloride'],
  'pesticide',
  10,
  ARRAY['extreme acute toxicity', 'Parkinson''s disease link', 'pulmonary fibrosis', 'no antidote', 'suicidal poisoning risk'],
  '{"acute": "Extremely toxic: ingestion of even small amounts (10-15 mL) is usually fatal. Causes severe oral and GI burns, progressive pulmonary fibrosis, multi-organ failure. No antidote exists.", "chronic": "Strong association with Parkinson''s disease (2.5x increased risk), progressive lung damage, liver and kidney damage, skin damage from chronic dermal exposure", "vulnerable_groups": ["farmworkers", "children", "anyone exposed (no safe dose for ingestion)", "rural communities in developing countries"]}',
  '{"fda": "restricted use pesticide (certified applicators only)", "eu": "banned (2007)", "epa": "registered, restricted use only", "notes": "Banned in over 60 countries including the EU, China, Brazil, and Switzerland. Still used in the US under restricted use. One sip can be fatal. Subject of major Parkinson''s disease litigation against Syngenta."}',
  ARRAY['organic herbicides', 'manual weeding', 'cover crops', 'vinegar-based weed killers', 'flame weeding'],
  ARRAY['conventional crops (application only)', 'herbicide-resistant crop systems', 'orchard floor management', 'desiccation of crops pre-harvest'],
  ARRAY['EPA', 'WHO', 'EFSA', 'NIH', 'Michael J. Fox Foundation']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Diquat',
  'diquat',
  ARRAY['6,7-dihydrodipyrido[1,2-a:2'',1''-c]pyrazinediium dibromide', 'diquat dibromide', 'Reglone', 'CAS 85-00-7', 'CAS 2764-72-9'],
  'pesticide',
  8,
  ARRAY['acute toxicity', 'eye damage', 'kidney damage', 'gastrointestinal damage', 'no antidote'],
  '{"acute": "Severe GI irritation, nausea, vomiting, diarrhea; severe poisoning causes kidney failure, liver damage, cataract formation, respiratory distress. Can be fatal.", "chronic": "Cataract formation, chronic kidney damage, liver effects, potential neurotoxicity, skin sensitization from repeated exposure", "vulnerable_groups": ["children", "farmworkers", "people with pre-existing kidney or liver conditions"]}',
  '{"fda": "restricted use pesticide", "eu": "not approved (2019)", "epa": "registered, restricted use", "notes": "Not approved in the EU since 2019. Restricted use pesticide in the US. Less toxic than paraquat but still highly dangerous. Used as pre-harvest desiccant on some crops."}',
  ARRAY['organic farming', 'cover cropping', 'mechanical harvest preparation', 'vinegar-based herbicides', 'flame weeding'],
  ARRAY['pre-harvest crop desiccation', 'aquatic weed control', 'potato desiccation', 'seed crop desiccation', 'conventional potatoes'],
  ARRAY['EPA', 'EFSA', 'WHO', 'NPIC', 'Extension Toxicology Network']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Chlorothalonil',
  'chlorothalonil',
  ARRAY['2,4,5,6-tetrachloroisophthalonitrile', 'CAS 1897-45-6', 'Bravo', 'Daconil', 'Echo'],
  'pesticide',
  8,
  ARRAY['probable carcinogen', 'water contamination', 'kidney toxicity', 'environmental persistence', 'aquatic toxicity'],
  '{"acute": "Severe skin and eye irritation, allergic dermatitis, respiratory irritation, nausea", "chronic": "Probable carcinogen (EPA Group B2), kidney tumors and damage, stomach tumors in animal studies, skin sensitization, potential endocrine disruption", "vulnerable_groups": ["children", "pregnant women", "farmworkers", "people with kidney disease", "aquatic organisms"]}',
  '{"fda": "tolerances established", "eu": "banned (2019)", "epa": "registered, probable carcinogen (Group B2)", "notes": "Banned in EU since 2019 due to groundwater contamination and carcinogenicity concerns. One of the most heavily used fungicides in the US. Metabolite SDS-3701 is more toxic than parent compound and widespread in groundwater."}',
  ARRAY['organic fungicides (copper-based)', 'sulfur-based fungicides', 'neem oil', 'crop rotation', 'disease-resistant varieties'],
  ARRAY['conventional potatoes', 'peanuts', 'tomatoes', 'golf courses', 'lawns', 'ornamental plants'],
  ARRAY['EPA', 'EFSA', 'WHO', 'IARC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Mancozeb',
  'mancozeb',
  ARRAY['manganese ethylenebis(dithiocarbamate) polymeric complex with zinc salt', 'CAS 8018-01-7', 'Dithane', 'Manzate', 'Penncozeb', 'EBDC fungicide'],
  'pesticide',
  7,
  ARRAY['thyroid disruption', 'possible carcinogen', 'developmental toxicity', 'neurotoxicity', 'ETU metabolite concerns'],
  '{"acute": "Skin and eye irritation, allergic dermatitis, respiratory irritation", "chronic": "Thyroid disruption (ETU metabolite), possible carcinogen, developmental and reproductive toxicity, neurotoxicity, Parkinson''s disease association, ETU metabolite classified as probable carcinogen", "vulnerable_groups": ["children", "pregnant women", "farmworkers", "people with thyroid conditions"]}',
  '{"fda": "tolerances established", "eu": "not approved (2021)", "epa": "registered, under review", "notes": "Not renewed in the EU in 2021 due to concerns about ETU metabolite, endocrine disruption, and developmental toxicity. ETU (ethylenethiourea) metabolite is more toxic than mancozeb itself. Still widely used in the US and developing countries."}',
  ARRAY['copper-based fungicides', 'sulfur-based fungicides', 'neem oil', 'biological fungicides (Bacillus)', 'disease-resistant crop varieties'],
  ARRAY['conventional potatoes', 'tomatoes', 'grapes', 'apples', 'bananas', 'ornamental plants'],
  ARRAY['EPA', 'EFSA', 'WHO', 'IARC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Lead',
  'lead',
  ARRAY['Pb', 'plumbum', 'lead(II)', 'CAS 7439-92-1', 'lead acetate', 'lead chromate'],
  'heavy_metal',
  10,
  ARRAY['neurotoxicity', 'developmental toxicity', 'no safe level', 'reproductive toxicity', 'cardiovascular effects'],
  '{"acute": "Abdominal pain, vomiting, constipation, fatigue, headache, encephalopathy and seizures at high levels, coma and death in severe cases", "chronic": "Irreversible neurodevelopmental damage in children (reduced IQ, learning disabilities, behavioral problems), kidney damage, cardiovascular disease, hypertension, reproductive toxicity, anemia, no safe blood lead level exists", "vulnerable_groups": ["children (especially under 6)", "pregnant women", "fetuses", "occupationally exposed workers"]}',
  '{"fda": "action levels for food and cosmetics", "eu": "restricted under REACH", "epa": "maximum contaminant level 15 ppb in drinking water (action level)", "cdc": "blood lead reference value 3.5 mcg/dL for children", "notes": "No safe level of lead exposure. Banned in gasoline (1996), residential paint (1978), and plumbing solder (1986) in the US. Still found in old housing, some imported goods, and contaminated water systems."}',
  ARRAY['lead-free paints', 'lead-free plumbing', 'certified lead-free products', 'NSF-certified water filters', 'stainless steel or glass cookware'],
  ARRAY['old paint (pre-1978)', 'contaminated water (lead pipes)', 'imported spices', 'some cosmetics (kohl/kajal)', 'pottery glazes', 'vintage toys', 'contaminated soil', 'some candies (imported)'],
  ARRAY['CDC', 'EPA', 'WHO', 'FDA', 'AAP']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Mercury (Methylmercury)',
  'methylmercury',
  ARRAY['MeHg', 'methylmercury', 'Hg', 'mercury', 'organic mercury', 'CAS 22967-92-6', 'monomethylmercury'],
  'heavy_metal',
  10,
  ARRAY['neurotoxicity', 'developmental neurotoxicity', 'bioaccumulation', 'reproductive toxicity', 'kidney damage'],
  '{"acute": "Numbness, tingling in extremities, impaired vision and hearing, difficulty walking and speaking, muscle weakness, death in severe cases (Minamata disease)", "chronic": "Permanent neurological damage, cognitive impairment, tremors, memory loss, severe fetal neurodevelopmental damage (microcephaly, cerebral palsy, intellectual disability), cardiovascular effects, kidney damage, immune suppression", "vulnerable_groups": ["fetuses", "infants", "pregnant women", "nursing mothers", "children", "subsistence fish consumers"]}',
  '{"fda": "action level 1 ppm in fish, advisory for pregnant women", "eu": "maximum levels in food established", "epa": "reference dose 0.1 mcg/kg/day, mercury maximum contaminant level 2 ppb in water", "notes": "Minamata Convention on Mercury (2017) is a global treaty to protect human health. FDA advises pregnant women to limit certain fish consumption. Mercury in dental amalgam remains controversial."}',
  ARRAY['low-mercury fish (salmon, sardines, tilapia)', 'wild Alaska salmon', 'composite dental fillings', 'LED lighting', 'digital thermometers'],
  ARRAY['large predatory fish (shark, swordfish, king mackerel, tilefish)', 'tuna (especially bigeye)', 'dental amalgam fillings', 'CFL bulbs', 'some skin-lightening creams', 'contaminated rice'],
  ARRAY['FDA', 'EPA', 'WHO', 'EFSA', 'Minamata Convention']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cadmium',
  'cadmium',
  ARRAY['Cd', 'CAS 7440-43-9', 'cadmium chloride', 'cadmium oxide', 'cadmium sulfate'],
  'heavy_metal',
  9,
  ARRAY['known carcinogen', 'kidney damage', 'bone damage', 'bioaccumulation', 'reproductive toxicity'],
  '{"acute": "Inhalation: severe lung damage, pulmonary edema, death. Ingestion: severe nausea, vomiting, abdominal cramps, diarrhea, kidney failure", "chronic": "Known human carcinogen (IARC Group 1), lung cancer, prostate cancer, kidney tubular damage (itai-itai disease), osteoporosis and bone fractures, cardiovascular disease, reproductive toxicity, 10-30 year biological half-life in kidneys", "vulnerable_groups": ["smokers (tobacco concentrates cadmium)", "women (higher absorption)", "children", "people with iron or calcium deficiency", "occupationally exposed workers"]}',
  '{"fda": "action levels for some foods", "eu": "maximum levels in food established under REACH", "iarc": "Group 1 known carcinogen", "epa": "maximum contaminant level 5 ppb in water", "notes": "IARC Group 1 carcinogen. Major source is tobacco smoke. Also found in chocolate, rice, and root vegetables grown in contaminated soil. EU restricts cadmium in fertilizers."}',
  ARRAY['cadmium-free pigments', 'nickel-metal hydride batteries', 'organic produce (lower cadmium)', 'water filtration with reverse osmosis'],
  ARRAY['tobacco smoke', 'chocolate', 'rice', 'root vegetables', 'shellfish', 'kidney and liver meats', 'NiCd batteries', 'artist pigments', 'some jewelry'],
  ARRAY['IARC', 'EPA', 'WHO', 'EFSA', 'ATSDR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Arsenic (Inorganic)',
  'inorganic-arsenic',
  ARRAY['As', 'arsenic trioxide', 'arsenite', 'arsenate', 'CAS 7440-38-2', 'inorganic arsenic', 'white arsenic'],
  'heavy_metal',
  10,
  ARRAY['known carcinogen', 'cardiovascular toxicity', 'developmental toxicity', 'diabetes risk', 'water contamination'],
  '{"acute": "Severe GI symptoms (bloody diarrhea, vomiting), cardiovascular collapse, multi-organ failure, death; historically used as a poison", "chronic": "Known human carcinogen (IARC Group 1): lung, bladder, skin, liver, kidney cancers. Skin lesions and hyperpigmentation, peripheral neuropathy, cardiovascular disease, type 2 diabetes, immunosuppression, developmental effects including reduced IQ", "vulnerable_groups": ["children (especially infants consuming rice cereal)", "pregnant women", "people in areas with naturally high arsenic in groundwater", "communities near mining or smelting sites"]}',
  '{"fda": "action level 100 ppb for apple juice, 100 ppb for infant rice cereal", "eu": "maximum levels in food established", "iarc": "Group 1 known carcinogen", "epa": "maximum contaminant level 10 ppb in drinking water", "notes": "IARC Group 1 carcinogen. Naturally occurring in groundwater in many regions. Rice is a significant source due to paddy field growing conditions. FDA set action levels for rice and apple juice."}',
  ARRAY['oat-based infant cereals (lower arsenic)', 'water filtration (reverse osmosis)', 'diverse grain diet', 'rinsing rice before cooking', 'cooking rice in excess water'],
  ARRAY['rice and rice products', 'rice cereal for infants', 'apple juice', 'drinking water (certain regions)', 'seafood (organic arsenic, less toxic)', 'pressure-treated wood (CCA, pre-2004)'],
  ARRAY['IARC', 'FDA', 'EPA', 'WHO', 'EFSA', 'Consumer Reports']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Chromium VI',
  'chromium-vi',
  ARRAY['hexavalent chromium', 'Cr(VI)', 'chromium-6', 'CAS 18540-29-9', 'chromate', 'dichromate', 'Erin Brockovich chemical'],
  'heavy_metal',
  10,
  ARRAY['known carcinogen', 'respiratory toxicity', 'kidney damage', 'water contamination', 'skin ulceration'],
  '{"acute": "Severe skin burns and ulceration (chrome holes), nasal septum perforation, severe respiratory irritation, kidney failure from ingestion", "chronic": "Known human carcinogen (IARC Group 1): lung cancer, nasal and sinus cancer. Chronic kidney disease, liver damage, skin sensitization and dermatitis, reproductive toxicity, immune system effects", "vulnerable_groups": ["industrial workers (welders, chromium platers, leather tanners)", "children", "communities near contamination sites", "pregnant women"]}',
  '{"fda": "no specific food standards (not a food additive)", "eu": "restricted under REACH, occupational exposure limits", "iarc": "Group 1 known carcinogen", "epa": "maximum contaminant level 100 ppb total chromium in water (no specific Cr-VI standard)", "notes": "Made famous by Erin Brockovich case against PG&E. IARC Group 1 carcinogen. California set a public health goal of 0.02 ppb for Cr-VI in drinking water. No federal drinking water standard specific to hexavalent chromium."}',
  ARRAY['trivalent chromium (Cr-III) alternatives in manufacturing', 'chromium-free tanning agents', 'water filtration (ion exchange, reverse osmosis)', 'stainless steel alternatives without Cr-VI coatings'],
  ARRAY['contaminated drinking water', 'chrome-tanned leather', 'stainless steel welding fumes', 'chrome-plated products', 'coal combustion', 'cement', 'some dyes'],
  ARRAY['IARC', 'EPA', 'OSHA', 'ATSDR', 'California OEHHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Aluminum',
  'aluminum',
  ARRAY['Al', 'aluminium', 'CAS 7429-90-5', 'aluminum chloride', 'aluminum chlorohydrate', 'aluminum zirconium', 'alum'],
  'heavy_metal',
  5,
  ARRAY['neurotoxicity concern', 'bone toxicity', 'Alzheimer''s disease debate', 'kidney burden', 'estrogen mimicry concern'],
  '{"acute": "Generally low acute toxicity; ingestion of large amounts can cause nausea, vomiting, diarrhea; inhalation of dust causes respiratory irritation", "chronic": "Neurotoxicity at high exposure levels, bone softening (dialysis patients), possible link to Alzheimer''s disease (debated and inconclusive), breast cancer concern from antiperspirants (unproven), accumulation in bone and brain tissue", "vulnerable_groups": ["people with kidney disease (cannot excrete efficiently)", "dialysis patients", "premature infants", "elderly"]}',
  '{"fda": "GRAS for food additives, approved in antiperspirants and vaccines", "eu": "approved with restrictions, tolerable weekly intake established", "efsa": "tolerable weekly intake 1 mg/kg body weight", "notes": "Extremely common in food, water, and consumer products. Alzheimer''s link remains controversial and unproven. FDA considers aluminum-based food additives GRAS. EU set tolerable weekly intake in 2008."}',
  ARRAY['aluminum-free deodorants', 'aluminum-free baking powder', 'stainless steel or cast iron cookware', 'glass food storage', 'parchment paper instead of aluminum foil'],
  ARRAY['antiperspirants', 'antacids', 'buffered aspirin', 'aluminum cookware', 'aluminum foil', 'processed cheese', 'baking powder', 'vaccines (adjuvant)', 'drinking water treatment'],
  ARRAY['FDA', 'EFSA', 'WHO', 'ATSDR', 'Alzheimer''s Association']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Nickel',
  'nickel',
  ARRAY['Ni', 'CAS 7440-02-0', 'nickel compounds', 'nickel sulfate', 'nickel carbonyl'],
  'heavy_metal',
  6,
  ARRAY['contact dermatitis', 'known carcinogen (compounds)', 'allergenic', 'respiratory sensitization', 'reproductive toxicity'],
  '{"acute": "Nickel carbonyl: extremely toxic, pulmonary edema, death. Ingestion: nausea, vomiting, diarrhea. Skin contact: allergic contact dermatitis in sensitized individuals", "chronic": "Nickel compounds are known human carcinogens (IARC Group 1): lung and nasal cancer. Chronic allergic contact dermatitis (10-20% of women affected), respiratory sensitization, occupational asthma, possible reproductive effects", "vulnerable_groups": ["people with nickel allergy (very common)", "women (higher allergy rates due to jewelry exposure)", "industrial workers", "children"]}',
  '{"fda": "no specific food limits", "eu": "restricted in jewelry and consumer products (REACH), migration limits established", "iarc": "Group 1 carcinogen (nickel compounds), Group 2B (metallic nickel)", "notes": "Nickel allergy is one of the most common contact allergies, affecting 10-20% of women. EU restricts nickel release from jewelry and consumer products. Nickel compounds are IARC Group 1 carcinogens for inhalation."}',
  ARRAY['nickel-free jewelry (titanium, surgical steel, platinum)', 'nickel-free belt buckles and buttons', 'stainless steel with low nickel release', 'silicone phone cases'],
  ARRAY['costume jewelry', 'belt buckles', 'eyeglass frames', 'coins', 'stainless steel cookware', 'canned foods', 'chocolate', 'nuts', 'phone cases'],
  ARRAY['IARC', 'EFSA', 'WHO', 'ATSDR', 'European Nickel Institute']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Antimony',
  'antimony',
  ARRAY['Sb', 'stibium', 'CAS 7440-36-0', 'antimony trioxide', 'antimony pentoxide', 'CAS 1309-64-4'],
  'heavy_metal',
  6,
  ARRAY['possible carcinogen', 'respiratory toxicity', 'leaching from plastics', 'cardiovascular effects', 'skin irritation'],
  '{"acute": "Nausea, vomiting, diarrhea (antimony potassium tartrate was historically used as an emetic), cardiac arrhythmia, respiratory irritation from inhalation", "chronic": "Possible carcinogen (IARC Group 2B for antimony trioxide), chronic lung disease (antimony pneumoconiosis), liver damage, cardiovascular effects, skin irritation, leaching into beverages from PET bottles", "vulnerable_groups": ["industrial workers", "children (higher exposure per body weight)", "people consuming beverages from PET bottles stored in heat"]}',
  '{"fda": "no specific food limits for antimony", "eu": "restricted under REACH, antimony trioxide classified as suspected carcinogen", "iarc": "Group 2B possibly carcinogenic (antimony trioxide)", "epa": "maximum contaminant level 6 ppb in drinking water", "notes": "Primary concern for consumers is leaching from PET plastic bottles, especially when heated or stored long-term. Antimony trioxide is widely used as a flame retardant in textiles and electronics."}',
  ARRAY['glass bottles', 'stainless steel water bottles', 'antimony-free PET catalysts', 'non-PET plastic alternatives', 'flame retardant alternatives'],
  ARRAY['PET plastic bottles', 'polyester textiles', 'flame retardants', 'lead-acid batteries', 'electronics solder', 'some paints'],
  ARRAY['IARC', 'EPA', 'EFSA', 'ATSDR', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Barium',
  'barium',
  ARRAY['Ba', 'CAS 7440-39-3', 'barium sulfate', 'barium chloride', 'barium carbonate'],
  'heavy_metal',
  5,
  ARRAY['cardiovascular toxicity', 'gastrointestinal effects', 'muscle weakness', 'hypokalemia', 'kidney effects'],
  '{"acute": "Soluble barium compounds: vomiting, diarrhea, severe abdominal pain, cardiac arrhythmias, muscle paralysis, respiratory failure, death. Barium sulfate (insoluble) is non-toxic and used as contrast agent.", "chronic": "Hypertension, cardiovascular effects, kidney damage, muscle weakness, hypokalemia (potassium depletion), gastrointestinal effects", "vulnerable_groups": ["children", "people with cardiovascular disease", "people with kidney disease", "industrial workers"]}',
  '{"fda": "barium sulfate approved as contrast agent", "eu": "occupational exposure limits established", "epa": "maximum contaminant level 2 ppm in drinking water", "notes": "Toxicity varies greatly by compound. Insoluble barium sulfate is medically safe (used for GI imaging). Soluble barium compounds (chloride, carbonate) are highly toxic. Naturally occurs in some drinking water sources."}',
  ARRAY['water filtration systems', 'regular water testing in affected areas', 'alternative contrast agents where available'],
  ARRAY['drinking water (natural occurrence)', 'barium contrast agents (medical)', 'fireworks', 'oil drilling', 'rat poison (historical)', 'some ceramics and glass'],
  ARRAY['EPA', 'WHO', 'ATSDR', 'FDA', 'OSHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Beryllium',
  'beryllium',
  ARRAY['Be', 'CAS 7440-41-7', 'beryllium oxide', 'beryllium copper', 'glucinium'],
  'heavy_metal',
  8,
  ARRAY['known carcinogen', 'chronic beryllium disease', 'lung toxicity', 'skin sensitization', 'immune system effects'],
  '{"acute": "Acute beryllium disease: severe chemical pneumonitis, pulmonary edema, respiratory failure; skin ulceration on contact", "chronic": "Known human carcinogen (IARC Group 1): lung cancer. Chronic beryllium disease (CBD/berylliosis): progressive granulomatous lung disease similar to sarcoidosis, irreversible and potentially fatal. Skin sensitization, immune system dysfunction.", "vulnerable_groups": ["aerospace workers", "electronics workers", "dental technicians", "nuclear industry workers", "genetically susceptible individuals (HLA-DPB1 gene)"]}',
  '{"fda": "not applicable (not a food/cosmetic ingredient)", "eu": "restricted under REACH, classified as carcinogen", "iarc": "Group 1 known carcinogen", "osha": "permissible exposure limit 0.2 mcg/m3", "notes": "IARC Group 1 carcinogen. Primarily an occupational hazard. About 1-15% of exposed workers develop chronic beryllium disease. Genetic susceptibility plays a role. OSHA significantly lowered the PEL in 2017."}',
  ARRAY['beryllium-free alloys', 'alternative materials in aerospace', 'proper industrial ventilation and PPE'],
  ARRAY['aerospace components', 'electronics', 'dental prosthetics', 'nuclear reactors', 'X-ray windows', 'beryllium-copper alloys'],
  ARRAY['IARC', 'OSHA', 'ATSDR', 'NIOSH', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Thallium',
  'thallium',
  ARRAY['Tl', 'CAS 7440-28-0', 'thallium sulfate', 'thallium(I)', 'thallium acetate'],
  'heavy_metal',
  10,
  ARRAY['extreme toxicity', 'neurotoxicity', 'hair loss', 'cardiovascular toxicity', 'no taste or odor (poison risk)'],
  '{"acute": "Extremely toxic: abdominal pain, nausea, vomiting, followed by peripheral neuropathy, alopecia (hair loss), confusion, seizures, coma, death. Lethal dose as low as 8-12 mg/kg.", "chronic": "Permanent neurological damage, chronic fatigue, hair loss, vision impairment, memory loss, peripheral neuropathy, liver and kidney damage, cardiovascular effects", "vulnerable_groups": ["children", "anyone exposed (extremely toxic at low doses)", "industrial workers", "communities near contamination sites"]}',
  '{"fda": "not applicable (not a food additive)", "eu": "severely restricted", "epa": "maximum contaminant level 2 ppb in drinking water", "notes": "Historically known as the poisoner''s poison due to being odorless, tasteless, and colorless in solution. Banned as a rodenticide in the US since 1975. Extremely toxic to humans at very low doses."}',
  ARRAY['water filtration', 'alternative rat poisons', 'environmental remediation of contaminated sites'],
  ARRAY['contaminated water near smelting operations', 'cement manufacturing waste', 'coal combustion', 'electronic waste', 'some contaminated foods'],
  ARRAY['EPA', 'WHO', 'ATSDR', 'CDC', 'OSHA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Organotin Compounds',
  'organotin',
  ARRAY['Sn', 'tin', 'tributyltin', 'TBT', 'dibutyltin', 'DBT', 'monobutyltin', 'MBT', 'triphenyltin', 'CAS 7440-31-5', 'organotin'],
  'heavy_metal',
  7,
  ARRAY['endocrine disruption', 'immunotoxicity', 'neurotoxicity', 'reproductive toxicity', 'marine ecosystem damage'],
  '{"acute": "Irritation of skin, eyes, and respiratory tract; trimethyltin and triethyltin compounds cause severe neurotoxicity; nausea, vomiting, headache", "chronic": "Endocrine disruption (tributyltin causes imposex in marine snails at ng/L levels), immunotoxicity (thymus atrophy), neurotoxicity, liver damage, reproductive effects, obesity-promoting (tributyltin is an obesogen)", "vulnerable_groups": ["children", "pregnant women", "marine organisms", "people consuming contaminated seafood", "industrial workers"]}',
  '{"fda": "migration limits from food contact materials", "eu": "restricted under REACH, banned in anti-fouling paints", "epa": "no specific drinking water standard", "imo": "tributyltin banned in anti-fouling paints globally (2008)", "notes": "Tributyltin (TBT) was one of the most toxic substances ever deliberately released into the marine environment. Banned in ship anti-fouling paints globally. Still used as PVC stabilizers and some industrial applications."}',
  ARRAY['tin-free anti-fouling paints', 'calcium-zinc PVC stabilizers', 'silicone-based marine coatings', 'BPA-free can linings'],
  ARRAY['PVC products (stabilizer)', 'canned food (tin can linings)', 'marine paint (historical)', 'silicone products', 'some textiles'],
  ARRAY['IMO', 'EFSA', 'WHO', 'EPA', 'ATSDR']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Uranium',
  'uranium',
  ARRAY['U', 'CAS 7440-61-1', 'depleted uranium', 'uranyl', 'uranium-238'],
  'heavy_metal',
  8,
  ARRAY['radioactivity', 'kidney toxicity', 'carcinogen', 'bone accumulation', 'water contamination'],
  '{"acute": "Chemical toxicity primarily affects kidneys: proximal tubule damage, proteinuria, elevated BUN. Radiation effects depend on form and exposure route.", "chronic": "Kidney damage and progressive renal failure, bone cancer risk from radioactivity, lung cancer risk from inhalation (miners), bone accumulation, potential reproductive effects, increased cancer risk proportional to exposure", "vulnerable_groups": ["uranium miners", "military personnel (depleted uranium)", "communities near mining sites", "people with well water in uranium-rich geological areas", "children"]}',
  '{"fda": "no specific food limits", "eu": "regulated under nuclear safety directives", "epa": "maximum contaminant level 30 ppb in drinking water", "nrc": "regulates nuclear materials", "notes": "Both a chemical and radiological hazard. Naturally occurring in some groundwater. EPA MCL based on chemical kidney toxicity rather than radioactivity. Depleted uranium used in military applications raises health concerns for veterans."}',
  ARRAY['water treatment (ion exchange, reverse osmosis)', 'regular well water testing in affected areas', 'alternative water sources'],
  ARRAY['well water in uranium-rich regions', 'contaminated soil near mining sites', 'phosphate fertilizers', 'some root vegetables', 'depleted uranium munitions exposure'],
  ARRAY['EPA', 'WHO', 'NRC', 'ATSDR', 'IAEA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Cobalt',
  'cobalt',
  ARRAY['Co', 'CAS 7440-48-4', 'cobalt chloride', 'cobalt sulfate', 'cobalt blue', 'vitamin B12 (cyanocobalamin)'],
  'heavy_metal',
  5,
  ARRAY['carcinogen (compounds)', 'contact dermatitis', 'cardiomyopathy', 'thyroid effects', 'lung disease'],
  '{"acute": "Nausea, vomiting, diarrhea from ingestion; respiratory irritation from inhalation; contact dermatitis in sensitized individuals", "chronic": "Cobalt compounds classified as possibly carcinogenic (IARC Group 2B), hard metal lung disease (giant cell interstitial pneumonitis), cardiomyopathy (beer drinker''s cardiomyopathy historically), thyroid effects, polycythemia, allergic contact dermatitis, reproductive effects", "vulnerable_groups": ["metal workers (hard metal, diamond polishing)", "people with cobalt-containing implants", "people with cobalt allergy", "children"]}',
  '{"fda": "essential nutrient as part of vitamin B12", "eu": "cobalt salts classified as carcinogen Category 1B under CLP", "iarc": "Group 2B possibly carcinogenic (cobalt and cobalt compounds)", "notes": "Essential trace element as part of vitamin B12, but excess exposure is toxic. Major concern is occupational exposure and cobalt-containing medical implants. EU classified certain cobalt salts as carcinogens."}',
  ARRAY['cobalt-free hard metal alternatives', 'ceramic or titanium implants', 'nickel-free and cobalt-free jewelry', 'lithium iron phosphate batteries'],
  ARRAY['lithium-ion batteries', 'metal implants (hip/knee)', 'blue pigments and ceramics', 'hard metal tools', 'some jewelry', 'vitamin B12 supplements (beneficial form)'],
  ARRAY['IARC', 'EFSA', 'OSHA', 'ATSDR', 'WHO']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Manganese (Excess)',
  'manganese-excess',
  ARRAY['Mn', 'CAS 7439-96-5', 'manganese dioxide', 'potassium permanganate', 'manganese sulfate', 'MMT'],
  'heavy_metal',
  5,
  ARRAY['neurotoxicity', 'manganism', 'developmental neurotoxicity', 'water contamination', 'respiratory effects'],
  '{"acute": "Inhalation of manganese dust or fumes: metal fume fever (flu-like symptoms), cough, respiratory irritation. Ingestion of excess: generally low acute toxicity", "chronic": "Manganism (chronic manganese poisoning): Parkinson''s-like syndrome with tremors, rigidity, psychomotor dysfunction, psychiatric symptoms. Developmental neurotoxicity in children from water exposure. Reduced IQ, behavioral problems, learning disabilities in children exposed to elevated manganese in water.", "vulnerable_groups": ["welders and miners (inhalation)", "infants (especially formula-fed with manganese-rich water)", "children", "people with liver disease (impaired manganese excretion)", "people on total parenteral nutrition"]}',
  '{"fda": "adequate intake established (essential nutrient)", "eu": "occupational exposure limits established", "epa": "secondary drinking water standard 50 ppb (non-enforceable), health advisory 300 ppb", "who": "provisional guideline removed in 2011, health-based value 80 ppb proposed", "notes": "Essential trace mineral, but excess exposure is neurotoxic. No enforceable EPA standard for drinking water. Major concern is occupational inhalation (welders) and elevated levels in drinking water, especially for infants."}',
  ARRAY['water filtration (manganese-specific filters)', 'proper ventilation in welding', 'monitoring of well water', 'ready-to-feed infant formula (lower manganese)'],
  ARRAY['well water (naturally occurring)', 'welding fumes', 'mining operations', 'gasoline additive (MMT)', 'soy-based infant formula', 'some dietary supplements'],
  ARRAY['EPA', 'WHO', 'ATSDR', 'OSHA', 'Health Canada']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Bisphenol A (BPA)',
  'bisphenol-a',
  ARRAY['BPA', '4,4''-(propane-2,2-diyl)diphenol', 'CAS 80-05-7', 'bisphenol A', 'BADGE'],
  'plastic',
  8,
  ARRAY['endocrine disruption', 'estrogenic activity', 'developmental toxicity', 'reproductive toxicity', 'obesity link'],
  '{"acute": "Low acute toxicity; skin and eye irritation at high concentrations", "chronic": "Potent endocrine disruptor mimicking estrogen at very low doses, reproductive toxicity (reduced fertility, early puberty), developmental effects in children, increased risk of breast and prostate cancer, cardiovascular disease, type 2 diabetes, obesity, ADHD and behavioral effects in children", "vulnerable_groups": ["fetuses", "infants", "children", "pregnant women", "women of reproductive age"]}',
  '{"fda": "banned in baby bottles and sippy cups (2012), approved for other food contact", "eu": "banned in all food contact materials (2025), classified as SVHC under REACH", "efsa": "dramatically lowered TDI to 0.2 ng/kg bw/day (2023)", "notes": "EU banned BPA from all food contact materials effective 2025. EFSA lowered the tolerable daily intake by 20,000-fold in 2023. FDA maintains it is safe at current exposure levels but banned from infant products. Detected in 93% of Americans tested."}',
  ARRAY['BPA-free cans and packaging', 'glass food containers', 'stainless steel water bottles', 'fresh or frozen food instead of canned', 'silicone food storage'],
  ARRAY['canned food linings', 'thermal receipt paper', 'polycarbonate water bottles', 'food storage containers', 'dental sealants', 'epoxy resins', 'water supply pipes'],
  ARRAY['FDA', 'EFSA', 'WHO', 'NIEHS', 'EWG', 'Endocrine Society']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Bisphenol S (BPS)',
  'bisphenol-s',
  ARRAY['BPS', '4,4''-sulfonyldiphenol', 'CAS 80-09-1', 'bisphenol S'],
  'plastic',
  7,
  ARRAY['endocrine disruption', 'estrogenic activity', 'regrettable substitution', 'reproductive toxicity', 'developmental toxicity'],
  '{"acute": "Low acute toxicity; skin and eye irritation possible", "chronic": "Endocrine disruptor with estrogenic and anti-androgenic activity similar to or stronger than BPA, reproductive toxicity, developmental neurotoxicity, obesogenic effects, cardiovascular effects, potential carcinogenicity", "vulnerable_groups": ["fetuses", "infants", "children", "pregnant women", "women of reproductive age"]}',
  '{"fda": "no specific regulation (considered BPA alternative)", "eu": "under evaluation, increasingly restricted", "notes": "Widely used as BPA replacement in ''BPA-free'' products, but research shows similar or worse endocrine-disrupting effects. Often called a regrettable substitution. More environmentally persistent than BPA. Detected in most people tested."}',
  ARRAY['glass containers', 'stainless steel bottles', 'avoid thermal receipts', 'truly BPA/BPS-free products', 'fresh food over canned'],
  ARRAY['BPA-free thermal receipt paper', 'BPA-free plastics and can linings', 'some food packaging', 'epoxy resins', 'currency and banknotes'],
  ARRAY['NIEHS', 'Endocrine Society', 'EFSA', 'Environmental Health Perspectives', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Bisphenol F (BPF)',
  'bisphenol-f',
  ARRAY['BPF', '4,4''-methylenediphenol', 'CAS 620-92-8', 'bisphenol F', 'bis(4-hydroxyphenyl)methane'],
  'plastic',
  7,
  ARRAY['endocrine disruption', 'estrogenic activity', 'regrettable substitution', 'reproductive toxicity', 'obesity link'],
  '{"acute": "Low acute toxicity; skin irritation possible", "chronic": "Endocrine disruptor with estrogenic activity comparable to BPA, anti-androgenic effects, reproductive toxicity, developmental effects, obesogenic potential, genotoxicity concerns", "vulnerable_groups": ["fetuses", "infants", "children", "pregnant women"]}',
  '{"fda": "no specific regulation", "eu": "under evaluation", "notes": "Another BPA substitute with similar endocrine-disrupting properties. Found in mustard and other foods due to migration from packaging. Also used in epoxy resins and lacquer coatings. Considered another regrettable substitution."}',
  ARRAY['glass food containers', 'stainless steel storage', 'bisphenol-free epoxy alternatives', 'fresh food over processed'],
  ARRAY['BPA-free can linings', 'epoxy resins', 'lacquer coatings', 'some food packaging', 'mustard and condiment containers', 'dental composites'],
  ARRAY['NIEHS', 'Endocrine Society', 'EFSA', 'Environmental Health Perspectives', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'DINP (Diisononyl Phthalate)',
  'dinp',
  ARRAY['DINP', 'diisononyl phthalate', 'CAS 28553-12-0', 'CAS 68515-48-0', 'diisononyl 1,2-benzenedicarboxylate'],
  'plastic',
  6,
  ARRAY['endocrine disruption', 'liver effects', 'reproductive toxicity concern', 'children''s product concern', 'anti-androgenic potential'],
  '{"acute": "Very low acute toxicity", "chronic": "Liver and kidney effects in animal studies, possible endocrine disruption, anti-androgenic potential (weaker than DEHP), possible carcinogenicity (liver tumors in rodents via PPARalpha mechanism), developmental concerns", "vulnerable_groups": ["children (oral exposure from toys)", "infants", "pregnant women"]}',
  '{"fda": "no specific limits for food contact (allowed)", "eu": "restricted in toys and childcare articles that can be placed in the mouth (REACH Annex XVII)", "cpsc": "permanently banned in children''s toys and childcare articles at >0.1%", "notes": "CPSC permanently banned DINP in children''s toys in 2017 based on anti-androgenic concerns. Still widely used in non-children''s products. Often used as DEHP replacement. Less toxic than DEHP but still raises concerns."}',
  ARRAY['phthalate-free toys', 'natural rubber products', 'citrate-based plasticizers', 'silicone products', 'wood and fabric toys'],
  ARRAY['vinyl flooring', 'plastic toys (non-compliant)', 'food packaging', 'garden hoses', 'PVC products', 'artificial leather', 'shoes'],
  ARRAY['CPSC', 'EFSA', 'EPA', 'ECHA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'DIDP (Diisodecyl Phthalate)',
  'didp',
  ARRAY['DIDP', 'diisodecyl phthalate', 'CAS 26761-40-0', 'CAS 68515-49-1', 'diisodecyl 1,2-benzenedicarboxylate'],
  'plastic',
  5,
  ARRAY['endocrine disruption concern', 'liver effects', 'reproductive toxicity concern', 'environmental persistence', 'phthalate exposure'],
  '{"acute": "Very low acute toxicity", "chronic": "Liver effects in animal studies at high doses, weak endocrine disruption potential, less reproductive toxicity than DEHP, possible developmental effects at high doses, contributes to cumulative phthalate exposure", "vulnerable_groups": ["children", "infants", "pregnant women"]}',
  '{"fda": "allowed in food contact materials", "eu": "restricted in toys and childcare articles that can be placed in the mouth (REACH Annex XVII)", "cpsc": "permanently banned in children''s toys and childcare articles at >0.1%", "notes": "Considered lower toxicity among phthalates but CPSC still banned it in children''s products as a precautionary measure. Commonly used as DEHP replacement in PVC. Contributes to cumulative phthalate exposure."}',
  ARRAY['phthalate-free products', 'citrate-based plasticizers', 'natural materials', 'PVC-free alternatives'],
  ARRAY['vinyl flooring', 'PVC products', 'wire and cable insulation', 'artificial leather', 'car interiors', 'roofing membranes'],
  ARRAY['CPSC', 'EFSA', 'ECHA', 'EPA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'DEHP (Di-2-ethylhexyl Phthalate)',
  'dehp',
  ARRAY['DEHP', 'di(2-ethylhexyl) phthalate', 'dioctyl phthalate', 'DOP', 'bis(2-ethylhexyl) phthalate', 'CAS 117-81-7'],
  'plastic',
  8,
  ARRAY['endocrine disruption', 'reproductive toxicity', 'anti-androgenic', 'developmental toxicity', 'probable carcinogen'],
  '{"acute": "Low acute toxicity; irritation to eyes, skin, and respiratory tract", "chronic": "Potent anti-androgenic endocrine disruptor, reproductive toxicity (testicular atrophy, reduced sperm, infertility), developmental toxicity (phthalate syndrome: hypospadias, cryptorchidism), probable carcinogen (IARC Group 2B), liver damage, kidney damage", "vulnerable_groups": ["male fetuses", "infants (NICU exposure)", "children", "pregnant women", "patients receiving blood transfusions or dialysis"]}',
  '{"fda": "banned in pacifiers, some food contact limits", "eu": "SVHC under REACH, restricted in toys and childcare articles, restricted in medical devices", "iarc": "Group 2B possibly carcinogenic", "cpsc": "permanently banned in children''s toys at >0.1%", "notes": "Most studied and most toxic common phthalate. NICU infants receive extremely high doses from PVC medical tubing. EU classified as toxic for reproduction. Being phased out but still widely used globally. CPSC permanently banned in children''s products."}',
  ARRAY['DEHP-free medical devices', 'phthalate-free toys', 'glass food containers', 'silicone tubing for medical use', 'citrate plasticizer alternatives'],
  ARRAY['PVC medical devices (IV bags, tubing)', 'vinyl flooring', 'plastic food wrap', 'children''s toys (non-compliant)', 'PVC products', 'blood storage bags', 'some food packaging'],
  ARRAY['IARC', 'FDA', 'EFSA', 'CPSC', 'ECHA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polyvinyl Chloride (PVC)',
  'polyvinyl-chloride',
  ARRAY['PVC', 'vinyl', 'poly(vinyl chloride)', 'CAS 9002-86-2', 'vinyl chloride polymer', 'plastic #3'],
  'plastic',
  7,
  ARRAY['phthalate leaching', 'dioxin release', 'vinyl chloride monomer', 'heavy metal stabilizers', 'environmental toxicity'],
  '{"acute": "PVC itself has low acute toxicity, but vinyl chloride monomer is extremely toxic; burning PVC releases hydrochloric acid and dioxins", "chronic": "Phthalate plasticizers leach from flexible PVC causing endocrine disruption, vinyl chloride monomer residuals are known carcinogens, heavy metal stabilizers (lead, cadmium) can leach, dioxin release during manufacture and incineration, off-gassing of volatile organics", "vulnerable_groups": ["children (toys, flooring)", "infants", "PVC manufacturing workers", "communities near PVC plants or incinerators"]}',
  '{"fda": "approved for food contact with conditions", "eu": "restricted phthalates and heavy metals in PVC products", "iarc": "vinyl chloride monomer is Group 1 carcinogen", "notes": "Called the ''poison plastic'' by environmental groups. Lifecycle concerns from manufacture (vinyl chloride, dioxins) to disposal (incineration releases dioxins). Requires toxic additives (phthalates, heavy metals) to be useful. Being phased out of many applications."}',
  ARRAY['HDPE or PP plastics', 'silicone', 'natural rubber', 'wood', 'metal', 'glass', 'PVC-free flooring (cork, hardwood, linoleum)'],
  ARRAY['vinyl flooring', 'shower curtains', 'plastic wrap (some brands)', 'children''s toys', 'plumbing pipes', 'window frames', 'inflatable pools', 'raincoats', 'artificial leather'],
  ARRAY['EPA', 'IARC', 'Greenpeace', 'CHEJ', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polystyrene',
  'polystyrene',
  ARRAY['PS', 'Styrofoam', 'expanded polystyrene', 'EPS', 'CAS 9003-53-6', 'plastic #6', 'styrene polymer'],
  'plastic',
  6,
  ARRAY['styrene leaching', 'possible carcinogen', 'environmental pollution', 'microplastic source', 'neurotoxicity'],
  '{"acute": "Low acute toxicity for polymer; styrene monomer causes eye, skin, respiratory irritation, CNS depression at high exposure", "chronic": "Styrene monomer leaches from containers (increased by heat and fat contact), styrene classified as probably carcinogenic (IARC Group 2A), neurotoxicity, hearing loss, potential lymphohematopoietic cancers, reproductive effects, persistent environmental pollutant and major microplastic source", "vulnerable_groups": ["food service workers (occupational styrene exposure)", "children", "pregnant women", "people consuming hot food/beverages from polystyrene"]}',
  '{"fda": "approved for food contact", "eu": "approved for food contact with migration limits for styrene", "iarc": "styrene classified as Group 2A probably carcinogenic (2019)", "notes": "IARC upgraded styrene to probably carcinogenic in 2019. Major environmental pollutant. Many cities and states have banned polystyrene food containers. Styrene leaching increases dramatically with hot, fatty, or acidic foods."}',
  ARRAY['paper or plant-fiber takeout containers', 'glass containers', 'reusable food containers', 'compostable alternatives', 'stainless steel cups'],
  ARRAY['foam takeout containers', 'disposable cups and plates', 'meat trays', 'egg cartons', 'packing peanuts', 'insulation', 'yogurt containers'],
  ARRAY['IARC', 'FDA', 'EFSA', 'NTP', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Melamine',
  'melamine',
  ARRAY['1,3,5-triazine-2,4,6-triamine', 'CAS 108-78-1', 'cyanuramide', 'melamine resin', 'melamine formaldehyde'],
  'plastic',
  6,
  ARRAY['kidney damage', 'bladder stones', 'food adulteration risk', 'formaldehyde release', 'migration into food'],
  '{"acute": "Renal failure, kidney stones, bladder stones at high doses (as seen in 2008 Chinese milk scandal)", "chronic": "Kidney stone formation, chronic kidney damage, bladder cancer risk (animal studies), formaldehyde migration from melamine-formaldehyde dishware when heated, reproductive effects in animal studies", "vulnerable_groups": ["infants (2008 scandal caused deaths)", "children", "people with kidney disease", "people who microwave food in melamine dishes"]}',
  '{"fda": "not approved as food additive, tolerance limit 2.5 ppm in food (not infant formula), 1 ppm for infant formula", "eu": "specific migration limit from food contact materials", "notes": "2008 Chinese milk scandal: melamine illegally added to infant formula killed 6 babies and sickened 300,000 children. Melamine-formaldehyde dishware can release both melamine and formaldehyde when heated. FDA does not recommend microwaving food in melamine dishes."}',
  ARRAY['ceramic or glass dishes', 'stainless steel dishes', 'bamboo fiber dishes', 'do not microwave in melamine dishes', 'silicone feeding products'],
  ARRAY['melamine dishes and bowls', 'countertop laminates (Formica)', 'whiteboards', 'flame retardants', 'cleaning products (melamine foam/Magic Eraser)'],
  ARRAY['FDA', 'EFSA', 'WHO', 'CPSC', 'Health Canada']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polyethylene Terephthalate (PET)',
  'polyethylene-terephthalate',
  ARRAY['PET', 'PETE', 'polyester', 'CAS 25038-59-9', 'plastic #1', 'PET plastic', 'Dacron', 'Mylar'],
  'plastic',
  4,
  ARRAY['antimony leaching', 'acetaldehyde migration', 'microplastic generation', 'endocrine disruption concern', 'phthalate contamination'],
  '{"acute": "Very low acute toxicity from the polymer itself", "chronic": "Antimony trioxide catalyst leaches into contents (especially when heated), acetaldehyde migration, phthalate contamination possible, microplastic generation from bottle degradation, endocrine-disrupting effects from leached compounds, potential estrogenic activity from leachates", "vulnerable_groups": ["infants", "children", "people who reuse PET bottles extensively", "people who store PET bottles in heat"]}',
  '{"fda": "approved for food and beverage contact", "eu": "approved with specific migration limits", "notes": "Generally considered one of the safer plastics for single use. However, antimony leaching increases dramatically with temperature and storage time. Should not be reused or heated. PET bottles are a major source of microplastics in water. Recycling symbol #1."}',
  ARRAY['glass bottles', 'stainless steel water bottles', 'do not reuse PET bottles', 'keep PET bottles cool and out of sunlight', 'home water filtration'],
  ARRAY['water bottles', 'soda bottles', 'food containers', 'peanut butter jars', 'polyester clothing', 'food packaging film'],
  ARRAY['FDA', 'EFSA', 'WHO', 'University of Heidelberg studies', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polycarbonate',
  'polycarbonate',
  ARRAY['PC', 'CAS 25037-45-0', 'Lexan', 'Makrolon', 'plastic #7', 'polycarbonate plastic'],
  'plastic',
  7,
  ARRAY['BPA leaching', 'endocrine disruption', 'heat sensitivity', 'degradation with age', 'chemical leaching'],
  '{"acute": "Very low acute toxicity from polymer; BPA leaching is the primary concern", "chronic": "Leaches BPA (potent endocrine disruptor) especially when heated, scratched, or washed with harsh detergents. BPA effects include reproductive toxicity, developmental effects, increased cancer risk, cardiovascular disease, metabolic effects. Older and damaged polycarbonate leaches significantly more BPA.", "vulnerable_groups": ["infants", "children", "pregnant women", "anyone using heated or aged polycarbonate containers"]}',
  '{"fda": "approved for food contact, banned BPA in baby bottles (polycarbonate baby bottles)", "eu": "BPA banned in all food contact materials (2025), effectively banning most polycarbonate food containers", "notes": "Made from BPA, which leaches during normal use and increasingly with heat, age, and damage. Previously used for baby bottles worldwide until BPA bans. EU 2025 ban on BPA in food contact materials effectively restricts polycarbonate food containers."}',
  ARRAY['glass food containers', 'stainless steel water bottles', 'Tritan (BPA-free copolyester)', 'silicone food storage', 'polypropylene containers'],
  ARRAY['5-gallon water cooler jugs', 'reusable water bottles (older)', 'food storage containers', 'baby bottles (historical)', 'eyeglass lenses', 'CDs and DVDs', 'electronic housings'],
  ARRAY['FDA', 'EFSA', 'NIEHS', 'Endocrine Society', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Polyurethane',
  'polyurethane',
  ARRAY['PU', 'PUR', 'CAS 9009-54-5', 'polyurethane foam', 'MDI-based polyurethane', 'TDI-based polyurethane'],
  'plastic',
  5,
  ARRAY['isocyanate off-gassing', 'flame retardant additives', 'VOC emissions', 'respiratory sensitization', 'fire hazard'],
  '{"acute": "Isocyanate exposure during manufacture causes severe respiratory irritation, asthma, chemical pneumonitis; cured polyurethane is relatively inert", "chronic": "Off-gassing of volatile organic compounds (VOCs) especially when new, flame retardant additives (often toxic) can leach or create dust, isocyanate sensitization (occupational), potential endocrine disruption from additives, fire produces highly toxic hydrogen cyanide gas", "vulnerable_groups": ["infants (crib mattresses)", "children", "people with asthma", "polyurethane manufacturing workers", "firefighters"]}',
  '{"fda": "not applicable (not food contact typically)", "eu": "isocyanate restrictions, flame retardant restrictions under REACH", "cpsc": "flammability standards require flame retardants in polyurethane foam", "notes": "Primary consumer concern is the toxic flame retardants added to polyurethane foam in furniture and mattresses. California TB 117-2013 reduced but did not eliminate flame retardant use. Cured polyurethane off-gasses VOCs, especially when new."}',
  ARRAY['natural latex mattresses', 'organic cotton mattresses', 'wool mattresses', 'CertiPUR-US certified foam', 'GOTS-certified organic bedding', 'solid wood furniture'],
  ARRAY['mattresses', 'furniture cushions', 'carpet padding', 'insulation (spray foam)', 'car seats', 'shoe soles', 'varnishes and coatings', 'adhesives'],
  ARRAY['EPA', 'CPSC', 'OSHA', 'CertiPUR-US', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'PFOA (Perfluorooctanoic Acid)',
  'pfoa',
  ARRAY['PFOA', 'perfluorooctanoic acid', 'C8', 'CAS 335-67-1', 'APFO (ammonium salt)', 'forever chemical', 'PFAS'],
  'plastic',
  9,
  ARRAY['known carcinogen', 'endocrine disruption', 'immune suppression', 'forever chemical', 'developmental toxicity'],
  '{"acute": "Low acute toxicity in humans but extremely persistent", "chronic": "Known carcinogen (IARC Group 1, 2023): kidney cancer, testicular cancer. Liver damage, thyroid disease, immune suppression (reduced vaccine response), reproductive toxicity, developmental effects, elevated cholesterol, ulcerative colitis, pre-eclampsia. Biological half-life of 2-4 years. Does not break down in the environment.", "vulnerable_groups": ["fetuses", "infants", "children", "pregnant women", "communities near PFAS manufacturing or military bases", "firefighters"]}',
  '{"fda": "voluntary phase-out from food packaging", "eu": "restricted under REACH, Stockholm Convention POP", "iarc": "Group 1 known carcinogen (2023)", "epa": "maximum contaminant level 4 ppt in drinking water (2024)", "notes": "IARC classified as known carcinogen in 2023. EPA set drinking water limit at 4 ppt (parts per trillion) in 2024, one of the strictest ever. Voluntarily phased out by major manufacturers but remains ubiquitous in the environment and in human blood. Detected in 98% of Americans."}',
  ARRAY['PFAS-free cookware (cast iron, stainless steel, ceramic)', 'PFAS-free food packaging', 'PFAS-free waterproof clothing', 'activated carbon water filters', 'reverse osmosis water filtration'],
  ARRAY['non-stick cookware (Teflon, historical)', 'food packaging (microwave popcorn bags, fast food wrappers)', 'stain-resistant fabrics', 'firefighting foam (AFFF)', 'waterproof clothing', 'contaminated drinking water'],
  ARRAY['IARC', 'EPA', 'EFSA', 'ATSDR', 'EWG', 'Stockholm Convention']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'PFOS (Perfluorooctane Sulfonate)',
  'pfos',
  ARRAY['PFOS', 'perfluorooctane sulfonic acid', 'CAS 1763-23-1', 'perfluorooctanesulfonate', 'forever chemical', 'PFAS'],
  'plastic',
  9,
  ARRAY['possible carcinogen', 'immune suppression', 'forever chemical', 'developmental toxicity', 'liver toxicity'],
  '{"acute": "Low acute toxicity but extremely persistent in body and environment", "chronic": "Possible carcinogen (IARC Group 2B), liver damage, thyroid disruption, immune suppression (reduced vaccine efficacy in children), reproductive toxicity, developmental effects, elevated cholesterol, kidney disease. Biological half-life of 4-5 years. Extremely persistent in environment.", "vulnerable_groups": ["fetuses", "infants", "children", "pregnant women", "military personnel and firefighters (AFFF foam)", "communities near contamination sites"]}',
  '{"fda": "not authorized for food contact (phased out)", "eu": "restricted under REACH and Stockholm Convention POP", "iarc": "Group 2B possibly carcinogenic (2023)", "epa": "maximum contaminant level 4 ppt in drinking water (2024)", "notes": "Listed as Persistent Organic Pollutant under Stockholm Convention. Phased out of production by 3M in 2002 but persists indefinitely in environment. EPA set ultra-low drinking water limit of 4 ppt. Found in blood of virtually all people tested worldwide."}',
  ARRAY['PFAS-free products', 'activated carbon water filters', 'reverse osmosis water treatment', 'fluorine-free firefighting foam', 'PFAS-free stain treatments'],
  ARRAY['firefighting foam (AFFF)', 'stain-resistant carpets and fabrics (historical)', 'food packaging (historical)', 'contaminated drinking water near military bases', 'Scotchgard (pre-2002)'],
  ARRAY['IARC', 'EPA', 'EFSA', 'ATSDR', 'Stockholm Convention', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'GenX (HFPO-DA)',
  'genx-hfpo-da',
  ARRAY['GenX', 'HFPO-DA', 'hexafluoropropylene oxide dimer acid', 'CAS 13252-13-6', 'ammonium 2,3,3,3-tetrafluoro-2-(heptafluoropropoxy)propanoate', 'forever chemical', 'PFAS'],
  'plastic',
  8,
  ARRAY['possible carcinogen', 'liver toxicity', 'kidney toxicity', 'forever chemical', 'water contamination'],
  '{"acute": "Limited human data; animal studies show liver and kidney toxicity", "chronic": "Liver tumors in animal studies, kidney damage, immune effects, thyroid disruption, reproductive and developmental toxicity in animal studies, pancreatic effects. Shorter half-life than PFOA in humans but still extremely persistent in the environment.", "vulnerable_groups": ["communities near manufacturing sites (Fayetteville, NC)", "children", "pregnant women", "people relying on contaminated water"]}',
  '{"fda": "no specific regulation", "eu": "under evaluation for restriction as part of universal PFAS restriction", "epa": "maximum contaminant level 10 ppt in drinking water (2024)", "notes": "Developed by Chemours (DuPont spinoff) as PFOA replacement, but found to be similarly toxic and persistent. Major contamination in Fayetteville, NC area. EPA set drinking water limit at 10 ppt. Part of broader PFAS class that EU is proposing to restrict universally."}',
  ARRAY['PFAS-free products', 'activated carbon plus ion exchange water filters', 'reverse osmosis water treatment', 'alternative non-PFAS manufacturing processes'],
  ARRAY['fluoropolymer manufacturing wastewater', 'contaminated drinking water near Chemours facilities', 'non-stick coatings (newer formulations)', 'some food packaging'],
  ARRAY['EPA', 'ATSDR', 'EFSA', 'North Carolina DEQ', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Titanium Dioxide',
  'titanium-dioxide',
  ARRAY['TiO2', 'E171', 'CI 77891', 'CAS 13463-67-7', 'titanium(IV) oxide', 'titania', 'titanium white'],
  'other',
  6,
  ARRAY['possible carcinogen (inhalation)', 'nanoparticle concerns', 'gut inflammation', 'genotoxicity', 'immune effects'],
  '{"acute": "Low acute toxicity; respiratory irritation from dust inhalation", "chronic": "Possible carcinogen by inhalation (IARC Group 2B), nanoparticle form can cross biological barriers, gut microbiome disruption, intestinal inflammation, potential genotoxicity of nanoparticles, immune system modulation, concerns about accumulation in organs", "vulnerable_groups": ["children (higher exposure from candies and processed foods)", "workers in TiO2 manufacturing", "people with inflammatory bowel disease"]}',
  '{"fda": "approved as color additive in food, drugs, and cosmetics", "eu": "banned as food additive E171 (2022), approved in cosmetics", "iarc": "Group 2B possibly carcinogenic (by inhalation)", "notes": "EU banned titanium dioxide as food additive (E171) in 2022 based on EFSA opinion that genotoxicity concerns could not be ruled out. FDA still permits it. Widely used in cosmetics, sunscreen, paints, and as a whitener in food."}',
  ARRAY['zinc oxide (for sunscreen)', 'iron oxides (for coloring)', 'calcium carbonate (for whitening)', 'rice starch', 'products without E171'],
  ARRAY['sunscreens', 'toothpaste', 'candies and confections', 'chewing gum', 'white paint', 'paper', 'medications (tablet coating)', 'coffee creamer', 'icing', 'cosmetics'],
  ARRAY['IARC', 'EFSA', 'FDA', 'WHO', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Talc',
  'talc',
  ARRAY['talcum', 'magnesium silicate', 'CAS 14807-96-6', 'hydrated magnesium silicate', 'talcum powder', 'CI 77718', 'soapstone'],
  'other',
  6,
  ARRAY['possible carcinogen', 'asbestos contamination', 'ovarian cancer association', 'respiratory hazard', 'mesothelioma risk'],
  '{"acute": "Inhalation causes respiratory irritation; severe talc pneumoconiosis (talcosis) from heavy acute exposure", "chronic": "Possible association with ovarian cancer when used in genital area (debated), asbestos contamination risk in some talc deposits, talcosis from chronic inhalation, mesothelioma from asbestos-contaminated talc, lung fibrosis", "vulnerable_groups": ["women using genital talc products", "infants (aspiration risk)", "miners and millers", "cosmetic manufacturing workers"]}',
  '{"fda": "approved in food and cosmetics, no pre-market testing required", "eu": "approved in cosmetics (must be asbestos-free)", "iarc": "Group 2B possibly carcinogenic (genital use of talc), Group 1 for asbestos-contaminated talc", "notes": "Johnson & Johnson discontinued talc-based baby powder in 2023 and agreed to $8.9 billion settlement for ovarian cancer claims. FDA found asbestos in some cosmetic talc products. IARC classifies genital use of talc as possibly carcinogenic."}',
  ARRAY['cornstarch-based powders', 'arrowroot powder', 'tapioca starch', 'kaolin clay', 'talc-free cosmetics and baby powder'],
  ARRAY['baby powder', 'body powders', 'cosmetics (foundation, blush, eyeshadow)', 'deodorants', 'chewing gum (anti-caking)', 'medications (excipient)', 'crayons'],
  ARRAY['IARC', 'FDA', 'WHO', 'American Cancer Society', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Mineral Oil',
  'mineral-oil',
  ARRAY['paraffinum liquidum', 'liquid paraffin', 'white mineral oil', 'CAS 8042-47-5', 'liquid petrolatum', 'mineral oil (cosmetic grade)', 'INCI: mineral oil'],
  'other',
  4,
  ARRAY['possible carcinogen (untreated)', 'skin barrier disruption', 'contamination concern', 'MOSH/MOAH contamination', 'comedogenic'],
  '{"acute": "Aspiration pneumonia if inhaled into lungs (lipoid pneumonia), laxative effect from ingestion, generally low acute toxicity for cosmetic-grade", "chronic": "Untreated/mildly treated mineral oil is Group 1 carcinogen (IARC). Highly refined cosmetic-grade considered safer but may contain MOSH (mineral oil saturated hydrocarbons) and MOAH (mineral oil aromatic hydrocarbons), which accumulate in organs. Potential comedogenic effects, skin barrier occlusion", "vulnerable_groups": ["infants (aspiration risk)", "people with compromised skin barrier", "workers exposed to industrial-grade mineral oil"]}',
  '{"fda": "GRAS for food use (food-grade), approved in cosmetics", "eu": "approved in cosmetics (must be fully refined), MOSH/MOAH limits under discussion", "iarc": "Group 1 carcinogen (untreated/mildly treated), Group 3 for highly refined", "notes": "IARC classification depends on refinement level. Cosmetic and food-grade mineral oil is highly refined and classified as not classifiable (Group 3). EFSA concerned about MOSH/MOAH contamination in food. Very widely used in cosmetics and pharmaceuticals."}',
  ARRAY['plant-based oils (jojoba, squalane, argan)', 'shea butter', 'coconut oil', 'natural waxes', 'plant-derived emollients'],
  ARRAY['baby oil', 'moisturizers', 'lip products', 'hair products', 'laxatives', 'food-grade lubricants', 'some processed foods', 'cosmetics'],
  ARRAY['IARC', 'FDA', 'EFSA', 'CIR', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Petroleum Jelly (Petrolatum)',
  'petrolatum',
  ARRAY['petrolatum', 'petroleum jelly', 'Vaseline', 'CAS 8009-03-8', 'white petrolatum', 'yellow petrolatum', 'mineral jelly', 'INCI: petrolatum'],
  'other',
  3,
  ARRAY['PAH contamination concern', 'skin occlusion', 'petroleum-derived', 'MOSH/MOAH concern', 'environmental impact'],
  '{"acute": "Very low acute toxicity; aspiration hazard if inhaled", "chronic": "Highly refined USP-grade petrolatum is considered safe. Concern is PAH (polycyclic aromatic hydrocarbon) contamination in inadequately refined grades; PAHs are known carcinogens. MOSH accumulation in the body over time. Skin occlusion may trap bacteria in some cases.", "vulnerable_groups": ["people using non-pharmaceutical grade petrolatum", "infants (aspiration risk)", "people with acne-prone skin"]}',
  '{"fda": "approved skin protectant (USP grade), GRAS", "eu": "approved in cosmetics only if full refining history is known and PAH-free", "notes": "EU requires proof that petrolatum is not carcinogenic by showing full refining history. USP-grade (pharmaceutical) petrolatum is well-refined and widely considered safe by dermatologists. One of the most effective occlusive moisturizers known. Environmental concerns about petroleum sourcing."}',
  ARRAY['shea butter', 'cocoa butter', 'beeswax', 'plant-based balms', 'squalane', 'coconut oil'],
  ARRAY['lip balms', 'moisturizers', 'diaper rash creams', 'healing ointments', 'hair products', 'Vaseline', 'Aquaphor', 'pharmaceutical ointment bases'],
  ARRAY['FDA', 'EFSA', 'CIR', 'AAD', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Microbeads (Polyethylene)',
  'microbeads-polyethylene',
  ARRAY['polyethylene microspheres', 'PE microbeads', 'plastic microbeads', 'CAS 9002-88-4', 'polyethylene beads', 'exfoliating beads'],
  'other',
  6,
  ARRAY['water pollution', 'microplastic contamination', 'bioaccumulation', 'toxic chemical adsorption', 'marine ecosystem damage'],
  '{"acute": "Not directly toxic to humans on contact; environmental concern is primary", "chronic": "Enter waterways and oceans, ingested by marine life and enter food chain, adsorb toxic chemicals (PCBs, pesticides, heavy metals) concentrating them, contribute to microplastic pollution, potential human health effects from microplastic ingestion via seafood and water are under active research", "vulnerable_groups": ["marine organisms", "seafood consumers", "children (higher microplastic exposure per body weight)", "communities relying on contaminated water"]}',
  '{"fda": "Microbead-Free Waters Act (2015) banned in rinse-off cosmetics", "eu": "banned in rinse-off cosmetics and other products (2023 ECHA microplastics restriction)", "notes": "US Microbead-Free Waters Act of 2015 banned plastic microbeads in rinse-off cosmetics. EU adopted broader microplastics restriction in 2023. Still found in some products outside these categories. Environmental contamination is persistent and irreversible."}',
  ARRAY['natural exfoliants (sugar, salt, oatmeal, rice bran)', 'jojoba beads (biodegradable)', 'pumice', 'walnut shell powder', 'bamboo powder'],
  ARRAY['exfoliating face washes (pre-ban)', 'body scrubs (pre-ban)', 'toothpaste (pre-ban)', 'industrial cleaning products', 'some cosmetics still containing microplastics'],
  ARRAY['NOAA', 'EPA', 'UNEP', 'ECHA', '5 Gyres Institute']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Microplastics',
  'microplastics',
  ARRAY['MPs', 'microplastic particles', 'nanoplastics', 'plastic particles', 'synthetic polymer particles'],
  'other',
  7,
  ARRAY['ubiquitous contamination', 'inflammation', 'chemical carriers', 'gut disruption', 'emerging health threat'],
  '{"acute": "No established acute toxicity at current exposure levels, but research is limited", "chronic": "Gut inflammation and microbiome disruption, cellular oxidative stress, potential cardiovascular effects (microplastics found in arterial plaques associated with increased heart attack and stroke risk), crosses placental barrier, found in human blood, lungs, liver, and placentas. Act as carriers for toxic chemicals (phthalates, heavy metals, persistent organic pollutants). Full health impacts still being researched.", "vulnerable_groups": ["infants (bottle-fed babies ingest millions of microplastic particles daily)", "children", "pregnant women", "people with inflammatory bowel disease"]}',
  '{"fda": "no specific regulation for microplastics in food/water", "eu": "2023 ECHA restriction on intentionally added microplastics", "who": "called for more research, no health-based guideline yet", "notes": "Humans ingest an estimated 5 grams of plastic per week (approximately a credit card''s worth). Found in human blood, placentas, lungs, and arterial plaques. 2024 study in New England Journal of Medicine linked microplastics in arterial plaques to increased cardiovascular events. Research is rapidly evolving."}',
  ARRAY['glass and stainless steel water bottles', 'water filtration (reverse osmosis)', 'natural fiber clothing', 'avoiding plastic food containers', 'using Guppyfriend laundry bags for synthetic clothing'],
  ARRAY['drinking water (tap and bottled)', 'seafood', 'sea salt', 'beer', 'honey', 'fruits and vegetables', 'indoor dust', 'synthetic clothing fibers', 'food packaging'],
  ARRAY['WHO', 'EFSA', 'UNEP', 'New England Journal of Medicine', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Paraffin Wax',
  'paraffin-wax',
  ARRAY['paraffin', 'CAS 8002-74-2', 'petroleum wax', 'mineral wax', 'paraffin wax', 'food-grade paraffin'],
  'other',
  3,
  ARRAY['petroleum-derived', 'VOC emissions when burned', 'possible PAH contamination', 'soot production', 'respiratory irritation'],
  '{"acute": "Very low acute toxicity; skin contact generally safe; burns can cause thermal injury", "chronic": "Burning paraffin candles releases VOCs (toluene, benzene in trace amounts), soot particles, and potentially PAHs. Regular candle burning in poorly ventilated spaces may cause respiratory irritation. Food-grade paraffin on fruits and cheese is considered safe. Concerns are primarily about combustion byproducts rather than the wax itself.", "vulnerable_groups": ["people with asthma or respiratory conditions", "children", "people burning many candles in unventilated rooms"]}',
  '{"fda": "GRAS for food use (food-grade)", "eu": "approved for food and cosmetic use", "notes": "Main concern is combustion byproducts from candles rather than direct toxicity. South Carolina State University study found paraffin candles release more VOCs than soy or beeswax candles. Food-grade paraffin used on fruits and cheese is well-refined and considered safe."}',
  ARRAY['soy wax candles', 'beeswax candles', 'coconut wax candles', 'LED candles', 'natural plant-based waxes'],
  ARRAY['candles', 'food coating (fruits, cheese)', 'cosmetics', 'crayons', 'wax paper', 'chocolate (coating)', 'pharmaceuticals', 'furniture polish'],
  ARRAY['FDA', 'EFSA', 'South Carolina State University', 'CPSC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Silicone (Dimethicone)',
  'dimethicone',
  ARRAY['dimethicone', 'polydimethylsiloxane', 'PDMS', 'CAS 9006-65-9', 'simethicone', 'cyclomethicone', 'silicone oil', 'INCI: dimethicone'],
  'other',
  2,
  ARRAY['environmental persistence', 'product buildup', 'non-biodegradable', 'potential cyclomethicone concern', 'occlusive properties'],
  '{"acute": "Very low acute toxicity; FDA-approved for internal use (simethicone for gas relief)", "chronic": "Generally considered safe for human use. Cyclomethicone (D4, D5, D6) variants have endocrine disruption and bioaccumulation concerns distinct from dimethicone. Hair and skin product buildup. Environmental persistence and non-biodegradability are primary concerns.", "vulnerable_groups": ["aquatic organisms (environmental persistence)", "people with sensitive or acne-prone skin (buildup concern)"]}',
  '{"fda": "approved in food, drugs, and cosmetics; simethicone is OTC drug", "eu": "approved in cosmetics; D4 and D5 cyclomethicone restricted in rinse-off products", "cir": "safe as used in cosmetics", "notes": "Dimethicone (linear silicone) is widely considered safe for human health. Cyclic silicones (D4, D5) are more concerning and restricted in EU rinse-off products due to environmental persistence and bioaccumulation. Simethicone is an FDA-approved OTC drug for gas relief."}',
  ARRAY['plant-based oils (argan, jojoba, squalane)', 'natural waxes', 'silicone-free hair products', 'shea butter', 'aloe vera'],
  ARRAY['hair conditioners', 'shampoos', 'skin moisturizers', 'primers', 'foundations', 'scar treatments', 'anti-gas medication', 'medical devices', 'cooking spray', 'baby products'],
  ARRAY['FDA', 'CIR', 'EFSA', 'ECHA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Nanoparticles (General)',
  'nanoparticles-general',
  ARRAY['nanomaterials', 'engineered nanoparticles', 'ENPs', 'nano-sized particles', 'ultrafine particles'],
  'other',
  6,
  ARRAY['cellular penetration', 'unknown long-term effects', 'inflammation', 'organ accumulation', 'regulatory gaps'],
  '{"acute": "Depends on material; nanoparticles can penetrate skin, lung, and gut barriers that larger particles cannot; inhalation of nanoparticles causes pulmonary inflammation", "chronic": "Ability to cross biological barriers (blood-brain barrier, placenta, cell membranes), cellular oxidative stress, DNA damage potential, organ accumulation (liver, spleen, kidneys), chronic inflammation, immune system modulation. Effects are material-specific and size-dependent. Many long-term effects remain unknown.", "vulnerable_groups": ["children", "pregnant women", "workers manufacturing or handling nanomaterials", "people with respiratory conditions"]}',
  '{"fda": "no nano-specific regulations, evaluated case by case", "eu": "nano ingredients must be labeled in cosmetics and food, REACH registration required", "notes": "EU requires labeling of nano ingredients in cosmetics (since 2013) and food (since 2014). FDA does not have nano-specific regulations. Major regulatory gap as nano forms of approved substances may have different toxicological profiles. Size, shape, surface chemistry all affect toxicity."}',
  ARRAY['non-nano versions of ingredients', 'conventional-sized particles', 'natural alternatives where available'],
  ARRAY['sunscreens (nano TiO2 and ZnO)', 'cosmetics', 'food packaging', 'food additives', 'textiles (nano-silver)', 'medical devices', 'supplements'],
  ARRAY['FDA', 'EFSA', 'ECHA', 'NIOSH', 'WHO', 'SCCS']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Carbon Nanotubes',
  'carbon-nanotubes',
  ARRAY['CNTs', 'single-walled carbon nanotubes', 'SWCNT', 'multi-walled carbon nanotubes', 'MWCNT', 'CAS 308068-56-6'],
  'other',
  8,
  ARRAY['asbestos-like pathology', 'mesothelioma risk', 'pulmonary fibrosis', 'carcinogenicity', 'biopersistence'],
  '{"acute": "Pulmonary inflammation, granuloma formation, fibrosis upon inhalation; severity depends on type, length, and rigidity", "chronic": "Asbestos-like pathogenicity for certain rigid, long multi-walled carbon nanotubes; mesothelioma in animal studies; pulmonary fibrosis; potential carcinogenicity; cardiovascular effects; extremely biopersistent; may cross biological barriers", "vulnerable_groups": ["workers manufacturing or handling CNTs", "researchers", "downstream manufacturing workers"]}',
  '{"fda": "no specific regulation", "eu": "MWCNT-7 classified as possibly carcinogenic (IARC)", "iarc": "MWCNT-7 classified as Group 2B possibly carcinogenic (2017)", "niosh": "recommended exposure limit established", "notes": "IARC classified one specific type (Fluoro MWCNT-7) as possibly carcinogenic. NIOSH set recommended exposure limits. The fiber paradigm (length, rigidity, biopersistence) determines carcinogenic potential, similar to asbestos. Not currently in consumer products in significant quantities."}',
  ARRAY['alternative reinforcement materials', 'graphene (for some applications)', 'conventional carbon fiber', 'proper engineering controls in workplaces'],
  ARRAY['advanced composites', 'electronics', 'energy storage', 'coatings', 'sporting goods', 'research laboratories'],
  ARRAY['IARC', 'NIOSH', 'WHO', 'OECD', 'EPA']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Nano Zinc Oxide',
  'nano-zinc-oxide',
  ARRAY['nano ZnO', 'zinc oxide nanoparticles', 'CAS 1314-13-2 (nano form)', 'nano zinc white'],
  'other',
  4,
  ARRAY['skin penetration debate', 'cellular toxicity in vitro', 'photocatalytic activity', 'aquatic toxicity', 'inhalation concern'],
  '{"acute": "Inhalation of nanoparticles causes pulmonary inflammation; skin application generally considered safe by most regulatory bodies", "chronic": "In vitro cytotoxicity and genotoxicity (relevance to in vivo debated), photocatalytic generation of reactive oxygen species, possible skin penetration through damaged skin, aquatic ecotoxicity, concerns about long-term dermal accumulation are under study", "vulnerable_groups": ["workers in manufacturing", "people with damaged or compromised skin", "aquatic organisms", "children (spray sunscreens - inhalation)"]}',
  '{"fda": "approved in sunscreens (any particle size)", "eu": "approved in sunscreens with conditions (coated nanoparticles, not to be inhaled, max 25%)", "sccs": "safe in cosmetics up to 25% as UV filter (coated, non-inhalable)", "notes": "EU SCCS opinion considers nano zinc oxide safe in sunscreens at up to 25% when coated to reduce photocatalytic activity and in non-spray forms. Australia TGA concluded it does not penetrate intact skin. Spray sunscreens with nano ZnO raise inhalation concerns."}',
  ARRAY['non-nano zinc oxide sunscreens', 'coated nano zinc oxide (reduced photocatalysis)', 'mineral sunscreens in lotion form (not spray)', 'clothing-based sun protection'],
  ARRAY['mineral sunscreens', 'cosmetics', 'anti-bacterial coatings', 'diaper cream (some formulations)', 'textile treatments'],
  ARRAY['FDA', 'SCCS', 'TGA (Australia)', 'EFSA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Nano Titanium Dioxide',
  'nano-titanium-dioxide',
  ARRAY['nano TiO2', 'titanium dioxide nanoparticles', 'CAS 13463-67-7 (nano form)', 'nano titania'],
  'other',
  5,
  ARRAY['photocatalytic activity', 'cellular toxicity', 'possible skin penetration', 'inhalation hazard', 'genotoxicity concern'],
  '{"acute": "Inhalation causes pulmonary inflammation; dermal application generally considered safe on intact skin", "chronic": "Photocatalytic activity generates reactive oxygen species (ROS) causing DNA damage, in vitro genotoxicity and cytotoxicity, possible penetration through damaged skin, pulmonary inflammation and fibrosis from inhalation, concerns about long-term accumulation, IARC Group 2B carcinogen for TiO2 broadly", "vulnerable_groups": ["workers in manufacturing", "people with damaged skin", "children (spray sunscreen inhalation risk)", "aquatic organisms"]}',
  '{"fda": "approved in sunscreens", "eu": "approved in sunscreens with restrictions (coated, non-spray, max 25%), banned as food additive (E171)", "sccs": "safe in cosmetics at up to 25% as UV filter (coated, non-inhalable)", "notes": "EU requires that nano TiO2 in sunscreens be coated to reduce photocatalytic activity and must not be in sprayable form. Banned as food additive E171 at any particle size in EU. The photocatalytic activity of uncoated nano TiO2 can damage skin cell DNA."}',
  ARRAY['non-nano titanium dioxide sunscreens', 'zinc oxide sunscreens', 'coated nano TiO2 (reduced photocatalysis)', 'lotion-form sunscreens (not spray)', 'UPF clothing'],
  ARRAY['mineral sunscreens', 'cosmetics', 'self-cleaning coatings', 'air purification systems', 'photocatalytic surfaces'],
  ARRAY['FDA', 'SCCS', 'EFSA', 'IARC', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Coal Tar',
  'coal-tar',
  ARRAY['coal tar solution', 'pix carbonis', 'CAS 8007-45-2', 'coal tar extract', 'LCD (liquor carbonis detergens)', 'crude coal tar'],
  'other',
  8,
  ARRAY['known carcinogen', 'photosensitivity', 'skin irritation', 'PAH content', 'mutagenicity'],
  '{"acute": "Skin irritation, photosensitivity (severe sunburn with UV exposure), stinging, folliculitis, contact dermatitis", "chronic": "Known human carcinogen (IARC Group 1): contains hundreds of PAHs including benzo[a]pyrene. Skin cancer risk with prolonged use, bladder cancer risk (occupational), lung cancer risk (occupational). Photosensitization increasing skin damage from UV exposure.", "vulnerable_groups": ["children", "pregnant women", "people with extensive or long-term use", "occupational exposure (road workers, roofers)"]}',
  '{"fda": "approved OTC active ingredient for psoriasis, seborrheic dermatitis, dandruff (0.5-5%)", "eu": "banned in cosmetics (2004), prescription use only for medical conditions", "iarc": "Group 1 known carcinogen (coal tar and coal-tar pitches)", "notes": "EU banned coal tar in cosmetics in 2004. FDA still permits it as an OTC drug for skin conditions. Contains PAHs that are known carcinogens. Used medicinally for over 100 years for psoriasis and eczema despite carcinogenicity."}',
  ARRAY['salicylic acid shampoos', 'zinc pyrithione shampoos', 'ketoconazole shampoos', 'prescription biologics for psoriasis', 'natural tar-free eczema treatments'],
  ARRAY['anti-dandruff shampoos', 'psoriasis treatments', 'eczema treatments', 'scalp treatments', 'roofing tar', 'road sealants'],
  ARRAY['IARC', 'FDA', 'EU Cosmetics Regulation', 'NTP', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Hydroquinone',
  'hydroquinone',
  ARRAY['1,4-benzenediol', 'CAS 123-31-9', 'HQ', 'hydroquinol', 'quinol', 'p-dihydroxybenzene', 'INCI: hydroquinone'],
  'other',
  7,
  ARRAY['carcinogenicity concern', 'ochronosis', 'skin sensitization', 'rebound hyperpigmentation', 'organ toxicity'],
  '{"acute": "Skin irritation, burning, redness, allergic contact dermatitis; ingestion causes nausea, vomiting, tinnitus, tremors, convulsions", "chronic": "Exogenous ochronosis (paradoxical permanent darkening and thickening of skin) with prolonged use, possible carcinogen (kidney tumors in rodents), liver damage, rebound hyperpigmentation upon discontinuation, skin sensitization, potential nephrotoxicity", "vulnerable_groups": ["pregnant women", "people with darker skin tones (higher ochronosis risk)", "children", "people using non-prescription high-concentration products"]}',
  '{"fda": "prescription only at 4% (2020 CARES Act removed OTC status), OTC no longer generally recognized as safe", "eu": "banned in cosmetics (2001), prescription only for medical use", "notes": "FDA removed OTC status in 2020; now prescription only in the US at 4% strength. EU banned from cosmetics in 2001. Illegally sold in high concentrations in many skin-lightening products worldwide. Mercury is sometimes combined with hydroquinone in illegal products."}',
  ARRAY['vitamin C (ascorbic acid)', 'niacinamide (vitamin B3)', 'arbutin (natural derivative)', 'azelaic acid', 'kojic acid', 'licorice root extract', 'tranexamic acid'],
  ARRAY['skin lightening creams', 'dark spot treatments', 'melasma treatments', 'age spot treatments', 'prescription depigmenting agents'],
  ARRAY['FDA', 'EU Cosmetics Regulation', 'CIR', 'WHO', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Resorcinol',
  'resorcinol',
  ARRAY['1,3-benzenediol', 'CAS 108-46-3', 'resorcin', 'm-dihydroxybenzene', 'INCI: resorcinol', '3-hydroxyphenol'],
  'other',
  6,
  ARRAY['endocrine disruption', 'thyroid disruption', 'skin sensitization', 'systemic toxicity', 'environmental toxicity'],
  '{"acute": "Skin irritation, allergic contact dermatitis, systemic absorption through skin causing dizziness, nausea, increased heart rate, methemoglobinemia in severe cases", "chronic": "Thyroid disruption (inhibits thyroid peroxidase, reduces thyroid hormone production), endocrine disruption, skin sensitization with repeated exposure, potential goitrogenic effects, CNS effects with chronic exposure", "vulnerable_groups": ["pregnant women", "people with thyroid conditions", "children", "people with compromised skin barrier"]}',
  '{"fda": "approved in OTC acne products (up to 2%), approved in hair dyes", "eu": "restricted in cosmetics (hair dye up to 5%, rinse-off products up to 0.5%)", "echa": "identified as SVHC candidate for endocrine disruption", "notes": "ECHA identified resorcinol as meeting criteria for Substance of Very High Concern due to endocrine disruption (thyroid). Widely used in hair dyes and some acne products. EU has concentration limits in cosmetics. Concern is primarily thyroid disruption."}',
  ARRAY['resorcinol-free hair dyes', 'henna and plant-based dyes', 'benzoyl peroxide for acne', 'salicylic acid for acne', 'sulfur-based acne treatments'],
  ARRAY['hair dyes', 'acne treatments', 'chemical peels', 'anti-itch medications', 'tire rubber manufacturing'],
  ARRAY['FDA', 'ECHA', 'SCCS', 'CIR', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'p-Phenylenediamine',
  'p-phenylenediamine',
  ARRAY['PPD', '1,4-diaminobenzene', 'CAS 106-50-3', 'para-phenylenediamine', 'CI 76060', 'INCI: p-phenylenediamine', '4-aminoaniline'],
  'other',
  8,
  ARRAY['severe allergic reactions', 'contact dermatitis', 'possible carcinogen', 'cross-sensitization', 'systemic toxicity'],
  '{"acute": "Severe allergic contact dermatitis (blistering, swelling, weeping), facial angioedema, anaphylaxis in sensitized individuals; ingestion is potentially fatal (renal failure, rhabdomyolysis)", "chronic": "Strong contact sensitizer (allergy develops with repeated exposure), cross-reacts with other para-amino compounds (benzocaine, PABA, sulfonamides), possible carcinogen (bladder cancer association in hairdressers), respiratory sensitization, kidney and liver damage", "vulnerable_groups": ["people with PPD allergy", "hairdressers and barbers", "people who use black henna tattoos", "children", "people with para-amino compound allergies"]}',
  '{"fda": "approved in oxidative hair dyes (not for direct skin application, eyelashes, or eyebrows)", "eu": "restricted to max 2% in hair dyes with mandatory warning labels, banned in black henna tattoos", "sccs": "safe in oxidative hair dyes up to 2% with proper precautions", "notes": "Most common cause of allergic contact dermatitis from hair dyes. Black henna temporary tattoos (containing PPD) are a major source of sensitization, especially in children. Once sensitized, allergy is lifelong and cross-reacts with many chemicals."}',
  ARRAY['PPD-free hair dyes', 'henna (pure Lawsonia inermis)', 'plant-based hair dyes', 'semi-permanent dyes (lower PPD alternatives)', 'demi-permanent dyes'],
  ARRAY['permanent hair dyes', 'black henna tattoos', 'dark-colored cosmetics', 'textile dyes', 'fur dyes', 'photographic developer (historical)'],
  ARRAY['SCCS', 'FDA', 'ECHA', 'British Journal of Dermatology', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Toluene-2,5-Diamine',
  'toluene-2-5-diamine',
  ARRAY['2,5-diaminotoluene', 'PTD', 'CAS 95-70-5', 'toluene-2,5-diamine sulfate', 'CAS 615-50-9', 'CI 76042', '2-methyl-1,4-benzenediamine'],
  'other',
  7,
  ARRAY['contact sensitization', 'possible carcinogen', 'mutagenicity', 'cross-reactivity with PPD', 'respiratory sensitization'],
  '{"acute": "Allergic contact dermatitis, skin irritation, facial swelling in sensitized individuals; similar but often slightly milder than PPD reactions", "chronic": "Contact sensitizer (cross-reacts with PPD), mutagenic in some test systems, possible carcinogen based on structural similarity to PPD, respiratory sensitization in occupational exposure, liver effects in animal studies", "vulnerable_groups": ["people with PPD allergy (cross-reactivity)", "hairdressers", "pregnant women", "children"]}',
  '{"fda": "approved in oxidative hair dyes", "eu": "restricted to max 3.5% in hair dyes (as sulfate salt), mandatory allergy warning", "sccs": "safe in oxidative hair dyes at specified concentrations with precautions", "notes": "Second most common hair dye allergen after PPD. Cross-reacts with PPD in most sensitized individuals. Often used as PPD alternative but provides limited benefit for PPD-allergic individuals due to cross-reactivity. Mutagenic potential requires careful risk assessment."}',
  ARRAY['PPD-free and PTD-free hair dyes', 'henna (pure)', 'plant-based hair colors', 'HC dyes (semi-permanent)', 'ME+ technology hair dyes'],
  ARRAY['permanent hair dyes', 'professional hair color', 'home hair dye kits', 'some textile dyes'],
  ARRAY['SCCS', 'FDA', 'CIR', 'ECHA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Ammonia (Hair Products)',
  'ammonia-hair-products',
  ARRAY['ammonium hydroxide', 'NH3', 'CAS 7664-41-7', 'aqua ammonia', 'ammonia solution', 'spirit of hartshorn'],
  'other',
  5,
  ARRAY['respiratory irritant', 'scalp irritation', 'hair damage', 'eye irritant', 'chemical burns at high concentration'],
  '{"acute": "Strong respiratory irritant (coughing, burning sensation, difficulty breathing), severe eye irritation and burns, scalp irritation and chemical burns from hair dye application, headache, nausea from fumes", "chronic": "Repeated exposure causes chronic respiratory irritation, occupational asthma in hairdressers, progressive hair damage (cuticle lifting, protein loss, breakage), scalp sensitization, indoor air quality degradation during salon use", "vulnerable_groups": ["hairdressers (occupational asthma)", "people with asthma or respiratory conditions", "pregnant women (fume exposure)", "people with sensitive scalps"]}',
  '{"fda": "approved in hair dyes and cosmetics", "eu": "approved in cosmetics with restrictions (max 6% free ammonia in hair products)", "osha": "occupational exposure limits for ammonia gas", "notes": "Used as alkalizing agent to open hair cuticle and allow dye penetration. Ammonia-free hair dyes use ethanolamine or MEA as alternatives, which may be less irritating to respiratory tract but can cause more hair damage. Salon ventilation is important."}',
  ARRAY['ammonia-free hair dyes (ethanolamine-based)', 'demi-permanent hair color', 'henna and plant-based dyes', 'semi-permanent dyes', 'proper salon ventilation'],
  ARRAY['permanent hair dyes', 'hair lighteners/bleach', 'hair relaxers', 'some cleaning products', 'salon treatments'],
  ARRAY['FDA', 'OSHA', 'SCCS', 'CIR', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Hydrogen Peroxide (Cosmetics)',
  'hydrogen-peroxide-cosmetics',
  ARRAY['H2O2', 'CAS 7722-84-1', 'peroxide', 'INCI: hydrogen peroxide', 'dihydrogen dioxide'],
  'other',
  4,
  ARRAY['oxidative damage', 'scalp irritation', 'hair damage', 'eye injury risk', 'mucosal irritation'],
  '{"acute": "Skin bleaching and irritation, chemical burns at high concentrations, severe eye damage, scalp burns from hair treatments, ingestion causes GI irritation and oxygen gas embolism at high concentrations", "chronic": "Progressive hair damage (protein degradation, cuticle destruction, breakage), gum and oral tissue damage from teeth whitening, potential oral cancer concern from chronic oral use (debated), oxidative DNA damage, chronic scalp irritation", "vulnerable_groups": ["children (ingestion risk)", "hairdressers (chronic exposure)", "people with sensitive skin or scalp", "people overusing teeth whitening products"]}',
  '{"fda": "approved OTC antiseptic (3%), approved in tooth whitening products, approved in hair products", "eu": "restricted in hair products (max 12% with professional use), max 0.1% in oral products for general use", "notes": "Concentration-dependent effects. 3% solution is a common household antiseptic. Hair bleaching uses 6-12%. Teeth whitening products use 3-10% (OTC) or up to 38% (dental office). EU limits are stricter than US. Safe when used correctly at appropriate concentrations."}',
  ARRAY['vitamin C-based hair lighteners', 'lemon juice (mild, natural)', 'enzyme-based stain removers', 'peroxide-free teeth whitening (PAP-based)', 'lower concentration products'],
  ARRAY['hair bleach and lighteners', 'permanent hair dye (developer)', 'teeth whitening products', 'antiseptic solutions', 'acne treatments', 'ear wax removal drops'],
  ARRAY['FDA', 'SCCS', 'ADA', 'CIR', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();

INSERT INTO public.ingredients (name, slug, aliases, category, toxicity_score, concerns, health_effects, regulatory_status, safe_alternatives, commonly_found_in, sources)
VALUES (
  'Thioglycolate',
  'thioglycolate',
  ARRAY['ammonium thioglycolate', 'calcium thioglycolate', 'glycolic acid thiol', 'CAS 68-11-1', 'thioglycolic acid', 'mercaptoacetic acid', 'INCI: ammonium thioglycolate'],
  'other',
  5,
  ARRAY['skin irritation', 'chemical burns', 'allergic reactions', 'hair damage', 'respiratory irritation'],
  '{"acute": "Strong skin and eye irritation, chemical burns from prolonged contact or high concentration, allergic contact dermatitis, scalp irritation and burns, respiratory irritation from fumes, nausea and headache", "chronic": "Contact sensitization, chronic scalp and skin irritation, progressive hair weakening and breakage, respiratory sensitization in hairdressers, nail damage from repeated depilatory use", "vulnerable_groups": ["people with sensitive skin", "hairdressers (occupational exposure)", "children", "people with allergies to thioglycolate"]}',
  '{"fda": "approved in cosmetics (hair straighteners, perms, depilatories)", "eu": "restricted in cosmetics (max 11% as thioglycolic acid in hair products, max 5% in depilatories)", "notes": "Primary active ingredient in chemical hair straighteners, permanent wave solutions, and depilatory creams. Works by breaking disulfide bonds in hair keratin. Can cause severe chemical burns if left on too long or used at too high concentration. pH of products is critical for safety."}',
  ARRAY['physical hair removal (waxing, sugaring, threading)', 'laser hair removal', 'heat-based hair straightening', 'keratin treatments (formaldehyde-free)', 'natural hair care methods'],
  ARRAY['chemical hair straighteners', 'permanent wave solutions', 'depilatory creams (Nair, Veet)', 'curl relaxers', 'some professional salon treatments'],
  ARRAY['FDA', 'SCCS', 'CIR', 'OSHA', 'EWG']
)
ON CONFLICT (slug) DO UPDATE SET
  name = EXCLUDED.name, aliases = EXCLUDED.aliases, category = EXCLUDED.category,
  toxicity_score = EXCLUDED.toxicity_score, concerns = EXCLUDED.concerns,
  health_effects = EXCLUDED.health_effects, regulatory_status = EXCLUDED.regulatory_status,
  safe_alternatives = EXCLUDED.safe_alternatives, commonly_found_in = EXCLUDED.commonly_found_in,
  sources = EXCLUDED.sources, updated_at = NOW();


-- Rebuild IVFFlat index after bulk insert
REINDEX INDEX idx_ingredients_embedding;
