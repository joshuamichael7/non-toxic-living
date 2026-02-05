# Non-Toxic Living: Design System

## Design Philosophy

**Vibe**: Premium, airy, organic, clean, trustworthy

The design should feel like a breath of fresh air—reflecting the app's mission to help users live cleaner, healthier lives. Every element should communicate trustworthiness, clarity, and calm.

---

## Typography

### Primary Font: Manrope

Manrope is a geometric sans-serif that feels modern and friendly while maintaining excellent readability. It works beautifully across all sizes.

```
Font Family: 'Manrope', sans-serif
Google Fonts: https://fonts.google.com/specimen/Manrope
```

### Type Scale

| Name | Size | Weight | Line Height | Usage |
|------|------|--------|-------------|-------|
| **Display** | 32px | 700 | 1.2 | Hero numbers, scores |
| **Title 1** | 24px | 600 | 1.3 | Screen titles |
| **Title 2** | 20px | 600 | 1.3 | Section headers |
| **Title 3** | 18px | 600 | 1.4 | Card titles |
| **Body** | 16px | 400 | 1.5 | Primary content |
| **Body Bold** | 16px | 600 | 1.5 | Emphasis |
| **Caption** | 14px | 400 | 1.4 | Secondary info |
| **Small** | 12px | 500 | 1.4 | Labels, metadata |

### Font Weights
- Regular: 400
- Medium: 500
- SemiBold: 600
- Bold: 700

---

## Color Palette

### Background Colors

| Name | Hex | RGB | Usage |
|------|-----|-----|-------|
| **Stone-50** | `#FAFAF9` | 250, 250, 249 | Primary background |
| **White** | `#FFFFFF` | 255, 255, 255 | Cards, elevated surfaces |
| **Stone-100** | `#F5F5F4` | 245, 245, 244 | Secondary background |
| **Stone-200** | `#E7E5E4` | 231, 229, 228 | Borders, dividers |

### Safety Score Colors

| Status | Name | Hex | RGB | Usage |
|--------|------|-----|-----|-------|
| **Safe** | Emerald-500 | `#10B981` | 16, 185, 129 | Safe scores (67-100) |
| **Safe Light** | Emerald-100 | `#D1FAE5` | 209, 250, 229 | Safe backgrounds |
| **Caution** | Amber-500 | `#F59E0B` | 245, 158, 11 | Caution scores (34-66) |
| **Caution Light** | Amber-100 | `#FEF3C7` | 254, 243, 199 | Caution backgrounds |
| **Toxic** | Rose-500 | `#F43F5E` | 244, 63, 94 | Toxic scores (0-33) |
| **Toxic Light** | Rose-100 | `#FFE4E6` | 255, 228, 230 | Toxic backgrounds |

### Accent & UI Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Primary** | `#059669` (Emerald-600) | Primary actions, CTAs |
| **Primary Dark** | `#047857` (Emerald-700) | Pressed states |
| **Text Primary** | `#1C1917` (Stone-900) | Headlines, important text |
| **Text Secondary** | `#57534E` (Stone-600) | Body text |
| **Text Tertiary** | `#A8A29E` (Stone-400) | Placeholder, disabled |

### Semantic Colors

```css
--color-safe: #10B981;
--color-safe-bg: #D1FAE5;
--color-safe-glow: rgba(16, 185, 129, 0.3);

--color-caution: #F59E0B;
--color-caution-bg: #FEF3C7;
--color-caution-glow: rgba(245, 158, 11, 0.3);

--color-toxic: #F43F5E;
--color-toxic-bg: #FFE4E6;
--color-toxic-glow: rgba(244, 63, 94, 0.3);
```

---

## Spacing System

Based on a 4px grid with an 8px base unit.

| Name | Value | Usage |
|------|-------|-------|
| **xs** | 4px | Tight spacing, icon padding |
| **sm** | 8px | Default component padding |
| **md** | 16px | Card padding, section gaps |
| **lg** | 24px | Large section spacing |
| **xl** | 32px | Screen margins |
| **2xl** | 48px | Hero spacing |
| **3xl** | 64px | Major section breaks |

---

## Border Radius

| Name | Value | Usage |
|------|-------|-------|
| **sm** | 8px | Small buttons, chips |
| **md** | 12px | Input fields, small cards |
| **lg** | 16px | Cards, modals |
| **xl** | 24px | Large cards, sheets |
| **full** | 9999px | Pills, circular buttons |

