<template>
  <div
    @click="$emit('close')"
  >
    <div class="modal__mask">
      <div class="modal__wrapper">
        <div
          class="modal__container"
          @click="stopCloseModal"
        >
          <button
            class="modal__container--close"
            @click="$emit('close')"
          >
            <i class="fas fa-times" />
          </button>

          <div class="modal__header">
            <slot name="modal__header" />
          </div>

          <div class="modal__body">
            <slot
              name="modal__body"
              @close="closeModal"
            />
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return { showModal: false }
  },
  methods:{
    stopCloseModal(e) {
      e.stopPropagation()
    }
  }
}
</script>