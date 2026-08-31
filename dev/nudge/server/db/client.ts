import postgres from 'postgres'
import { drizzle } from 'drizzle-orm/postgres-js'
import * as schema from './schema'
let client: ReturnType<typeof postgres> | undefined
export function db() { client ||= postgres(useRuntimeConfig().DATABASE_URL); return drizzle(client, { schema }) }
