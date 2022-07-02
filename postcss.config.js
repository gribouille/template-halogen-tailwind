module.exports = {
  plugins: process.env.NODE_ENV === 'production' ? [
    require('postcss-import'),
    require('tailwindcss'),
    require('autoprefixer'),
    require('cssnano'),
  ] : [
    require('postcss-import'),
    require('tailwindcss'),
    require('autoprefixer'),
  ]
}