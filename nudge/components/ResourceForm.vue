<script setup lang="ts">
const props = defineProps<{ resource: string; title: string; id?: string }>()
const fields = ['name', 'abbreviation', 'description', 'address', 'streetAddress', 'city', 'state', 'postalCode', 'country', 'isActive', 'firstName', 'lastName', 'middleName', 'email', 'phoneNumber', 'schoolId', 'roleId', 'courseId', 'accountId', 'standardId', 'assessmentUnitId', 'assessmentId', 'rosterId', 'referenceIds', 'startDate', 'endDate', 'scoringScale', 'maxScore', 'minScore', 'defaultScore', 'placeholderScore', 'score', 'attemptNumber', 'completedAt', 'version']
const form = reactive<Record<string, unknown>>({})
const error = ref('')
if (props.id) Object.assign(form, await $fetch(`/api/${props.resource}/${props.id}`))
async function submit() {
  try { await $fetch(props.id ? `/api/${props.resource}/${props.id}` : `/api/${props.resource}`, { method: props.id ? 'PUT' : 'POST', body: form }); await navigateTo(`/${props.resource}`) }
  catch (err: any) { error.value = err?.data?.message || 'Unable to save record.' }
}
</script>
<template><section><div class="toolbar"><div><p class="eyebrow">{{ id ? 'Edit record' : 'Create record' }}</p><h2 class="page-title">{{ id ? 'Edit' : 'New' }} {{ title }}</h2></div></div><form class="panel form-grid" @submit.prevent="submit"><label v-for="field in fields" :key="field">{{ field.replace(/([A-Z])/g, ' $1') }}<input v-model="form[field]" :name="field" :type="field.includes('Date') ? 'date' : 'text'" /></label><p v-if="error" class="error">{{ error }}</p><div class="form-actions"><NuxtLink class="btn secondary" :to="`/${resource}`">Cancel</NuxtLink><button class="btn" type="submit">Save</button></div></form></section></template>
