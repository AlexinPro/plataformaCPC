<script setup>
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'
import Swal from 'sweetalert2'

const props = defineProps({
  consejo: { type: Object, required: true },
  integrante: { type: Object, required: true }
})

const emit = defineEmits(['close', 'saved'])
const errorArchivo = ref('')

// Datos del justificante
const form = useForm({
  fecha: '',
  tipo_sesion: '',
  justificante: null
})

// Validar archivo PDF
function seleccionarArchivo(event) {
  const file = event.target.files[0]

  if (!file) {
    form.justificante = null
    errorArchivo.value = ''
    return
  }

  if (file.type !== 'application/pdf') {
    errorArchivo.value = 'Solo se permiten archivos PDF.'
    form.justificante = null
    event.target.value = ''
    return
  }

  errorArchivo.value = ''
  form.justificante = file
}

// Enviar justificante
function guardar() {
  errorArchivo.value = ''

  form.post(route('justificantes.store', props.consejo.id), {
    forceFormData: true,
    preserveScroll: true,
    onSuccess: () => {
      form.reset()
      emit('saved')
      emit('close')
    }
  })
}
</script>

<template>
  <!-- fondo del modal -->
  <div class="fixed inset-0 z-50 flex items-center justify-center bg-black/50 p-4">

    <!-- contenedor -->
    <div class="w-full max-w-xl rounded-lg bg-white shadow-xl">

      <!-- Encabezado -->
      <div class="flex items-start justify-between border-b p-5">
        <div>
          <h2 class="text-xl font-bold text-gray-800">Subir justificante</h2>

          <p class="mt-1 text-sm text-gray-500">
            Adjunta un justificante correspondiente a una sesión.
          </p>
        </div>

        <!--cerrar -->
        <button type="button" @click="emit('close')" class="text-2xl leading-none text-gray-400 hover:text-gray-700">
          ×
        </button>
      </div>

      <!-- Formulario -->
      <div class="p-5">

        <!-- Integrante -->
        <div class="mb-5">
          <label class="mb-1 block text-sm font-medium text-gray-700">
            Integrante
          </label>

          <input type="text" :value="integrante ? `${integrante.nombre} ${integrante.apellido}` : ''"
           readonly class="w-full rounded border bg-gray-100 px-3 py-2 text-gray-600">
        </div>

        <!-- Fecha -->
        <div class="mb-5">
          <label class="mb-1 block text-sm font-medium text-gray-700">
            Fecha de la sesión
          </label>

          <input v-model="form.fecha" type="date"class="w-full rounded border px-3 py-2">

          <!-- Error de sesión -->
          <p v-if="form.errors.fecha" class="mt-1 text-sm text-red-600">
            {{ form.errors.fecha }}
          </p>
        </div>

        <!-- Tipo de sesión -->
        <div class="mb-5">
          <label class="mb-1 block text-sm font-medium text-gray-700">
            Tipo de sesión
          </label>

          <select v-model="form.tipo_sesion"
            class="w-full rounded border px-3 py-2">
            <option value="" disabled>
              Seleccione el tipo de sesión
            </option>
            <option value="ordinaria">Ordinaria</option>
            <option value="solemne">Solemne</option>
            <option value="extraordinaria">Extraordinaria</option>
          </select>

          <!-- error backend -->
          <p v-if="form.errors.tipo_sesion" class="mt-1 text-sm text-red-600">
            {{ form.errors.tipo_sesion }}
          </p>
        </div>

        <!-- Archivo -->
        <div class="mb-6">
          <label class="mb-1 block text-sm font-medium text-gray-700">
            Justificante (PDF)
          </label>

          <input type="file" accept="application/pdf" @change="seleccionarArchivo"
            class="w-full rounded border px-3 py-2">

          <!-- error frontend -->
          <p v-if="errorArchivo" class="mt-1 text-sm text-red-600">
            {{ errorArchivo }}
          </p>

          <!-- error backend -->
          <p v-if="form.errors.justificante" class="mt-1 text-sm text-red-600">
            {{ form.errors.justificante }}
          </p>

          <p class="mt-1 text-xs text-gray-500">
            Solo se permiten archivos PDF de hasta 4 MB.
          </p>
        </div>

        <!-- Botones -->
        <div class="flex justify-end gap-3 border-t pt-4">
          <button type="button" @click="emit('close')"
            class="rounded bg-gray-300 px-4 py-2 text-gray-800 transition hover:bg-gray-400">
            Cancelar
          </button>
          <button type="button" @click="guardar" :disabled="form.processing"
            class="rounded bg-yellow-700 px-5 py-2 text-white transition hover:bg-yellow-800 disabled:opacity-50">
            {{ form.processing ? 'Enviando...' : 'Enviar justificante' }}
          </button>
        </div>

      </div>
    </div>
  </div>
</template>