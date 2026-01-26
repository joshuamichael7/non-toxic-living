# Implementation Plan: UploadPro MVP

## Tech Stack Decision

### Recommended: Electron + React + TypeScript

**Why Electron over Tauri for MVP:**
- Faster development (JavaScript ecosystem)
- More tutorials/resources available
- Easier to find help if stuck
- Can always optimize later

**Why React:**
- Component-based (good for our UI)
- Large ecosystem
- You may already know it

**Key Dependencies:**
```json
{
  "electron": "^28.0.0",
  "react": "^18.2.0",
  "fluent-ffmpeg": "^2.1.2",
  "electron-builder": "^24.0.0",
  "tailwindcss": "^3.4.0"
}
```

---

## Project Structure

```
uploadpro/
├── package.json
├── electron/
│   ├── main.ts              # Electron main process
│   ├── preload.ts           # Bridge between main/renderer
│   └── ffmpeg/
│       ├── processor.ts     # FFmpeg wrapper
│       └── presets.ts       # Platform-specific settings
├── src/
│   ├── App.tsx
│   ├── components/
│   │   ├── DropZone.tsx     # Drag-and-drop area
│   │   ├── PresetSelector.tsx
│   │   ├── ProgressBar.tsx
│   │   ├── ThumbnailPicker.tsx
│   │   └── OutputPreview.tsx
│   ├── hooks/
│   │   └── useVideoProcessor.ts
│   └── styles/
│       └── globals.css
├── resources/
│   └── ffmpeg/              # Bundled FFmpeg binaries
│       ├── ffmpeg-mac
│       ├── ffmpeg-win.exe
│       └── ffmpeg-linux
└── build/                   # Build output
```

---

## Development Phases

### Phase 1: Project Setup (Day 1-2)

**Tasks:**
1. Initialize Electron + React project
2. Set up TypeScript configuration
3. Configure Tailwind CSS
4. Set up electron-builder for packaging
5. Download and bundle FFmpeg binaries

**Validation Checkpoint:**
- Can build and run empty Electron app
- Hot reload working for development

---

### Phase 2: Core Video Processing (Day 3-5)

**Tasks:**
1. Create FFmpeg wrapper module
2. Implement preset configurations
3. Build file analysis function (detect input specs)
4. Create optimization pipeline
5. Add progress reporting

**Key Code: FFmpeg Preset System**

```typescript
// electron/ffmpeg/presets.ts

export interface VideoPreset {
  name: string;
  platform: 'instagram' | 'tiktok';
  format: 'reels' | 'feed_square' | 'feed_portrait' | 'story';
  width: number;
  height: number;
  videoBitrate: string;
  maxBitrate: string;
  audioBitrate: string;
  fps: number;
}

export const PRESETS: Record<string, VideoPreset> = {
  instagram_reels: {
    name: 'Instagram Reels',
    platform: 'instagram',
    format: 'reels',
    width: 1080,
    height: 1920,
    videoBitrate: '5M',
    maxBitrate: '6M',
    audioBitrate: '128k',
    fps: 30
  },
  tiktok: {
    name: 'TikTok',
    platform: 'tiktok',
    format: 'reels',
    width: 1080,
    height: 1920,
    videoBitrate: '6M',
    maxBitrate: '8M',
    audioBitrate: '128k',
    fps: 30
  },
  instagram_feed_square: {
    name: 'Instagram Feed (Square)',
    platform: 'instagram',
    format: 'feed_square',
    width: 1080,
    height: 1080,
    videoBitrate: '4M',
    maxBitrate: '5M',
    audioBitrate: '128k',
    fps: 30
  },
  instagram_feed_portrait: {
    name: 'Instagram Feed (Portrait)',
    platform: 'instagram',
    format: 'feed_portrait',
    width: 1080,
    height: 1350,
    videoBitrate: '4M',
    maxBitrate: '5M',
    audioBitrate: '128k',
    fps: 30
  }
};
```

**Key Code: FFmpeg Processor**

