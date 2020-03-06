<template>
  <div class="mb-3">
    <h3
      v-if="isCorrect == true"
      class="text-success text-center"
    >
      正解！
    </h3>
    <h3
      v-else-if="isCorrect == false"
      class="text-warning text-center"
    >
      残念！
    </h3>
    <h3 v-else >ㅤ</h3>
  </div>
</template>

<script>
export default {
  props: {
    isCorrect: {
      type: Boolean,
      default: null
    }
  }
}
</script>
