<template>
  <div class="wadokaichin__result-box mb-3">
    <div
      v-if="isCorrect == true"
      class="wadokaichin__result-box--text text-success text-center"
    >
      正解！
    </div>
    <div
      v-else-if="isCorrect == false"
      class="wadokaichin__result-box--text text-warning text-center"
    >
      残念！
    </div>
    <!-- 回答前も空白文字でスペースを確保 -->
    <div v-else
      class="wadokaichin__result-box--text">ㅤ</div>
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
