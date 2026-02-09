-- ============================================================================
-- Seed swap products: cookware, storage, paint, garden, clothing
-- Real brands with genuine non-toxic certifications
-- ============================================================================

INSERT INTO public.swaps (name, brand, category, score, why_better, badges, available_stores, is_active, replaces_ingredients, replaces_products)
VALUES
  -- ==========================================================================
  -- COOKWARE (4 products)
  -- ==========================================================================
  (
    'Lodge 12-Inch Cast Iron Skillet',
    'Lodge',
    'cookware',
    92,
    'Bare cast iron is naturally non-toxic with no synthetic coatings. Seasoned with vegetable oil, it improves with use and can last generations. Also adds trace dietary iron to food.',
    ARRAY['PFAS-Free', 'PFOA-Free', 'Lead-Free', 'Cadmium-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Williams Sonoma', 'REI', 'Coupang'],
    true,
    ARRAY['PFAS', 'PFOA', 'PTFE', 'GenX'],
    ARRAY['Teflon skillet', 'non-stick frying pan', 'coated skillet']
  ),
  (
    'Caraway Non-Toxic Ceramic Cookware Set',
    'Caraway',
    'cookware',
    90,
    'Ceramic-coated cookware free from PFAS, PFOA, PTFE, and other toxic chemicals. Uses a mineral-based ceramic coating that does not release harmful fumes even at high temperatures.',
    ARRAY['PFAS-Free', 'PFOA-Free', 'Lead-Free', 'Cadmium-Free'],
    ARRAY['Amazon', 'Target', 'Caraway.com', 'Coupang'],
    true,
    ARRAY['PFAS', 'PFOA', 'PTFE', 'GenX', 'cadmium', 'lead'],
    ARRAY['Teflon cookware set', 'non-stick pan set', 'coated pots and pans']
  ),
  (
    'All-Clad D3 Stainless Steel 10-Piece Set',
    'All-Clad',
    'cookware',
    94,
    'Tri-ply stainless steel construction with no coatings or chemicals. Fully non-reactive cooking surface that will not leach toxins. American-made and built to last a lifetime.',
    ARRAY['PFAS-Free', 'PFOA-Free', 'Lead-Free', 'Cadmium-Free'],
    ARRAY['Amazon', 'Williams Sonoma', 'Sur La Table', 'Coupang'],
    true,
    ARRAY['PFAS', 'PFOA', 'PTFE', 'GenX', 'aluminum'],
    ARRAY['Teflon cookware set', 'non-stick cookware', 'coated pots and pans']
  ),
  (
    'Xtrema Pure Ceramic Skillet',
    'Xtrema',
    'cookware',
    95,
    '100% pure ceramic with zero coatings, glazes, or dyes. Independently tested and certified free of lead, cadmium, and all heavy metals. Safe for oven, stovetop, microwave, and dishwasher.',
    ARRAY['PFAS-Free', 'PFOA-Free', 'Lead-Free', 'Cadmium-Free'],
    ARRAY['Amazon', 'Xtrema.com', 'Coupang'],
    true,
    ARRAY['PFAS', 'PFOA', 'PTFE', 'GenX', 'lead', 'cadmium', 'aluminum'],
    ARRAY['Teflon skillet', 'non-stick frying pan', 'coated ceramic pan']
  ),

  -- ==========================================================================
  -- STORAGE (3 products)
  -- ==========================================================================
  (
    'Pyrex Simply Store Glass Container Set',
    'Pyrex',
    'storage',
    91,
    'Borosilicate-style tempered glass is completely non-reactive and does not leach chemicals into food. BPA-free lids keep food fresh without plastic touching food directly. Microwave and dishwasher safe.',
    ARRAY['PFAS-Free', 'Lead-Free', 'Cadmium-Free'],
    ARRAY['Amazon', 'Target', 'Walmart', 'Coupang'],
    true,
    ARRAY['BPA', 'BPS', 'phthalates', 'PFAS', 'styrene'],
    ARRAY['plastic containers', 'Tupperware', 'plastic food storage']
  ),
  (
    'Bee''s Wrap Reusable Food Wraps',
    'Bee''s Wrap',
    'storage',
    88,
    'Made from organic cotton, beeswax, jojoba oil, and tree resin. Replaces single-use plastic wrap without any synthetic chemicals. Compostable at end of life and GOTS certified organic cotton.',
    ARRAY['PFAS-Free', 'GOTS Certified', 'B Corp'],
    ARRAY['Amazon', 'Target', 'Whole Foods', 'REI', 'Coupang'],
    true,
    ARRAY['PFAS', 'PVC', 'phthalates', 'PVDC', 'BPA'],
    ARRAY['plastic wrap', 'Saran wrap', 'cling film', 'Press''n Seal']
  ),
  (
    'U-Konserve Stainless Steel Food Container',
    'U-Konserve',
    'storage',
    89,
    'Food-grade 18/8 stainless steel is completely non-toxic and will not leach chemicals into food. No plastic linings or coatings. Durable enough to last years and fully recyclable.',
    ARRAY['PFAS-Free', 'Lead-Free', 'Cadmium-Free', 'B Corp'],
    ARRAY['Amazon', 'REI', 'Coupang'],
    true,
    ARRAY['BPA', 'BPS', 'phthalates', 'PFAS', 'styrene'],
    ARRAY['plastic containers', 'Tupperware', 'plastic lunch box', 'plastic food storage']
  ),

  -- ==========================================================================
  -- PAINT (3 products)
  -- ==========================================================================
  (
    'Benjamin Moore Natura Interior Paint',
    'Benjamin Moore',
    'paint',
    90,
    'Zero-VOC formula with zero emissions from the start. GREENGUARD Gold certified for use in schools and healthcare facilities. No added solvents, no chemical off-gassing after application.',
    ARRAY['Zero VOC', 'GREENGUARD Gold'],
    ARRAY['Benjamin Moore retailers', 'Home Depot', 'Coupang'],
    true,
    ARRAY['VOCs', 'formaldehyde', 'benzene', 'toluene', 'ethylene glycol', 'methylene chloride'],
    ARRAY['standard interior paint', 'conventional wall paint', 'latex paint']
  ),
  (
    'ECOS Interior Wall Paint',
    'ECOS Paints',
    'paint',
    93,
    'Zero-VOC, zero-toxin formula with no harmful chemicals even in the colorants. Safe for chemically sensitive individuals. Made without formaldehyde, ammonia, crystalline silica, or ethylene glycol.',
    ARRAY['Zero VOC', 'GREENGUARD Gold'],
    ARRAY['Amazon', 'ECOS Paints website', 'Coupang'],
    true,
    ARRAY['VOCs', 'formaldehyde', 'ammonia', 'crystalline silica', 'ethylene glycol', 'benzene'],
    ARRAY['standard interior paint', 'conventional wall paint', 'latex paint']
  ),
  (
    'Sherwin-Williams Harmony Interior Paint',
    'Sherwin-Williams',
    'paint',
    88,
    'Zero-VOC formula with antimicrobial agents that help reduce odors from common household sources. GREENGUARD Gold certified. Widely available at over 4,000 Sherwin-Williams stores.',
    ARRAY['Zero VOC', 'GREENGUARD Gold'],
    ARRAY['Sherwin-Williams stores', 'Lowe''s', 'Coupang'],
    true,
    ARRAY['VOCs', 'formaldehyde', 'benzene', 'toluene', 'ethylene glycol'],
    ARRAY['standard interior paint', 'conventional wall paint', 'latex paint']
  ),

  -- ==========================================================================
  -- GARDEN (3 products)
  -- ==========================================================================
  (
    'Dr. Earth Organic All Purpose Fertilizer',
    'Dr. Earth',
    'garden',
    91,
    'OMRI-listed organic fertilizer made from fish bone meal, feather meal, and beneficial soil microbes. Contains no synthetic chemicals, GMOs, or sewage sludge. Safe for people, pets, and the planet.',
    ARRAY['PFAS-Free', 'OEKO-TEX'],
    ARRAY['Amazon', 'Home Depot', 'Lowe''s', 'Coupang'],
    true,
    ARRAY['glyphosate', 'synthetic nitrogen', 'ammonium sulfate', 'organophosphates'],
    ARRAY['Miracle-Gro', 'synthetic fertilizer', 'chemical plant food']
  ),
  (
    'Neem Bliss Pure Organic Neem Oil',
    'Neem Bliss',
    'garden',
    87,
    'Cold-pressed 100% pure neem oil acts as a natural insecticide, fungicide, and miticide. Breaks down quickly in the environment with no toxic residues. Safe to use around bees when applied correctly.',
    ARRAY['PFAS-Free'],
    ARRAY['Amazon', 'Home Depot', 'Coupang'],
    true,
    ARRAY['permethrin', 'pyrethroids', 'organophosphates', 'neonicotinoids', 'glyphosate'],
    ARRAY['Raid spray', 'chemical pesticide', 'synthetic insecticide', 'conventional bug spray']
  ),
  (
    'Safer Brand Insecticidal Soap Concentrate',
    'Safer Brand',
    'garden',
    85,
    'Made from potassium salts of fatty acids derived from natural plant oils. Kills insects on contact but breaks down rapidly, leaving no toxic residue. OMRI-listed for organic gardening.',
    ARRAY['PFAS-Free'],
    ARRAY['Amazon', 'Home Depot', 'Lowe''s', 'Walmart', 'Coupang'],
    true,
    ARRAY['permethrin', 'pyrethroids', 'organophosphates', 'neonicotinoids', 'carbaryl'],
    ARRAY['Raid spray', 'chemical pesticide', 'conventional insecticide', 'Ortho Bug Spray']
  ),

  -- ==========================================================================
  -- CLOTHING (3 products)
  -- ==========================================================================
  (
    'Pact Organic Cotton Essential Tee',
    'Pact',
    'clothing',
    90,
    'Made from 100% GOTS-certified organic cotton grown without synthetic pesticides or fertilizers. Fair Trade Certified factory ensures ethical production. Free from formaldehyde, AZO dyes, and heavy metals.',
    ARRAY['GOTS Certified', 'Fair Trade', 'OEKO-TEX'],
    ARRAY['Amazon', 'Target', 'Pact website', 'Coupang'],
    true,
    ARRAY['formaldehyde', 'AZO dyes', 'PFAS', 'phthalates', 'heavy metals', 'pesticide residues'],
    ARRAY['conventional cotton tee', 'fast fashion t-shirt', 'polyester shirt']
  ),
  (
    'Patagonia Regenerative Organic Cotton Tee',
    'Patagonia',
    'clothing',
    92,
    'Made with Regenerative Organic Certified cotton that rebuilds soil health and sequesters carbon. Fair Trade Certified sewn. No PFAS treatments, and colored with low-impact dyes meeting bluesign standards.',
    ARRAY['GOTS Certified', 'Fair Trade', 'OEKO-TEX', 'B Corp'],
    ARRAY['Patagonia.com', 'REI', 'Coupang'],
    true,
    ARRAY['formaldehyde', 'AZO dyes', 'PFAS', 'phthalates', 'heavy metals', 'pesticide residues'],
    ARRAY['conventional cotton tee', 'fast fashion t-shirt', 'performance shirt with PFAS']
  ),
  (
    'Burt''s Bees Baby Organic Cotton Bodysuit',
    'Burt''s Bees Baby',
    'clothing',
    91,
    'Made from 100% GOTS-certified organic cotton that is gentle on baby skin. Free from chlorine bleach, formaldehyde, and harmful dyes. OEKO-TEX Standard 100 certified safe for infants.',
    ARRAY['GOTS Certified', 'OEKO-TEX'],
    ARRAY['Amazon', 'Target', 'Walmart', 'buybuyBaby', 'Coupang'],
    true,
    ARRAY['formaldehyde', 'AZO dyes', 'flame retardants', 'PFAS', 'chlorine bleach', 'heavy metals'],
    ARRAY['conventional baby clothes', 'polyester baby bodysuit', 'standard baby onesie']
  )
;
