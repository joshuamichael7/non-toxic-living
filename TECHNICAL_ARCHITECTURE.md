# Non-Toxic Living: Technical Architecture

## Overview

This document outlines the technical architecture for Non-Toxic Living, a mobile-first application that uses multimodal AI to identify toxins in everyday products.

---

## System Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                         Mobile App (React Native)                    │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌────────────┐ │
│  │   Scanner   │  │  Dashboard  │  │   Profile   │  │   Search   │ │
│  │   Screen    │  │   Screen    │  │   Screen    │  │   Screen   │ │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘  └─────┬──────┘ │
│         │                │                │                │        │
│  ┌──────┴────────────────┴────────────────┴────────────────┴──────┐ │
│  │                    State Management (Zustand)                   │ │
│  └──────────────────────────────┬──────────────────────────────────┘ │
└─────────────────────────────────┼───────────────────────────────────┘
                                  │
                                  ▼
┌─────────────────────────────────────────────────────────────────────┐
│                        API Gateway (Firebase)                        │
└──────────────┬────────────────────────────────────┬─────────────────┘
               │                                    │
               ▼                                    ▼
┌──────────────────────────┐          ┌──────────────────────────────┐
│   Cloud Functions        │          │   Firestore Database         │
│   (Node.js/Python)       │          │                              │
│  ┌────────────────────┐  │          │  ┌────────────────────────┐  │
│  │  Scan Processor    │  │          │  │  Products Collection   │  │
│  │  - OCR Pipeline    │  │          │  │  - Cached scan results │  │
│  │  - AI Analysis     │  │          │  │  - Ingredient database │  │
│  └────────────────────┘  │          │  └────────────────────────┘  │
│  ┌────────────────────┐  │          │  ┌────────────────────────┐  │
│  │  Swap Engine       │  │          │  │  Users Collection      │  │
│  │  - Recommendations │  │          │  │  - Profiles            │  │
│  │  - Affiliate links │  │          │  │  - Scan history        │  │
│  └────────────────────┘  │          │  │  - Preferences         │  │
└────────────┬─────────────┘          │  └────────────────────────┘  │
             │                        │  ┌────────────────────────┐  │
             ▼                        │  │  Ingredients Index     │  │
┌──────────────────────────┐          │  │  - Toxicity ratings    │  │
│   External AI Services   │          │  │  - Health impacts      │  │
│  ┌────────────────────┐  │          │  └────────────────────────┘  │
│  │  GPT-4o / Gemini   │  │          └──────────────────────────────┘
│  │  Vision + Text     │  │
│  └────────────────────┘  │
│  ┌────────────────────┐  │
│  │  Google Cloud      │  │
│  │  Vision API (OCR)  │  │
│  └────────────────────┘  │
└──────────────────────────┘
```

---

## Tech Stack

### Mobile Application

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Framework** | React Native (Expo) | Cross-platform, large ecosystem, faster iteration |
| **State Management** | Zustand | Lightweight, simple API, TypeScript-friendly |
| **Navigation** | Expo Router | File-based routing, native feel |
| **UI Components** | Custom + Tamagui | Performance, design system alignment |
| **Camera** | expo-camera | Native performance, easy integration |
| **Image Processing** | expo-image-manipulator | Compression before upload |
| **Animations** | Reanimated 3 | 60fps native animations |
| **Styling** | NativeWind (Tailwind) | Rapid development, design system tokens |

### Backend Services

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Cloud Platform** | Firebase | Integrated auth, database, functions, hosting |
| **Serverless Functions** | Cloud Functions (Node.js) | Scalable, pay-per-use |
| **Database** | Firestore | Real-time sync, offline support, flexible schema |
| **Authentication** | Firebase Auth | Social logins, secure token management |
| **Storage** | Cloud Storage | Image caching, user uploads |
| **Analytics** | Firebase Analytics | User behavior, conversion tracking |

### AI/ML Services

| Component | Technology | Rationale |
|-----------|------------|-----------|
| **Multimodal Analysis** | GPT-4o or Gemini 1.5 Pro | Vision + text in single API call |
| **OCR (Backup)** | Google Cloud Vision | High accuracy for curved surfaces |
| **Embeddings** | OpenAI Embeddings | Product similarity search |
| **Vector DB** | Pinecone (future) | Semantic product search |

---

## Core Modules

### 1. Scanner Module

Handles image capture, preprocessing, and routing to appropriate AI analysis.

```typescript
// src/modules/scanner/types.ts

