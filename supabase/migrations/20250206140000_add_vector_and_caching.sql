-- ============================================================================
-- Non-Toxic Living: Enhanced Schema with Vector Search & Smart Caching
-- ============================================================================
-- This migration adds:
-- 1. pgvector extension for semantic search
-- 2. Smart caching fields (freshness tracking, versioning)
-- 3. Vector embeddings for products and ingredients
-- 4. Optimized indexes for performance
-- ============================================================================

-- Enable extensions
CREATE EXTENSION IF NOT EXISTS "pg_trgm";      -- Fuzzy text search
CREATE EXTENSION IF NOT EXISTS "vector";        -- pgvector for embeddings

-- ============================================================================
-- PROFILES TABLE (extends Supabase auth.users)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.profiles (
  id UUID REFERENCES auth.users(id) ON DELETE CASCADE PRIMARY KEY,
  display_name TEXT,
  avatar_url TEXT,
  subscription TEXT DEFAULT 'free' CHECK (subscription IN ('free', 'pro', 'family')),
  subscription_expires_at TIMESTAMPTZ,

  -- Scan quota tracking
  scans_this_month INTEGER DEFAULT 0,
  scans_month_reset_at TIMESTAMPTZ DEFAULT DATE_TRUNC('month', NOW()) + INTERVAL '1 month',

  preferences JSONB DEFAULT '{
    "concernPriorities": ["chemicals", "additives", "allergens"],
    "dietaryRestrictions": [],
    "familyMode": false,
    "notifications": true
  }',

  stats JSONB DEFAULT '{
    "totalScans": 0,
    "toxinsAvoided": 0,
    "swapsMade": 0,
    "streakDays": 0,
    "lastScanDate": null
  }',

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- PRODUCTS TABLE (cached product analyses)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.products (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,

  -- Identification
  name TEXT NOT NULL,
  brand TEXT,
  category TEXT NOT NULL,
  barcode TEXT UNIQUE,                          -- Primary lookup key
  upc TEXT,                                     -- Alternative barcode format

  -- Analysis results
  score INTEGER CHECK (score >= 0 AND score <= 100),
  verdict TEXT CHECK (verdict IN ('safe', 'caution', 'toxic')),
  summary TEXT,
  dads_take TEXT,
  analysis JSONB,                               -- Full analysis JSON

  -- Ingredients (structured + raw)
  ingredients TEXT[],                           -- Array of ingredient names
  ingredients_raw TEXT,                         -- Raw OCR text for reference
  ingredient_hash TEXT,                         -- Hash to detect changes

  -- Smart caching fields
  analysis_version INTEGER DEFAULT 1,           -- Increment when we update AI prompts
  last_analyzed_at TIMESTAMPTZ DEFAULT NOW(),
  confidence_score FLOAT DEFAULT 0.8,           -- OCR confidence when analyzed
  cache_ttl_days INTEGER DEFAULT 90,            -- How long to trust this cache
  manual_refresh_count INTEGER DEFAULT 0,       -- Track user refresh requests

  -- Vector embedding for semantic search
  embedding vector(1536),                       -- text-embedding-3-small dimension

  -- Metadata
  image_url TEXT,
  source TEXT DEFAULT 'user_scan',              -- 'user_scan', 'database_seed', 'api_import'
  scan_count INTEGER DEFAULT 1,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SCANS TABLE (user scan history)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.scans (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  product_id UUID REFERENCES public.products(id) ON DELETE SET NULL,

  -- Scan results (denormalized for quick access)
  product_name TEXT,
  brand TEXT,
  score INTEGER CHECK (score >= 0 AND score <= 100),
  verdict TEXT CHECK (verdict IN ('safe', 'caution', 'toxic')),

  -- Full analysis (in case product cache is cleared)
  analysis JSONB NOT NULL,

  -- OCR tracking
  ocr_source TEXT CHECK (ocr_source IN ('device', 'cloud', 'ai-mini', 'ai-vision')),
  ocr_confidence FLOAT,

  -- Scan metadata
  image_path TEXT,
  barcode TEXT,
  was_cached BOOLEAN DEFAULT false,             -- Did we use cached result?
  ai_model_used TEXT,                           -- Which model analyzed this

  -- User actions
  saved_to_list TEXT CHECK (saved_to_list IN ('favorites', 'avoid')),
  user_rating INTEGER CHECK (user_rating >= 1 AND user_rating <= 5),
  user_notes TEXT,

  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- INGREDIENTS TABLE (toxicity database)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.ingredients (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,

  -- Identification
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  aliases TEXT[] DEFAULT '{}',                  -- Alternative names, abbreviations

  -- Classification
  category TEXT CHECK (category IN (
    'additive', 'preservative', 'sweetener', 'color', 'flavor',
    'fragrance', 'surfactant', 'solvent', 'emulsifier',
    'pesticide', 'heavy_metal', 'plastic', 'other'
  )),

  -- Toxicity data
  toxicity_score INTEGER CHECK (toxicity_score >= 1 AND toxicity_score <= 10),
  concerns TEXT[] DEFAULT '{}',
  health_effects JSONB,                         -- Detailed health info
  regulatory_status JSONB,                      -- FDA, EU, etc. status

  -- Recommendations
  safe_alternatives TEXT[] DEFAULT '{}',
  commonly_found_in TEXT[] DEFAULT '{}',

  -- Vector embedding for semantic matching
  embedding vector(1536),                       -- For fuzzy matching OCR errors

  -- Sources and metadata
  sources TEXT[] DEFAULT '{}',
  last_reviewed_at TIMESTAMPTZ,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- SWAPS TABLE (affiliate product recommendations)
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.swaps (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,

  -- Product info
  name TEXT NOT NULL,
  brand TEXT NOT NULL,
  category TEXT NOT NULL,
  description TEXT,

  -- Safety rating
  score INTEGER CHECK (score >= 0 AND score <= 100),
  why_better TEXT,
  badges TEXT[] DEFAULT '{}',                   -- 'organic', 'non-gmo', etc.

  -- What it replaces
  replaces_ingredients TEXT[] DEFAULT '{}',     -- Toxic ingredients this avoids
  replaces_products TEXT[] DEFAULT '{}',        -- Product names this can replace

  -- Affiliate info
  price_cents INTEGER,
  affiliate_url TEXT,
  affiliate_source TEXT CHECK (affiliate_source IN ('amazon', 'thrive', 'iherb', 'direct', 'other')),
  affiliate_commission_percent FLOAT,

  -- Vector embedding for recommendations
  embedding vector(1536),

  -- Display
  image_url TEXT,
  is_active BOOLEAN DEFAULT true,
  featured BOOLEAN DEFAULT false,

  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ============================================================================
-- INDEXES
-- ============================================================================

-- Profiles
CREATE INDEX IF NOT EXISTS idx_profiles_subscription ON public.profiles(subscription);

-- Products - performance critical
CREATE INDEX IF NOT EXISTS idx_products_barcode ON public.products(barcode);
CREATE INDEX IF NOT EXISTS idx_products_name_brand ON public.products(LOWER(name), LOWER(brand));
CREATE INDEX IF NOT EXISTS idx_products_category_score ON public.products(category, score DESC);
CREATE INDEX IF NOT EXISTS idx_products_last_analyzed ON public.products(last_analyzed_at);
CREATE INDEX IF NOT EXISTS idx_products_name_trgm ON public.products USING gin(name gin_trgm_ops);

-- Products - vector similarity search
CREATE INDEX IF NOT EXISTS idx_products_embedding ON public.products
  USING ivfflat (embedding vector_cosine_ops) WITH (lists = 100);

-- Scans
CREATE INDEX IF NOT EXISTS idx_scans_user_id ON public.scans(user_id);
CREATE INDEX IF NOT EXISTS idx_scans_created_at ON public.scans(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_scans_barcode ON public.scans(barcode);
CREATE INDEX IF NOT EXISTS idx_scans_user_created ON public.scans(user_id, created_at DESC);

-- Ingredients
CREATE INDEX IF NOT EXISTS idx_ingredients_name_trgm ON public.ingredients USING gin(name gin_trgm_ops);
CREATE INDEX IF NOT EXISTS idx_ingredients_aliases ON public.ingredients USING gin(aliases);
CREATE INDEX IF NOT EXISTS idx_ingredients_category ON public.ingredients(category);
CREATE INDEX IF NOT EXISTS idx_ingredients_embedding ON public.ingredients
  USING ivfflat (embedding vector_cosine_ops) WITH (lists = 50);

-- Swaps
CREATE INDEX IF NOT EXISTS idx_swaps_category_score ON public.swaps(category, score DESC);
CREATE INDEX IF NOT EXISTS idx_swaps_active ON public.swaps(is_active) WHERE is_active = true;
CREATE INDEX IF NOT EXISTS idx_swaps_embedding ON public.swaps
  USING ivfflat (embedding vector_cosine_ops) WITH (lists = 50);

-- ============================================================================
-- ROW LEVEL SECURITY
-- ============================================================================

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.scans ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.ingredients ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.swaps ENABLE ROW LEVEL SECURITY;

-- Profiles: users can only access their own
CREATE POLICY "Users can view own profile" ON public.profiles
  FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);
CREATE POLICY "Users can insert own profile" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

-- Scans: users can only access their own
CREATE POLICY "Users can view own scans" ON public.scans
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own scans" ON public.scans
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own scans" ON public.scans
  FOR UPDATE USING (auth.uid() = user_id);
CREATE POLICY "Users can delete own scans" ON public.scans
  FOR DELETE USING (auth.uid() = user_id);

-- Products: publicly readable, service role can write
CREATE POLICY "Products are publicly readable" ON public.products
  FOR SELECT USING (true);

-- Ingredients: publicly readable
CREATE POLICY "Ingredients are publicly readable" ON public.ingredients
  FOR SELECT USING (true);

-- Swaps: active swaps are publicly readable
CREATE POLICY "Active swaps are publicly readable" ON public.swaps
  FOR SELECT USING (is_active = true);

-- ============================================================================
-- FUNCTIONS
-- ============================================================================

-- Function to check if a product cache is fresh
CREATE OR REPLACE FUNCTION is_product_cache_fresh(product public.products)
RETURNS BOOLEAN AS $$
DECLARE
  current_analysis_version INTEGER := 1;  -- Bump this when we update AI prompts
BEGIN
  -- Check if analysis version matches
  IF product.analysis_version < current_analysis_version THEN
    RETURN false;
  END IF;

  -- Check if within TTL
  IF product.last_analyzed_at + (product.cache_ttl_days || ' days')::interval < NOW() THEN
    RETURN false;
  END IF;

  RETURN true;
END;
$$ LANGUAGE plpgsql;

-- Function to search products by semantic similarity
CREATE OR REPLACE FUNCTION search_products_semantic(
  query_embedding vector(1536),
  match_threshold FLOAT DEFAULT 0.7,
  match_count INTEGER DEFAULT 10
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  brand TEXT,
  score INTEGER,
  similarity FLOAT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p.id,
    p.name,
    p.brand,
    p.score,
    1 - (p.embedding <=> query_embedding) AS similarity
  FROM public.products p
  WHERE p.embedding IS NOT NULL
    AND 1 - (p.embedding <=> query_embedding) > match_threshold
  ORDER BY p.embedding <=> query_embedding
  LIMIT match_count;
END;
$$ LANGUAGE plpgsql;

-- Function to find similar ingredients (for OCR error tolerance)
CREATE OR REPLACE FUNCTION find_similar_ingredients(
  query_embedding vector(1536),
  match_threshold FLOAT DEFAULT 0.8,
  match_count INTEGER DEFAULT 5
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  toxicity_score INTEGER,
  similarity FLOAT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    i.id,
    i.name,
    i.toxicity_score,
    1 - (i.embedding <=> query_embedding) AS similarity
  FROM public.ingredients i
  WHERE i.embedding IS NOT NULL
    AND 1 - (i.embedding <=> query_embedding) > match_threshold
  ORDER BY i.embedding <=> query_embedding
  LIMIT match_count;
END;
$$ LANGUAGE plpgsql;

-- Function to get swap recommendations based on product embedding
CREATE OR REPLACE FUNCTION get_swap_recommendations(
  product_category TEXT,
  product_embedding vector(1536),
  min_score INTEGER DEFAULT 70,
  match_count INTEGER DEFAULT 5
)
RETURNS TABLE (
  id UUID,
  name TEXT,
  brand TEXT,
  score INTEGER,
  price_cents INTEGER,
  affiliate_url TEXT,
  why_better TEXT,
  similarity FLOAT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.id,
    s.name,
    s.brand,
    s.score,
    s.price_cents,
    s.affiliate_url,
    s.why_better,
    CASE
      WHEN s.embedding IS NOT NULL AND product_embedding IS NOT NULL
      THEN 1 - (s.embedding <=> product_embedding)
      ELSE 0.5
    END AS similarity
  FROM public.swaps s
  WHERE s.is_active = true
    AND s.category = product_category
    AND s.score >= min_score
  ORDER BY
    CASE
      WHEN s.embedding IS NOT NULL AND product_embedding IS NOT NULL
      THEN s.embedding <=> product_embedding
      ELSE 1
    END,
    s.score DESC
  LIMIT match_count;
END;
$$ LANGUAGE plpgsql;

-- Function to increment user scan count and check quota
CREATE OR REPLACE FUNCTION check_and_increment_scan_quota(user_uuid UUID)
RETURNS TABLE (
  allowed BOOLEAN,
  scans_used INTEGER,
  scans_limit INTEGER,
  resets_at TIMESTAMPTZ
) AS $$
DECLARE
  user_profile public.profiles;
  scan_limit INTEGER;
BEGIN
  -- Get user profile
  SELECT * INTO user_profile FROM public.profiles WHERE id = user_uuid;

  IF NOT FOUND THEN
    RETURN QUERY SELECT false, 0, 0, NOW();
    RETURN;
  END IF;

  -- Reset monthly count if needed
  IF user_profile.scans_month_reset_at < NOW() THEN
    UPDATE public.profiles
    SET scans_this_month = 0,
        scans_month_reset_at = DATE_TRUNC('month', NOW()) + INTERVAL '1 month'
    WHERE id = user_uuid;
    user_profile.scans_this_month := 0;
    user_profile.scans_month_reset_at := DATE_TRUNC('month', NOW()) + INTERVAL '1 month';
  END IF;

  -- Determine limit based on subscription
  scan_limit := CASE user_profile.subscription
    WHEN 'free' THEN 5
    WHEN 'pro' THEN 40
    WHEN 'family' THEN 100
    ELSE 5
  END;

  -- Check if under limit
  IF user_profile.scans_this_month >= scan_limit THEN
    RETURN QUERY SELECT false, user_profile.scans_this_month, scan_limit, user_profile.scans_month_reset_at;
    RETURN;
  END IF;

  -- Increment count
  UPDATE public.profiles
  SET scans_this_month = scans_this_month + 1,
      stats = jsonb_set(
        stats,
        '{totalScans}',
        to_jsonb((stats->>'totalScans')::integer + 1)
      )
  WHERE id = user_uuid;

  RETURN QUERY SELECT true, user_profile.scans_this_month + 1, scan_limit, user_profile.scans_month_reset_at;
END;
$$ LANGUAGE plpgsql;

-- Trigger to update updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER update_profiles_updated_at
  BEFORE UPDATE ON public.profiles
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_products_updated_at
  BEFORE UPDATE ON public.products
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_ingredients_updated_at
  BEFORE UPDATE ON public.ingredients
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

CREATE TRIGGER update_swaps_updated_at
  BEFORE UPDATE ON public.swaps
  FOR EACH ROW EXECUTE FUNCTION update_updated_at();

-- ============================================================================
-- AUTO-CREATE PROFILE ON USER SIGNUP
-- ============================================================================
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, display_name, avatar_url)
  VALUES (
    NEW.id,
    COALESCE(NEW.raw_user_meta_data->>'name', NEW.email),
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Only create trigger if it doesn't exist
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM pg_trigger WHERE tgname = 'on_auth_user_created'
  ) THEN
    CREATE TRIGGER on_auth_user_created
      AFTER INSERT ON auth.users
      FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();
  END IF;
END;
$$;
