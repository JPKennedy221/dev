<script setup lang="ts">
import { getResourceDisplayName, getResourceFields } from '~/utils/resource-schema'

const props = defineProps<{ resource: string; title: string }>()
const rows = ref<Record<string, unknown>[]>([])
const error = ref('')

async function load() {
  try {
    rows.value = await $fetch(`/api/${props.resource}`) as Record<string, unknown>[]
  } catch (err: any) {
    error.value = err?.data?.message || 'Unable to load records.'
  }
}

async function remove(id: unknown) {
  if (!confirm('Delete this record?')) return
  await $fetch(`/api/${props.resource}/${id}`, { method: 'DELETE' })
  await load()
}

await load()

const columns = computed(() => {
  const firstRow = rows.value[0]
  if (firstRow) {
    return Object.keys(firstRow).filter(key => !['id', 'createdAt', 'updatedAt'].includes(key))
  }
  return getResourceFields(props.resource)
})
</script>

<template>
  <section>
    <div class="toolbar">
      <div>
        <p class="eyebrow">Manage records</p>
        <h2 class="page-title">{{ title }}</h2>
      </div>
      <NuxtLink class="btn" :to="`/${resource}/new`">New {{ getResourceDisplayName(resource) }}</NuxtLink>
    </div>
    <div class="panel">
      <p v-if="error" class="error">{{ error }}</p>
      <table v-else>
        <thead>
          <tr>
            <th v-for="column in columns" :key="column">{{ column.replace(/([A-Z])/g, ' $1') }}</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="row in rows" :key="String(row.id)">
            <td v-for="column in columns" :key="column">{{ row[column] ?? '—' }}</td>
            <td class="actions">
              <NuxtLink :to="`/${resource}/${row.id}/edit`">Edit</NuxtLink>
              <button class="danger-link" @click="remove(row.id)">Delete</button>
            </td>
          </tr>
          <tr v-if="!rows.length">
            <td :colspan="columns.length + 1">No records yet.</td>
          </tr>
        </tbody>
      </table>
    </div>
  </section>
</template>
