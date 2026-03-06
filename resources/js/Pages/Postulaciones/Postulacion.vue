<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { ref, watchEffect } from 'vue'
import { router, usePage } from '@inertiajs/vue3'
import Swal from 'sweetalert2'
import { CheckBadgeIcon, XMarkIcon } from '@heroicons/vue/24/solid'

const page = usePage()

const props = defineProps({
  postulaciones: { type: Array, default: () => [] }
})

watchEffect(() => {

  if (page.props.flash?.success) {
    Swal.fire({
      icon: 'success',
      title: 'Correcto',
      text: page.props.flash.success
    })
  }

  if (page.props.flash?.error) {
    Swal.fire({
      icon: 'error',
      title: 'Error',
      text: page.props.flash.error
    })
  }

})

const aprobar = (id) => {

  Swal.fire({
    title: 'Resolución de postulación',
    html: `
      <input type="date" id="fecha" class="swal2-input">
      <input type="file" id="acta" class="swal2-file" accept="application/pdf">
    `,
    showCancelButton: true,
    confirmButtonText: 'Aprobar',
    cancelButtonText: 'Cancelar',
    confirmButtonColor: '#16a34a',
    cancelButtonColor: '#6b7280',

    preConfirm: () => {

      const fecha = document.getElementById('fecha').value
      const archivo = document.getElementById('acta').files[0]

      if (!fecha || !archivo) {
        Swal.showValidationMessage('Debe capturar fecha y subir el acta')
      }

      return { fecha, archivo }

    }

  }).then(result => {

    if (!result.isConfirmed) return

    const formData = new FormData()

    formData.append('fecha_validacion', result.value.fecha)
    formData.append('acta_resolucion', result.value.archivo)

    router.post(route('postulaciones.aprobar', id), formData)

  })

}

const rechazar = (id) => {

  Swal.fire({
    title: 'Resolución de postulación',
    html: `
      <input type="date" id="fecha" class="swal2-input">
      <input type="file" id="acta" class="swal2-file" accept="application/pdf">
    `,
    showCancelButton: true,
    confirmButtonText: 'Rechazar',
    cancelButtonText: 'Cancelar',
    confirmButtonColor: '#dc2626',
    cancelButtonColor: '#6b7280',

    preConfirm: () => {

      const fecha = document.getElementById('fecha').value
      const archivo = document.getElementById('acta').files[0]

      if (!fecha || !archivo) {
        Swal.showValidationMessage('Debe capturar fecha y subir el acta')
      }

      return { fecha, archivo }

    }

  }).then(result => {

    if (!result.isConfirmed) return

    const formData = new FormData()

    formData.append('fecha_validacion', result.value.fecha)
    formData.append('acta_resolucion', result.value.archivo)

    router.post(route('postulaciones.rechazar', id), formData)

  })

}
</script>

<template>

  <AuthenticatedLayout>

    <template #header>
      <h2 class="text-xl font-semibold">
        Panel de Validación
      </h2>
    </template>

    <div class="py-12">

      <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">

        <div v-if="!postulaciones.length" class="text-gray-500">
          No hay postulaciones pendientes.
        </div>

        <div v-else class="bg-white shadow sm:rounded-lg p-6">

          <table class="min-w-full divide-y divide-gray-200">

            <thead>
              <tr>
                <th class="px-4 py-2 text-left">Nombre</th>
                <th class="px-4 py-2 text-left">Consejo</th>
                <th class="px-4 py-2 text-left">Resolución</th>
              </tr>
            </thead>

            <tbody class="divide-y divide-gray-200">

              <tr v-for="p in postulaciones" :key="p.id">

                <td class="px-4 py-2">
                  {{ p.nombre }} {{ p.apellidos }}
                </td>

                <td class="px-4 py-2">
                  {{ p.consejo?.nombre }}
                </td>

                <td class="px-4 py-2 space-x-3">

                  <button @click="aprobar(p.id)" class="text-green-600 font-bold text-lg">
                    <CheckBadgeIcon class="w-6 h-6" />
                  </button>

                  <button @click="rechazar(p.id)" class="text-red-600 font-bold text-lg">
                    <XMarkIcon class="w-6 h-6" />
                  </button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </AuthenticatedLayout>
</template>