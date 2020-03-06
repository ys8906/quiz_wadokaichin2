<template>
  <div class="row">
    <div class="wadokaichin__half-box col-12 col-md-6">
      <img class="wadokaichin__image" :src="quiz.image_url">
      <AnswerButtons
        @check-answer="checkAnswer"
        @show-answer="showAnswer"
        :is-correct="isCorrect"
        :answer-is-visible="answerIsVisible"
      />
      <SocialBox
        :url="url"
      />
    </div>
    <div class="wadokaichin__half-box col-12 col-md-6">
      <Resultflash
        :is-correct="isCorrect"
      />
      <AnswerBox
        :answer-is-visible="answerIsVisible"
        :quiz="quiz"
        v-bind:meanings="meanings"
      />
    </div>
  </div>
</template>

<script>
import AnswerButtons from './quiz_wadokaichin_show/AnswerButtons.vue'
import SocialBox from './quiz_wadokaichin_show/SocialBox.vue'
import Resultflash from './quiz_wadokaichin_show/ResultFlash.vue'
import AnswerBox from './quiz_wadokaichin_show/AnswerBox.vue'

export default {
  components: {
    AnswerButtons,
    SocialBox,
    Resultflash,
    AnswerBox,
  },
  props: {
    quiz: {
      type: Object,
      default: null
    },
    meanings: {
      type: Array,
      default: null
    },
    needSavedata: {
      type: Boolean,
      default: null
    },
    url: {
      type: String,
      default: null
    }
  },
  data() {
    return {
      isCorrect: null,
      answerIsVisible: null,
    }
  },
 	watch: {
		answerIsVisible() {
      console.log("visible")
			// もしユーザーがログインしていてセーブデータがない場合、正解するか答えを見たらセーブ
			if (this.needSavedata) {
				axios.post('../../quiz_wadokaichin_savedata', {
					quiz_id: this.quiz.id,
					correct: false
				})
			}
		}
	},
  methods: {
		checkAnswer(answer) {
			if (answer == this.quiz.answer) {
				this.isCorrect = true
        this.answerIsVisible = true
			} else {
        this.isCorrect = false
			}
    },
    showAnswer() {
      this.answerIsVisible = true
    }    
  }
}
</script>
