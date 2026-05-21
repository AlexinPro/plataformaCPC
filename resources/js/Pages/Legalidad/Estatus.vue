<script>
import { router, usePage, Link } from "@inertiajs/vue3";
import AuthenticatedLayout from "@/Layouts/AuthenticatedLayout.vue";
import Swal from "sweetalert2";
import { watch } from "vue";

export default {
  components: { AuthenticatedLayout, Link },

  props: {
    consejo: Object,
    registros: Array,
  },

  setup() {
    const page = usePage();

    //mensaje de confirmacion despues de aprobar o rechazar una reeleccion
    watch(
      () => page.props.flash,
      (flash) => {
        if (!flash) return;

        if (flash.success) {
          Swal.fire({
            toast: true,
            position: "top-end",
            icon: "success",
            title: flash.success,
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
          });
        }

        if (flash.warning) {
          Swal.fire({
            toast: true,
            position: "top-end",
            icon: "warning",
            title: flash.warning,
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
          });
        }

        if (flash.error) {
          Swal.fire({
            toast: true,
            position: "top-end",
            icon: "error",
            title: flash.error,
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
          });
        }
      },
      { immediate: true }
    );

    return {};
  },

  data() {
    return {
      showModal: false,
      seleccionado: null,
      historialAbierto: null,
    };
  },

  computed: {
    historialPorIntegrante() {
      const grupos = {};

      this.registros.forEach(r => {
        const id = r.integrante_id;

        if (!grupos[id]) {
          grupos[id] = {
            integrante: r.integrante,
            periodos: [],
          };
        }

        grupos[id].periodos.push(r);
      });

      Object.values(grupos).forEach(g => {
        g.periodos.sort(
          (a, b) => new Date(b.inicio_cargo) - new Date(a.inicio_cargo)
        );
      });

      return grupos;
    }
  },
  
  //funciones para formatear fechas, abrir modal, cerrar modal, aprobar, rechazar, obtener estatus
  methods: {
    formatearFecha(fecha) {
      if (!fecha) return "N/A";
      return new Date(fecha).toLocaleDateString("es-MX"); //formato de fecha en español
    },

    abrirValidacion(periodo) {
      this.seleccionado = periodo;
      this.showModal = true;
    },

    cerrarModal() {
      this.showModal = false;
      this.seleccionado = null;
    },

    aprobar() {
      router.post(`/legalidad/${this.seleccionado.id}/aprobar`);
      this.cerrarModal();
    },

    rechazar() {
      router.post(`/legalidad/${this.seleccionado.id}/rechazar`);
      this.cerrarModal();
    },

    estado(p) {
      return p.estatus_reeleccion || "pendiente";
    },

    vecesReelegido(periodos) {
      const aprobados = periodos.filter(
        p => p.estatus_reeleccion === "aprobado"
      ).length;

      return aprobados === 1 ? "1 vez" : `${aprobados} veces`;
    },

    toggleHistorial(integranteId) {
      this.historialAbierto =
        this.historialAbierto === integranteId ? null : integranteId;
    }
  },
};
</script>


