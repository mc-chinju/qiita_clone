<template>
  <div id="articles-container">
    <ul>
      <li v-for="article in articles" v-bind:key="article.id">
        <div>{{article.title}}</div>
        <div>{{article.body}}</div>
      </li>
    </ul>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";

@Component
export default class ArticlesContainer extends Vue {
  articles: string[] = [];

  async mounted(): Promise<void> {
    await this.fetchArticles();
  }

  async fetchArticles(): Promise<void> {
    await axios.get("/api/v1/articles").then(response => {
      response.data.map((article: any) => {
        this.articles.push(article);
      });
    });
  }
}
</script>