---

## Shadows

### Standard Shadows

```css
/* Subtle - for cards */
--shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);

/* Default - for elevated cards */
--shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.07),
             0 2px 4px -1px rgba(0, 0, 0, 0.04);

/* Large - for modals, sheets */
--shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.08),
             0 4px 6px -2px rgba(0, 0, 0, 0.04);

/* Extra large - for floating elements */
--shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.08),
             0 10px 10px -5px rgba(0, 0, 0, 0.03);
```

### Colored Shadows (Glows)

Used behind score badges and safety indicators:

```css
/* Safe glow */
--glow-safe: 0 4px 14px rgba(16, 185, 129, 0.25);

/* Caution glow */
--glow-caution: 0 4px 14px rgba(245, 158, 11, 0.25);

/* Toxic glow */
--glow-toxic: 0 4px 14px rgba(244, 63, 94, 0.25);
```

---

## UI Patterns

### 1. Glassmorphism

Used for sheets, overlays, and floating UI elements.

```css
.glass-panel {
  background: rgba(255, 255, 255, 0.8);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.3);
  border-radius: 24px;
}

.glass-panel-dark {
  background: rgba(28, 25, 23, 0.7);
  backdrop-filter: blur(20px);
  border: 1px solid rgba(255, 255, 255, 0.1);
}
```

### 2. Floating Elements

Buttons and navigation bars float above content, never sticking directly to edges.

```css
.floating-button {
  position: absolute;
  bottom: 32px;  /* Never 0 */
  left: 50%;
  transform: translateX(-50%);
  padding: 16px 32px;
  border-radius: 9999px;
  box-shadow: var(--shadow-xl);
}

.floating-nav {
  position: fixed;
  bottom: 24px;
  left: 16px;
  right: 16px;
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.9);
  backdrop-filter: blur(20px);
}
```

### 3. Immersive Imagery

Camera feed and product images take up 100% of screen height behind UI.

```css
.immersive-background {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  z-index: 0;
}

.content-overlay {
  position: relative;
  z-index: 1;
}
```

### 4. Bottom Sheets

Slide-up panels for results and details.

```css
.bottom-sheet {
  position: fixed;
  bottom: 0;
  left: 0;
  right: 0;
  background: rgba(255, 255, 255, 0.95);
  backdrop-filter: blur(20px);
  border-radius: 24px 24px 0 0;
  padding: 24px;
  max-height: 80vh;
  overflow-y: auto;

  /* Drag handle */
  &::before {
    content: '';
    position: absolute;
    top: 12px;
    left: 50%;
    transform: translateX(-50%);
    width: 36px;
    height: 4px;
    background: #E7E5E4;
    border-radius: 2px;
  }
}
```

---

## Component Library

### Score Badge

```css
.score-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 64px;
  height: 64px;
  border-radius: 50%;
  font-size: 24px;
  font-weight: 700;
}

.score-badge--safe {
  background: var(--color-safe-bg);
  color: var(--color-safe);
  box-shadow: var(--glow-safe);
}

.score-badge--caution {
  background: var(--color-caution-bg);
  color: var(--color-caution);
  box-shadow: var(--glow-caution);
}

.score-badge--toxic {
  background: var(--color-toxic-bg);
  color: var(--color-toxic);
  box-shadow: var(--glow-toxic);
}
```

### Insight Card

```css
.insight-card {
  background: white;
  border-radius: 16px;
  padding: 16px;
  box-shadow: var(--shadow-md);
  min-width: 280px;
}

.insight-card__icon {
  width: 40px;
  height: 40px;
  border-radius: 12px;
  background: var(--color-safe-bg);
  display: flex;
  align-items: center;
  justify-content: center;
}
```

### Product Card (Swap Suggestion)

```css
.product-card {
  background: white;
  border-radius: 16px;
  padding: 12px;
  box-shadow: var(--shadow-sm);
  display: flex;
  gap: 12px;
  align-items: center;
}

.product-card__image {
  width: 64px;
  height: 64px;
  border-radius: 12px;
  object-fit: cover;
  background: #F5F5F4;
}

.product-card__badge {
  position: absolute;
  top: 8px;
  right: 8px;
  background: var(--color-safe);
  color: white;
  font-size: 12px;
  font-weight: 600;
  padding: 4px 8px;
  border-radius: 6px;
}
```

