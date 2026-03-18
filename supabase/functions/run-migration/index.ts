import postgres from 'https://deno.land/x/postgresjs@v3.4.5/mod.js'

Deno.serve(async () => {
  const dbUrl = Deno.env.get('SUPABASE_DB_URL')!
  const sql = postgres(dbUrl, { ssl: 'require' })

  try {
    await sql`
      CREATE TABLE IF NOT EXISTS swap_misses (
        subcategory        text PRIMARY KEY,
        category           text,
        example_product    text,
        miss_count         integer NOT NULL DEFAULT 1,
        last_seen_at       timestamptz NOT NULL DEFAULT now(),
        auto_populated_at  timestamptz
      )
    `
    await sql`
      CREATE OR REPLACE FUNCTION log_swap_miss(
        p_subcategory   text,
        p_category      text DEFAULT NULL,
        p_product_name  text DEFAULT NULL
      ) RETURNS void LANGUAGE plpgsql SECURITY DEFINER AS $$
      BEGIN
        INSERT INTO swap_misses (subcategory, category, example_product, miss_count, last_seen_at)
        VALUES (p_subcategory, p_category, p_product_name, 1, now())
        ON CONFLICT (subcategory) DO UPDATE SET
          miss_count      = swap_misses.miss_count + 1,
          last_seen_at    = now(),
          category        = COALESCE(EXCLUDED.category,       swap_misses.category),
          example_product = COALESCE(EXCLUDED.example_product, swap_misses.example_product);
      END;
      $$
    `
    await sql`GRANT EXECUTE ON FUNCTION log_swap_miss TO service_role`
    await sql`ALTER TABLE swaps ADD COLUMN IF NOT EXISTS source text DEFAULT 'manual'`

    // Subcategories table — master list, can grow via discover-subcategories
    await sql`
      CREATE TABLE IF NOT EXISTS subcategories (
        name       text PRIMARY KEY,
        category   text NOT NULL,
        source     text NOT NULL DEFAULT 'manual',
        created_at timestamptz NOT NULL DEFAULT now()
      )
    `
    await sql`GRANT SELECT ON subcategories TO anon, authenticated, service_role`

    // Seed all known subcategories (ON CONFLICT DO NOTHING = idempotent)
    await sql`
      INSERT INTO subcategories (name, category) VALUES
        ('dish_soap','cleaning'),('dishwasher_detergent','cleaning'),('laundry_detergent','cleaning'),
        ('all_purpose_cleaner','cleaning'),('bathroom_cleaner','cleaning'),('floor_cleaner','cleaning'),
        ('glass_cleaner','cleaning'),('surface_cleaner','cleaning'),('stain_remover','cleaning'),
        ('drain_cleaner','cleaning'),('toilet_cleaner','cleaning'),('mold_remover','cleaning'),
        ('fabric_softener','cleaning'),('dryer_sheets','cleaning'),('carpet_cleaner','cleaning'),
        ('hand_soap','personal_care'),('body_wash','personal_care'),('bar_soap','personal_care'),
        ('shampoo','personal_care'),('conditioner','personal_care'),('hair_treatment','personal_care'),
        ('dry_shampoo','personal_care'),('face_wash','personal_care'),('face_scrub','personal_care'),
        ('toner','personal_care'),('face_serum','personal_care'),('moisturizer','personal_care'),
        ('eye_cream','personal_care'),('face_mask','personal_care'),('face_oil','personal_care'),
        ('lip_balm','personal_care'),('lip_gloss','personal_care'),('deodorant','personal_care'),
        ('antiperspirant','personal_care'),('hair_gel','personal_care'),('hair_spray','personal_care'),
        ('hair_mousse','personal_care'),('hair_wax','personal_care'),('hair_serum','personal_care'),
        ('hair_oil','personal_care'),('hair_mask','personal_care'),('hair_dye','personal_care'),
        ('leave_in_conditioner','personal_care'),('sunscreen_lotion','personal_care'),
        ('sunscreen_spray','personal_care'),('sunscreen_stick','personal_care'),
        ('bug_spray','personal_care'),('bug_repellent_lotion','personal_care'),
        ('toothpaste','personal_care'),('mouthwash','personal_care'),('teeth_whitening','personal_care'),
        ('dental_floss','personal_care'),('shaving_cream','personal_care'),('body_oil','personal_care'),
        ('toothbrush','personal_care'),
        ('foundation','makeup'),('concealer','makeup'),('blush','makeup'),('bronzer','makeup'),
        ('highlighter','makeup'),('eye_shadow','makeup'),('eye_liner','makeup'),('mascara','makeup'),
        ('eye_makeup_remover','makeup'),('nail_polish','makeup'),('nail_polish_remover','makeup'),
        ('baby_wipes','baby'),('diapers','baby'),('baby_formula','baby'),('baby_lotion','baby'),
        ('baby_sunscreen','baby'),('baby_shampoo','baby'),('baby_body_wash','baby'),
        ('baby_powder','baby'),('diaper_cream','baby'),
        ('cooking_oil','food'),('olive_oil','food'),('coconut_oil','food'),('avocado_oil','food'),
        ('vegetable_oil','food'),('butter','food'),('ghee','food'),('margarine','food'),
        ('ketchup','food'),('mustard','food'),('mayonnaise','food'),('hot_sauce','food'),
        ('salsa','food'),('bbq_sauce','food'),('salad_dressing','food'),('vinegar','food'),
        ('soy_sauce','food'),('marinade','food'),('pasta_sauce','food'),('jam','food'),
        ('honey','food'),('maple_syrup','food'),('flour','food'),('sugar','food'),('salt','food'),
        ('spices','food'),('bread','food'),('tortilla','food'),('crackers','food'),('rice','food'),
        ('pasta','food'),('noodles','food'),('cereal','food'),('oats','food'),('granola','food'),
        ('canned_goods','food'),('beans','food'),('soup','food'),('nut_butter','food'),
        ('nuts','food'),('seeds','food'),('dried_fruit','food'),('plant_based_milk','food'),
        ('dairy_milk','food'),('yogurt','food'),('cheese','food'),('eggs','food'),
        ('meat','food'),('seafood','food'),('tofu','food'),
        ('chips','snacks'),('popcorn','snacks'),('cookies','snacks'),('candy','snacks'),
        ('chocolate','snacks'),('protein_bar','snacks'),('granola_bar','snacks'),
        ('fruit_snack','snacks'),('jerky','snacks'),('trail_mix','snacks'),
        ('coffee','beverages'),('tea','beverages'),('kombucha','beverages'),
        ('sparkling_water','beverages'),('juice','beverages'),('sports_drink','beverages'),
        ('energy_drink','beverages'),('soda','beverages'),('plant_based_drink','beverages'),
        ('protein_shake','beverages'),('electrolyte_drink','beverages'),
        ('multivitamin','supplements'),('vitamin_d','supplements'),('vitamin_c','supplements'),
        ('vitamin_b','supplements'),('omega_3','supplements'),('fish_oil','supplements'),
        ('probiotic','supplements'),('prebiotic','supplements'),('collagen','supplements'),
        ('protein_powder','supplements'),('creatine','supplements'),('magnesium','supplements'),
        ('zinc','supplements'),('iron','supplements'),('melatonin','supplements'),
        ('ashwagandha','supplements'),('turmeric','supplements'),
        ('cookware','kitchen'),('bakeware','kitchen'),('knife','kitchen'),
        ('cutting_board','kitchen'),('utensils','kitchen'),('food_storage','kitchen'),
        ('water_bottle','kitchen'),('food_wrap','kitchen'),
        ('air_freshener','home'),('candle','home'),('diffuser_oil','home'),('pest_control','home'),
        ('trash_bag','home'),('paper_towel','home'),('toilet_paper','home'),
        ('mattress','home'),('pillow','home'),('bedding','home'),('furniture','home'),('rug','home'),
        ('clothing','clothing'),
        ('pet_food','pet'),('pet_treat','pet')
      ON CONFLICT (name) DO NOTHING
    `
    await sql`CREATE EXTENSION IF NOT EXISTS pg_cron`
    await sql`CREATE EXTENSION IF NOT EXISTS pg_net`
    await sql`SELECT cron.unschedule('populate-swaps')`.catch(() => {})
    await sql`SELECT cron.unschedule('seed-swaps')`.catch(() => {})
    await sql`SELECT cron.unschedule('discover-subcategories')`.catch(() => {})
    await sql`
      SELECT cron.schedule(
        'populate-swaps',
        '0 */6 * * *',
        $$
        SELECT net.http_post(
          url     := 'https://dzdhkojarygvfjcgesbz.supabase.co/functions/v1/populate-swaps',
          headers := '{"Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6ZGhrb2phcnlndmZqY2dlc2J6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTcyNTExMCwiZXhwIjoyMDgxMzAxMTEwfQ.peHAZiZW7Ne-We54CbtHHKLSE69rq5dRAQmWI9NmTWM","Content-Type":"application/json"}'::jsonb,
          body    := '{}'::jsonb
        )
        $$
      )
    `

    // Schedule seed-swaps — proactive filler, runs every 6 hours offset by 3h from populate-swaps
    await sql`
      SELECT cron.schedule(
        'seed-swaps',
        '0 3,9,15,21 * * *',
        $$
        SELECT net.http_post(
          url     := 'https://dzdhkojarygvfjcgesbz.supabase.co/functions/v1/seed-swaps',
          headers := '{"Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6ZGhrb2phcnlndmZqY2dlc2J6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTcyNTExMCwiZXhwIjoyMDgxMzAxMTEwfQ.peHAZiZW7Ne-We54CbtHHKLSE69rq5dRAQmWI9NmTWM","Content-Type":"application/json"}'::jsonb,
          body    := '{}'::jsonb
        )
        $$
      )
    `

    // discover-subcategories — weekly on Sunday at 2am
    await sql`
      SELECT cron.schedule(
        'discover-subcategories',
        '0 2 * * 0',
        $$
        SELECT net.http_post(
          url     := 'https://dzdhkojarygvfjcgesbz.supabase.co/functions/v1/discover-subcategories',
          headers := '{"Authorization":"Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImR6ZGhrb2phcnlndmZqY2dlc2J6Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc2NTcyNTExMCwiZXhwIjoyMDgxMzAxMTEwfQ.peHAZiZW7Ne-We54CbtHHKLSE69rq5dRAQmWI9NmTWM","Content-Type":"application/json"}'::jsonb,
          body    := '{}'::jsonb
        )
        $$
      )
    `

    await sql.end()
    return new Response(JSON.stringify({ ok: true, message: 'Migration applied' }), {
      headers: { 'Content-Type': 'application/json' }
    })
  } catch (err) {
    await sql.end()
    return new Response(JSON.stringify({ ok: false, error: String(err) }), {
      status: 500, headers: { 'Content-Type': 'application/json' }
    })
  }
})
