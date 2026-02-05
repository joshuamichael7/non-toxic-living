export const colors = {
  // Background colors
  stone: {
    50: '#FAFAF9',
    100: '#F5F5F4',
    200: '#E7E5E4',
    400: '#A8A29E',
    600: '#57534E',
    900: '#1C1917',
  },

  // Safety score colors
  safe: {
    DEFAULT: '#10B981',
    light: '#D1FAE5',
    glow: 'rgba(16, 185, 129, 0.25)',
  },
  caution: {
    DEFAULT: '#F59E0B',
    light: '#FEF3C7',
    glow: 'rgba(245, 158, 11, 0.25)',
  },
  toxic: {
    DEFAULT: '#F43F5E',
    light: '#FFE4E6',
    glow: 'rgba(244, 63, 94, 0.25)',
  },

  // Primary accent
  primary: {
    DEFAULT: '#059669',
    dark: '#047857',
  },

  // Standard colors
  white: '#FFFFFF',
  black: '#000000',
  transparent: 'transparent',
} as const;

export type ColorName = keyof typeof colors;
