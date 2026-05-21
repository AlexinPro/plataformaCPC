<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { ref, computed } from 'vue'
import { Link } from '@inertiajs/vue3'
import { ArrowDownTrayIcon } from '@heroicons/vue/24/solid'

//props para recibir datos desde el controlador
const props = defineProps({
  consejo: Object,
  convocatorias: Array,
  asistencias: Array,
  integrantes: Array,
  bajas: Array,
  reporteAsistencias: Array,
  hayDatos: Boolean,
})

const tipoReporte = ref('')

//años para filtro
const year = ['2025', '2026', '2027', '2028', '2029']
const anioSeleccionado = ref(year[0])

function obtenerAnio(fecha) {
  return new Date(fecha).getFullYear().toString()
}

// documentos
const tiposDocumentos = [
  { label: 'INE', key: 'ine' },
  { label: 'Comprobante domiciliario', key: 'comprobante_domiciliario' },
  { label: 'Bajo protesta (Art. 170)', key: 'bajo_protesta_art_170' },
  { label: 'Curriculum Vitae', key: 'curriculum_vitae' },
  { label: 'Integración de fórmula', key: 'integracion_formula' },
  { label: 'Carta de motivos', key: 'carta_motivos' },
  { label: 'Cumplimiento de normatividad', key: 'cumplimiento_normatividad' },
]

function tieneDocumento(integrante, key) {
  if (!integrante || !Array.isArray(integrante.documentos)) return false
  return integrante.documentos.some(doc => doc.tipo === key)
}

// fechas
function formatearFecha(fecha) {
  if (!fecha) return '-'
  if (fecha.includes('T')) {
    fecha = fecha.split('T')[0]
  }
  const match = fecha.match(/\d{4}-\d{2}-\d{2}/)
  if (match) {
    const [year, month, day] = match[0].split('-')
    return `${day}/${month}/${year}`
  }
  return fecha
}

const meses = [
  'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
  'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'
]

function obtenerMes(fecha) {
  return meses[new Date(fecha).getMonth()]
}

// sección para pivotear convocatorias por tipo de sesión y mes
const tiposSesion = ['ordinaria', 'solemne', 'extraordinaria']

const convocatoriasFiltradas = computed(() =>
  props.convocatorias.filter(c =>
    obtenerAnio(c.fecha) === anioSeleccionado.value
  )
)

const tablaConvocatoriasPivot = computed(() => {
  const estructura = {}

  tiposSesion.forEach(tipo => {
    estructura[tipo] = {}
    meses.forEach(mes => {
      estructura[tipo][mes] = { convocada: '', realizada: '' }
    })
  })

  convocatoriasFiltradas.value.forEach(c => {
    const mes = obtenerMes(c.fecha)
    estructura[c.tipo_sesion][mes].convocada = c.estado_convocatoria ? 'si' : 'no'
    estructura[c.tipo_sesion][mes].realizada = c.estado_sesion ? 'si' : 'no'
  })

  return estructura
})

// asistencias filtradas por año 
const asistenciasFiltradas = computed(() =>
  props.asistencias.filter(a =>
    obtenerAnio(a.fecha) === anioSeleccionado.value
  )
)

const asistenciasExcel = computed(() => {
  const mapa = {}

  asistenciasFiltradas.value.forEach(a => {
    if (!a.integrante || !a.fecha) return

    const id = a.integrante.id
    const mes = obtenerMes(a.fecha)

    if (!mapa[id]) {
      mapa[id] = {
        integrante: `${a.integrante.nombre} ${a.integrante.apellido}`,
        puesto: a.integrante.puesto ?? '',
        meses: {},
        totalA: 0,
        totalI: 0,
        totalIJ: 0,
      }

      meses.forEach(m => {
        mapa[id].meses[m] = []
      })
    }

    const simbolo = a.simbolo

    mapa[id].meses[mes].push(simbolo)

    if (simbolo === 'A') mapa[id].totalA++
    if (simbolo === 'I') mapa[id].totalI++
    if (simbolo === 'IJ') mapa[id].totalIJ++
  })

  return Object.values(mapa)
})


// baas
function obtenerNombreArchivo(ruta) {
  if (!ruta) return '-'
  return ruta.split('/').pop()
}

function obtenerUrlPublica(ruta) {
  if (!ruta) return '#'
  return `/storage/${ruta}`
}

// exports
function exportarConvocatoriasExcel() {
  const tabla = document.querySelector('#tabla-convocatorias-pivot')
  if (!tabla) return

  const blob = new Blob(['\ufeff' + tabla.outerHTML], {
    type: 'application/vnd.ms-excel',
  })

  const link = document.createElement('a')
  link.href = URL.createObjectURL(blob)
  link.download = `convocatorias_${props.consejo.nombre}_${anioSeleccionado.value}.xls`
  link.click()
}

