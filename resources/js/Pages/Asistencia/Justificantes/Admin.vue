<script setup>
import { ref } from 'vue'
import { router } from '@inertiajs/vue3'
import Swal from 'sweetalert2'

const props = defineProps({
  show: Boolean,
  justificantes: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['close'])
const seleccionado = ref(null)

function abrir(justificante) {
  seleccionado.value = justificante
}

function cerrar() {
  seleccionado.value = null
  emit('close')
}

function aprobar() {
  Swal.fire({
    title: '¿Aprobar justificante?',
    text: 'La asistencia será marcada como justificada.',
    icon: 'question',
    showCancelButton: true,
    confirmButtonText: 'Aprobar',
    cancelButtonText: 'Cancelar'
  }).then(result => {
    if (!result.isConfirmed) return

    //aprobar
    router.patch(route('justificantes.aprobar', seleccionado.value.id), {}, {
      preserveScroll: true,
      onSuccess: () => {
        cerrar()

        Swal.fire({
          icon: 'success',
          title: 'Justificante aprobado',
          text: 'La asistencia fue marcada como justificada.'
        })
      }
    })
  })
}

function rechazar() {
  Swal.fire({
    title: '¿Rechazar justificante?',
    text: 'La asistencia permanecerá como falta.',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonText: 'Rechazar',
    cancelButtonText: 'Cancelar'
  }).then(result => {
    if (!result.isConfirmed) return

    //rechazar
    router.post(route('justificantes.rechazar', seleccionado.value.id), {}, {
      preserveScroll: true,
      onSuccess: () => {
        cerrar()

        Swal.fire({
          icon: 'success',
          title: 'Justificante rechazado',
          text: 'La asistencia permanece marcada como falta.'
        })
      }
    })
  })
}
</script>

<template>
  <div
    v-if="show" class="fixed inset-0 z-50 flex 
    items-center justify-center bg-black bg-opacity-40 p-4">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-4xl p-6">
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-xl font-bold">Justificantes</h2>
        <button @click="cerrar"
          class="text-2xl text-gray-500 hover:text-gray-800">
          ×
        </button>
      </div>

      <!-- Lista de justificantes -->
      <div v-if="!seleccionado" class="space-y-3">
        <div v-for="j in justificantes" :key="j.id"
          class="border rounded p-4 flex justify-between items-center">
          <div>
            <p class="font-semibold">
              {{ j.integrante?.nombre }}
              {{ j.integrante?.apellido }}
            </p>

            <p class="text-sm text-gray-500">
              {{ j.fecha }} · {{ j.tipo_sesion }}
            </p>

            <p class="text-sm font-medium capitalize">
              Estado: {{ j.estado_justificante }}
            </p>
          </div>

          <button @click="abrir(j)"class="px-4 py-2 bg-gray-700 text-white rounded hover:bg-gray-900">
            Revisar
          </button>
        </div>

        <p v-if="!justificantes.length" class="text-center text-gray-500 py-6">
          No hay justificantes subidos aun.
        </p>
      </div>

      <!-- Revisar justificante -->
      <div v-else>
        <button @click="seleccionado = null" class="mb-4 text-gray-600 hover:underline">
          ← Volver
        </button>

        <h3 class="font-bold text-lg mb-1">
          {{ seleccionado.integrante?.nombre }}
          {{ seleccionado.integrante?.apellido }}
        </h3>

        <p class="text-sm text-gray-500 mb-4">
          {{ seleccionado.fecha }} · {{ seleccionado.tipo_sesion }}
        </p>

        <iframe :src="`/storage/${seleccionado.justificante}`"
          class="w-full h-[450px] border rounded mb-4">
        </iframe>

        <div v-if="seleccionado.estado_justificante === 'pendiente'"
          class="flex justify-end gap-3">
          <button @click="rechazar"
            class="px-4 py-2 bg-red-700 text-white rounded hover:bg-red-900">
            Rechazar
          </button>

          <button @click="aprobar"class="px-4 py-2 bg-green-700 text-white 
          rounded hover:bg-green-900">
            Aprobar   
          </button>
        </div>
      </div>
    </div>
  </div>
</template>