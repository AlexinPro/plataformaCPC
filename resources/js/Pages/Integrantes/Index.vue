<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { ref, computed } from 'vue'
import { useForm, Link } from '@inertiajs/vue3'
import { FolderOpenIcon } from '@heroicons/vue/24/solid'
import { PencilIcon } from '@heroicons/vue/24/outline'
import Form from './Form.vue'

const props = defineProps({
  consejo: Object,
  integrantes: Array
})

const showForm = ref(false)
const editingId = ref(null)

/* ---------- EDITAR DESCRIPCIÓN CONSEJO ---------- */
const showDescripcionModal = ref(false)

const descripcionForm = useForm({
  descripcion: props.consejo.descripcion ?? ''
})

function openDescripcionModal() {
  descripcionForm.descripcion = props.consejo.descripcion ?? ''
  showDescripcionModal.value = true
}

function submitDescripcion() {
  descripcionForm.patch(
    route('consejos.descripcion.update', props.consejo.id),
    {
      onSuccess: () => {
        showDescripcionModal.value = false
      }
    }
  )
}

/* ---------- FORM INTEGRANTE ---------- */
const form = useForm({
  nombre: '',
  apellido: '',
  puesto: '',
  correo: '',
  genero: '',
  colonia: '',
  discapacidad: false,
  discapacidad_tipo: '',
  consejo_id: props.consejo.id,
})

function openForm() {
  editingId.value = null
  form.reset()
  form.discapacidad = false
  form.discapacidad_tipo = ''
  showForm.value = true
}

function editIntegrante(integrante) {
  editingId.value = integrante.id
  form.nombre = integrante.nombre
  form.apellido = integrante.apellido
  form.puesto = integrante.puesto
  form.correo = integrante.correo
  form.genero = integrante.genero
  form.colonia = integrante.colonia
  form.discapacidad = integrante.discapacidad === 'si'
  form.discapacidad_tipo = integrante.discapacidad_tipo ?? ''
  form.consejo_id = integrante.consejo_id
  showForm.value = true
}

function submitForm() {
  form.discapacidad = form.discapacidad ? 'si' : 'no'

  if (editingId.value) {
    form.put(route('integrantes.update', editingId.value), {
      onSuccess: () => {
        form.reset()
        showForm.value = false
      }
    })
  } else {
    form.post(route('integrantes.store'), {
      onSuccess: () => {
        form.reset()
        showForm.value = false
      }
    })
  }
}

/* ---------- BAJA / ELIMINACIÓN ---------- */
const showDeleteModal = ref(false)
const integranteAEliminar = ref(null)

const bajaForm = useForm({
  motivo: '',
  fecha_baja: '',
  evidencia_pdf: null,
  _method: 'delete',
})

function solicitarEliminacion(id) {
  integranteAEliminar.value = id
  bajaForm.reset()
  showDeleteModal.value = true
}

function confirmarEliminacion() {
  if (!bajaForm.motivo || !bajaForm.fecha_baja || !bajaForm.evidencia_pdf) return

  bajaForm.post(route('integrantes.destroy', integranteAEliminar.value), {
    forceFormData: true,
    onSuccess: () => {
      showDeleteModal.value = false
      integranteAEliminar.value = null
    }
  })
}

/* ---------- AGRUPAR FÓRMULAS ---------- */
const formulas = computed(() => {
  const grouped = []
  for (let i = 0; i < props.integrantes.length; i += 2) {
    grouped.push(props.integrantes.slice(i, i + 2))
  }
  return grouped
})

const getSemaforoClase = (integrante) => {
  const total = integrante?.documentos?.length || 0
  if (total === 0) return 'bg-red-500'
  if (total < 7) return 'bg-yellow-400'
  return 'bg-green-500'
}
</script>

