<template>
  <div class="row">
    <div class="wadokaichin__half-box col-12 col-md-6">
      <img
        :src="quiz.image_url"
        class="wadokaichin__image"
      >
      <div
        v-if="hasSavedata"
        class="wadokaichin__caption text-warning text-center"
      >
        以前解答した問題です
      </div>
      <!-- AnswerButtons -->
      <div class="wadokaichin__answer-buttons">
        <div class="wadokaichin__button-box row justify-content-center">
          <div class="wadokaichin__button-box--subtitle">
            答え
          </div>
          <input
            v-model="answer"
            class="ml-4 text-center"
            type="text"
            placeholder="回答は1文字です"
            :disabled="answerIsVisible"
            @keypress.enter="checkAnswer"
          >
        </div>
        <div
          id="answer_buttons"
          class="wadokaichin__button-box row justify-content-center"
        >
          <button
            class="wadokaichin__button-box--button btn btn-primary font-weight-bold col-5"
            :disabled="!answer || isCorrect || answerIsVisible"
            @click="checkAnswer"
          >
            解答する
          </button>
          <button
            class="wadokaichin__button-box--show-answer-button btn btn-outline-dark ml-4 col-5"
            :disabled="answerIsVisible"
            @click="showAnswer"
          >
            答えを見る
          </button>
        </div>
      </div>

      <!-- SocialBox -->
      <div class="wadokaichin__social-box">
        <div class="wadokaichin__button-box row justify-content-center">
          <div
            class="wadokaichin__button-box--button ml-n3 fb-like wadokaichin__social-box--facebook"
            :data-href="url"
            data-width=""
            data-layout="button"
            data-action="like"
            data-size="large"
            data-share="false"
          />
          <span class="m-2" />
          <button
            href="#"
            class="btn wadokaichin__social-box--tweet"
            @click="twitterShare"
          >
            <i class="fab fa-twitter fa-lg" />
            Tweet
          </button>
        </div>
      </div>
    </div>

    <div class="wadokaichin__half-box col-12 col-md-6">
      <!-- ResultFlash -->
      <div class="wadokaichin__result-box mb-3">
        <div
          v-if="isCorrect === true"
          class="wadokaichin__result-box--text text-success text-center"
        >
          正解！
        </div>
        <div
          v-else-if="isCorrect === false"
          class="wadokaichin__result-box--text text-warning text-center"
        >
          残念！
        </div>
      </div>

      <!-- AnswerBox -->
      <div
        v-cloak
        class="wadokaichin__answer-box"
      >
        <div v-if="answerIsVisible">
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
        <div v-else>
          <h2 class="wadokaichin__answer-box--text">
            <span
              class="wadokaichin__answer-box--large-letter text-primary"
            >和</span>
            同開珎とは、四つの熟語に共通する、一つの漢字を当てるクイズです。<br>
            漢字を上下左右に四つ並べる様子が、日本最古の貨幣といわれる「和同開珎」に似ているため、
            しばしばなぞらえて同じ名前で呼ばれます。「虫食い漢字クイズ」などとも呼ばれます。
          </h2>
          <div class="wadokaichin__answer-box--text">
            <br>
            <span
              class="wadokaichin__answer-box--large-letter text-primary"
            >画</span>
            像の中央に解答を入力し、「回答する」を押すと、解答結果が現れます。「答えを見る」を押すと、正答と解説が現れます。
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  props: {
    quiz: {
      type: Object,
      default: null,
    },
    meanings: {
      type: Array,
      default: null,
    },
    isSignedIn: {
      type: Boolean,
    },
    hasSavedata: {
      type: Boolean,
    },
    url: {
      type: String,
      default: null,
    },
  },
  data() {
    return {
      isCorrect: null,
      answerIsVisible: null,
      answer: null,
    };
  },
  watch: {
    answerIsVisible() {
      // もしユーザーがログインしていてセーブデータがない場合、正解するか答えを見たらセーブ
      if (this.isSignedIn && !this.hasSavedata) {
        axios.post("../../quiz_wadokaichin_savedata", {
          quiz_id: this.quiz.id,
          correct: false,
        });
      }
    },
  },
  methods: {
    checkAnswer() {
      if (this.answer == this.quiz.answer) {
        this.isCorrect = true;
        this.answerIsVisible = true;
      } else {
        this.isCorrect = false;
      }
    },
    showAnswer() {
      if(!confirm("答えを見ますか？")){
        return
      }
      this.answerIsVisible = true;
    },
    twitterShare() {
      const shareURL =
        "https://twitter.com/intent/tweet" +
        "?text=" +
        "あなたは解けるかな？" + // ツイート内容
        "%20%23和銅開珍" + // ハッシュタグ
        "&url=" +
        this.url; // シェアURL
      window.open(
        shareURL,
        "tweetwindow",
        "width=650, height=470, personalbar=0,　toolbar=0, scrollbars=1, sizable=1"
      );
    },
  },
};
</script>
