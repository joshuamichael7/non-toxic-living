# Non-Toxic Living

A mobile-first utility app that helps users identify environmental toxins, harmful ingredients, and hidden dangers in every aspect of life—from food and cosmetics to furniture and household items.

## Project Status: Planning Phase

This repository contains the product strategy and planning documents for Non-Toxic Living.

## Documents

| File | Description |
|------|-------------|
| [PRODUCT_SPEC.md](./PRODUCT_SPEC.md) | Feature specifications, user flows, and monetization strategy |
| [DESIGN_SYSTEM.md](./DESIGN_SYSTEM.md) | UI/UX guidelines, color palette, and design patterns |
| [TECHNICAL_ARCHITECTURE.md](./TECHNICAL_ARCHITECTURE.md) | Tech stack, AI/ML requirements, and system architecture |

## The Problem

People want to avoid toxins in their daily lives but face significant barriers:

1. **Information Overload**: Thousands of ingredients to research, constantly changing science
2. **Label Limitations**: Products often lack clear ingredient lists (furniture, toys, cookware)
3. **Fragmented Tools**: Existing apps only cover specific categories (food OR cosmetics)
4. **Hidden Dangers**: Off-gassing, microplastics, EMFs, and processing methods are rarely discussed
5. **No Action Path**: Knowing something is "bad" doesn't help without safe alternatives

## The Solution

Non-Toxic Living provides:

- **Universal AI Scanner**: Point your camera at anything—food, cosmetics, furniture, cookware, toys
- **Beyond Barcodes**: Visual recognition identifies products even without labels
- **Instant Verdicts**: Clear "Safe", "Caution", or "Toxic" ratings with explanations
- **Actionable Swaps**: Immediate suggestions for safe alternatives
- **Expert Guidance**: Criteria aligned with rigorous health standards (including often-overlooked factors)

## Core Features

### AI-Powered Scanner
- **OCR Mode**: Reads ingredient lists, nutrition facts, and material labels
- **Visual Recognition**: Identifies products by packaging, logos, and object type
- **Zero-Shot Analysis**: Can infer composition even without exact product data

### Toxicity Analysis
- **Ingredients**: Food additives, cosmetic chemicals, preservatives
- **Materials**: Plastics, fabrics, coatings, foams
- **Processing**: Inferred manufacturing and processing methods
- **Environmental**: Off-gassing, microplastic shedding, EMF considerations

### Smart Recommendations
- Curated safe alternatives for toxic products
- Personalized based on user preferences and budget
- Affiliate partnerships with vetted non-toxic brands

## Tech Stack (Planned)

- **Frontend**: React Native (Expo) - Cross-platform mobile
- **Backend**: Node.js/Python serverless functions
- **AI/ML**: GPT-4o or Gemini 1.5 Pro for multimodal analysis
- **Database**: Firestore or PostgreSQL
- **Cloud**: Firebase or AWS

## Strategic Partner

Designed to align with the "Non-Toxic Dad" brand and methodology—utilizing rigorous, science-backed criteria that go beyond mainstream toxicity assessments.

## Roadmap

- [ ] **Phase 1**: Product specification and design system
- [ ] **Phase 2**: MVP development (core scanner + basic database)
- [ ] **Phase 3**: Beta testing with early adopters
- [ ] **Phase 4**: Launch and iterate

## License

TBD - Will be determined before public release.
