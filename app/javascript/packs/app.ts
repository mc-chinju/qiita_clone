import Vue from "vue/dist/vue.esm";
import Router from "./router/router";
import Header from "./container/Header.vue";

document.addEventListener("turbolinks:load", () => {
  new Vue({
    el: "#app",
    router: Router,
    components: {
      navbar: Header
    }
  });
});
