<script setup>
import { ref, onMounted } from 'vue';
import { usePage } from '@inertiajs/vue3';

//hacer visible el modal si el usuario debe cambiar la contraseña
const page = usePage();
const visible = ref(false);

onMounted(() => {
    if(
        page.props.mustChangePassword) {
        visible.value = true;
    }
});

function cerrar() {
    visible.value = false;
}
</script>

<template>
    <div v-if="visible" class="fixed inset-0 z-50 flex items-center justify-center bg-black/60">
        <div class="bg-white w-full max-w-lg rounded-lg shadow-lg p-6">
            <h2 class="text-xl font-bold mb-4 text-gray-800">
                Actualizar contraseña
            </h2>

            <div class="text-sm text-gray-600">
                <p>
                    Aviso: Se creó este usuario con una contraseña temporal.
                    Por seguridad, se recomienda actualizar la contraseña para continuar.
                </p>

                <p class="mt-3">
                    Agregar instrucciones (opcional).
                </p>
            </div>

            <div class="flex justify-end mt-6">
                <button @click="cerrar" class="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700">
                    Entendido
                </button>
            </div>
        </div>
    </div>
</template>
