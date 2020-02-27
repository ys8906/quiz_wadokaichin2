// frontend内のファイル読み込み
const images = require.context('../images', true)
import '../stylesheets/application.css'

// Vue
import Vue from 'vue'

// Vuetify
import "vuetify/dist/vuetify.min.css"
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import '@mdi/font/css/materialdesignicons.css'
import Vuetify from 'vuetify'

// main.js
import App from '../App.vue'

Vue.use(Vuetify)
const vuetify = new Vuetify()

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
