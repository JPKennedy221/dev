import { tables, type Resource } from '../db/schema'

const aliases: Record<string, Resource> = {
  roles: 'role', schools: 'school', accounts: 'account', courses: 'course', rosters: 'roster',
  standards: 'standard', 'assessment-units': 'assessmentUnit',
  'assessment-unit-standards': 'assessmentUnitStandard', assessments: 'assessment',
  'assessment-standards': 'assessmentStandard', assignments: 'assignment',
}

export function getResource(name: string) {
  const key = aliases[name] ?? (name in tables ? name as Resource : undefined)
  if (!key) throw createError({ statusCode: 404, statusMessage: 'Unknown resource' })
  return tables[key] as any
}
