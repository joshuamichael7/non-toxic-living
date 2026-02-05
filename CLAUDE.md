# Non-Toxic Living - Project Context

## What We're Building

A mobile-first app that helps users identify toxins in everyday products - food, cosmetics, household items, furniture, cookware. Think "Yuka meets universal scanner" aligned with the "Non-Toxic Dad" influencer methodology.

**Core value prop**: Point your camera at anything, get instant toxicity analysis with safe swap recommendations.

## Tech Stack

| Layer | Technology |
|-------|------------|
| Mobile | React Native + Expo SDK 52 |
| Navigation | Expo Router v4 (file-based) |
| Backend | Supabase (PostgreSQL, Auth, Edge Functions, Storage) |
| State | Zustand (client) + TanStack Query (server) |
| Styling | NativeWind v4 (Tailwind for RN) |
| AI | GPT-4o-mini (text analysis), GPT-4o (vision fallback) |
| OCR | Device-native first (free), AI fallback |

## Key Architecture Decisions

### Hybrid OCR Strategy (Cost Optimization)
1. **Device OCR first** (iOS Vision / Android ML Kit) - FREE
2. If confidence > 80%: Send extracted TEXT to GPT-4o-mini for analysis (~$0.001)
3. If confidence low or no text: Send IMAGE to GPT-4o vision (~$0.02)
4. **Result**: 70-80% cost savings vs always using vision API

### Database (Supabase/PostgreSQL)
- `profiles` - User data, preferences, stats
- `scans` - User scan history
- `products` - Cached product analysis
- `ingredients` - Toxicity database (pre-seeded)
- `swaps` - Affiliate product recommendations

### Scoring System
- **0-33**: Toxic (Rose/Red)
- **34-66**: Caution (Amber/Yellow)
- **67-100**: Safe (Emerald/Green)

## Project Structure

```
app/                    # Expo Router screens
├── (tabs)/            # Tab navigation (Home, Scan, Search, Profile)
├── (auth)/            # Auth screens (login, register)
└── result/[id].tsx    # Scan result detail

src/
├── components/        # UI components
│   ├── ui/           # Base components (Button, Card, ScoreBadge)
│   ├── home/         # Dashboard components
│   ├── scanner/      # Camera and result components
│   └── swaps/        # Swap recommendation components
├── services/
│   ├── ocr/          # Hybrid OCR pipeline
│   └── api/          # Supabase API calls
├── stores/           # Zustand stores
├── hooks/            # React Query hooks
├── lib/              # Supabase client, utilities
├── constants/        # Colors, config
└── types/            # TypeScript types

supabase/
├── functions/        # Edge Functions (analyze-ingredients, get-swaps)
└── migrations/       # Database migrations
```

## What's Already Done

- [x] Project scaffold with Expo + TypeScript
- [x] Tab navigation (Home, Scan, Search, Profile)
- [x] Basic UI components with design system colors
- [x] Scanner screen with camera placeholder
- [x] Result screen with score display
- [x] OCR pipeline structure (not yet connected)
- [x] Supabase client setup
- [x] Type definitions

## What Needs To Be Done

### Immediate (MVP)
- [ ] Set up Supabase project + run migrations (SQL in TECHNICAL_ARCHITECTURE.md)
- [ ] Implement actual camera capture in scanner
- [ ] Connect device OCR (react-native-mlkit-ocr)
- [ ] Create Edge Function for AI analysis
- [ ] Wire up full scan flow (capture → OCR → analyze → display)
- [ ] Add authentication (Supabase Auth)
- [ ] Seed ingredient database with initial data

### Next Phase
- [ ] Implement swap suggestions with affiliate links
- [ ] Add search functionality
- [ ] User scan history persistence
- [ ] Premium subscription (RevenueCat)
- [ ] Offline mode with cached products

## Key Files to Reference

- `PRODUCT_SPEC.md` - Detailed features, user flows, monetization
- `DESIGN_SYSTEM.md` - Typography, colors, UI patterns, components
- `TECHNICAL_ARCHITECTURE.md` - Full tech details, database schema, Edge Functions

## Design System Quick Reference

### Colors
```
Primary: #059669 (Emerald-600)
Safe: #10B981 (Emerald-500)
Caution: #F59E0B (Amber-500)
Toxic: #F43F5E (Rose-500)
Background: #FAFAF9 (Stone-50)
Text: #1C1917 (Stone-900)
```

### Typography
- Font: Manrope (Google Fonts)
- Weights: 400 (regular), 500 (medium), 600 (semibold), 700 (bold)

### UI Patterns
- Glassmorphism for sheets/overlays
- Floating elements (never stick to edges)
- Soft colored shadows (glows behind score badges)
- Bottom sheets for results

## Coding Conventions

- Use TypeScript strictly
- Prefer functional components with hooks
- Use NativeWind classes for styling
- Keep components small and focused
- Colocate related files (component + styles + types)
- Use Zustand for client state, React Query for server state

## Environment Setup

Copy `.env.example` to `.env.local` and add:
- `EXPO_PUBLIC_SUPABASE_URL` - From Supabase dashboard
- `EXPO_PUBLIC_SUPABASE_ANON_KEY` - From Supabase dashboard

## Running the App

```bash
npm install
npx expo start
# Then: 'i' for iOS, 'a' for Android, or scan QR with Expo Go
```
