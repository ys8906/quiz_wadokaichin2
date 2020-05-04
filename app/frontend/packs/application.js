// node modules
require("bootstrap")
require("toastr")

// Fontawesome
import { dom, library } from '@fortawesome/fontawesome-svg-core';
import {
  faTimes,
  faChevronLeft,
  faChevronRight,
  faAngleDoubleLeft,
  faAngleDoubleRight,
  faAngleLeft,
  faAngleRight  
} from "@fortawesome/free-solid-svg-icons"
import {
  faTwitter,
  faGoogle,
  faYahoo,
  faLine 
} from "@fortawesome/free-brands-svg-icons"
library.add(
  faTimes,
  faChevronLeft,
  faChevronRight,
  faAngleDoubleLeft,
  faAngleDoubleRight,
  faAngleLeft,
  faAngleRight,
  faTwitter,
  faGoogle,
  faYahoo,
  faLine
);
dom.watch();

// SCSS
import '../stylesheets/application.scss'

// toastr
import toastr from 'toastr';
toastr.options.positionClass = "toast-bottom-left";
window.toastr = toastr;

// Vue
import Vue from 'vue'
import axios from "axios"
  // CSRFトークンを指定
  axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
  }

  let vms = []
  let options = {}
  const requireContext = require.context('../javascripts', true, /\.js$/)
  requireContext.keys().forEach(key => {
    let name = key.split('/').pop().split('.').shift()
    options[name] = requireContext(key).default
  })
  
  document.addEventListener('DOMContentLoaded', () => {
    let templates = document.querySelectorAll('[data-vue]')
    for (let el of templates) {
      let vm = new Vue(
        Object.assign(options[el.dataset.vue], { el })
      )
      vms.push(vm)
    }
  })