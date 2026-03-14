<script setup>
import { ref, computed, onMounted } from 'vue'
import { usePage, useForm } from '@inertiajs/vue3'

const page = usePage()
const form = useForm({})

// visible si el usuario NO ha aceptado
const visible = ref(false)

onMounted(() => {
    const avisoMostrado = sessionStorage.getItem('privacyShown')
    if (!page.props.privacyAccepted && !avisoMostrado) {
        visible.value = true
        sessionStorage.setItem('privacyShown', 'true')
    }
})
// aceptar aviso
function aceptar() {
    form.post(route('privacy.accept'), {
        preserveScroll: true,
        onSuccess: () => {
            visible.value = false
        }
    })
}

// rechazar aviso
function rechazar() {
    window.location.href = '/logout'
}
</script>

<template>

<div v-if="visible"
class="fixed inset-0 z-50 flex items-center justify-center bg-black/60">
    <div class="bg-white w-full max-w-2xl rounded-lg shadow-lg p-6">
        <h2 class="text-xl font-bold mb-4 text-gray-800">
            Aviso de Privacidad
        </h2>
        <div class="text-sm text-gray-600 max-h-72 overflow-y-auto border p-3 rounded">

            <p class="mb-3">
            Este sistema administra información personal de los integrantes de los consejos.
            Los datos serán utilizados exclusivamente para fines administrativos, estadísticos
            y de gestión institucional.
            </p>

            <p class="mb-3">
            Al continuar utilizando el sistema usted acepta el tratamiento de los datos
            conforme a la normativa aplicable en materia de protección de datos personales.
            </p>
            <p>

            Si no está de acuerdo con el tratamiento de sus datos, deberá abandonar
            el sistema inmediatamente.
            </p>
        </div>

        <div class="flex justify-end gap-3 mt-6">
            <button
            @click="rechazar"
            class="px-4 py-2 bg-red-500 text-white rounded hover:bg-red-600">
            Rechazar
            </button>
            <button
            @click="aceptar"
            class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
            Aceptar
            </button>
        </div>
    </div>
</div>
</template>