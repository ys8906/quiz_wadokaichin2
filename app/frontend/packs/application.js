// Frontend modules
require("jquery")
require("@fortawesome/fontawesome-free")
require("bootstrap")

// frontend内のファイル読み込み
const images = require.context('../images', true)
import '../stylesheets/application.scss'
import '../javascripts/infinite-loading.pkgd.min'

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

import App from '../App.vue'
document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})