export type ScanMode = 'label' | 'product' | 'produce' | 'environment';

export interface ScanRequest {
  imageBase64: string;
  mode: ScanMode;
  userId?: string;
  hints?: string[]; // User-provided context
}

export interface ScanResult {
  id: string;
  timestamp: Date;
  score: number; // 0-100
  verdict: 'safe' | 'caution' | 'toxic';
  product?: ProductInfo;
  analysis: ToxicityAnalysis;
  swaps: SwapSuggestion[];
}

export interface ToxicityAnalysis {
  summary: string;
  dadsTake?: string;
  concerns: Concern[];
  positives: string[];
  ingredients?: IngredientAnalysis[];
  materials?: MaterialAnalysis[];
}

export interface Concern {
  ingredient: string;
  severity: 'low' | 'medium' | 'high';
  description: string;
  category: 'carcinogen' | 'endocrine' | 'allergen' | 'irritant' | 'environmental';
}
```

```typescript
// src/modules/scanner/ScannerService.ts

import { CameraView } from 'expo-camera';
import * as ImageManipulator from 'expo-image-manipulator';

export class ScannerService {
  private cameraRef: CameraView | null = null;

  async captureImage(): Promise<string> {
    if (!this.cameraRef) throw new Error('Camera not initialized');

    const photo = await this.cameraRef.takePictureAsync({
      quality: 0.8,
      base64: true,
    });

    // Compress and resize for API
    const processed = await ImageManipulator.manipulateAsync(
      photo.uri,
      [{ resize: { width: 1024 } }],
      { compress: 0.7, format: ImageManipulator.SaveFormat.JPEG, base64: true }
    );

    return processed.base64!;
  }

  async analyzeImage(imageBase64: string, mode: ScanMode): Promise<ScanResult> {
    const response = await fetch(`${API_URL}/analyze`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'Authorization': `Bearer ${await getAuthToken()}`,
      },
      body: JSON.stringify({ imageBase64, mode }),
    });

    return response.json();
  }
}
```

### 2. AI Analysis Pipeline

Server-side processing that orchestrates AI analysis.

```typescript
// functions/src/analyze/index.ts

import { onCall } from 'firebase-functions/v2/https';
import { OpenAI } from 'openai';

const openai = new OpenAI();

export const analyzeProduct = onCall(async (request) => {
  const { imageBase64, mode } = request.data;

  // Build dynamic prompt based on scan mode
  const systemPrompt = buildSystemPrompt(mode);

  const response = await openai.chat.completions.create({
    model: 'gpt-4o',
    messages: [
      { role: 'system', content: systemPrompt },
      {
        role: 'user',
        content: [
          {
            type: 'image_url',
            image_url: {
              url: `data:image/jpeg;base64,${imageBase64}`,
              detail: 'high',
            },
          },
          {
            type: 'text',
            text: 'Analyze this product for toxicity concerns. Extract all visible text and identify the product.',
          },
        ],
      },
    ],
    response_format: { type: 'json_object' },
    max_tokens: 2000,
  });

  const analysis = JSON.parse(response.choices[0].message.content);

  // Enrich with our ingredient database
  const enrichedAnalysis = await enrichWithDatabase(analysis);

  // Calculate score
  const score = calculateToxicityScore(enrichedAnalysis);

  // Get swap suggestions
  const swaps = await getSwapSuggestions(enrichedAnalysis, score);

  // Cache result
  await cacheResult(enrichedAnalysis, score);

  return {
    score,
    verdict: getVerdict(score),
    analysis: enrichedAnalysis,
    swaps,
  };
});

function buildSystemPrompt(mode: ScanMode): string {
  const basePrompt = `You are a toxicity analysis expert aligned with the "Non-Toxic Dad" methodology.
Analyze products with a rigorous, health-first perspective that considers:
- Known carcinogens and endocrine disruptors
- Ingredients often dismissed as "safe" but have emerging concerns
- Processing methods that may introduce toxins
- Off-gassing and material composition for non-food items

Return JSON with: productName, brand, category, ingredients[], materials[], concerns[], positives[], overallRisk (1-10).`;

  const modeSpecific = {
    label: 'Focus on reading and analyzing the ingredient list and nutrition facts.',
    product: 'Identify the product by visual recognition. Infer likely ingredients based on product type.',
    produce: 'Identify the produce type. Consider pesticide load (Dirty Dozen vs Clean Fifteen).',
    environment: 'Assess materials, potential off-gassing, and overall environmental toxin risk.',
  };

  return `${basePrompt}\n\nMode: ${mode}\n${modeSpecific[mode]}`;
}
```

### 3. Ingredient Database

Pre-computed toxicity data for common ingredients.

```typescript
// functions/src/data/ingredients.ts

