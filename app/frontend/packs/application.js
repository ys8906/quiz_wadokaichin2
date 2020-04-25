// node modules
// require("jquery")
require("@fortawesome/fontawesome-free")
require("bootstrap")
require("toastr")

// frontend内のファイル
import '../stylesheets/application.scss'

// toastr
import toastr from 'toastr';
toastr.options.positionClass = "toast-bottom-left";
window.toastr = toastr;

// Vue
import Vue from 'vue'
window.Vue = Vue

  // Axios
  import axios from "axios"
    // CSRFトークンを指定
    axios.defaults.headers.common = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    }
    // viewでのエイリアス設定
    window.axios = axios

  // Components
  import QuizWadokaichinShow from '../components/QuizWadokaichinShow.vue'
    // 読み込みを遅らせる
    window.onload = function() {
      new Vue({
        el: 'quiz-wadokaichin-show',
        components: {
          QuizWadokaichinShow
        }
      })
    }

  //// For SPA
  // import App from '../App.vue'
  // document.addEventListener('DOMContentLoaded', () => {
  //   const app = new Vue({
  //     render: h => h(App)
  //   }).$mount()
  //   document.body.appendChild(app.$el)
  
  //   console.log(app)
  // })