# Non-Toxic Living: Technical Architecture

## Overview

This document outlines the technical architecture for Non-Toxic Living, a mobile-first application that uses a hybrid OCR approach (device-native + AI) to identify toxins in everyday products.

**Key Design Principles:**
1. **Device-first OCR** - Use free, fast native OCR for text extraction
2. **AI for analysis** - Only hit OpenAI for ingredient analysis and complex recognition
3. **Cost efficiency** - Start with 4o-mini, escalate to 4o when needed
4. **Offline capable** - Cache aggressively, work without network when possible

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         Mobile App (React Native / Expo)                     │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        OCR Pipeline (Device-First)                   │    │
│  │  ┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐  │    │
│  │  │  Camera Capture │───▶│  Native OCR     │───▶│  Text Extracted │  │    │
│  │  │  (expo-camera)  │    │  (iOS/Android)  │    │  (ingredients)  │  │    │
│  │  └─────────────────┘    └─────────────────┘    └────────┬────────┘  │    │
│  │                                                         │            │    │
│  │                              ┌──────────────────────────┴──────┐     │    │
│  │                              ▼                                 ▼     │    │
│  │                    ┌─────────────────┐              ┌──────────────┐│    │
│  │                    │ Text Confidence │              │ No Text/Low  ││    │
│  │                    │     > 80%       │              │  Confidence  ││    │
│  │                    └────────┬────────┘              └──────┬───────┘│    │
│  │                             │                              │        │    │
│  │                             ▼                              ▼        │    │
│  │                    ┌─────────────────┐              ┌─────────────┐ │    │
│  │                    │ Send TEXT only  │              │ Send IMAGE  │ │    │
│  │                    │ to AI (cheap)   │              │ to AI (4o)  │ │    │
│  │                    └─────────────────┘              └─────────────┘ │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌────────────────┐      │
│  │   Scanner   │  │  Dashboard  │  │   Profile   │  │     Search     │      │
│  │   Screen    │  │   Screen    │  │   Screen    │  │     Screen     │      │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └───────┬────────┘      │
│         └────────────────┴────────────────┴─────────────────┘               │
│                                    │                                         │
│                    ┌───────────────┴───────────────┐                        │
│                    │   State Management (Zustand)   │                        │
│                    │   + React Query (server state) │                        │
│                    └───────────────┬───────────────┘                        │
└────────────────────────────────────┼────────────────────────────────────────┘
                                     │
                                     ▼
┌────────────────────────────────────────────────────────────────────────────┐
│                              Supabase                                       │
│                                                                             │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────────────┐  │
│  │   Auth           │  │   PostgreSQL     │  │   Edge Functions         │  │
│  │   - Email/Pass   │  │   - users        │  │   - analyze-ingredients  │  │
│  │   - Google       │  │   - scans        │  │   - get-swaps            │  │
│  │   - Apple        │  │   - products     │  │   - search-products      │  │
│  └──────────────────┘  │   - ingredients  │  └───────────┬──────────────┘  │
│                        │   - swaps        │              │                  │
│  ┌──────────────────┐  └──────────────────┘              │                  │
│  │   Storage        │                                    │                  │
│  │   - scan-images  │                                    ▼                  │
│  │   - product-imgs │                      ┌──────────────────────────┐    │
│  └──────────────────┘                      │   OpenAI API             │    │
│                                            │   - GPT-4o-mini (default)│    │
│  ┌──────────────────┐                      │   - GPT-4o (escalation)  │    │
│  │   Realtime       │                      └──────────────────────────┘    │
│  │   - scan updates │                                                       │
│  └──────────────────┘                                                       │
└────────────────────────────────────────────────────────────────────────────┘
```

---

## Hybrid OCR Strategy

The key to cost efficiency is using device OCR first, then AI only when necessary.

### Decision Flow

```typescript
// src/services/ocr/OcrPipeline.ts

export type OcrSource = 'device' | 'ai-mini' | 'ai-vision';

export interface OcrResult {
  text: string;
  confidence: number;
  source: OcrSource;
  boundingBoxes?: BoundingBox[];
}