export interface IngredientData {
  name: string;
  aliases: string[];
  category: 'additive' | 'preservative' | 'sweetener' | 'color' | 'fragrance' | 'material';
  toxicityScore: number; // 1-10 (10 = most toxic)
  concerns: string[];
  sources: string[]; // Scientific references
  commonProducts: string[];
  safeAlternatives: string[];
}

// Example entries
export const ingredientDatabase: Record<string, IngredientData> = {
  'red-40': {
    name: 'Red 40',
    aliases: ['Allura Red', 'FD&C Red No. 40', 'E129'],
    category: 'color',
    toxicityScore: 7,
    concerns: [
      'Linked to hyperactivity in children',
      'Potential carcinogen (animal studies)',
      'Banned in several European countries',
    ],
    sources: ['FDA CFSAN', 'CSPI Report 2023'],
    commonProducts: ['Candy', 'Beverages', 'Cereals', 'Snacks'],
    safeAlternatives: ['Beet juice', 'Paprika extract', 'Annatto'],
  },
  'titanium-dioxide': {
    name: 'Titanium Dioxide',
    aliases: ['TiO2', 'E171', 'CI 77891'],
    category: 'additive',
    toxicityScore: 6,
    concerns: [
      'Banned in EU for food use (2022)',
      'Potential gut inflammation',
      'Nanoparticle concerns',
    ],
    sources: ['EFSA Opinion 2021', 'EU Regulation 2022/63'],
    commonProducts: ['Candy', 'Gum', 'Supplements', 'Sunscreen'],
    safeAlternatives: ['Zinc oxide (non-nano)', 'Rice starch'],
  },
  // ... hundreds more entries
};
```

### 4. Swap Engine

Recommendation system for safe alternatives.

```typescript
// functions/src/swaps/SwapEngine.ts

export interface SwapSuggestion {
  id: string;
  productName: string;
  brand: string;
  score: number;
  imageUrl: string;
  price: number;
  affiliateUrl: string;
  affiliateSource: 'amazon' | 'thrive' | 'iherb' | 'direct';
  badges: ('dad-approved' | 'budget-friendly' | 'premium')[];
  whyBetter: string;
}

export class SwapEngine {
  async getSuggestions(
    analysis: ToxicityAnalysis,
    score: number,
    userPreferences?: UserPreferences
  ): Promise<SwapSuggestion[]> {
    // Only suggest swaps for toxic/caution items
    if (score > 66) return [];

    const category = analysis.category;
    const concerns = analysis.concerns.map(c => c.category);

    // Query Firestore for safe alternatives
    const swapsQuery = db.collection('products')
      .where('category', '==', category)
      .where('score', '>=', 70)
      .orderBy('score', 'desc')
      .limit(10);

    const swaps = await swapsQuery.get();

    let suggestions = swaps.docs.map(doc => ({
      id: doc.id,
      ...doc.data(),
    })) as SwapSuggestion[];

    // Apply user preferences
    if (userPreferences) {
      suggestions = this.applyPreferences(suggestions, userPreferences);
    }

    // Sort by relevance and limit
    return suggestions.slice(0, 5);
  }

  private applyPreferences(
    suggestions: SwapSuggestion[],
    prefs: UserPreferences
  ): SwapSuggestion[] {
    return suggestions.filter(s => {
      if (prefs.maxPrice && s.price > prefs.maxPrice) return false;
      if (prefs.preferOrganic && !s.badges.includes('organic')) return false;
      return true;
    });
  }
}
```

### 5. User Management

Authentication and profile management.

```typescript
// src/modules/user/types.ts

export interface UserProfile {
  id: string;
  email: string;
  displayName?: string;
  subscription: 'free' | 'premium';
  preferences: UserPreferences;
  stats: UserStats;
  createdAt: Date;
}

export interface UserPreferences {
  concernPriorities: ('chemicals' | 'environmental' | 'allergens')[];
  dietaryRestrictions: string[];
  budgetRange: 'budget' | 'mid' | 'premium';
  familyMode: boolean;
  notifications: boolean;
}

