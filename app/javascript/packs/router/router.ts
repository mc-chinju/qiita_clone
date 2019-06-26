import Vue from "vue/dist/vue.esm.js";
import VueRouter from "vue-router";
import ArticlesContainer from "../container/ArticlesContainer.vue";
import ArticleContainer from "../container/ArticleContainer.vue";
import RegisterContainer from "../container/RegisterContainer.vue";
import LoginContainer from "../container/LoginContainer.vue";
import EditArticleContainer from "../container/EditArticleContainer.vue";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [
    { path: "/", component: ArticlesContainer },
    { path: "/sign_up", component: RegisterContainer },
    { path: "/sign_in", component: LoginContainer },
    { path: "/articles/new", component: EditArticleContainer },
    { path: "/articles/:id", component: ArticleContainer, name: "article" }
  ]
});
