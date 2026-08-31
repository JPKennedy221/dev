import { db } from '../../db/client'
import { getResource } from '../../utils/resource'
import { desc } from 'drizzle-orm'

export default defineEventHandler(async event => {
  const table = getResource(getRouterParam(event, 'resource')!)
  if (event.method === 'GET') return db().select().from(table).orderBy(desc(table.id))
  if (event.method === 'POST') {
    const body = await readBody(event)
    if (!body || typeof body !== 'object') throw createError({ statusCode: 400, statusMessage: 'JSON body required' })
    const [row] = await db().insert(table).values(body).returning()
    setResponseStatus(event, 201)
    return row
  }
  throw createError({ statusCode: 405, statusMessage: 'Method not allowed' })
})
