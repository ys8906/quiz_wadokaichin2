<template>
  <div class="wadokaichin__social-box">
    <div class="wadokaichin__button-box row justify-content-center">
      <div class="wadokaichin__button-box--button ml-n3 fb-like  wadokaichin__social-box--facebook" :data-href="url"
          　data-width="" data-layout="button" data-action="like" data-size="large"
          　data-share="false"></div>
      <span class="m-2"></span>
      <button href="#" @click="twitterShare" class="btn wadokaichin__social-box--tweet">
        <i class="fab fa-twitter fa-lg"></i>
        Tweet
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    url: {
      type: String,
      default: null
    }
  },
  methods:{
    twitterShare(){
      const shareURL =  "https://twitter.com/intent/tweet" +
                        "?text=" + "あなたは解けるかな？" +   // ツイート内容
                        "%20%23和銅開珍" +                  // ハッシュタグ
                        "&url=" + this.url                // シェアURL
      window.open(shareURL, "tweetwindow", "width=650, height=470, personalbar=0,　toolbar=0, scrollbars=1, sizable=1")
    }
  }  
}
</script>
