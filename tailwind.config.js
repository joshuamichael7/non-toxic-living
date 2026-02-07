/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./app/**/*.{js,jsx,ts,tsx}",
    "./src/**/*.{js,jsx,ts,tsx}",
  ],
  presets: [require("nativewind/preset")],
  theme: {
    extend: {
      colors: {
        // Aerogel Design System
        canvas: '#E8E8E8',
        glass: {
          DEFAULT: 'rgba(240, 240, 240, 0.65)',
          solid: '#F0F0F0',
          border: 'rgba(255, 255, 255, 0.6)',
        },
        // Oxygen Blue (Primary)
        oxygen: {
          DEFAULT: '#0EA5E9',
          deep: '#0284C7',
          light: '#38BDF8',
          glow: 'rgba(14, 165, 233, 0.3)',
        },
        // Text colors
        ink: {
          DEFAULT: '#1A1A1A',
          secondary: '#64748B',
          muted: '#94A3B8',
        },
        // Safety colors (clinical versions)
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
      },
      fontFamily: {
        sans: ['Space Grotesk', 'system-ui', 'sans-serif'],
        mono: ['Space Mono', 'monospace'],
      },
      borderRadius: {
        'sm': '8px',
        'md': '12px',
        'lg': '20px',
        'xl': '24px',
        '2xl': '32px',
        'pill': '9999px',
      },
      boxShadow: {
        'glass': '0 8px 32px rgba(0, 0, 0, 0.03)',
        'glow': '0 10px 30px -5px rgba(14, 165, 233, 0.3)',
        'glow-lg': '0 15px 40px -5px rgba(14, 165, 233, 0.4)',
      },
    },
  },
  plugins: [],
};