<template>
  <AuthenticatedLayout>
    <div class="mb-4">
      <Link :href="route('legalidad.index', {consejo: consejo.id})"
        class="inline-flex items-center px-3 py-2 bg-gray-200 text-gray-800 text-sm rounded hover:bg-gray-300 transition">
      ← Volver a Panel de Integrantes
      </Link>
    </div>

    <div class="p-6 space-y-6">

      <h1 class="text-2xl font-bold text-center">
        Validación de Reelecciones
        <br />
        <span class="text-gray-600 text-lg">
          Consejo de {{ consejo.nombre }}
        </span>
      </h1>

      <div class="overflow-x-auto bg-white shadow rounded p-4">
        <table class="min-w-full border-collapse">
          <thead>
            <tr class="bg-gray-100">
              <th class="px-4 py-3 border">Integrante</th>
              <th class="px-4 py-3 border text-center">Reelegido</th>
              <th class="px-4 py-3 border text-center">Acciones</th>
            </tr>
          </thead>

          <tbody>
            <template v-for="(grupo, integranteId) in historialPorIntegrante" :key="integranteId">
              <tr class="bg-gray-50 hover:bg-gray-100">
                <td class="px-4 py-3 border font-semibold">
                  {{ grupo.integrante.nombre }}
                  {{ grupo.integrante.apellido }}
                </td>

                <td class="px-4 py-3 border text-center">
                  {{ vecesReelegido(grupo.periodos) }}
                </td>

                <td class="px-4 py-3 border text-center">
                  <button class="px-3 py-1 rounded text-white bg-red-800" @click="toggleHistorial(integranteId)">
                    {{ historialAbierto === integranteId
                      ? "Ocultar historial"
                      : "Ver historial" }}
                  </button>
                </td>
              </tr>

              <tr v-if="historialAbierto === integranteId">
                <td colspan="3" class="bg-white p-4 border">
                  <table class="min-w-full border-collapse">
                    <thead>
                      <tr class="bg-gray-100">
                        <th class="px-3 py-2 border">Inicio</th>
                        <th class="px-3 py-2 border">Fin</th>
                        <th class="px-3 py-2 border text-center">Estatus</th>
                        <th class="px-3 py-2 border text-center">Acciones</th>
                      </tr>
                    </thead>

                    <tbody>
                      <tr v-for="periodo in grupo.periodos" :key="periodo.id" class="hover:bg-gray-50">
                        <td class="px-3 py-2 border">
                          {{ formatearFecha(periodo.inicio_cargo) }}
                        </td>

                        <td class="px-3 py-2 border">
                          {{ formatearFecha(periodo.fin_cargo) }}
                        </td>

                        <td class="px-3 py-2 border text-center font-semibold">
                          {{ estado(periodo) }}
                        </td>

                        <td class="px-3 py-2 border text-center">
                          <button v-if="estado(periodo) === 'pendiente'"
                            class="px-3 py-1 rounded text-white bg-yellow-700" @click="abrirValidacion(periodo)">
                            Validar
                          </button>

                          <button v-else class="px-3 py-1 rounded text-white bg-gray-700"
                            @click="abrirValidacion(periodo)" style="background-color: #A6A6A8;">
                            Ver
                          </button>
                        </td>
                      </tr>
                    </tbody>
                  </table>
                </td>
              </tr>
            </template>
          </tbody>
        </table>
      </div>

      <!-- MODAL -->
      <div v-if="showModal" class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50">
        <div class="bg-white rounded shadow p-6 w-96 space-y-4">
          <h2 class="text-xl font-bold text-center">
            Validar documentos
          </h2>

          <div v-if="seleccionado">
            <p>
              <strong>Integrante:</strong>
              {{ seleccionado.integrante?.nombre }}
              {{ seleccionado.integrante?.apellido }}
            </p>

            <a v-if="seleccionado.doc_nombramiento" :href="`/storage/${seleccionado.doc_nombramiento}`" target="_blank"
              class="block text-blue-600 underline mt-2">
              Ver Nombramiento
            </a>

            <a v-if="seleccionado.doc_carta_reeleccion" :href="`/storage/${seleccionado.doc_carta_reeleccion}`"
              target="_blank" class="block text-blue-600 underline mt-2">
              Ver Carta de Reelección
            </a>

            <a v-if="seleccionado.doc_otros" :href="`/storage/${seleccionado.doc_otros}`" target="_blank"
              class="block text-blue-600 underline mt-2">
              Ver Otros documentos
            </a>
          </div>

          <div class="flex justify-between mt-4">
            <button @click="cerrarModal" class="px-4 py-2 bg-gray-500 text-white rounded">
              Cerrar
            </button>

            <div class="space-x-2">
              <button @click="rechazar" class="px-4 py-2 bg-red-700 text-white rounded">
                Rechazar
              </button>

              <button @click="aprobar" class="px-4 py-2 bg-green-700 text-white rounded">
                Aprobar
              </button>
            </div>
          </div>
        </div>
      </div>

    </div>
  </AuthenticatedLayout>
</template>
