<script>
import { router } from "@inertiajs/vue3";


export default {
  props: {
    consejo: Object,
    integrantes: Array,
    editData: Object, // Si existe → es reelección
  },

  data() {
    return {
      form: {
        integrante_id: "",
        inicio_cargo: "",
        fin_cargo: "",
        periodo_habil: "",
        doc_nombramiento: null,
        doc_carta_reeleccion: null,
        doc_otros: null,
      },
    };
  },

  computed: {
    esReeleccion() {
      return !!this.editData;
    },
  },

  mounted() {
    if (this.editData) {
      this.form.integrante_id = this.editData.integrante_id;
      this.form.inicio_cargo = this.formatDateForInput(this.editData.inicio_cargo);
      this.form.fin_cargo = this.formatDateForInput(this.editData.fin_cargo);
      this.form.periodo_habil = this.editData.periodo_habil;
    }
  },

  methods: {
    /*convierte cualquier fecha a formato YYYY-MM-DD
     *para que funcione con <input type="date">*/
    formatDateForInput(date) {
      if (!date) return "";

      const d = new Date(date);
      const year = d.getFullYear();
      const month = String(d.getMonth() + 1).padStart(2, "0");
      const day = String(d.getDate()).padStart(2, "0");

      return `${year}-${month}-${day}`;
    },

    autoCalcularFin() {
      if (!this.form.inicio_cargo) return;
      const inicio = new Date(this.form.inicio_cargo);
      //sumamos 3 años
      const fin = new Date(inicio);
      fin.setFullYear(fin.getFullYear() + 3);
      const year = fin.getFullYear();
      const month = String(fin.getMonth() + 1).padStart(2, "0");
      const day = String(fin.getDate()).padStart(2, "0");
      this.form.fin_cargo = `${year}-${month}-${day}`;
      //recalcula periodo
      this.calcularPeriodo();
    },

    calcularPeriodo() {
      if (!this.form.inicio_cargo || !this.form.fin_cargo) return;

      const inicio = new Date(this.form.inicio_cargo);
      const fin = new Date(this.form.fin_cargo);
      const diffTime = Math.abs(fin - inicio);
      const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

      this.form.periodo_habil = `${diffDays} días`;
    },

    handleNombramiento(e) {
      this.form.doc_nombramiento = e.target.files[0];
    },

    handleCarta(e) {
      this.form.doc_carta_reeleccion = e.target.files[0];
    },

    handleOtros(e) {
      this.form.doc_otros = e.target.files[0];
    },

    submitForm() {
      const data = new FormData();

      Object.keys(this.form).forEach((key) => {
        if (this.form[key] !== null && this.form[key] !== "") {
          data.append(key, this.form[key]);
        }
      });

      if (this.esReeleccion) {
        router.post(`/legalidad/${this.editData.id}/reeleccion`, data);
      } else {
        router.post(`/legalidad/${this.consejo.id}`, data);
      }

      setTimeout(() => {
        this.$emit("close");
      }, 300);
    },
  },

};
</script>

<template>
  <div class="fixed inset-0 bg-black bg-opacity-50 flex justify-center items-center z-50">
    <div class="bg-white rounded shadow p-6 w-96">

      <h2 class="text-xl font-bold mb-4 text-center">
        {{ esReeleccion ? 'Inicio de proceso de reelección' : 'Crear periodo' }}
      </h2>

      <form @submit.prevent="submitForm">

        <!-- INTEGRANTE -->
        <label class="block mb-2 font-semibold">Integrante</label>
        <select v-model="form.integrante_id" class="w-full border rounded px-3 py-2 mb-3 bg-gray-100"
          :disabled="esReeleccion">
          <option value="">Seleccione...</option>
          <option v-for="i in integrantes" :key="i.id" :value="i.id">
            {{ i.nombre }} {{ i.apellido }}
          </option>
        </select>

        <!-- FECHA INICIO -->
        <label class="block mb-2 font-semibold">Fecha de inicio</label>
        <input type="date" v-model="form.inicio_cargo" class="w-full border rounded px-3 py-2 mb-3"
          :disabled="esReeleccion" @change="autoCalcularFin" />

        <!-- FECHA FIN -->
        <label class="block mb-2 font-semibold">Fecha de culminación</label>
        <input type="date" v-model="form.fin_cargo" class="w-full border rounded px-3 py-2 mb-3"
          :disabled="esReeleccion" @change="calcularPeriodo" />

        <!-- DOCUMENTOS SOLO EN REELECCIÓN -->
        <div v-if="esReeleccion">

          <label class="block mb-2 font-semibold">
            Nombramiento (PDF)
          </label>
          <input type="file" accept="application/pdf" @change="handleNombramiento"
            class="w-full border rounded px-3 py-2 mb-3" required />

          <label class="block mb-2 font-semibold">
            Carta de reelección (PDF)
          </label>
          <input type="file" accept="application/pdf" @change="handleCarta" class="w-full border rounded px-3 py-2 mb-3"
            required />

          <label class="block mb-2 font-semibold">
            Otros documentos (PDF, opcional)
          </label>
          <input type="file" accept="application/pdf" @change="handleOtros"
            class="w-full border rounded px-3 py-2 mb-3" />

          <p class="text-sm text-yellow-700 mt-2">
            Los documentos serán revisados por un Administrador.
          </p>
        </div>

        <!-- BOTONES -->
        <div class="flex justify-end mt-4">
          <button type="button" @click="$emit('close')" class="px-4 py-2 bg-gray-500 text-white rounded mr-2">
            Cancelar
          </button>

          <button type="submit" class="px-4 py-2 text-white rounded"
            :style="{ backgroundColor: esReeleccion ? '#7A1F32' : '#C7A447' }">
            Guardar
          </button>
        </div>

      </form>
    </div>
  </div>
</template>
