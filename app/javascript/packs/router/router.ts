import Vue from "vue/dist/vue.esm.js";
import VueRouter from "vue-router";
import ArticlesContainer from "../container/ArticlesContainer.vue";
import RegisterContainer from "../container/RegisterContainer.vue";
import LoginContainer from "../container/LoginContainer.vue";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [
    { path: "/", component: ArticlesContainer },
    { path: "/sign_up", component: RegisterContainer },
    { path: "/sign_in", component: LoginContainer }
  ]
});
