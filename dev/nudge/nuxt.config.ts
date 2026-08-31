export default defineNuxtConfig({
  devtools: { enabled: true },
  css: ['~/assets/main.css'],
  runtimeConfig: { DATABASE_URL: process.env.DATABASE_URL || '' },
  typescript: { strict: true, typeCheck: true },
  compatibilityDate: '2024-04-03'
})