function exportarDocumentosExcel() {
  const tabla = document.querySelector('#tabla-documentos')
  if (!tabla) return

  const blob = new Blob(['\ufeff' + tabla.outerHTML], {
    type: 'application/vnd.ms-excel',
  })

  const link = document.createElement('a')
  link.href = URL.createObjectURL(blob)
  link.download = `documentos_${props.consejo.nombre}.xls`
  link.click()
}

function exportarAsistenciasExcel() {
  const tabla = document.querySelector('#tabla-asistencias-excel')
  if (!tabla) return

  const blob = new Blob(['\ufeff' + tabla.outerHTML], {
    type: 'application/vnd.ms-excel',
  })

  const link = document.createElement('a')
  link.href = URL.createObjectURL(blob)
  link.download = `asistencias_${props.consejo.nombre}_${anioSeleccionado.value}.xls`
  link.click()
}
</script>


<template>
  <AuthenticatedLayout>
    <div class="mt-2 mb-4">
      <Link :href="route('consejos.reportes', consejo.id)" class="text-gray-600 hover:underline">
        ← Volver a Consejos de Participación Ciudadana
      </Link>
    </div>
    <div class="p-6 bg-white rounded-lg shadow-md">

      <h1 class="text-2xl font-bold mb-6">
        Reportes del Consejo de Participación Ciudadana de {{ consejo.nombre }}
      </h1>

      <div v-if="!hayDatos" class="text-center text-gray-500 p-10 border rounded-lg bg-gray-50">
        No hay información disponible para generar reportes de este consejo.
      </div>

      <div v-else>

        <!-- SELECTOR DE TIPO -->
        <div class="mb-4">
          <label class="block font-semibold mb-2">Selecciona el tipo de reporte</label>
          <select v-model="tipoReporte" class="border rounded-lg p-2 w-full sm:w-1/3">
            <option disabled value="">--Selecciona--</option>
            <option value="convocatorias">Sesiones</option>
            <option value="asistencias">Asistencias</option>
            <option value="documentos">Documentos</option>
            <option value="bajas">Bajas de integrantes</option>
          </select>
        </div>

        <!-- SELECTOR DE AÑO SOLO PARA ASISTENCIAS Y CONVOCATORIAS -->
        <div v-if="tipoReporte === 'convocatorias' || tipoReporte === 'asistencias'" class="mb-6">
          <label class="block font-semibold mb-2">Selecciona el año</label>
          <select v-model="anioSeleccionado" class="border rounded-lg p-2 w-full sm:w-1/3">
            <option v-for="y in year" :key="y" :value="y">{{ y }}</option>
          </select>
        </div>

        <!-- CONVOCATORIAS -->
        <div v-if="tipoReporte === 'convocatorias'">
          <h2 class="text-lg font-semibold mb-4">Convocatorias por Mes</h2>

          <table id="tabla-convocatorias-pivot" class="min-w-full border text-sm">
            <thead>
              <tr>
                <th class="border p-2 bg-gray-100">Tipo de sesión</th>
                <th v-for="mes in meses" :key="mes" class="border p-2 bg-gray-100 text-center" colspan="2">
                  {{ mes }}
                </th>
              </tr>
              <tr>
                <th></th>
                <template v-for="mes in meses" :key="mes">
                  <th class="border p-2 bg-gray-200">Convocada</th>
                  <th class="border p-2 bg-gray-200">Realizada</th>
                </template>
              </tr>
            </thead>

            <tbody>
              <tr v-for="tipo in tiposSesion" :key="tipo">
                <td class="border p-2 capitalize font-semibold">{{ tipo }}</td>
                <template v-for="mes in meses" :key="mes">
                  <td class="border p-2 text-center">{{ tablaConvocatoriasPivot[tipo][mes].convocada }}</td>
                  <td class="border p-2 text-center">{{ tablaConvocatoriasPivot[tipo][mes].realizada }}</td>
                </template>
              </tr>
            </tbody>
          </table>

          <div class="text-right mt-4">
            <button @click="exportarConvocatoriasExcel"
              class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex ml-auto">
              <ArrowDownTrayIcon class="w-5 h-5 mr-2" />
              Exportar a Excel
            </button>
          </div>
        </div>

        <!-- ASISTENCIAS -->
        <div v-if="tipoReporte === 'asistencias'">
          <h2 class="text-lg font-semibold mb-4">
            Reporte de Asistencias (Formato Excel)
          </h2>

          <div class="overflow-x-auto border rounded-lg">
            <table id="tabla-asistencias-excel" class="min-w-max border text-sm">
              <thead class="bg-gray-100">
                <tr>
                  <th class="border p-2 sticky left-0 bg-gray-100 z-10">
                    Integrante
                  </th>

                  <th class="border p-2 sticky left-0 bg-gray-100 z-10">
                    Cargo
                  </th>

                  <th v-for="mes in meses" :key="mes" class="border p-2 text-center">
                    {{ mes }}
                  </th>

                  <th class="border p-2 text-center">A totales</th>
                  <th class="border p-2 text-center">I totales</th>
                  <th class="border p-2 text-center">IJ totales</th>
                </tr>
              </thead>

              <tbody>
                <tr v-for="fila in asistenciasExcel" :key="fila.integrante" class="border-t">
                  <td class="p-2 font-medium">
                    {{ fila.integrante }}
                  </td>

                  <td class="p-2 font-medium">
                    {{ fila.puesto }}
                  </td>

                  <td v-for="mes in meses" :key="mes" class="p-2 text-center whitespace-nowrap">
                    {{ fila.meses[mes].join(', ') }}
                  </td>

                  <td class="p-2 text-center font-semibold">
                    {{ fila.totalA }}
                  </td>
                  <td class="p-2 text-center font-semibold">
                    {{ fila.totalI }}
                  </td>
                  <td class="p-2 text-center font-semibold">
                    {{ fila.totalIJ }}
                  </td>
                </tr>
              </tbody>
            </table>
          </div>

          <div class="text-right mt-4">
            <button @click="exportarAsistenciasExcel"
              class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex ml-auto">
              <ArrowDownTrayIcon class="w-5 h-5 mr-2" />
              Exportar a Excel
            </button>
          </div>
        </div>

        <!-- DOCUMENTOS  -->
        <div v-if="tipoReporte === 'documentos'">
          <h2 class="text-lg font-semibold mb-2">Checklist de Documentos</h2>

          <table id="tabla-documentos" class="min-w-full border text-sm">
            <thead class="bg-gray-100">
              <tr>
                <th class="p-2 text-left">Integrante</th>
                <th v-for="doc in tiposDocumentos" :key="doc.key" class="p-2 text-center">
                  {{ doc.label }}
                </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for="integrante in props.integrantes" :key="integrante.id" class="border-t">
                <td class="p-2">{{ integrante.nombre }} {{ integrante.apellido }}</td>
                <td v-for="doc in tiposDocumentos" :key="doc.key" class="p-2 text-center">
                  <span v-if="tieneDocumento(integrante, doc.key)" class="text-green-700 font-semibold">si</span>
                  <span v-else class="text-red-700 font-semibold">no</span>
                </td>
              </tr>
            </tbody>
          </table>

          <div class="text-right mt-4">
            <button @click="exportarDocumentosExcel"
              class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex ml-auto">
              <ArrowDownTrayIcon class="w-5 h-5 mr-2" />
              Exportar a Excel
            </button>
          </div>
        </div>

        <!-- BAJAS-->
        <div v-if="tipoReporte === 'bajas'">
          <h2 class="text-lg font-semibold mb-4">Integrantes dados de baja</h2>

          <table class="min-w-full border text-sm">
            <thead class="bg-gray-100">
              <tr>
                <th class="p-2 text-left">Integrante</th>
                <th class="p-2 text-left">Motivo</th>
                <th class="p-2 text-left">Fecha</th>
                <th class="p-2 text-left">Evidencia</th>
              </tr>
            </thead>

            <tbody>
              <tr v-if="props.bajas.length === 0">
                <td colspan="4" class="p-4 text-center text-gray-500">
                  No hay integrantes dados de baja en este consejo.
                </td>
              </tr>

              <tr v-for="baja in props.bajas" :key="baja.id" class="border-t">
                <td class="p-2">{{ baja.nombre }} {{ baja.apellido }}</td>
                <td class="p-2 capitalize">{{ baja.motivo }}</td>
                <td class="p-2">{{ formatearFecha(baja.fecha_baja) }}</td>
                <td class="p-2">
                  <a v-if="baja.evidencia_pdf" :href="obtenerUrlPublica(baja.evidencia_pdf)" target="_blank"
                    class="text-red-700 underline">
                    {{ obtenerNombreArchivo(baja.evidencia_pdf) }}
                  </a>
                  <span v-else class="text-gray-500">Sin archivo</span>
                </td>
              </tr>
            </tbody>
          </table>
        </div>

      </div>
    </div>
  </AuthenticatedLayout>
</template>
