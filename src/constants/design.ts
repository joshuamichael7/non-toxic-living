/**
 * Frosted Aerogel Design System
 *
 * A clinical, premium tech aesthetic with:
 * - Light matte gray canvas background
 * - Frosted glass surfaces with white borders
 * - Oxygen Blue (clinical blue) as primary accent
 * - Blue glow shadows on interactive elements
 * - Aggressive border radii (24-32px)
 */

export const colors = {
  // Canvas (Background)
  canvas: '#E8E8E8',

  // Glass Surfaces
  glass: {
    DEFAULT: 'rgba(240, 240, 240, 0.65)',
    solid: '#F0F0F0',
    border: 'rgba(255, 255, 255, 0.6)',
  },

  // Oxygen Blue (Primary Accent)
  oxygen: {
    DEFAULT: '#0EA5E9',
    deep: '#0284C7',
    light: '#38BDF8',
    glow: 'rgba(14, 165, 233, 0.3)',
    glowSubtle: 'rgba(14, 165, 233, 0.15)',
  },

  // Text Colors (Ink)
  ink: {
    DEFAULT: '#1A1A1A',
    secondary: '#64748B',
    muted: '#94A3B8',
  },

  // Safety Colors (Clinical versions)
  safe: {
    DEFAULT: '#10B981',
    light: 'rgba(16, 185, 129, 0.15)',
  },
  caution: {
    DEFAULT: '#F59E0B',
    light: 'rgba(245, 158, 11, 0.15)',
  },
  toxic: {
    DEFAULT: '#EF4444',
    light: 'rgba(239, 68, 68, 0.15)',
  },
} as const;

// Flat colors for easier inline use
export const flatColors = {
  canvas: colors.canvas,
  glassSolid: colors.glass.solid,
  glassBorder: colors.glass.border,
  oxygen: colors.oxygen.DEFAULT,
  oxygenDeep: colors.oxygen.deep,
  oxygenLight: colors.oxygen.light,
  oxygenGlow: colors.oxygen.glow,
  oxygenGlowSubtle: colors.oxygen.glowSubtle,
  ink: colors.ink.DEFAULT,
  inkSecondary: colors.ink.secondary,
  inkMuted: colors.ink.muted,
  safe: colors.safe.DEFAULT,
  safeLight: colors.safe.light,
  caution: colors.caution.DEFAULT,
  cautionLight: colors.caution.light,
  toxic: colors.toxic.DEFAULT,
  toxicLight: colors.toxic.light,
} as const;

export const shadows = {
  glass: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.06,
    shadowRadius: 24,
  },
  subtle: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.04,
    shadowRadius: 12,
  },
  oxygenGlow: {
    shadowColor: colors.oxygen.DEFAULT,
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.3,
    shadowRadius: 16,
  },
  safeGlow: {
    shadowColor: colors.safe.DEFAULT,
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.3,
    shadowRadius: 16,
  },
  cautionGlow: {
    shadowColor: colors.caution.DEFAULT,
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.3,
    shadowRadius: 16,
  },
  toxicGlow: {
    shadowColor: colors.toxic.DEFAULT,
    shadowOffset: { width: 0, height: 8 },
    shadowOpacity: 0.3,
    shadowRadius: 16,
  },
} as const;

export const borderRadii = {
  sm: 8,
  md: 12,
  lg: 16,
  xl: 20,
  '2xl': 24,
  '3xl': 32,
  pill: 9999,
} as const;

export const typography = {
  fontFamily: {
    sans: 'System', // Will be Space Grotesk when fonts are loaded
    mono: 'monospace',
  },
  fontSize: {
    xs: 11,
    sm: 13,
    base: 15,
    lg: 18,
    xl: 20,
    '2xl': 24,
    '3xl': 28,
    '4xl': 32,
  },
  fontWeight: {
    regular: '400' as const,
    medium: '500' as const,
    semibold: '600' as const,
    bold: '700' as const,
    extrabold: '800' as const,
  },
} as const;
