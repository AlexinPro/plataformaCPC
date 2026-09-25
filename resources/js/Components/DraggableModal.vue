<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue'

defineProps({
  title: {
    type: String,
    default: 'Modal'
  },
  maxWidth: {
    type: String,
    default: 'max-w-xl'
  }
})

const emit = defineEmits(['close'])
const modal = ref(null)
const position = ref({ x: 0, y: 0 })
const dragging = ref(false)
const offset = ref({ x: 0, y: 0 })

// Centra el modal al abrirlo.
function centrarModal() {
  if (!modal.value) return
  const rect = modal.value.getBoundingClientRect()
  position.value = {
    x: Math.max(16, (window.innerWidth - rect.width) / 2),
    y: Math.max(16, (window.innerHeight - rect.height) / 2)
  }
}

// Inicia el arrastre del modal.
function iniciarArrastre(event) {
  if (event.button !== 0 || !modal.value) return
  const rect = modal.value.getBoundingClientRect()

  offset.value = {
    x: event.clientX - rect.left,
    y: event.clientY - rect.top
  }

  dragging.value = true
  document.addEventListener('pointermove', moverModal)
  document.addEventListener('pointerup', detenerArrastre)
}

// Mueve el modal mientras se arrastra.
function moverModal(event) {
  if (!dragging.value || !modal.value) return

  const rect = modal.value.getBoundingClientRect()
  const maxX = window.innerWidth - rect.width
  const maxY = window.innerHeight - rect.height
  const x = event.clientX - offset.value.x
  const y = event.clientY - offset.value.y
  position.value = {
    x: Math.min(Math.max(0, x), Math.max(0, maxX)),
    y: Math.min(Math.max(0, y), Math.max(0, maxY))
  }
}

// Finaliza el arrastre.
function detenerArrastre() {
  dragging.value = false
  document.removeEventListener('pointermove', moverModal)
  document.removeEventListener('pointerup', detenerArrastre)
}

// Centra el modal cuando se monta.
onMounted(() => {
  centrarModal()
})

// Limpia los eventos al desmontar el componente.
onBeforeUnmount(() => {
  document.removeEventListener('pointermove', moverModal)
  document.removeEventListener('pointerup', detenerArrastre)
})
</script>

<template>
  <div class="fixed inset-0 z-40 bg-black/50">
    <div ref="modal"
      class="fixed z-50 w-[calc(100%-2rem)] max-w-xl rounded-lg bg-white shadow-xl"
      :class="maxWidth"
      :style="{
        left: `${position.x}px`,
        top: `${position.y}px`,
        transform: 'none'}">
      <!-- Barra superior arrastrable -->
      <div class="flex cursor-move select-none items-center justify-between border-b p-5"
        @pointerdown="iniciarArrastre">
        <h2 class="text-xl font-bold text-gray-800">
          {{ title }}
        </h2>

        <button type="button"
          class="cursor-pointer text-2xl text-gray-400 hover:text-gray-700"
          @pointerdown.stop
          @click="emit('close')">
          ×
        </button>
      </div>

      <!-- Contenido del modal -->
      <div class="max-h-[80vh] overflow-y-auto p-5">
        <slot />
      </div>
    </div>
  </div>
</template>