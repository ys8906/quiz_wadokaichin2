const { environment } = require('@rails/webpacker')
const { VueLoaderPlugin } = require('vue-loader')
const vue = require('./loaders/vue')
const eslint =  require('./loaders/eslint')

environment.plugins.prepend('VueLoaderPlugin', new VueLoaderPlugin())
environment.loaders.prepend('vue', vue)
environment.loaders.append('eslint', eslint)
environment.config.resolve.alias = { 'vue$': 'vue/dist/vue.esm.js' }
environment.splitChunks()
module.exports = environment
