<script setup>
import { ref, watch } from 'vue'
import { router } from '@inertiajs/vue3'

const props = defineProps({
  consejoId: {
    type: [Number, String],
    required: true,
  },
  integrantes: {
    type: Array,
    required: true,
  },
  fecha: {
    type: String,
    required: true,
  },
})

const emit = defineEmits(['close', 'saved'])

//Estado del formulario
const form = ref({
  fecha: props.fecha,
  tipo_sesion: '',
  asistencias: props.integrantes.map(i => ({
    integrante_id: i.id,
    estado: 'asistio', //valor por defecto
  })),
})

const evidencia = ref(null)
const errorArchivo = ref('')

//Sincronizar fecha si cambia desde el formulario padre
watch(() => props.fecha, (value) => {
  form.value.fecha = value
})

//Validación del archivo PDF
function onFileChange(e) {
  const file = e.target.files[0]

  if (!file) {
    evidencia.value = null
    return
  }

  if (file.type !== 'application/pdf') {
    errorArchivo.value = 'Solo se permiten archivos PDF'
    evidencia.value = null
    e.target.value = ''
    return
  }

  errorArchivo.value = ''
  evidencia.value = file
}

// enviar formulario, se cierra solito al final
function submitForm() {
  const formData = new FormData()

  formData.append('fecha', form.value.fecha)
  formData.append('tipo_sesion', form.value.tipo_sesion)

  form.value.asistencias.forEach((a, index) => {
    formData.append(`asistencias[${index}][integrante_id]`, a.integrante_id)
    formData.append(`asistencias[${index}][estado]`, a.estado)
  })

  if (evidencia.value) {
    formData.append('evidencia', evidencia.value)
  }

  router.post(
    route('asistencias.sesion.store', { consejo: props.consejoId }),
    formData,
    {
      forceFormData: true,
      preserveScroll: true,
      onSuccess: () => {
        emit('saved')
        emit('close')//cerrar modal
      },
    }
  )
}
</script>

<template>
  <div class="fixed inset-0 bg-black bg-opacity-40 flex items-center justify-center z-50">
    <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-xl">

      <h2 class="text-lg font-bold mb-4">
        Crear asistencia
      </h2>

      <!-- FECHA -->
      <div class="mb-3">
        <label class="block text-sm font-medium mb-1">Fecha</label>
        <input
          type="date"
          v-model="form.fecha"
          readonly
          class="w-full border rounded px-3 py-2 bg-gray-100"/>
      </div>

      <!-- TIPO DE SESIÓN -->
      <div class="mb-4">
        <label class="block text-sm font-medium mb-1">Tipo de sesión</label>
        <select
          v-model="form.tipo_sesion"
          class="w-full border rounded px-3 py-2">
          <option disabled value="">Seleccione tipo</option>
          <option value="ordinaria">Ordinaria</option>
          <option value="solemne">Solemne</option>
          <option value="extraordinaria">Extraordinaria</option>
        </select>
      </div>

      <!-- INTEGRANTES -->
      <div class="border rounded p-3 max-h-64 overflow-y-auto mb-4">
        <p class="text-sm font-medium mb-2">Integrantes</p>

        <div
          v-for="(i, index) in integrantes"
          :key="i.id"
          class="py-2 border-b last:border-b-0">
          <p class="text-sm font-semibold mb-1">
            {{ i.nombre }} {{ i.apellido }}
          </p>

          <div class="flex gap-4 text-sm">
            <label class="flex items-center gap-1">
              <input
                type="radio"
                :name="`estado-${i.id}`"
                value="asistio"
                v-model="form.asistencias[index].estado"/>
              Asistió
            </label>

            <label class="flex items-center gap-1">
              <input
                type="radio"
                :name="`estado-${i.id}`"
                value="falto"
                v-model="form.asistencias[index].estado"/>
              Faltó
            </label>

            <label class="flex items-center gap-1">
              <input
                type="radio"
                :name="`estado-${i.id}`"
                value="justificada"
                v-model="form.asistencias[index].estado"/>
              Justificada
            </label>
          </div>
        </div>
      </div>

      <!-- EVIDENCIA PDF -->
      <div class="mb-4">
        <label class="block text-sm font-medium mb-1">
          Evidencia (PDF)
        </label>
        <input
          type="file"
          accept="application/pdf"
          @change="onFileChange"
          class="w-full border rounded px-3 py-2"/>

        <p v-if="errorArchivo" class="text-red-500 text-sm mt-1">
          {{ errorArchivo }}
        </p>
      </div>

      <!-- BOTONES -->
      <div class="flex justify-end gap-2 pt-2">
        <button
          type="button"
          class="px-4 py-2 bg-gray-300 rounded"
          @click="$emit('close')">
          Cancelar
        </button>

        <button
          type="button"
          class="px-4 py-2 bg-gray-700 text-white rounded"
          :disabled="!form.tipo_sesion"
          @click="submitForm">
          Guardar asistencia
        </button>
      </div>

    </div>
  </div>
</template>