<template>
  <div>
    <div class="wadokaichin__button-box row justify-content-center">
      <div class="wadokaichin__button-box--subtitle">答え</div>
      <input
        v-model="answer"
        class="ml-4"
        type="text"
        placeholder="回答は1文字です。"
      >
    </div>
    <div id="answer_buttons" class="wadokaichin__button-box row justify-content-center">
      <button
        class="wadokaichin__button-box--button btn btn-primary font-weight-bold col-5"
        @click="$emit('check-answer', answer)"
        :disabled="!answer || isCorrect || answerIsVisible"
      >
        解答する
      </button>
      <button
        class="wadokaichin__button-box--button btn btn-outline-dark ml-4 col-5"
        @click="$emit('show-answer', answer)"
        :disabled="answerIsVisible"
      >
        答えを見る
      </button>
    </div>    
  </div>
</template>

<script>
export default {
  props: {
    answerIsVisible: {
      type: Boolean,
      default: null
    },
    isCorrect: {
      type: Boolean,
      default: null
    }
  },  
  data: function() {
    return {
      answer: null,
    }
  }
}
</script>
