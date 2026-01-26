# UploadPro

A desktop video optimizer for Instagram and TikTok creators. Pre-processes videos to exact platform specs so they don't get crushed by server-side compression.

## Project Status: Planning Phase

This repository contains the strategy and planning documents for UploadPro.

## Documents

| File | Description |
|------|-------------|
| [STRATEGY.md](./STRATEGY.md) | Full product strategy, market analysis, and technical approach |
| [IMPLEMENTATION_PLAN.md](./IMPLEMENTATION_PLAN.md) | Detailed development plan with code examples |
| [VALIDATION.md](./VALIDATION.md) | Market validation steps to complete before building |

## The Problem

Video editors export high-quality videos on desktop but Instagram/TikTok crush the quality during upload because:

1. Files don't match platform specs exactly
2. Platform algorithms assume unoptimized casual uploads
3. Desktop web upload experiences are afterthoughts

## The Solution

A native desktop app that:

1. Analyzes your video file
2. Re-encodes to exact platform specs (codec, bitrate, resolution)
3. Outputs a file that platforms won't re-compress
4. Includes thumbnail picker (missing from desktop web)

## Tech Stack (Planned)

- **Framework**: Electron + React + TypeScript
- **Video Engine**: FFmpeg (bundled)
- **Styling**: Tailwind CSS
- **Distribution**: electron-builder (Mac DMG, Windows NSIS)

## Quick Start (Development)

```bash
# Clone the repo
git clone https://github.com/[your-username]/uploadpro.git
cd uploadpro

# Install dependencies (after project is scaffolded)
npm install

# Run in development
npm run dev

# Build for distribution
npm run build
```

## Roadmap

- [ ] **Week 1-2**: Market validation (Reddit posts, landing page)
- [ ] **Week 3-4**: Core FFmpeg processing engine
- [ ] **Week 5-6**: User interface
- [ ] **Week 7**: Beta testing
- [ ] **Week 8**: Launch

## Contributing

This is currently a solo project in planning phase. Check back after MVP launch for contribution guidelines.

## License

TBD - Will be determined before public release.
