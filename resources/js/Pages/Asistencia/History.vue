<script setup>
import { defineProps, defineEmits } from 'vue'
import * as XLSX from 'xlsx'

const props = defineProps({
  integrante: Object,
  historial: Array,
  show: Boolean
})

const emit = defineEmits(['close'])

function textoEstado(estado) {
  switch (estado) {
    case 'asistio': return 'Asistió'
    case 'falto': return 'Faltó'
    case 'justificada': return 'Falta justificada'
    default: return '-'
  }
}

function claseEstado(estado) {
  switch (estado) {
    case 'asistio': return 'text-green-600 font-semibold'
    case 'falto': return 'text-red-600 font-semibold'
    case 'justificada': return 'text-yellow-600 font-semibold'
    default: return 'text-gray-500'
  }
}

// export a excel
function exportarExcel() {

  const data = props.historial.map(h => ({
    'Tipo de sesión': h.tipo_sesion,
    'Fecha': h.fecha,
    'Estado': textoEstado(h.estado)
  }))

  const worksheet = XLSX.utils.json_to_sheet(data)
  const workbook = XLSX.utils.book_new()

  XLSX.utils.book_append_sheet(workbook, worksheet, "Historial")

  XLSX.writeFile(
    workbook,
    `Historial_${props.integrante.nombre}_${props.integrante.apellido}.xlsx`
  )
}
</script>


<template>
  <div v-if="show" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center p-4 z-50">
    <div class="bg-white rounded-lg shadow-xl w-full max-w-2xl p-6">

      <!-- Header -->
      <div class="flex justify-between items-center mb-4">
        <h2 class="text-xl font-bold">
          Historial de {{ integrante.nombre }} {{ integrante.apellido }}
        </h2>

        <button @click="emit('close')" class="text-gray-500 hover:text-gray-700 text-xl">
          &times;
        </button>
      </div>

      <!-- Botón Exportar -->
      <div class="mb-3 text-right">
        <button @click="exportarExcel" class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700 text-sm">
          Exportar Excel
        </button>
      </div>

      <!-- Tabla de historial -->
      <table class="w-full border border-gray-300 rounded text-sm">
        <thead class="bg-gray-100">
          <tr>
            <th class="px-3 py-2 border">Tipo de sesión</th>
            <th class="px-3 py-2 border">Fecha</th>
            <th class="px-3 py-2 border">Estado</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="h in historial" :key="h.id" class="hover:bg-gray-50">
            <td class="px-3 py-2 border capitalize">
              {{ h.tipo_sesion }}
            </td>

            <td class="px-3 py-2 border">
              {{ h.fecha }}
            </td>

            <td class="px-3 py-2 border">
              <span :class="claseEstado(h.estado)">
                {{ textoEstado(h.estado) }}
              </span>
            </td>
          </tr>
        </tbody>
      </table>

      <!-- Botón cerrar -->
      <div class="text-right mt-4">
        <button @click="emit('close')" class="px-4 py-2 bg-gray-600 text-white rounded hover:bg-gray-800">
          Cerrar
        </button>
      </div>

    </div>
  </div>
</template>