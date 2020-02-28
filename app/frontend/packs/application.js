// frontend内のファイル読み込み
const images = require.context('../images', true)
import '../stylesheets/application.scss'

// Bootstrap
require("jquery")
require("bootstrap")

// Vue
import Vue from 'vue'
window.Vue = Vue
import App from '../App.vue'

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
