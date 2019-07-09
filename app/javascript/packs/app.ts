import Vue from "vue";
import Router from "./router/router";
import Header from "./container/Header.vue";
import Vuetify from "vuetify";
import "highlight.js/styles/monokai.css";
import "@fortawesome/fontawesome-free/css/all.css"

Vue.use(Vuetify);
Vue.use(Vuetify, {
  iconfont: "fa"
})

document.addEventListener("turbolinks:load", () => {
  new Vue({
    el: "#app",
    router: Router,
    components: {
      navbar: Header
    }
  });
});
