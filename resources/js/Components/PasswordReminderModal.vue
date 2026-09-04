<script setup>
import { ref, onMounted } from 'vue';
import { usePage } from '@inertiajs/vue3';

const page = usePage();
const visible = ref(false);

onMounted(() => {
    const passwordReminderShown = sessionStorage.getItem(
        'passwordReminderShown'
    )
    if(
        page.props.mustChangePassword && !passwordReminderShown
    ) {
        visible.value = true;
        sessionStorage.setItem('passwordReminderShown', 'true');
    }
})

function cerrar() {
    visible.value = false;
}
</script>

<template>
    <div class="bg-white w-full max-w-lg rounded-lg shadow-lg p-6"> 
      <div>  
        <h2 class="text-xl font-bold mb-4 text-gray-800">
            Actualizar contraseña
        </h2>
        <div class="text-sm text-gray-600">
            <p>
                Aviso: Se creo este usuario con una contraseña temporal, 
                por seguridad, se recomienda actualizar la contraseña para continuar.
            </p>
            <p>
                agregar instrucciones (pcional)
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