export interface UserStats {
  totalScans: number;
  toxinsAvoided: number;
  swapsMade: number;
  streakDays: number;
  badges: string[];
}

export interface ScanHistory {
  id: string;
  userId: string;
  result: ScanResult;
  savedToList?: 'favorites' | 'avoid';
  createdAt: Date;
}
```

```typescript
// src/modules/user/useUser.ts

import { create } from 'zustand';
import { persist, createJSONStorage } from 'zustand/middleware';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface UserState {
  user: UserProfile | null;
  isLoading: boolean;
  scanHistory: ScanHistory[];

  setUser: (user: UserProfile) => void;
  updatePreferences: (prefs: Partial<UserPreferences>) => void;
  addScan: (result: ScanResult) => void;
  incrementToxinsAvoided: (count: number) => void;
}

export const useUserStore = create<UserState>()(
  persist(
    (set, get) => ({
      user: null,
      isLoading: true,
      scanHistory: [],

      setUser: (user) => set({ user, isLoading: false }),

      updatePreferences: (prefs) => set((state) => ({
        user: state.user ? {
          ...state.user,
          preferences: { ...state.user.preferences, ...prefs },
        } : null,
      })),

      addScan: (result) => set((state) => ({
        scanHistory: [
          { id: result.id, userId: state.user?.id || '', result, createdAt: new Date() },
          ...state.scanHistory.slice(0, 99), // Keep last 100
        ],
      })),

      incrementToxinsAvoided: (count) => set((state) => ({
        user: state.user ? {
          ...state.user,
          stats: {
            ...state.user.stats,
            toxinsAvoided: state.user.stats.toxinsAvoided + count,
          },
        } : null,
      })),
    }),
    {
      name: 'user-storage',
      storage: createJSONStorage(() => AsyncStorage),
    }
  )
);
```

---

## Database Schema

### Firestore Collections

```
/users/{userId}
  - email: string
  - displayName: string
  - subscription: 'free' | 'premium'
  - preferences: object
  - stats: object
  - createdAt: timestamp

/users/{userId}/scans/{scanId}
  - productName: string
  - score: number
  - verdict: string
  - analysis: object
  - imageUrl: string (optional, stored in Cloud Storage)
  - savedToList: 'favorites' | 'avoid' | null
  - createdAt: timestamp

/products/{productId}
  - name: string
  - brand: string
  - category: string
  - barcode: string (optional)
  - score: number
  - analysis: object
  - imageUrl: string
  - affiliateLinks: object
  - scanCount: number
  - lastScanned: timestamp
  - createdAt: timestamp

/ingredients/{ingredientId}
  - name: string
  - aliases: string[]
  - category: string
  - toxicityScore: number
  - concerns: string[]
  - sources: string[]
  - updatedAt: timestamp

/swaps/{categoryId}
  - categoryName: string
  - products: object[] (denormalized for fast reads)
  - updatedAt: timestamp
```

### Indexes

```
// Compound indexes for efficient queries
products: category + score (descending)
products: barcode (unique)
users/{userId}/scans: createdAt (descending)
ingredients: name (for search)
```

---

## API Endpoints

### Cloud Functions

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/analyze` | POST | Submit image for toxicity analysis |
| `/products/{id}` | GET | Get cached product details |
| `/products/barcode/{code}` | GET | Lookup by barcode |
| `/swaps/{category}` | GET | Get swap suggestions for category |
| `/search` | GET | Search products/ingredients |
| `/user/stats` | GET | Get user statistics |
| `/subscription/webhook` | POST | RevenueCat webhook handler |

### Request/Response Examples

```typescript
// POST /analyze
// Request
{
  "imageBase64": "...",
  "mode": "label",
  "hints": ["food", "snack"]
}

// Response
{
  "id": "scan_abc123",
  "score": 34,
  "verdict": "caution",
  "product": {
    "name": "Cheetos Crunchy",
    "brand": "Frito-Lay",
    "category": "snacks"
  },
  "analysis": {
    "summary": "Contains several artificial additives and highly processed ingredients.",
    "dadsTake": "I keep these out of my house. The artificial colors and MSG derivatives aren't worth it when there are better options.",
    "concerns": [
      {
        "ingredient": "Yellow 6",
        "severity": "medium",
        "description": "Artificial color linked to hyperactivity"
      }
    ],
    "positives": ["No trans fats listed"]
  },
  "swaps": [
    {
      "id": "prod_xyz",
      "productName": "Lesser Evil Paleo Puffs",
      "score": 82,
      "price": 4.99,
      "affiliateUrl": "https://..."
    }
  ]
}
```