### Primary Button

```css
.btn-primary {
  background: var(--color-primary);
  color: white;
  font-size: 16px;
  font-weight: 600;
  padding: 16px 24px;
  border-radius: 12px;
  border: none;
  box-shadow: var(--shadow-md);
  transition: all 0.2s ease;
}

.btn-primary:hover {
  background: var(--color-primary-dark);
  transform: translateY(-1px);
  box-shadow: var(--shadow-lg);
}

.btn-primary:active {
  transform: translateY(0);
}
```

### Scan Button (Floating)

```css
.scan-button {
  width: 72px;
  height: 72px;
  border-radius: 50%;
  background: linear-gradient(135deg, #059669 0%, #10B981 100%);
  border: 4px solid white;
  box-shadow: 0 8px 24px rgba(5, 150, 105, 0.4);
  display: flex;
  align-items: center;
  justify-content: center;
  transition: all 0.2s ease;
}

.scan-button:active {
  transform: scale(0.95);
}

.scan-button__icon {
  width: 28px;
  height: 28px;
  color: white;
}
```

---

## Iconography

### Style Guidelines
- **Weight**: 1.5px stroke (outline style)
- **Size**: 24x24px default
- **Color**: Inherit from parent or Stone-600
- **Style**: Rounded corners, friendly feel

### Recommended Icon Set
- **Phosphor Icons** (phosphoricons.com) - Flexible, modern
- **Heroicons** - Clean, well-maintained
- **Lucide** - Consistent, open source

### Core Icons Needed
| Icon | Usage |
|------|-------|
| Camera | Scanner |
| Search | Search bar |
| Home | Dashboard |
| User | Profile |
| Heart | Favorites |
| X Circle | Toxic indicator |
| Check Circle | Safe indicator |
| Alert Triangle | Caution indicator |
| Leaf | Organic/natural |
| Shield | Safety/protection |
| Barcode | Scan mode |
| Eye | Visual recognition |
| History | Recent scans |
| Star | Premium/featured |

---

## Animation Guidelines

### Principles
- **Subtle**: Animations should feel natural, not flashy
- **Purposeful**: Every animation should have meaning
- **Fast**: Keep durations under 300ms for interactions

### Timing Functions

```css
--ease-out: cubic-bezier(0.16, 1, 0.3, 1);
--ease-in-out: cubic-bezier(0.45, 0, 0.55, 1);
--spring: cubic-bezier(0.34, 1.56, 0.64, 1);
```

### Standard Durations

| Duration | Usage |
|----------|-------|
| 150ms | Micro-interactions (button press) |
| 200ms | State changes (hover, focus) |
| 300ms | Component transitions |
| 400ms | Page/sheet transitions |

### Key Animations

**Score Reveal**:
```css
@keyframes score-reveal {
  from {
    opacity: 0;
    transform: scale(0.8);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}

.score-badge {
  animation: score-reveal 400ms var(--spring) forwards;
}
```

**Sheet Slide Up**:
```css
@keyframes sheet-up {
  from {
    transform: translateY(100%);
  }
  to {
    transform: translateY(0);
  }
}

.bottom-sheet {
  animation: sheet-up 400ms var(--ease-out) forwards;
}
```

---

## Accessibility

### Color Contrast
- All text must meet WCAG AA standards (4.5:1 for normal text, 3:1 for large text)
- Safety colors chosen for sufficient contrast on both light and dark backgrounds

### Touch Targets
- Minimum touch target size: 44x44px
- Adequate spacing between interactive elements

### Screen Reader Support
- All icons include sr-only labels
- Score badges announce "Safe: 87 out of 100" not just "87"
- Form inputs have proper labels

### Motion
- Respect `prefers-reduced-motion` preference
- Provide static alternatives for all animations

---

## Dark Mode (Future)

Dark mode colors to be implemented in v1.1:

```css
/* Dark mode backgrounds */
--dark-bg-primary: #1C1917;
--dark-bg-secondary: #292524;
--dark-bg-elevated: #3F3A36;

/* Dark mode text */
--dark-text-primary: #FAFAF9;
--dark-text-secondary: #A8A29E;

/* Safety colors remain the same */
/* Glows become more prominent in dark mode */
```
