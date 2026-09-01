import { db } from '../../db/client'
import { getResource } from '../../utils/resource'
import { validateResourceFields } from '../../utils/validate-resource'
import { eq } from 'drizzle-orm'

export default defineEventHandler(async event => {
  const table = getResource(getRouterParam(event, 'resource')!)
  const id = Number(getRouterParam(event, 'id'))
  if (!Number.isInteger(id)) throw createError({ statusCode: 400, statusMessage: 'Invalid id' })
  if (event.method === 'GET') {
    const [row] = await db().select().from(table).where(eq(table.id, id))
    if (!row) throw createError({ statusCode: 404, statusMessage: 'Not found' })
    return row
  }
  if (event.method === 'PUT') {
    const body = await readBody(event)
    const validated = validateResourceFields(getRouterParam(event, 'resource') as any, body)
    const [row] = await db().update(table).set({ ...validated, updatedAt: new Date() }).where(eq(table.id, id)).returning()
    if (!row) throw createError({ statusCode: 404, statusMessage: 'Not found' })
    return row
  }
  if (event.method === 'DELETE') {
    const [row] = await db().delete(table).where(eq(table.id, id)).returning({ id: table.id })
    if (!row) throw createError({ statusCode: 404, statusMessage: 'Not found' })
    return { success: true, ...row }
  }
  throw createError({ statusCode: 405, statusMessage: 'Method not allowed' })
})
