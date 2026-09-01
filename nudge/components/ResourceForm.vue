<script setup lang="ts">
import { getInputType, getResourceFields, normalizeResourceFormData } from '~/utils/resource-schema'

const props = defineProps<{ resource: string; title: string; id?: string }>()
const fields = computed<string[]>(() => getResourceFields(props.resource))
const form = reactive<Record<string, unknown>>({})
const error = ref('')
const resourcePath = computed(() => `/api/${String(props.resource)}` as string)

const loadForm = async () => {
  form.id = undefined
  for (const field of fields.value) form[field] = undefined

  if (props.id) {
    const row = await $fetch<Record<string, unknown>>(`${resourcePath.value}/${String(props.id)}` as string)
    for (const field of fields.value) {
      if (field in row) {
        form[field] = getInputType(field) === 'checkbox' ? Boolean(row[field]) : row[field]
      }
    }
  } else {
    for (const field of fields.value) {
      if (getInputType(field) === 'checkbox') form[field] = false
    }
  }
}

watchEffect(loadForm)

async function submit() {
  try {
    const payload = normalizeResourceFormData(props.resource, form)
    const url = props.id ? `${resourcePath.value}/${String(props.id)}` as string : resourcePath.value
    await $fetch(url, {
      method: props.id ? 'PUT' : 'POST',
      body: payload,
    })
    await navigateTo(`/${props.resource}`)
  } catch (err: any) {
    error.value = err?.data?.message || 'Unable to save record.'
  }
}
</script>

<template>
  <section>
    <div class="toolbar">
      <div>
        <p class="eyebrow">{{ id ? 'Edit record' : 'Create record' }}</p>
        <h2 class="page-title">{{ id ? 'Edit' : 'New' }} {{ title }}</h2>
      </div>
    </div>
    <form class="panel form-grid" @submit.prevent="submit">
      <label v-for="field in fields" :key="field">
        {{ field.replace(/([A-Z])/g, ' $1') }}
        <input
          v-if="getInputType(field) !== 'checkbox'"
          v-model="form[field]"
          :name="field"
          :type="getInputType(field)"
        />
        <input
          v-else
          :checked="Boolean(form[field])"
          :name="field"
          type="checkbox"
          @change="form[field] = !Boolean(form[field])"
        />
      </label>
      <p v-if="error" class="error">{{ error }}</p>
      <div class="form-actions">
        <NuxtLink class="btn secondary" :to="`/${resource}`">Cancel</NuxtLink>
        <button class="btn" type="submit">Save</button>
      </div>
    </form>
  </section>
</template>
