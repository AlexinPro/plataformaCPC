<script setup>
import { useForm } from '@inertiajs/vue3'

const props = defineProps({
  consejos: {
    type: Array,
    default: () => []
  }
})

const emit = defineEmits(['close'])

const form = useForm({
  nombre: '',
  apellidos: '',
  'correo': '',
  puesto: '',
  consejo_id: '',
  documentos: {
    ine: null,
    comprobante_domiciliario: null,
    bajo_protesta: null,
    integracion_formula: null,
    curriculum_vitae: null,
    carta_motivos: null,
    cumplimiento_normatividad: null
  }
})

const submit = () => {
  form.post(route('postulaciones.store'), {
    forceFormData: true,
    onSuccess: () => {
      form.reset()
      emit('close')
    }
  })
}
</script>

<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">

    <div class="bg-white w-full max-w-3xl rounded-lg shadow-lg p-6 relative overflow-y-auto max-h-[90vh]">

      <button type="button" @click="emit('close')" class="absolute top-3 right-3 text-gray-500 hover:text-gray-700">
        ✕
      </button>

      <h3 class="text-lg font-semibold mb-4">
        Nueva Postulación
      </h3>

      <form @submit.prevent="submit" class="space-y-6">

        <!-- Datos personales -->

        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

          <div>
            <label class="block text-sm font-medium text-gray-700">
              Nombre
            </label>

            <input v-model="form.nombre" type="text" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm" />

            <div v-if="form.errors.nombre" class="text-red-500 text-sm">
              {{ form.errors.nombre }}
            </div>
          </div>


          <div>
            <label class="block text-sm font-medium text-gray-700">
              Apellidos
            </label>

            <input v-model="form.apellidos" type="text"
              class="mt-1 block w-full border-gray-300 rounded-md shadow-sm" />

            <div v-if="form.errors.apellidos" class="text-red-500 text-sm">
              {{ form.errors.apellidos }}
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">
              Correo electrónico
            </label>
            <input v-model="form.correo" type="email" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm"/>
            <div v-if="form.errors.correo" class="text-red-500 text-sm">
              {{ form.errors.correo }}
            </div>
          </div>

          <div>
            <label class="block text-sm font-medium text-gray-700">
              Cargo
            </label>

            <input v-model="form.puesto" type="text" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm" />

            <div v-if="form.errors.puesto" class="text-red-500 text-sm">
              {{ form.errors.puesto }}
            </div>
          </div>


          <div>
            <label class="block text-sm font-medium text-gray-700">
              Consejo
            </label>

            <select v-model="form.consejo_id" class="mt-1 block w-full border-gray-300 rounded-md shadow-sm">
              <option value="">Seleccione un consejo</option>

              <option v-for="c in props.consejos" :key="c.id" :value="c.id">
                {{ c.nombre }}
              </option>

            </select>

            <div v-if="form.errors.consejo_id" class="text-red-500 text-sm">
              {{ form.errors.consejo_id }}
            </div>
          </div>

        </div>


        <!-- Expediente -->

        <div class="border-t pt-4">

          <h4 class="font-semibold text-gray-700 mb-3">
            Expediente (Todos los documentos son obligatorios en PDF)
          </h4>

          <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

            <!-- INE -->

            <div>
              <label class="text-sm">INE</label>

              <input type="file" accept="application/pdf" @change="e => form.documentos.ine = e.target.files[0]"
                class="block w-full mt-1" />

              <div v-if="form.errors['documentos.ine']" class="text-red-500 text-sm">
                {{ form.errors['documentos.ine'] }}
              </div>
            </div>


            <!-- Comprobante -->

            <div>
              <label class="text-sm">
                Comprobante domiciliario
              </label>

              <input type="file" accept="application/pdf"
                @change="e => form.documentos.comprobante_domiciliario = e.target.files[0]" class="block w-full mt-1" />

              <div v-if="form.errors['documentos.comprobante_domiciliario']" class="text-red-500 text-sm">
                {{ form.errors['documentos.comprobante_domiciliario'] }}
              </div>
            </div>


            <!-- Bajo protesta -->

            <div>
              <label class="text-sm">
                Bajo protesta art. 170
              </label>

              <input type="file" accept="application/pdf"
                @change="e => form.documentos.bajo_protesta = e.target.files[0]" class="block w-full mt-1" />

              <div v-if="form.errors['documentos.bajo_protesta']" class="text-red-500 text-sm">
                {{ form.errors['documentos.bajo_protesta'] }}
              </div>
            </div>


            <!-- Integración fórmula -->

            <div>
              <label class="text-sm">
                Integración de fórmula
              </label>

              <input type="file" accept="application/pdf"
                @change="e => form.documentos.integracion_formula = e.target.files[0]" class="block w-full mt-1" />

              <div v-if="form.errors['documentos.integracion_formula']" class="text-red-500 text-sm">
                {{ form.errors['documentos.integracion_formula'] }}
              </div>
            </div>
            <!-- CV -->
            <div>
              <label class="text-sm">
                Currículum Vitae
              </label>

              <input type="file" accept="application/pdf"
                @change="e => form.documentos.curriculum_vitae = e.target.files[0]" class="block w-full mt-1" />

              <div v-if="form.errors['documentos.curriculum_vitae']" class="text-red-500 text-sm">
                {{ form.errors['documentos.curriculum_vitae'] }}
              </div>
            </div>

            <!-- Carta motivos -->

            <div>
              <label class="text-sm">
                Carta de motivos
              </label>

              <input type="file" accept="application/pdf"
                @change="e => form.documentos.carta_motivos = e.target.files[0]" class="block w-full mt-1" />

              <div v-if="form.errors['documentos.carta_motivos']" class="text-red-500 text-sm">
                {{ form.errors['documentos.carta_motivos'] }}
              </div>
            </div>

            <!-- Cumplimiento normatividad -->

            <div>
              <label class="text-sm">
                Cumplimiento de normatividad
              </label>

              <input type="file" accept="application/pdf"
                @change="e => form.documentos.cumplimiento_normatividad = e.target.files[0]"
                class="block w-full mt-1" />

              <div v-if="form.errors['documentos.cumplimiento_normatividad']" class="text-red-500 text-sm">
                {{ form.errors['documentos.cumplimiento_normatividad'] }}
              </div>
            </div>

          </div>

        </div>

        <!-- Botones -->

        <div class="flex justify-end space-x-2 pt-4">

          <button type="button" @click="emit('close')" class="px-4 py-2 bg-gray-300 rounded-md">
            Cancelar
          </button>

          <button type="submit" :disabled="form.processing"
            class="px-4 py-2 bg-yellow-700 text-white rounded-md hover:bg-yellow-800">
            Guardar
          </button>
        </div>
      </form>
    </div>
  </div>
</template>