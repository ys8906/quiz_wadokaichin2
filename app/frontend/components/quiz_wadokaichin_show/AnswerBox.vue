<template>
  <div class="wadokaichin__answer-box">
    <div
      v-if="answerIsVisible"
    >
      <div class="wadokaichin__answer-box--text">
        答え：
        <span class="wadokaichin__answer-box--large-letter">
          {{ quiz.answer }}
        </span>
      </div>
      <div class="wadokaichin__answer-box--text">
        <br>
        <span class="wadokaichin__answer-box--large-letter">
          {{ quiz.jukugo_right_name }}：
        </span>
        <br>
        {{ meanings[0] }}
      </div>
      <div class="wadokaichin__answer-box--text">
        <br>
        <span class="wadokaichin__answer-box--large-letter">
          {{ quiz.jukugo_bottom_name }}：
        </span>
        <br>
        {{ meanings[1] }}
      </div>
      <div class="wadokaichin__answer-box--text">
        <br>
        <span class="wadokaichin__answer-box--large-letter">
          {{ quiz.jukugo_left_name }}：
        </span>
        <br>
        {{ meanings[2] }}
      </div>
      <div class="wadokaichin__answer-box--text">
        <br>
        <span class="wadokaichin__answer-box--large-letter">
          {{ quiz.jukugo_top_name }}：
        </span>
        <br>
        {{ meanings[3] }}
      </div>
    </div>
    <div
      v-else
    >
      <div class="wadokaichin__answer-box--text">
        <span class="wadokaichin__answer-box--large-letter text-primary">和</span>
        同開珎とは、四つの熟語に共通する、一つの漢字を当てるクイズです。<br>
        漢字を上下左右に四つ並べる様子が、日本最古の貨幣といわれる「和同開珎」に似ているため、
        しばしばなぞらえて同じ名前で呼ばれます。「虫食い漢字クイズ」などとも呼ばれます。
      </div>
      <div class="wadokaichin__answer-box--text">
        <br>
        <span class="wadokaichin__answer-box--large-letter text-primary">画</span>
        像の中央に解答を入力し、「回答する」を押すと、解答結果が現れます。「答えを見る」を押すと、正答と解説が現れます。
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    quiz: {
      type: Object,
      default: null
    },
    meanings: {
      type: Array,
      default: null
    },
    answerIsVisible: {
      type: Boolean,
      default: null
    },
  }
}
</script>
