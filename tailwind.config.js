module.exports = {
  // important: true,
  content: [
    "./src/**/*.{html,js,ts,jsx,tsx,purs}"
  ],
  plugins: [
    require("tailwindcss-debug-screens"),
    require('@tailwindcss/typography'),
    require('@tailwindcss/forms'),
  ],
  // example
  theme: {
    fontSize: {
      xxs: "9px",
      xs: "12px",
      sm: "14px",
      base: "16px",
      lg: "18px",
      xl: "24px",
    },
    container: {
      center: true,
      padding: "1.5rem",
    },
    spacing: {
      "1": "8px",
      "2": "12px",
      "3": "16px",
      "4": "24px",
      "5": "32px",
      "6": "48px",
    },
  },
}