```typescript
// electron/ffmpeg/processor.ts

import ffmpeg from 'fluent-ffmpeg';
import path from 'path';
import { VideoPreset } from './presets';

export interface ProcessingProgress {
  percent: number;
  currentTime: number;
  totalTime: number;
}

export async function optimizeVideo(
  inputPath: string,
  outputPath: string,
  preset: VideoPreset,
  onProgress: (progress: ProcessingProgress) => void
): Promise<void> {
  return new Promise((resolve, reject) => {
    ffmpeg(inputPath)
      // Video settings
      .videoCodec('libx264')
      .addOutputOptions([
        '-profile:v high',
        '-level:v 4.0',
        '-pix_fmt yuv420p',
        `-b:v ${preset.videoBitrate}`,
        `-maxrate ${preset.maxBitrate}`,
        '-bufsize 12M',
      ])
      // Scale with padding to maintain aspect ratio
      .videoFilter([
        `scale=${preset.width}:${preset.height}:force_original_aspect_ratio=decrease`,
        `pad=${preset.width}:${preset.height}:(ow-iw)/2:(oh-ih)/2`
      ])
      .fps(preset.fps)
      // Audio settings
      .audioCodec('aac')
      .audioBitrate(preset.audioBitrate)
      .audioFrequency(44100)
      // Output settings
      .addOutputOptions(['-movflags', '+faststart'])
      .on('progress', (progress) => {
        onProgress({
          percent: progress.percent || 0,
          currentTime: progress.timemark ? parseTimemark(progress.timemark) : 0,
          totalTime: 0 // Set from probe data
        });
      })
      .on('end', () => resolve())
      .on('error', (err) => reject(err))
      .save(outputPath);
  });
}

function parseTimemark(timemark: string): number {
  const parts = timemark.split(':').map(Number);
  return parts[0] * 3600 + parts[1] * 60 + parts[2];
}
```

**Validation Checkpoint:**
- Can process a test video file
- Output file matches expected specs
- Progress events firing correctly

---

### Phase 3: User Interface (Day 6-8)

**Tasks:**
1. Build DropZone component with drag-and-drop
2. Create preset selector with visual previews
3. Implement progress bar with time estimate
4. Build output comparison view (before/after)
5. Add thumbnail picker with frame scrubber

**Key Component: DropZone**

```tsx
// src/components/DropZone.tsx

import React, { useCallback, useState } from 'react';

interface DropZoneProps {
  onFileSelect: (file: File) => void;
}

export function DropZone({ onFileSelect }: DropZoneProps) {
  const [isDragging, setIsDragging] = useState(false);

  const handleDrop = useCallback((e: React.DragEvent) => {
    e.preventDefault();
    setIsDragging(false);

    const file = e.dataTransfer.files[0];
    if (file && file.type.startsWith('video/')) {
      onFileSelect(file);
    }
  }, [onFileSelect]);

  return (
    <div
      onDragOver={(e) => { e.preventDefault(); setIsDragging(true); }}
      onDragLeave={() => setIsDragging(false)}
      onDrop={handleDrop}
      className={`
        border-2 border-dashed rounded-xl p-12 text-center
        transition-colors cursor-pointer
        ${isDragging
          ? 'border-blue-500 bg-blue-50'
          : 'border-gray-300 hover:border-gray-400'}
      `}
    >
      <div className="text-4xl mb-4">📹</div>
      <p className="text-lg font-medium">
        Drop your video here
      </p>
      <p className="text-sm text-gray-500 mt-2">
        Supports MP4, MOV, ProRes, and more
      </p>
    </div>
  );
}
```

**Validation Checkpoint:**
- Full workflow working end-to-end
- Can drag file, select preset, process, save output

---

### Phase 4: Thumbnail Picker (Day 9-10)

**Tasks:**
1. Extract frames from video at intervals
2. Build frame scrubber UI
3. Add custom thumbnail upload option
4. Export selected frame as JPEG

**Key Code: Frame Extraction**