---

## Infrastructure

### Firebase Configuration

```typescript
// firebase.json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  },
  "functions": {
    "source": "functions",
    "runtime": "nodejs20",
    "region": "us-central1"
  },
  "storage": {
    "rules": "storage.rules"
  }
}
```

### Security Rules

```javascript
// firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only access their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;

      match /scans/{scanId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }

    // Products are publicly readable
    match /products/{productId} {
      allow read: if true;
      allow write: if false; // Admin only via Cloud Functions
    }

    // Ingredients are publicly readable
    match /ingredients/{ingredientId} {
      allow read: if true;
      allow write: if false;
    }
  }
}
```

### Environment Variables

```bash
# .env (Cloud Functions)
OPENAI_API_KEY=sk-...
GOOGLE_CLOUD_VISION_KEY=...
REVENUECAT_WEBHOOK_SECRET=...

# Affiliate API Keys
AMAZON_AFFILIATE_TAG=...
THRIVE_AFFILIATE_ID=...
IHERB_AFFILIATE_CODE=...
```

---

## Performance Considerations

### Image Optimization
- Compress images client-side before upload (max 1024px width, 70% quality)
- Cache processed results by image hash
- Use Cloud Storage CDN for product images

### Database Optimization
- Denormalize swap suggestions for fast reads
- Use Firestore offline persistence for scan history
- Implement pagination for large lists

### API Response Times
- Target: < 3 seconds for full analysis
- Cache common products (80% of scans are repeat products)
- Use streaming responses for progressive UI updates

### Cost Optimization
- GPT-4o Vision: ~$0.01-0.03 per scan
- Implement daily scan limits for free tier
- Cache aggressively to reduce API calls

---

## Development Setup

### Prerequisites
```bash
node >= 20.0.0
npm >= 10.0.0
expo-cli >= 6.0.0
firebase-tools >= 13.0.0
```

### Local Development
```bash
# Clone repository
git clone https://github.com/[org]/non-toxic-living.git
cd non-toxic-living

# Install dependencies
npm install

# Start Expo development server
npm run start

# Start Firebase emulators
npm run emulators

# Run tests
npm test
```

### Project Structure
```
non-toxic-living/
├── app/                    # Expo Router screens
│   ├── (tabs)/
│   │   ├── index.tsx      # Home/Dashboard
│   │   ├── scan.tsx       # Scanner
│   │   ├── search.tsx     # Search
│   │   └── profile.tsx    # Profile
│   ├── result/[id].tsx    # Scan result detail
│   └── _layout.tsx        # Root layout
├── src/
│   ├── components/        # Reusable UI components
│   ├── modules/           # Feature modules
│   │   ├── scanner/
│   │   ├── user/
│   │   └── swaps/
│   ├── hooks/             # Custom hooks
│   ├── utils/             # Utilities
│   └── constants/         # App constants
├── functions/             # Cloud Functions
│   ├── src/
│   │   ├── analyze/
│   │   ├── swaps/
│   │   └── data/
│   └── package.json
├── assets/                # Images, fonts
├── app.json              # Expo config
├── firebase.json         # Firebase config
└── package.json
```

---

## Testing Strategy

### Unit Tests
- Jest for business logic
- Mock AI API responses
- Test toxicity score calculations

### Integration Tests
- Test full scan flow with Firebase emulators
- Verify Firestore read/write operations
- Test authentication flows

### E2E Tests
- Detox for mobile E2E testing
- Test camera permissions flow
- Test purchase flow (sandbox)

---

## Deployment

### Mobile App
1. Build with EAS Build: `eas build --platform all`
2. Submit to App Store Connect and Google Play Console
3. Staged rollout (10% → 50% → 100%)

### Backend
1. Deploy functions: `firebase deploy --only functions`
2. Deploy rules: `firebase deploy --only firestore:rules,storage:rules`
3. Monitor via Firebase Console

### CI/CD
- GitHub Actions for automated testing
- EAS Build for automated mobile builds
- Firebase Hosting for web admin dashboard (future)
