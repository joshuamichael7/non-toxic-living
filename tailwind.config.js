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
        },
        caution: {
          DEFAULT: '#F59E0B',
          light: '#FEF3C7',
        },
        toxic: {
          DEFAULT: '#F43F5E',
          light: '#FFE4E6',
        },
        // Primary accent
        primary: {
          DEFAULT: '#059669',
          dark: '#047857',
        },
      },
      fontFamily: {
        sans: ['Manrope', 'system-ui', 'sans-serif'],
      },
      borderRadius: {
        'sm': '8px',
        'md': '12px',
        'lg': '16px',
        'xl': '24px',
      },
    },
  },
  plugins: [],
};