<template>
  <AuthenticatedLayout>
    <div class="mt-2 mb-4">
      <Link :href="route('consejos.index', consejo.id)" class="text-gray-600 hover:underline">
        ← Volver a Consejos de Participación Ciudadana
      </Link>
    </div>
    <div class="p-6">
      <div class="flex justify-between items-center mb-4">
        <h1 class="text-2xl font-bold">
          Integrantes del Consejo de Participación Ciudadana de {{ consejo.nombre }}
        </h1>
        <button @click="openForm" class="px-4 py-2 bg-black text-white rounded hover:bg-gray-500">
          + Agregar Integrante
        </button>
      </div>

      <!-- DESCRIPCIÓN CON BOTÓN MINIMALISTA -->
      <div class="flex items-start gap-2 mb-6">
        <p class="text-gray-700">
          {{ consejo.descripcion }}
        </p>

        <button @click="openDescripcionModal" class="text-gray-400 hover:text-gray-600 transition"
          title="Editar descripción">
          <PencilIcon class="w-4 h-4" />
        </button>
      </div>

      <!-- TABLA -->
      <div v-if="formulas.length" class="overflow-x-auto">
        <table class="min-w-full border border-gray-300 rounded-lg">
          <thead class="bg-gray-100">
            <tr>
              <th class="px-4 py-2 border"># Fórmula</th>
              <th class="px-4 py-2 border">Personas integrantes</th>
              <th class="px-4 py-2 border">Cargo</th>
              <th class="px-4 py-2 border">Acciones</th>
            </tr>
          </thead>

          <tbody>
            <tr v-for="(f, i) in formulas" :key="i">
              <td class="px-4 py-2 border text-center">{{ i + 1 }}</td>

              <td class="px-4 py-2 border">
                <div v-if="f[0]" class="flex items-center gap-2">
                  <span class="semaforo" :class="getSemaforoClase(f[0])"></span>
                  <span>{{ f[0].nombre }} {{ f[0].apellido }}</span>
                </div>
                <span v-else class="text-gray-400">Pendiente</span>

                <br />

                <div v-if="f[1]" class="flex items-center gap-2">
                  <span class="semaforo" :class="getSemaforoClase(f[1])"></span>
                  <span>{{ f[1].nombre }} {{ f[1].apellido }}</span>
                </div>
                <span v-else class="text-gray-400">Pendiente</span>
              </td>

              <td class="px-4 py-2 border">
                <span v-if="f[0]">{{ f[0].puesto }}</span>
                <span v-else class="text-gray-400">Pendiente</span>
                <br />
                <span v-if="f[1]">{{ f[1].puesto }}</span>
                <span v-else class="text-gray-400">Pendiente</span>
              </td>

              <td class="px-4 py-2 border">
                <div v-if="f[0]" class="flex space-x-2">
                  <button @click="editIntegrante(f[0])" class="px-2 py-1 bg-yellow-700 text-white rounded">
                    Editar
                  </button>
                  <button @click="solicitarEliminacion(f[0].id)" class="px-2 py-1 bg-red-500 text-white rounded">
                    Eliminar
                  </button>
                  <button @click="$inertia.get(route('docu.index', f[0].id))"
                    class="px-2 py-1 bg-red-800 text-white rounded flex items-center">
                    <FolderOpenIcon class="w-5 h-5 mr-1" /> Documentos
                  </button>
                </div>

                <div v-if="f[1]" class="flex space-x-2 mt-2">
                  <button @click="editIntegrante(f[1])" class="px-2 py-1 bg-yellow-700 text-white rounded">
                    Editar
                  </button>
                  <button @click="solicitarEliminacion(f[1].id)" class="px-2 py-1 bg-red-500 text-white rounded">
                    Eliminar
                  </button>
                  <button @click="$inertia.get(route('docu.index', f[1].id))"
                    class="px-2 py-1 bg-red-800 text-white rounded flex items-center">
                    <FolderOpenIcon class="w-5 h-5 mr-1" /> Documentos
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <p v-else class="text-gray-500">No hay integrantes registrados.</p>
    </div>

    <!-- MODAL EDITAR DESCRIPCIÓN -->
    <div v-if="showDescripcionModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div class="bg-white rounded-lg p-6 w-full max-w-lg">
        <h2 class="text-lg font-bold mb-4">Editar descripción del consejo</h2>

        <textarea v-model="descripcionForm.descripcion" rows="4"
          class="w-full border rounded px-3 py-2 mb-4"></textarea>

        <div class="flex justify-end space-x-2">
          <button @click="showDescripcionModal = false" class="px-4 py-2 bg-gray-300 rounded">
            Cancelar
          </button>

          <button @click="submitDescripcion" :disabled="descripcionForm.processing"
            class="px-4 py-2 bg-black text-white rounded hover:bg-gray-700 disabled:opacity-50">
            Guardar
          </button>
        </div>
      </div>
    </div>

    <!-- FORMULARIO -->
    <Form :show="showForm" :form="form" :editingId="editingId" @close="showForm = false" @submit="submitForm" />

    <!-- MODAL DE BAJA -->
    <div v-if="showDeleteModal" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center">
      <div class="bg-white rounded-lg p-6 w-full max-w-md">
        <h2 class="text-lg font-bold mb-4">Registrar baja de integrante</h2>
        <!-- MOTIVO -->
        <label class="block font-semibold mb-1">Motivo</label>
        <select v-model="bajaForm.motivo" class="w-full border rounded px-3 py-2 mb-4">
          <option value="">Seleccione un motivo</option>
          <option value="inasistencia">Inasistencia</option>
          <option value="sancion">Sanciones</option>
          <option value="fin_periodo">Fin de periodo / No realizó reelección</option>
          <option value="renuncia">Renuncia</option>
        </select>

        <!-- FECHA -->
        <label class="block font-semibold mb-1">Fecha de baja</label>
        <input type="date" v-model="bajaForm.fecha_baja" class="w-full border rounded px-3 py-2 mb-4" />

        <!-- PDF -->
        <label class="block font-semibold mb-1">Evidencia PDF</label>
        <input type="file" accept="application/pdf" class="w-full border rounded px-3 py-2 mb-4"
          @change="e => bajaForm.evidencia_pdf = e.target.files[0]" />

        <div class="flex justify-end space-x-2">
          <button @click="showDeleteModal = false" class="px-4 py-2 bg-gray-300 rounded">
            Cancelar
          </button>

          <button @click="confirmarEliminacion"
            :disabled="!bajaForm.motivo || !bajaForm.fecha_baja || !bajaForm.evidencia_pdf"
            class="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-800 disabled:opacity-50">
            Confirmar baja
          </button>
        </div>
      </div>
    </div>
  </AuthenticatedLayout>
</template>

<style>
.semaforo {
  width: 10px;
  height: 10px;
  border-radius: 50%;
  display: inline-block;
}
</style>