```typescript
// electron/ffmpeg/thumbnails.ts

export async function extractFrames(
  videoPath: string,
  outputDir: string,
  frameCount: number = 10
): Promise<string[]> {
  return new Promise((resolve, reject) => {
    const framePaths: string[] = [];

    ffmpeg(videoPath)
      .screenshots({
        count: frameCount,
        folder: outputDir,
        filename: 'frame-%i.jpg',
        size: '320x?'  // Thumbnail size for preview
      })
      .on('end', () => {
        for (let i = 1; i <= frameCount; i++) {
          framePaths.push(path.join(outputDir, `frame-${i}.jpg`));
        }
        resolve(framePaths);
      })
      .on('error', reject);
  });
}

export async function extractFrameAtTime(
  videoPath: string,
  outputPath: string,
  timeInSeconds: number,
  fullResolution: boolean = true
): Promise<void> {
  return new Promise((resolve, reject) => {
    let command = ffmpeg(videoPath)
      .seekInput(timeInSeconds)
      .frames(1);

    if (!fullResolution) {
      command = command.size('1080x?');
    }

    command
      .on('end', () => resolve())
      .on('error', reject)
      .save(outputPath);
  });
}
```

---

### Phase 5: Polish & Packaging (Day 11-14)

**Tasks:**
1. Error handling and user feedback
2. Auto-update system
3. App icons and branding
4. Build installers for Mac/Windows
5. Code signing (required for Mac distribution)

**electron-builder config:**

```json
{
  "build": {
    "appId": "com.uploadpro.app",
    "productName": "UploadPro",
    "mac": {
      "category": "public.app-category.video",
      "target": ["dmg", "zip"],
      "hardenedRuntime": true,
      "gatekeeperAssess": false
    },
    "win": {
      "target": ["nsis", "portable"]
    },
    "extraResources": [
      {
        "from": "resources/ffmpeg",
        "to": "ffmpeg"
      }
    ]
  }
}
```

---

## Monetization Integration

### Recommended: Gumroad or LemonSqueezy

**Why not Stripe directly?**
- License key management built-in
- Handles VAT for international sales
- Simple webhook integration

**Implementation:**

```typescript
// src/hooks/useLicense.ts

export function useLicense() {
  const [isPro, setIsPro] = useState(false);
  const [usageToday, setUsageToday] = useState(0);

  const FREE_LIMIT = 3;

  const canProcess = isPro || usageToday < FREE_LIMIT;

  const validateLicense = async (key: string): Promise<boolean> => {
    // Call Gumroad/LemonSqueezy API to validate
    const response = await fetch('https://api.gumroad.com/v2/licenses/verify', {
      method: 'POST',
      body: JSON.stringify({
        product_id: 'YOUR_PRODUCT_ID',
        license_key: key
      })
    });

    const data = await response.json();
    if (data.success) {
      // Store license locally
      localStorage.setItem('license_key', key);
      setIsPro(true);
      return true;
    }
    return false;
  };

  return { isPro, canProcess, usageToday, validateLicense };
}
```

---

## Testing Checklist

### Before Beta Release
- [ ] Test with 10+ different video formats (MP4, MOV, ProRes, HEVC)
- [ ] Test with edge cases (very short, very long, 4K, vertical, horizontal)
- [ ] Test on both Mac and Windows
- [ ] Verify output quality on actual Instagram/TikTok uploads
- [ ] Test free tier limits
- [ ] Test license activation flow

### Beta Feedback Questions
1. Was the app easy to understand without instructions?
2. Did the output quality meet your expectations?
3. What feature would you most want added?
4. Would you pay $49 for lifetime access?
5. Any bugs or crashes?

---

## Launch Checklist

### Pre-Launch (1 week before)
- [ ] Landing page live with email capture
- [ ] Payment integration tested
- [ ] Download links working
- [ ] Support email set up
- [ ] Social media accounts created

### Launch Day
- [ ] Product Hunt submission (aim for Tuesday 12:01 AM PST)
- [ ] Post to Reddit communities
- [ ] Reach out to beta testers for reviews
- [ ] Monitor for critical bugs

### Post-Launch (Week 1)
- [ ] Respond to all feedback
- [ ] Fix critical bugs within 24 hours
- [ ] Collect testimonials
- [ ] Plan v1.1 based on feedback
