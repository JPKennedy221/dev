import { tables, type Resource } from '../db/schema'
import { resourceAliases } from '../../utils/resource-schema'

export function getResource(name: string) {
  const key = resourceAliases[name as keyof typeof resourceAliases] ?? (name in tables ? name as Resource : undefined)
  if (!key) throw createError({ statusCode: 404, statusMessage: 'Unknown resource' })
  return tables[key as Resource] as any
}
