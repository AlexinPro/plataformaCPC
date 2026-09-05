<script setup>
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';

import { useForm } from '@inertiajs/vue3';
import { ref } from 'vue';

import Swal from 'sweetalert2';

import {
    EyeIcon,
    EyeSlashIcon,
} from '@heroicons/vue/24/outline';


const passwordInput = ref(null);
const currentPasswordInput = ref(null);


// *Variables para mostrar/ocultar las contraseñas*

const showCurrentPassword = ref(false);
const showPassword = ref(false);
const showPasswordConfirmation = ref(false);


const form = useForm({
    current_password: '',
    password: '',
    password_confirmation: '',
});


const updatePassword = () => {
    form.put(route('password.update'), {
        preserveScroll: true,

        onSuccess: () => {
            form.reset();

            // *Ocultar nuevamente las contraseñas después de actualizar*
            showCurrentPassword.value = false;
            showPassword.value = false;
            showPasswordConfirmation.value = false;

            Swal.fire({
                icon: 'success',
                title: 'Contraseña actualizada',
                text: 'Tu contraseña se ha actualizado correctamente.',
                confirmButtonText: 'Aceptar',
            });
        },

        onError: () => {

            if (form.errors.password) {
                form.reset(
                    'password',
                    'password_confirmation'
                );

                passwordInput.value?.focus();
            }


            if (form.errors.current_password) {
                form.reset('current_password');

                currentPasswordInput.value?.focus();
            }
        },
    });
};
</script>


<template>
    <section>
        <header>
            <h2 class="text-lg font-medium text-gray-900">
                Reestablecer contraseña
            </h2>

            <p class="mt-1 text-sm text-gray-600">
                Puedes reestablecer tu contraseña actualizando el formulario a continuación:
            </p>
        </header>


        <form @submit.prevent="updatePassword" class="mt-6 space-y-6">

            <!-- Contraseña actual -->
            <div>
                <InputLabel for="current_password" value="Contraseña actual"/>
                <div class="relative mt-1">
                    <TextInput
                        id="current_password"
                        ref="currentPasswordInput"
                        v-model="form.current_password"
                        :type="showCurrentPassword ? 'text' : 'password'"
                        class="block w-full pr-10"
                        autocomplete="current-password"/>
                    <button
                        type="button"
                        @click="showCurrentPassword = !showCurrentPassword"
                        class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500 hover:text-gray-700"
                        aria-label="Mostrar u ocultar contraseña">

                        <EyeSlashIcon v-if="showCurrentPassword" class="w-5 h-5"/>
                        <EyeIcon v-else class="w-5 h-5"/>
                    </button>
                </div>
                <InputError :message="form.errors.current_password" class="mt-2"/>
            </div>

            <!-- Nueva contraseña -->
            <div>
                <InputLabel for="password" value="Nueva contraseña"/>
                <div class="relative mt-1">
                    <TextInput
                        id="password"
                        ref="passwordInput"
                        v-model="form.password"
                        :type="showPassword ? 'text' : 'password'"
                        class="block w-full pr-10"
                        autocomplete="new-password"/>

                    <button
                        type="button"
                        @click="showPassword = !showPassword"
                        class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500 hover:text-gray-700"
                        aria-label="Mostrar u ocultar contraseña">
                        <EyeSlashIcon v-if="showPassword" class="w-5 h-5"/>
                        <EyeIcon v-else class="w-5 h-5"/>
                    </button>
                </div>
                <InputError
                    :message="form.errors.password"
                    class="mt-2"
                />
            </div>


            <!-- Confirmar nueva contraseña -->
            <div>
                <InputLabel
                    for="password_confirmation"
                    value="Repetir nueva contraseña"/>
                <div class="relative mt-1">
                    <TextInput
                        id="password_confirmation"
                        v-model="form.password_confirmation"
                        :type="showPasswordConfirmation ? 'text' : 'password'"
                        class="block w-full pr-10"
                        autocomplete="new-password"/>

                    <button
                        type="button"
                        @click="showPasswordConfirmation = !showPasswordConfirmation"
                        class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500 hover:text-gray-700"
                        aria-label="Mostrar u ocultar contraseña">
                        <EyeSlashIcon v-if="showPasswordConfirmation"class="w-5 h-5"/>
                        <EyeIcon v-else class="w-5 h-5"/>
                    </button>
                </div>
                <InputError :message="form.errors.password_confirmation" class="mt-2"/>
            </div>

            <!-- Botón -->
            <div class="flex items-center gap-4">
                <PrimaryButton :disabled="form.processing">
                    Guardar
                </PrimaryButton>
            </div>
        </form>
    </section>
</template>