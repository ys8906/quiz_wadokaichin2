<template>
  <v-app id="app">
    <Header/>
    <h1>App.vue</h1>
    <p>{{ message }}</p>
  </v-app>
</template>

<script>
// Components
import Header from "./components/Header";

export default {
  name: 'App',
  components: {
    Header,
  },
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
