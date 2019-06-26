<template>
  <v-container class="item elevation-3 articles-container">
    <v-list two-line>
      <template v-for="(article, index) in articles">
        <v-list-tile :key="article.title" avatar>
          <v-list-tile-avatar>
            <img :src="article.avatar">
          </v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title>{{ article.title }}</v-list-tile-title>
            <v-list-tile-sub-title>by {{ article.user.name }} {{ article.updated_at }}</v-list-tile-sub-title>
          </v-list-tile-content>
        </v-list-tile>
        <v-divider :key="index"></v-divider>
      </template>
    </v-list>
  </v-container>
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

<style lang="scss" scoped>
.articles-container {
  margin-top: 2em;
}
</style>