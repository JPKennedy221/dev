export const resourceAliases = {
  roles: 'role',
  schools: 'school',
  accounts: 'account',
  courses: 'course',
  rosters: 'roster',
  standards: 'standard',
  'assessment-units': 'assessmentUnit',
  'assessment-unit-standards': 'assessmentUnitStandard',
  assessments: 'assessment',
  'assessment-standards': 'assessmentStandard',
  assignments: 'assignment',
} as const

export const resourceFields = {
  roles: ['name', 'description'],
  schools: ['name', 'abbreviation', 'address', 'streetAddress', 'city', 'state', 'postalCode', 'country', 'isActive'],
  accounts: ['schoolId', 'firstName', 'lastName', 'middleName', 'email', 'phoneNumber', 'roleId', 'isActive'],
  courses: ['name', 'abbreviation', 'startDate', 'endDate', 'isActive'],
  rosters: ['schoolId', 'accountId', 'courseId'],
  standards: ['name', 'shortName', 'referenceIds'],
  'assessment-units': ['courseId', 'name', 'abbreviation'],
  'assessment-unit-standards': ['assessmentUnitId', 'standardId'],
  assessments: ['assessmentUnitId', 'name', 'scoringScale', 'maxScore', 'minScore', 'defaultScore', 'placeholderScore'],
  'assessment-standards': ['assessmentId', 'standardId'],
  assignments: ['rosterId', 'assessmentId', 'score', 'attemptNumber', 'completedAt', 'version'],
} as const

export const resourceDisplayNames = {
  roles: { singular: 'Role', plural: 'Roles' },
  schools: { singular: 'School', plural: 'Schools' },
  accounts: { singular: 'Account', plural: 'Accounts' },
  courses: { singular: 'Course', plural: 'Courses' },
  rosters: { singular: 'Roster', plural: 'Rosters' },
  standards: { singular: 'Standard', plural: 'Standards' },
  'assessment-units': { singular: 'Assessment Unit', plural: 'Assessment Units' },
  'assessment-unit-standards': { singular: 'Assessment Unit Standard', plural: 'Assessment Unit Standards' },
  assessments: { singular: 'Assessment', plural: 'Assessments' },
  'assessment-standards': { singular: 'Assessment Standard', plural: 'Assessment Standards' },
  assignments: { singular: 'Assignment', plural: 'Assignments' },
} as const

export function getResourceFields(resource: string) {
  const key = resource as keyof typeof resourceFields
  if (!(key in resourceFields)) {
    console.warn(`[Resource Schema] Unknown resource: "${resource}". Check resourceFields configuration.`)
  }
  return resourceFields[key] ?? []
}

export function getResourceDisplayName(resource: string, plural = false) {
  const key = resource as keyof typeof resourceDisplayNames
  const labels = resourceDisplayNames[key]
  if (!labels) return resource
  return plural ? labels.plural : labels.singular
}

export function getInputType(field: string) {
  if (field === 'isActive') return 'checkbox'
  if (field.includes('Date') || field.endsWith('At')) return 'date'
  if (['maxScore', 'minScore', 'defaultScore', 'placeholderScore', 'score', 'attemptNumber', 'version', 'schoolId', 'roleId', 'courseId', 'accountId', 'standardId', 'assessmentUnitId', 'assessmentId', 'rosterId'].includes(field)) return 'number'
  return 'text'
}

export function normalizeResourceFormData(resource: string, form: Record<string, unknown>) {
  const allowedFields = new Set(getResourceFields(resource))
  const sanitized: Record<string, unknown> = {}

  for (const [key, value] of Object.entries(form)) {
    if (!allowedFields.has(key)) continue
    if (value === '' || value === null || value === undefined) {
      if (key === 'isActive') sanitized[key] = false
      continue
    }
    sanitized[key] = value
  }

  return sanitized
}