export async function processImage(imageUri: string): Promise<OcrResult> {
  // Step 1: Try device OCR first (FREE)
  const deviceResult = await performDeviceOcr(imageUri);

  if (deviceResult.confidence > 0.8 && deviceResult.text.length > 20) {
    // Good text extracted - use it directly
    return { ...deviceResult, source: 'device' };
  }

  if (deviceResult.confidence > 0.5 && deviceResult.text.length > 10) {
    // Partial text - send text to AI for cleanup/analysis (CHEAP)
    return {
      text: deviceResult.text,
      confidence: deviceResult.confidence,
      source: 'ai-mini'
    };
  }

  // Step 2: Poor/no text - need full vision API (EXPENSIVE)
  // This handles: curved bottles, low contrast, product-only scans
  return { text: '', confidence: 0, source: 'ai-vision' };
}
```

### Device OCR Implementation

```typescript
// src/services/ocr/DeviceOcr.ts

import * as MLKit from 'expo-ml-kit'; // or react-native-mlkit-ocr

// iOS: Uses Apple Vision framework
// Android: Uses Google ML Kit

export async function performDeviceOcr(imageUri: string): Promise<OcrResult> {
  try {
    const result = await MLKit.detectText(imageUri);

    // Calculate overall confidence from blocks
    const avgConfidence = result.blocks.reduce(
      (sum, block) => sum + block.confidence, 0
    ) / result.blocks.length;

    // Extract full text
    const fullText = result.blocks
      .map(block => block.text)
      .join('\n');

    return {
      text: fullText,
      confidence: avgConfidence,
      boundingBoxes: result.blocks.map(b => b.frame),
    };
  } catch (error) {
    console.warn('Device OCR failed:', error);
    return { text: '', confidence: 0 };
  }
}
```

### Cost Comparison

| Scenario | OCR Method | AI Call | Est. Cost |
|----------|------------|---------|-----------|
| Clear label, good lighting | Device OCR | 4o-mini (text only) | ~$0.001 |
| Curved bottle, readable | Device OCR | 4o-mini (text only) | ~$0.001 |
| Low confidence text | Device OCR | 4o-mini (text cleanup) | ~$0.002 |
| No text / product-only | None | 4o Vision | ~$0.02 |
| Complex visual ID needed | None | 4o Vision | ~$0.03 |

**Projected savings**: 70-80% cost reduction vs always using vision API.

---

## Tech Stack

### Mobile Application

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Framework** | React Native (Expo SDK 52+) | Cross-platform, large ecosystem |
| **Navigation** | Expo Router v4 | File-based routing, native feel |
| **State (Client)** | Zustand | Lightweight, simple API |
| **State (Server)** | TanStack Query | Caching, sync, offline support |
| **Camera** | expo-camera | Native performance |
| **OCR** | react-native-mlkit-ocr | Free device OCR (iOS Vision / Android ML Kit) |
| **Animations** | Reanimated 3 | 60fps native animations |
| **Styling** | NativeWind v4 | Tailwind for React Native |
| **Forms** | React Hook Form + Zod | Validation, performance |

### Backend (Supabase)

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Database** | PostgreSQL | Relational, full-text search, JSONB |
| **Auth** | Supabase Auth | Social logins, JWT, RLS |
| **API** | PostgREST (auto-generated) | Instant CRUD APIs |
| **Functions** | Edge Functions (Deno) | Serverless, low latency |
| **Storage** | Supabase Storage | S3-compatible, CDN |
| **Realtime** | Supabase Realtime | WebSocket subscriptions |

### AI Services

| Component | Technology | Usage |
|-----------|------------|-------|
| **Text Analysis** | GPT-4o-mini | Ingredient parsing, scoring (default) |
| **Vision Analysis** | GPT-4o | Product recognition, complex labels |
| **Embeddings** | text-embedding-3-small | Product similarity search |

---

## Database Schema (PostgreSQL)

```sql
-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";  -- For fuzzy text search

