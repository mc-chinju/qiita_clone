import Vue from "vue/dist/vue.esm.js";
import VueRouter from "vue-router";
import ArticlesContainer from "../container/ArticlesContainer.vue";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [{ path: "/", component: ArticlesContainer }]
});
