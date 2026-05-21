<script setup>
import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout.vue'
import { Head, Link } from '@inertiajs/vue3'
import { defineComponent, h } from 'vue'

defineProps({
  consejos: Array,
  origen: String,
})

//Iconos importados desde Google Fonts
const PetsIcon = defineComponent({
  name: 'PetsIcon',
  render() {
    return h(
      'span',
      { class: 'material-icons text-white text-5xl' },
      'pets'
    )
  }
})

const SportsSoccerIcon = defineComponent({
  name: 'SportsSoccerIcon',
  render() {
    return h(
      'span',
      { class: 'material-symbols-outlined text-white text-5xl' },
      'sports_soccer'
    )
  }
})

const AccesibleIcon = defineComponent({
  name: 'AccesibleIcon',
  render() {
    return h(
      'span',
      { class: 'material-symbols-outlined text-white text-5xl' },
      'accessible_forward'
    )
  }
})

const ElectricCarIcon = defineComponent({
  name: 'ElectricCarIcon',
  render() {
    return h(
      'span',
      { class: 'material-symbols-outlined text-white text-5xl' },
      'electric_car'
    )
  }
})

const LocalPoliceIcon = defineComponent({
  name: 'LocalPoliceIcon',
  render() {
    return h(
      'span',
      { class: 'material-symbols-outlined text-white text-5xl' },
      'local_police'
    )
  }
})

const ElderlyWomenIcon = defineComponent({
  name: 'ElderlyWomenIcon',
  render() {
    return h(
      'span',
      { class: 'material-symbols-outlined text-white text-5xl' },
      'elderly_woman'
    )
  }
})

const PersonSieldIcon = defineComponent({
  name: 'PersonSieldIcon',
  render() {
    return h(
      'span',
      { class: 'material-symbols-outlined text-white text-5xl' },
      'person_shield'
    )
  }
})

import {
  SunIcon,
  GlobeAmericasIcon,
  FaceSmileIcon,
  UserGroupIcon,
  UsersIcon,
  MusicalNoteIcon,
  HeartIcon,
  BuildingOfficeIcon,
  BuildingOffice2Icon,
  HandRaisedIcon,
  TruckIcon,
  WrenchScrewdriverIcon,
  BriefcaseIcon,
  AcademicCapIcon,
  MapPinIcon,
} from '@heroicons/vue/24/solid'

const normalize = (text) =>
  text?.trim().toLowerCase()

const icons = {
  'asuntos indígenas': SunIcon,
  'bienestar': FaceSmileIcon,
  'bienestar animal': PetsIcon,
  'centro histórico y patrimonio edificado': BuildingOfficeIcon,
  'cultura': MusicalNoteIcon,
  'deporte': SportsSoccerIcon,
  'derechos humanos e igualdad entre géneros': HandRaisedIcon,
  'desarrollo urbano': BuildingOffice2Icon,
  'desempeño gubernamental': BriefcaseIcon,
  'discapacidad': AccesibleIcon,
  'ecología y medio ambiente': GlobeAmericasIcon,
  'educación': AcademicCapIcon,
  'juventud': UserGroupIcon,
  'niñez y la adolescencia': UsersIcon,
  'obras y servicios públicos': WrenchScrewdriverIcon,
  'movilidad': ElectricCarIcon,
  'personas en situación de vulnerabilidad': ElderlyWomenIcon,
  'protección civil': PersonSieldIcon,
  'salud': HeartIcon,
  'seguridad pública': LocalPoliceIcon,
  'turismo': MapPinIcon,
  'vialidad y transporte': TruckIcon,
}
</script>

<template>
  <AuthenticatedLayout>
    <Head title="Archivo Digital" />

    <div class="p-4 sm:p-8 bg-white shadow sm:rounded-lg">

      <!-- TÍTULO DINÁMICO -->
      <h1 class="text-2xl font-bold mb-6 text-center">
        {{
          origen === 'asistencias'
            ? 'Asistencias y Participación'
            : origen === 'convocatorias'
              ? 'Convocatorias y sesiones'
              : origen === 'reportes'
                ? 'Reportes'
                : origen === 'legalidad'
                  ? 'Periodo en el cargo'
                  : 'Archivo Digital'
        }}
      </h1>

      <div class="grid grid-cols-2 md:grid-cols-4 gap-4">
        <Link
          v-for="consejo in consejos"
          :key="consejo.id"
          :href="
            origen === 'convocatorias'
              ? route('convocatorias.index', { consejo: consejo.id })
              : origen === 'asistencias'
                ? route('asistencias.index', { consejo: consejo.id })
                : origen === 'reportes'
                  ? route('reportes.consejo', { consejo: consejo.id })
                  : origen === 'legalidad'
                    ? route('legalidad.index', { consejo: consejo.id })
                    : route('consejos.integrantes', consejo.id)
          "
          class="p-4 shadow rounded-lg flex flex-col items-center justify-center
                 font-semibold text-center text-white bg-gray-600 hover:bg-black transition">

          <component
            :is="icons[normalize(consejo.nombre)] || AcademicCapIcon"
            class="w-10 h-10 text-white mb-2"/>

          {{ consejo.nombre }}
        </Link>
      </div>

    </div>
  </AuthenticatedLayout>
</template>
