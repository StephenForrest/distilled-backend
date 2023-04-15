const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
      colors: {
        'brand': '#FE3CE3',
        'brand-light': '#FFC0F0',
        'brand-dark': '#C600B0',
        'secondary': '#652CB3',
        'badge-product': '#D2EA54',
        'badge-product-light': '#E8F5A2',
        'badge-product-dark': '#B4D23B',
        'badge-engineering': '#652CB3',
        'badge-engineering-light': '#A17EDC',
        'badge-engineering-dark': '#4A1E8C',
        'badge-marketing': '#F9A825',
        'badge-marketing-light': '#FCD38D',
        'badge-marketing-dark': '#D68B00',
        'badge-sales': '#F25C54',
        'badge-sales-light': '#F9A2A0',
        'badge-sales-dark': '#D23C34',
        'badge-support': '#00B0F0',
        'badge-support-light': '#7ED4F5',
        'badge-support-dark': '#0095C6',
        'alert': '#F25C54',
        'alert-light': '#F9A2A0',
        'alert-dark': '#D23C34',
        'success': '#D2EA54',
        'success-light': '#E8F5A2',
        'success-dark': '#B4D23B',
        'warning': '#F9A825',
        'warning-light': '#FCD38D',
        'warning-dark': '#D68B00',
        'info': '#00B0F0',
        'info-light': '#7ED4F5',
        'info-dark': '#0095C6'
  },
  extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/aspect-ratio'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