-- Users table (extends Supabase auth.users)
CREATE TABLE public.profiles (
  id UUID REFERENCES auth.users(id) PRIMARY KEY,
  display_name TEXT,
  avatar_url TEXT,
  subscription TEXT DEFAULT 'free' CHECK (subscription IN ('free', 'premium')),
  preferences JSONB DEFAULT '{
    "concernPriorities": ["chemicals"],
    "dietaryRestrictions": [],
    "budgetRange": "mid",
    "familyMode": false,
    "notifications": true
  }',
  stats JSONB DEFAULT '{
    "totalScans": 0,
    "toxinsAvoided": 0,
    "swapsMade": 0,
    "streakDays": 0,
    "badges": []
  }',
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Scans table (user scan history)
CREATE TABLE public.scans (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  user_id UUID REFERENCES public.profiles(id) ON DELETE CASCADE,
  product_id UUID REFERENCES public.products(id),
  score INTEGER CHECK (score >= 0 AND score <= 100),
  verdict TEXT CHECK (verdict IN ('safe', 'caution', 'toxic')),
  analysis JSONB NOT NULL,
  ocr_source TEXT CHECK (ocr_source IN ('device', 'ai-mini', 'ai-vision')),
  image_path TEXT,
  saved_to_list TEXT CHECK (saved_to_list IN ('favorites', 'avoid')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Products table (cached product data)
CREATE TABLE public.products (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  brand TEXT,
  category TEXT NOT NULL,
  barcode TEXT UNIQUE,
  score INTEGER CHECK (score >= 0 AND score <= 100),
  verdict TEXT CHECK (verdict IN ('safe', 'caution', 'toxic')),
  analysis JSONB,
  image_url TEXT,
  scan_count INTEGER DEFAULT 0,
  last_scanned TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Ingredients table (toxicity database)
CREATE TABLE public.ingredients (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  slug TEXT UNIQUE NOT NULL,
  aliases TEXT[] DEFAULT '{}',
  category TEXT CHECK (category IN (
    'additive', 'preservative', 'sweetener', 'color',
    'fragrance', 'material', 'pesticide', 'heavy_metal'
  )),
  toxicity_score INTEGER CHECK (toxicity_score >= 1 AND toxicity_score <= 10),
  concerns TEXT[] DEFAULT '{}',
  health_effects JSONB,
  sources TEXT[] DEFAULT '{}',
  safe_alternatives TEXT[] DEFAULT '{}',
  common_products TEXT[] DEFAULT '{}',
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Swaps table (affiliate product recommendations)
CREATE TABLE public.swaps (
  id UUID DEFAULT uuid_generate_v4() PRIMARY KEY,
  name TEXT NOT NULL,
  brand TEXT NOT NULL,
  category TEXT NOT NULL,
  score INTEGER CHECK (score >= 0 AND score <= 100),
  price_cents INTEGER,
  image_url TEXT,
  affiliate_url TEXT,
  affiliate_source TEXT CHECK (affiliate_source IN ('amazon', 'thrive', 'iherb', 'direct')),
  badges TEXT[] DEFAULT '{}',
  why_better TEXT,
  replaces_ingredients TEXT[] DEFAULT '{}',
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Indexes for performance
CREATE INDEX idx_scans_user_id ON public.scans(user_id);
CREATE INDEX idx_scans_created_at ON public.scans(created_at DESC);
CREATE INDEX idx_products_barcode ON public.products(barcode);
CREATE INDEX idx_products_category_score ON public.products(category, score DESC);
CREATE INDEX idx_ingredients_name_trgm ON public.ingredients USING gin(name gin_trgm_ops);
CREATE INDEX idx_ingredients_aliases ON public.ingredients USING gin(aliases);
CREATE INDEX idx_swaps_category_score ON public.swaps(category, score DESC);

-- Row Level Security
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

-- Scans: users can only access their own
CREATE POLICY "Users can view own scans" ON public.scans
  FOR SELECT USING (auth.uid() = user_id);
CREATE POLICY "Users can insert own scans" ON public.scans
  FOR INSERT WITH CHECK (auth.uid() = user_id);
CREATE POLICY "Users can update own scans" ON public.scans
  FOR UPDATE USING (auth.uid() = user_id);

-- Products: publicly readable
CREATE POLICY "Products are publicly readable" ON public.products
  FOR SELECT USING (true);

-- Ingredients: publicly readable
CREATE POLICY "Ingredients are publicly readable" ON public.ingredients
  FOR SELECT USING (true);

-- Swaps: publicly readable (active only)
CREATE POLICY "Active swaps are publicly readable" ON public.swaps
  FOR SELECT USING (is_active = true);
```

---

## Edge Functions

### analyze-ingredients

Analyzes extracted text or image for toxicity.

```typescript
// supabase/functions/analyze-ingredients/index.ts

import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import OpenAI from 'https://esm.sh/openai@4'

const openai = new OpenAI({ apiKey: Deno.env.get('OPENAI_API_KEY') })
const supabase = createClient(
  Deno.env.get('SUPABASE_URL')!,
  Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
)

interface AnalyzeRequest {
  text?: string           // Extracted text from device OCR
  imageBase64?: string    // Image for vision analysis
  ocrSource: 'device' | 'ai-mini' | 'ai-vision'
  userId?: string
}

serve(async (req) => {
  const { text, imageBase64, ocrSource, userId } = await req.json() as AnalyzeRequest

  let ingredientText = text
  let model = 'gpt-4o-mini'  // Default to cheaper model

  // If we have an image and need vision, use 4o
  if (ocrSource === 'ai-vision' && imageBase64) {
    model = 'gpt-4o'

    const visionResponse = await openai.chat.completions.create({
      model: 'gpt-4o',
      messages: [
        {
          role: 'system',
          content: `You are a product identification expert. Extract:
1. Product name and brand
2. All ingredients or materials listed
3. Any nutrition facts
4. Product category

Return JSON: { productName, brand, category, ingredients: string[], materials: string[], nutritionFacts: object }`
        },
        {
          role: 'user',
          content: [
            {
              type: 'image_url',
              image_url: { url: `data:image/jpeg;base64,${imageBase64}`, detail: 'high' }
            },
            { type: 'text', text: 'Identify this product and extract all visible information.' }
          ]
        }
      ],
      response_format: { type: 'json_object' },
      max_tokens: 1500
    })

    const extracted = JSON.parse(visionResponse.choices[0].message.content!)
    ingredientText = extracted.ingredients?.join(', ') || ''
  }

  // Look up ingredients in our database
  const ingredientList = parseIngredients(ingredientText)
  const { data: knownIngredients } = await supabase
    .from('ingredients')
    .select('*')
    .or(ingredientList.map(i => `name.ilike.%${i}%,aliases.cs.{${i}}`).join(','))

  // Analyze with AI
  const analysisResponse = await openai.chat.completions.create({
    model,
    messages: [
      {
        role: 'system',
        content: `You are a toxicity analysis expert aligned with the "Non-Toxic Dad" methodology.
Analyze ingredients with a rigorous, health-first perspective considering:
- Known carcinogens and endocrine disruptors
- Ingredients often dismissed as "safe" but have emerging concerns
- Processing methods that may introduce toxins

Known ingredient data from our database:
${JSON.stringify(knownIngredients, null, 2)}

Return JSON: {
  productName: string,
  brand: string,
  category: string,
  score: number (0-100, higher = safer),
  verdict: "safe" | "caution" | "toxic",
  summary: string,
  dadsTake: string (friendly advice in Non-Toxic Dad voice),
  concerns: [{ ingredient, severity: "low"|"medium"|"high", description, category }],
  positives: string[]
}`
      },
      {
        role: 'user',
        content: `Analyze these ingredients for toxicity:\n\n${ingredientText}`
      }
    ],
    response_format: { type: 'json_object' },
    max_tokens: 1500
  })

  const analysis = JSON.parse(analysisResponse.choices[0].message.content!)

  // Get swap suggestions if toxic/caution
  let swaps = []
  if (analysis.score < 67) {
    const { data } = await supabase
      .from('swaps')
      .select('*')
      .eq('category', analysis.category)
      .gte('score', 70)
      .order('score', { ascending: false })
      .limit(5)
    swaps = data || []
  }

  // Cache product if identifiable
  if (analysis.productName && analysis.brand) {
    await supabase.from('products').upsert({
      name: analysis.productName,
      brand: analysis.brand,
      category: analysis.category,
      score: analysis.score,
      verdict: analysis.verdict,
      analysis,
      scan_count: 1,
      last_scanned: new Date().toISOString()
    }, { onConflict: 'name,brand' })
  }

  return new Response(JSON.stringify({
    ...analysis,
    swaps,
    ocrSource,
    model
  }), {
    headers: { 'Content-Type': 'application/json' }
  })
})

function parseIngredients(text: string): string[] {
  // Split by common delimiters and clean up
  return text
    .split(/[,;.]/)
    .map(i => i.trim().toLowerCase())
    .filter(i => i.length > 2 && i.length < 50)
}
```

### get-swaps

Fetch swap suggestions for a category.

```typescript
// supabase/functions/get-swaps/index.ts

import { serve } from 'https://deno.land/std@0.177.0/http/server.ts'
import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'

serve(async (req) => {
  const { category, concerns, limit = 5 } = await req.json()

  const supabase = createClient(
    Deno.env.get('SUPABASE_URL')!,
    Deno.env.get('SUPABASE_ANON_KEY')!
  )

  let query = supabase
    .from('swaps')
    .select('*')
    .eq('is_active', true)
    .gte('score', 70)
    .order('score', { ascending: false })
    .limit(limit)

  if (category) {
    query = query.eq('category', category)
  }

  // If specific concerns, prioritize swaps that address them
  if (concerns?.length > 0) {
    query = query.overlaps('replaces_ingredients', concerns)
  }

  const { data, error } = await query

  if (error) {
    return new Response(JSON.stringify({ error: error.message }), { status: 500 })
  }

  return new Response(JSON.stringify(data), {
    headers: { 'Content-Type': 'application/json' }
  })
})
```

---

## Mobile App Structure

```
non-toxic-living/
├── app/                          # Expo Router screens
│   ├── (tabs)/
│   │   ├── _layout.tsx          # Tab navigator
│   │   ├── index.tsx            # Home/Dashboard
│   │   ├── scan.tsx             # Scanner
│   │   ├── search.tsx           # Search
│   │   └── profile.tsx          # Profile
│   ├── (auth)/
│   │   ├── login.tsx
│   │   └── register.tsx
│   ├── result/[id].tsx          # Scan result detail
│   ├── product/[id].tsx         # Product detail
│   ├── _layout.tsx              # Root layout
│   └── +not-found.tsx
├── src/
│   ├── components/
│   │   ├── ui/                  # Base UI components
│   │   │   ├── Button.tsx
│   │   │   ├── Card.tsx
│   │   │   ├── ScoreBadge.tsx
│   │   │   ├── BottomSheet.tsx
│   │   │   └── index.ts
│   │   ├── scanner/
│   │   │   ├── CameraView.tsx
│   │   │   ├── ScanOverlay.tsx
│   │   │   └── ResultSheet.tsx
│   │   ├── home/
│   │   │   ├── InsightCard.tsx
│   │   │   ├── RecentScans.tsx
│   │   │   └── StatsCard.tsx
│   │   └── swaps/
│   │       ├── SwapCard.tsx
│   │       └── SwapList.tsx
│   ├── services/
│   │   ├── ocr/
│   │   │   ├── OcrPipeline.ts
│   │   │   ├── DeviceOcr.ts
│   │   │   └── types.ts
│   │   ├── api/
│   │   │   ├── supabase.ts
│   │   │   ├── analyze.ts
│   │   │   └── swaps.ts
│   │   └── storage/
│   │       └── images.ts
│   ├── stores/
│   │   ├── useUserStore.ts
│   │   ├── useScanStore.ts
│   │   └── useSettingsStore.ts
│   ├── hooks/
│   │   ├── useAnalyze.ts
│   │   ├── useScans.ts
│   │   ├── useSwaps.ts
│   │   └── useAuth.ts
│   ├── lib/
│   │   ├── supabase.ts          # Supabase client init
│   │   ├── queryClient.ts       # React Query setup
│   │   └── utils.ts
│   ├── constants/
│   │   ├── colors.ts
│   │   ├── typography.ts
│   │   └── config.ts
│   └── types/
│       ├── database.ts          # Generated from Supabase
│       ├── scan.ts
│       └── product.ts
├── assets/
│   ├── images/
│   └── fonts/
├── supabase/
│   ├── functions/
│   │   ├── analyze-ingredients/
│   │   └── get-swaps/
│   ├── migrations/
│   └── seed.sql
├── app.json
├── babel.config.js
├── tailwind.config.js
├── tsconfig.json
├── package.json
└── .env.local
```

---

## Environment Configuration

```bash
# .env.local (mobile app)
EXPO_PUBLIC_SUPABASE_URL=https://xxxxx.supabase.co
EXPO_PUBLIC_SUPABASE_ANON_KEY=eyJhbGc...

# .env (Supabase Edge Functions)
OPENAI_API_KEY=sk-...
SUPABASE_URL=https://xxxxx.supabase.co
SUPABASE_SERVICE_ROLE_KEY=eyJhbGc...

# Affiliate keys (Edge Functions)
AMAZON_AFFILIATE_TAG=nontoxic-20
THRIVE_AFFILIATE_ID=...
```

---

## Performance & Cost Optimization

### Caching Strategy

```typescript
// src/hooks/useAnalyze.ts

import { useQuery, useMutation, useQueryClient } from '@tanstack/react-query'

export function useAnalyze() {
  const queryClient = useQueryClient()

  return useMutation({
    mutationFn: analyzeImage,
    onSuccess: (result) => {
      // Cache by product name for quick lookups
      if (result.productName) {
        queryClient.setQueryData(
          ['product', result.productName.toLowerCase()],
          result
        )
      }
    }
  })
}

// Check cache before scanning
export function useCachedProduct(barcode?: string) {
  return useQuery({
    queryKey: ['product', 'barcode', barcode],
    queryFn: () => supabase
      .from('products')
      .select('*')
      .eq('barcode', barcode)
      .single(),
    enabled: !!barcode,
    staleTime: 1000 * 60 * 60 * 24, // 24 hours
  })
}
```

### Cost Projections

| Daily Active Users | Scans/Day | Device OCR % | AI Calls | Est. Daily Cost |
|-------------------|-----------|--------------|----------|-----------------|
| 1,000 | 5,000 | 75% | 1,250 mini + 250 vision | ~$8 |
| 10,000 | 50,000 | 75% | 12,500 mini + 2,500 vision | ~$80 |
| 100,000 | 500,000 | 80% | 100k mini + 20k vision | ~$700 |

---

## Development Setup

```bash
# Prerequisites
node >= 20.0.0
npm >= 10.0.0
Expo CLI (npx expo)
Supabase CLI

# Clone and install
git clone https://github.com/[org]/non-toxic-living.git
cd non-toxic-living
npm install

# Set up environment
cp .env.example .env.local
# Add your Supabase credentials

# Start Supabase locally
npx supabase start

# Run migrations
npx supabase db push

# Start Expo
npx expo start

# Run on device
npx expo run:ios
npx expo run:android
```

---

## Deployment

### Mobile App
1. Configure EAS: `eas build:configure`
2. Build: `eas build --platform all`
3. Submit: `eas submit --platform all`

### Supabase
1. Link project: `npx supabase link --project-ref xxxxx`
2. Deploy functions: `npx supabase functions deploy`
3. Push migrations: `npx supabase db push`

### CI/CD (GitHub Actions)

```yaml
name: Deploy
on:
  push:
    branches: [main]

jobs:
  deploy-functions:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: supabase/setup-cli@v1
      - run: supabase functions deploy --project-ref ${{ secrets.SUPABASE_PROJECT_REF }}
        env:
          SUPABASE_ACCESS_TOKEN: ${{ secrets.SUPABASE_ACCESS_TOKEN }}

  build-mobile:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: expo/expo-github-action@v8
        with:
          eas-version: latest
          token: ${{ secrets.EXPO_TOKEN }}
      - run: eas build --platform all --non-interactive
```
