import Vue from "vue";
import Router from "./router/router";
import Header from "./container/Header.vue";
import Vuetify from "vuetify";

Vue.use(Vuetify);

document.addEventListener("turbolinks:load", () => {
  new Vue({
    el: "#app",
    router: Router,
    components: {
      navbar: Header
    }
  });
});
