<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { Link } from '@inertiajs/vue3'

const props = defineProps({
  consejo: Object,
  sesiones: Array, //fecha, tipo_sesion, evidencia 
})
</script>

<template>
  <AuthenticatedLayout>
    <div class="p-6">

      <!-- Título -->
      <h1 class="text-2xl font-bold mb-6">
        Pases de lista – {{ consejo.nombre }}
      </h1>

      <!-- Enlace para volver -->
      <div class="mt-6">
        <Link :href="route('asistencias.index', consejo.id)" 
        class="text-gray-600 hover:underline">
          ← Volver a asistencias
        </Link> 
      </div> <br>

      <!-- Tabla -->
      <div v-if="sesiones.length" class="overflow-x-auto">
        <table class="min-w-full border border-gray-300 rounded-lg">
          <thead class="bg-gray-100">
            <tr>
              <th class="px-4 py-2 border">Fecha</th>
              <th class="px-4 py-2 border">Tipo de sesión</th>
              <th class="px-4 py-2 border text-center">Evidencia</th>
            </tr>
          </thead>

          <tbody>
            <tr v-for="(s, index) in sesiones" :key="index" class="hover:bg-gray-50">
              <td class="px-4 py-2 border">
                {{ s.fecha }}
              </td>

              <td class="px-4 py-2 border capitalize">
                {{ s.tipo_sesion }}
              </td>

              <td class="px-4 py-2 border text-center space-x-4">
                <!-- VER -->
                <a :href="`/storage/${s.evidencia}`" target="_blank" class="text-red-600 hover:underline">
                  Ver
                </a>

                <!-- DESCARGAR -->
                <a :href="`/storage/${s.evidencia}`" download class="text-green-600 hover:underline">
                  Descargar
                </a>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- Sin evidencias -->
      <p v-else class="text-gray-500">
        No hay pases de lista registrados para este consejo.
      </p>

    </div>
  </AuthenticatedLayout>
</template>
