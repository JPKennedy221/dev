import { type Resource, resourceFieldMap } from '../db/schema'

export function validateResourceFields(resource: Resource, data: unknown): Record<string, unknown> {
  if (!data || typeof data !== 'object') {
    throw createError({ statusCode: 400, statusMessage: 'Request body must be a valid JSON object' })
  }

  const allowedFields = new Set(resourceFieldMap[resource])
  const sanitized: Record<string, unknown> = {}
  const obj = data as Record<string, unknown>

  for (const field of allowedFields) {
    if (field in obj) {
      sanitized[field] = obj[field]
    }
  }

  return sanitized
}
