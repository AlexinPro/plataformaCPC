<script setup>
import { ref } from 'vue'
import { useForm } from '@inertiajs/vue3'
import Swal from 'sweetalert2'
import DraggableModal from '@/Components/DraggableModal.vue'

const props = defineProps({
  consejo: {
    type: Object,
    required: true
  },
  integrante: {
    type: Object,
    required: true
  }
})

const emit = defineEmits(['close', 'saved'])

const errorArchivo = ref('')

// Datos del justificante.
const form = useForm({
  fecha: '',
  tipo_sesion: '',
  justificante: null
})

// Valida que el archivo sea PDF.
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

// Envía el justificante.
function guardar() {
  errorArchivo.value = ''

  form.post(
    route('justificantes.store', props.consejo.id),
    {
      forceFormData: true,
      preserveScroll: true,

      onSuccess: () => {
        Swal.fire({
          icon: 'success',
          title: 'Justificante enviado',
          text: 'El justificante se envió correctamente.',
          confirmButtonText: 'Aceptar',
          confirmButtonColor: '#374151'
        }).then(() => {
          form.reset()
          emit('saved')
          emit('close')
        })
      }
    }
  )
}

// Cierra el modal.
function cerrarModal() {
  if (!form.processing) {
    emit('close')
  }
}
</script>

<template>
  <DraggableModal title="Subir justificante" max-width="max-w-xl"
    @close="cerrarModal">
    <!-- Descripción -->
    <p class="mb-5 text-sm text-gray-500">
      Adjunta un justificante correspondiente a una sesión.
    </p>

    <!-- Integrante -->
    <div class="mb-5">
      <label class="mb-1 block text-sm font-medium text-gray-700">
        Integrante
      </label>

      <input type="text"
        :value="`${integrante.nombre} ${integrante.apellido}`" readonly
        class="w-full rounded border bg-gray-100 px-3 py-2 text-gray-600"/>
    </div>

    <!-- Fecha -->
    <div class="mb-5">
      <label class="mb-1 block text-sm font-medium text-gray-700">
        Fecha de la sesión
      </label>

      <input v-model="form.fecha" type="date"
        class="w-full rounded border px-3 py-2"/>

      <p v-if="form.errors.fecha" class="mt-1 text-sm text-red-600">
        {{ form.errors.fecha }}
      </p>
    </div>

    <!-- Tipo de sesión -->
    <div class="mb-5">
      <label class="mb-1 block text-sm font-medium text-gray-700">
        Tipo de sesión
      </label>

      <select v-model="form.tipo_sesion" class="w-full rounded border px-3 py-2">
        <option value="" disabled>
          Seleccione el tipo de sesión
        </option>

        <option value="ordinaria">
          Ordinaria
        </option>

        <option value="solemne">
          Solemne
        </option>

        <option value="extraordinaria">
          Extraordinaria
        </option>
      </select>

      <p v-if="form.errors.tipo_sesion" class="mt-1 text-sm text-red-600">
        {{ form.errors.tipo_sesion }}
      </p>
    </div>

    <!-- Archivo -->
    <div class="mb-6">
      <label class="mb-1 block text-sm font-medium text-gray-700">
        Justificante (PDF)
      </label>

      <input type="file" accept="application/pdf" class="w-full rounded border px-3 py-2"
        @change="seleccionarArchivo"/>

      <!-- Error de validación frontend -->
      <p v-if="errorArchivo" class="mt-1 text-sm text-red-600">
        {{ errorArchivo }}
      </p>

      <!-- Error de validación backend -->
      <p v-if="form.errors.justificante" class="mt-1 text-sm text-red-600">
        {{ form.errors.justificante }}
      </p>

      <p c   lass="mt-1 text-xs text-gray-500">
        Solo se permiten archivos PDF de hasta 4 MB.
      </p>
    </div>

    <!-- Botones -->
    <div class="flex justify-end gap-3 border-t pt-4">
      <button type="button"
        class="rounded bg-gray-300 px-4 py-2 text-gray-800 transition hover:bg-gray-400 disabled:opacity-50"
        :disabled="form.processing" @click="cerrarModal">
        Cancelar
      </button>

      <button type="button"
        class="rounded bg-yellow-700 px-5 py-2 text-white transition hover:bg-yellow-800 disabled:opacity-50"
        :disabled="form.processing"@click="guardar">
        {{ form.processing ? 'Enviando...' : 'Enviar justificante' }}
      </button>  
    </div>
  </DraggableModal>
</template>