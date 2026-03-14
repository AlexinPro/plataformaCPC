<script setup>
import { ref, watch } from 'vue';

const props = defineProps({
    show: Boolean,
    form: Object,
    editingId: Number,
});

const emit = defineEmits(['close', 'submit']);

const showDiscapacidadTipo = ref(false);
const showGeneroOtro = ref(false);

//resetar modal al abrir
watch(
    () => props.show,
    (open) => {
        if (open) {
            showGeneroOtro.value = false;
            showDiscapacidadTipo.value = !!props.form.discapacidad;

            // limpiar género auxiliar
            props.form.genero_opcion = '';

            // limpiar texto autodescrito
            if (props.form.genero && ![
                'Mujer',
                'Hombre',
                'Prefiero no responder'
            ].includes(props.form.genero)) {
                props.form.genero_opcion = 'Prefiero autodescribirme'
                showGeneroOtro.value = true
            }
        }
    }
);
watch(
    () => props.form.genero_opcion,
    (newVal) => {

        if (newVal === 'Prefiero autodescribirme') {
            showGeneroOtro.value = true;
            props.form.genero = '';
        } else {
            showGeneroOtro.value = false;
            props.form.genero = newVal ?? '';
        }

    }
);
watch(
    () => props.form.discapacidad,
    (newVal) => {

        showDiscapacidadTipo.value = !!newVal;

        if (!newVal) {
            props.form.discapacidad_tipo = '';
        }

    }
);
</script>

<template>
    <div v-if="show" class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
        <div class="bg-white rounded-lg p-6 w-full max-w-md">
            <h2 class="text-lg font-bold mb-4">
                {{ editingId ? 'Editar Integrante' : 'Nuevo Integrante' }}
            </h2>
            <form @submit.prevent="$emit('submit')" class="space-y-4">

                <!-- Nombre -->
                <div>
                    <label class="block text-sm font-medium">Nombre</label>
                    <input v-model="form.nombre" type="text" class="w-full border rounded px-3 py-2" />
                    <p v-if="form.errors.nombre" class="text-red-500 text-sm">{{ form.errors.nombre }}</p>
                </div>

                <!-- Apellido -->
                <div>
                    <label class="block text-sm font-medium">Apellidos</label>
                    <input v-model="form.apellido" type="text" class="w-full border rounded px-3 py-2" />
                    <p v-if="form.errors.apellido" class="text-red-500 text-sm">{{ form.errors.apellido }}</p>
                </div>

                <!-- formula -->
                <div>
                    <label class="block text-sm font-medium">Fórmula</label>
                    <input type="number" min="1"v-model="form.formula" 
                    class="w-full border rounded px-3 py-2" />
                </div>            

                <!-- Cargo -->
                <div>
                    <label class="block text-sm font-medium">Cargo</label>
                    <input v-model="form.puesto" type="text" class="w-full border rounded px-3 py-2" />
                    <p v-if="form.errors.puesto" class="text-red-500 text-sm">{{ form.errors.puesto }}</p>
                </div>

                <!-- Correo -->
                <div>
                    <label class="block text-sm font-medium">Correo</label>
                    <input v-model="form.correo" type="email" class="w-full border rounded px-3 py-2" />
                    <p v-if="form.errors.correo" class="text-red-500 text-sm">{{ form.errors.correo }}</p>
                </div>

                <!-- Colonia -->
                <div>
                    <label class="block text-sm font-medium">Colonia</label>
                    <input v-model="form.colonia" type="text" class="w-full border rounded px-3 py-2" />
                    <p v-if="form.errors.colonia" class="text-red-500 text-sm">{{ form.errors.colonia }}</p>
                </div>

                <!-- GENERO -->
                <div>
                    <label class="block text-sm font-medium">Género</label>
                    <select v-model="form.genero_opcion" class="w-full border rounded px-3 py-2">
                        <option value="">Seleccione</option>
                        <option value="Mujer">Mujer</option>
                        <option value="Hombre">Hombre</option>
                        <option value="Prefiero autodescribirme">Prefiero autodescribirme</option>
                        <option value="Prefiero no responder">Prefiero no responder</option>
                    </select>
                    <p v-if="form.errors.genero" class="text-red-500 text-sm">{{ form.errors.genero }}</p>
                </div>

                <!-- AUTODESCRIBIR -->
                <div v-if="showGeneroOtro">
                    <label class="block text-sm font-medium">Describa su género</label>
                    <input v-model="form.genero" type="text" class="w-full border rounded px-3 py-2"
                        placeholder="Especifique su género" />
                </div>

               <!-- DISCAPACIDAD -->
                <div class="flex items-center space-x-2">

                    <input type="checkbox" v-model="form.discapacidad" class="w-4 h-4" />

                    <label class="text-sm font-medium">Posee discapacidad</label>
                </div>
                <!-- TIPO DISCAPACIDAD -->
                <div v-if="showDiscapacidadTipo">
                    <label class="block text-sm font-medium">Tipo de discapacidad</label>
                    <input v-model="form.discapacidad_tipo" type="text" class="w-full border rounded px-3 py-2" />
                    <p v-if="form.errors.discapacidad_tipo" class="text-red-500 text-sm">

                        {{ form.errors.discapacidad_tipo }}
                    </p>
                </div>
                <!-- BOTONES -->
                <div class="flex justify-end space-x-2">
                    <button type="button" @click="$emit('close')" class="px-4 py-2 bg-gray-300 rounded">
                        Cancelar
                    </button>
                    <button type="submit" class="px-4 py-2 bg-gray-600 text-white rounded hover:bg-black">
                        Guardar
                    </button>
                </div>
            </form>
        </div>
    </div>
</template>
