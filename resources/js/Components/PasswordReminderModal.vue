<script setup>
import { ref, computed, onMounted } from 'vue';
import { useForm, usePage } from '@inertiajs/vue3';
import InputError from '@/Components/InputError.vue';
import InputLabel from '@/Components/InputLabel.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import TextInput from '@/Components/TextInput.vue';
import { EyeIcon, EyeSlashIcon } from '@heroicons/vue/24/outline';

const page = usePage();
const visible = ref(false);
const showPassword = ref(false);
const showPasswordConfirmation = ref(false);
const passwordInput = ref(null);
const passwordConfirmationInput = ref(null);

const form = useForm({
    password: '',
    password_confirmation: '',
});

const passwordsDoNotMatch = computed(() => {
    return form.password_confirmation.length > 0 && form.password !== form.password_confirmation;
});

onMounted(() => {
  if (page.props.mustChangePassword) {
    visible.value = true;
  }
});

const updatePassword = () => {
    if (passwordsDoNotMatch.value) {
        passwordConfirmationInput.value?.focus();
        return;  
    }
    form.put(route('password.force-update'), {
        preserveScroll: true,
        onSuccess: () => {
            form.reset();
            showPassword.value = false;
            showPasswordConfirmation.value = false;
            visible.value = false;
        },
        onError: () => {
            if (form.errors.password) {
                form.reset('password', 'password_confirmation');
                showPassword.value = false;
                showPasswordConfirmation.value = false;
                passwordInput.value?.focus();
            }

            if (form.errors.password_confirmation) {
                passwordConfirmationInput.value?.focus();
            }
        },
    });
};
</script>


<template>
  <div v-if="visible" class="fixed inset-0 z-50 flex items-center justify-center bg-black/60">
    <div class="bg-white w-full max-w-lg rounded-lg shadow-lg p-6" role="dialog" aria-modal="true" aria-labelledby="password-reminder-title">
      <h2 id="password-reminder-title" class="text-xl font-bold mb-4 text-gray-800">
        Actualizar contraseña
      </h2>

      <div class="text-sm text-gray-600 mb-6">
        <p>
          Se creó este usuario con una contraseña temporal.
          Por seguridad, debes establecer una nueva contraseña para continuar.
        </p>
      </div>

      <form @submit.prevent="updatePassword" class="space-y-5">
        <!-- Nueva contraseña -->
        <div>
          <InputLabel for="reminder-password" value="Nueva contraseña" />
          <div class="relative mt-1">
            <TextInput id="reminder-password" ref="passwordInput" v-model="form.password" :type="showPassword ? 'text' : 'password'" class="block w-full pr-10" autocomplete="new-password" :disabled="form.processing" />
            <button type="button" @click="showPassword = !showPassword" class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500 hover:text-gray-700" aria-label="Mostrar u ocultar contraseña">
              <EyeSlashIcon v-if="showPassword" class="w-5 h-5" />
              <EyeIcon v-else class="w-5 h-5" />
            </button>
          </div>
          <InputError :message="form.errors.password" class="mt-2" />
        </div>

        <!-- Confirmar contraseña -->
        <div>
          <InputLabel for="reminder-password-confirmation" value="Repetir nueva contraseña" />
          <div class="relative mt-1">
            <TextInput id="reminder-password-confirmation" ref="passwordConfirmationInput" v-model="form.password_confirmation" :type="showPasswordConfirmation ? 'text' : 'password'" class="block w-full pr-10" autocomplete="new-password" :disabled="form.processing" />
            <button type="button" @click="showPasswordConfirmation = !showPasswordConfirmation" class="absolute inset-y-0 right-0 flex items-center px-3 text-gray-500 hover:text-gray-700" aria-label="Mostrar u ocultar contraseña">
              <EyeSlashIcon v-if="showPasswordConfirmation" class="w-5 h-5" />
              <EyeIcon v-else class="w-5 h-5" />
            </button>
          </div>
          <p v-if="passwordsDoNotMatch" class="mt-2 text-sm text-red-600">
            Las contraseñas no coinciden.
          </p>
          <InputError v-else :message="form.errors.password_confirmation" class="mt-2" />
        </div>

        <!-- Botón -->
        <div class="flex justify-end pt-2">
          <PrimaryButton :disabled="form.processing || passwordsDoNotMatch || !form.password || !form.password_confirmation">
            <span v-if="form.processing">Actualizando...</span>
            <span v-else>Actualizar contraseña</span>
          </PrimaryButton>
        </div>
      </form>
    </div>
  </div>
</template> 