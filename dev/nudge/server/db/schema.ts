import {
  bigint, boolean, check, date, integer, index, numeric, pgSchema, text,
  timestamp, uniqueIndex, sql,
} from 'drizzle-orm/pg-core'

const app = pgSchema('app')
const id = () => bigint('id', { mode: 'number' }).generatedByDefaultAsIdentity().primaryKey()
const timestamps = {
  createdAt: timestamp('created_at', { withTimezone: true }).defaultNow().notNull(),
  updatedAt: timestamp('updated_at', { withTimezone: true }).defaultNow().notNull(),
}

export const role = app.table('role', {
  id: id(), name: text('name').notNull(), description: text('description'), ...timestamps,
}, t => [uniqueIndex('role_name_unique').on(t.name)])

export const school = app.table('school', {
  id: id(), name: text('name').notNull(), abbreviation: text('abbreviation').notNull(),
  address: text('address').notNull(), streetAddress: text('street_address').notNull(),
  city: text('city'), state: text('state'), postalCode: text('postal_code'),
  country: text('country').default('USA'), isActive: boolean('is_active').default(true).notNull(), ...timestamps,
})

export const account = app.table('account', {
  id: id(), schoolId: bigint('school_id', { mode: 'number' }).references(() => school.id).notNull(),
  firstName: text('first_name').notNull(), lastName: text('last_name').notNull(), middleName: text('middle_name'),
  email: text('email').notNull(), phoneNumber: text('phone_number').notNull(),
  roleId: bigint('role_id', { mode: 'number' }).references(() => role.id).notNull(),
  isActive: boolean('is_active').default(true).notNull(), ...timestamps,
}, t => [uniqueIndex('account_email_unique').on(t.email), index('account_role_idx').on(t.roleId)])

export const course = app.table('course', {
  id: id(), name: text('name').notNull(), abbreviation: text('abbreviation').notNull(),
  startDate: date('start_date').notNull(), endDate: date('end_date').notNull(),
  isActive: boolean('is_active').default(true).notNull(), ...timestamps,
}, t => [check('course_dates_check', sql`${t.startDate} < ${t.endDate}`)])

export const roster = app.table('roster', {
  id: id(), schoolId: bigint('school_id', { mode: 'number' }).references(() => school.id).notNull(),
  accountId: bigint('account_id', { mode: 'number' }).references(() => account.id).notNull(),
  courseId: bigint('course_id', { mode: 'number' }).references(() => course.id).notNull(), ...timestamps,
}, t => [
  uniqueIndex('roster_unique').on(t.schoolId, t.accountId, t.courseId),
  index('roster_school_idx').on(t.schoolId), index('roster_account_idx').on(t.accountId), index('roster_course_idx').on(t.courseId),
])

export const standard = app.table('standard', {
  id: id(), name: text('name').notNull(), shortName: text('short_name').notNull(),
  referenceIds: text('reference_ids'), ...timestamps,
})

export const assessmentUnit = app.table('assessment_unit', {
  id: id(), courseId: bigint('course_id', { mode: 'number' }).references(() => course.id).notNull(),
  name: text('name').notNull(), abbreviation: text('abbreviation').notNull(), ...timestamps,
}, t => [index('assessment_unit_course_idx').on(t.courseId)])

export const assessmentUnitStandard = app.table('assessment_unit_standard', {
  id: id(), assessmentUnitId: bigint('assessment_unit_id', { mode: 'number' }).references(() => assessmentUnit.id).notNull(),
  standardId: bigint('standard_id', { mode: 'number' }).references(() => standard.id).notNull(), ...timestamps,
}, t => [uniqueIndex('assessment_unit_standard_unique').on(t.assessmentUnitId, t.standardId), index('aus_unit_idx').on(t.assessmentUnitId), index('aus_standard_idx').on(t.standardId)])

export const assessment = app.table('assessment', {
  id: id(), assessmentUnitId: bigint('assessment_unit_id', { mode: 'number' }).references(() => assessmentUnit.id).notNull(),
  name: text('name').notNull(), scoringScale: text('scoring_scale').notNull(), maxScore: numeric('max_score').notNull(),
  minScore: numeric('min_score').notNull(), defaultScore: numeric('default_score').notNull(),
  placeholderScore: numeric('placeholder_score').notNull(), ...timestamps,
}, t => [
  index('assessment_unit_idx').on(t.assessmentUnitId),
  check('assessment_scoring_scale_check', sql`${t.scoringScale} in ('free-numeric', 'two-value', 'three-value', 'four-value', 'five-value')`),
])

export const assessmentStandard = app.table('assessment_standard', {
  id: id(), assessmentId: bigint('assessment_id', { mode: 'number' }).references(() => assessment.id).notNull(),
  standardId: bigint('standard_id', { mode: 'number' }).references(() => standard.id).notNull(), ...timestamps,
}, t => [uniqueIndex('assessment_standard_unique').on(t.assessmentId, t.standardId), index('as_assessment_idx').on(t.assessmentId), index('as_standard_idx').on(t.standardId)])

export const assignment = app.table('assignment', {
  id: id(), rosterId: bigint('roster_id', { mode: 'number' }).references(() => roster.id).notNull(),
  assessmentId: bigint('assessment_id', { mode: 'number' }).references(() => assessment.id).notNull(),
  score: numeric('score'), attemptNumber: integer('attempt_number').default(1).notNull(),
  completedAt: timestamp('completed_at', { withTimezone: true }), version: integer('version').default(1).notNull(), ...timestamps,
}, t => [
  uniqueIndex('assignment_unique').on(t.rosterId, t.assessmentId, t.attemptNumber),
  index('assignment_roster_idx').on(t.rosterId), index('assignment_assessment_idx').on(t.assessmentId),
  index('assignment_roster_assessment_idx').on(t.rosterId, t.assessmentId),
])

export const tables = {
  role, school, account, course, roster, standard, assessmentUnit, assessmentUnitStandard,
  assessment, assessmentStandard, assignment,
}
export type Resource = keyof typeof tables
