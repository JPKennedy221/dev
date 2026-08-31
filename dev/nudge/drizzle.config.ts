import { defineConfig } from 'drizzle-kit'
export default defineConfig({
  dialect: 'postgresql',
  schema: './server/db/schema.ts',
  out: './server/db/migrations',
  schemaFilter: ['app'],
  dbCredentials: { url: process.env.DATABASE_URL || 'postgresql://nudge:nudge@localhost:5432/nudge' },
})
