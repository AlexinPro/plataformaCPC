<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { Link, useForm, usePage } from '@inertiajs/vue3'
import {
  EyeIcon,
  CloudArrowUpIcon,
  ArrowDownTrayIcon,
  PaperClipIcon,
  BellIcon,
  CheckCircleIcon,
} from '@heroicons/vue/24/solid'
import { ref, watch } from 'vue'
import Swal from 'sweetalert2'

const props = defineProps({
  integrante: Object,
})

// Sweet alert para mostrar mensajes flash
const page = usePage()

watch(
  () => page.props.flash,
  (flash) => {
    if (flash) {
      Swal.fire({
        toast: true,
        position: 'top-end',
        icon: 'success',
        title: flash,
        showConfirmButton: false,
        timer: 3000,
        timerProgressBar: true,
      })
    }
  },
  { immediate: true }
)

// Form documuentos
const form = useForm({
  ine: null,
  comprobante_domiciliario: null,
  bajo_protesta_art_170: null,
  integracion_formula: null,
  curriculum_vitae: null,
  carta_motivos: null,
  cumplimiento_normatividad: null,
})

const selectedFiles = ref({})

const submitForm = () => {
  form.post(route('docu.store', props.integrante.id), {
    forceFormData: true,
    onSuccess: () => {
      form.reset()
      selectedFiles.value = {}
    },
  })
}

// Helpers para manejar documentos existentes y nombres de archivos
const getDoc = (tipo) =>
  props.integrante.documentos.find((d) => d.tipo === tipo)

const getCleanFileName = (doc) => {
  if (!doc || !doc.tipo) return ''
  const item = documentos.find(d => d.key === doc.tipo)
  if (!item) return 'Documento.pdf'
  return `${item.label}.pdf`
}

const getPublicUrl = (ruta) =>
  `/storage/${ruta.replace('public/', '')}`

const documentos = [
  { key: 'ine', label: 'INE' },
  { key: 'comprobante_domiciliario', label: 'Comprobante domiciliario' },
  { key: 'bajo_protesta_art_170', label: 'Bajo protesta art. 170' },
  { key: 'integracion_formula', label: 'Integración de fórmula' },
  { key: 'curriculum_vitae', label: 'Currículum Vitae' },
  { key: 'carta_motivos', label: 'Carta de motivos' },
  { key: 'cumplimiento_normatividad', label: 'Cumplimiento de normatividad' },
]

//maneja la selección de archivos para cada documento 
const handleFileSelect = (event, key) => {
  const file = event.target.files[0]
  if (file) {
    form[key] = file
    selectedFiles.value[key] = file.name
  }
}
</script>

<template>
  <AuthenticatedLayout>
    <div class="mb-4">
      <Link :href="route('consejos.integrantes', integrante.consejo_id)"
        class="inline-flex items-center px-3 py-2 bg-gray-200 text-gray-800 text-sm rounded hover:bg-gray-300 transition">
        ← Volver a Integrantes
      </Link>
    </div>
    <div class="p-6">
      <h1 class="text-2xl font-bold mb-4">
        Documentos de {{ integrante.nombre }} {{ integrante.apellido }}
      </h1>

      <!-- FORMULARIO DOCUMENTOS -->
      <form @submit.prevent="submitForm" class="space-y-4">
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div v-for="doc in documentos" :key="doc.key"
            class="border p-4 rounded-lg bg-gray-50 hover:bg-gray-100 transition">
            <label class="block text-sm font-medium mb-2">
              {{ doc.label }}
            </label>

            <!-- BOTÓN DE CARGA -->
            <div class="flex items-center space-x-2">
              <label
                class="inline-flex items-center px-2 py-1 text-xs bg-white border border-gray-300 rounded cursor-pointer hover:bg-gray-200 transition">
                <PaperClipIcon class="w-3 h-3 mr-1 text-gray-600" />
                Cargar
                <input type="file" class="hidden" @change="handleFileSelect($event, doc.key)" />
              </label>

              <span v-if="selectedFiles[doc.key]" class="text-xs text-gray-700 truncate max-w-[140px]">
                {{ selectedFiles[doc.key] }}
              </span>
            </div>

            <!-- ESTADO -->
            <div class="mt-3">
              <div v-if="getDoc(doc.key)">
                <p class="text-green-700 text-sm mb-2 flex items-center gap-1">
                  <CheckCircleIcon class="w-4 h-4" />
                  <span>{{ getCleanFileName(getDoc(doc.key)) }}</span>
                </p>

                <div class="flex space-x-3">
                  <a :href="getPublicUrl(getDoc(doc.key).archivo)" target="_blank"
                    class="inline-flex items-center text-blue-600 hover:text-blue-800 text-sm">
                    <EyeIcon class="w-4 h-4 mr-1" />
                    Ver
                  </a>

                  <a :href="route('docu.download', getDoc(doc.key).id)"
                    class="inline-flex items-center text-indigo-600 hover:text-indigo-800 text-sm">
                    <ArrowDownTrayIcon class="w-4 h-4 mr-1" />
                    Descargar
                  </a>
                </div>
              </div>

              <div v-else-if="!selectedFiles[doc.key]">
                <BellIcon class="w-4 h-4 text-yellow-500 inline-block mr-1" />
                <p class="text-gray-500 text-sm inline-block">
                  Aún no se ha subido
                </p>
              </div>
            </div>
          </div>
        </div>

        <div class="flex justify-end mt-6">
          <button type="submit" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex items-center">
            <CloudArrowUpIcon class="h-5 w-5 mr-1" />
            Guardar documentos
          </button>
        </div>
      </form>
    </div>
  </AuthenticatedLayout>
</template>
