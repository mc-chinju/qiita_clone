<template>
  <form class="article-form">
    <v-text-field outline single-line v-model="title" name="title" label="タイトル" class="title-form"></v-text-field>
    <v-textarea
      outline
      no-resize
      height="100%"
      v-model="body"
      name="body"
      label="プログラミング知識をMarkdown記法で書いて共有しよう"
      class="body-form"
    ></v-textarea>
  </form>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";

const headers = {
  headers: {
    Authorization: "Bearer",
    "Access-Control-Allow-Origin": "*",
    "access-token": localStorage.getItem("access-token"),
    client: localStorage.getItem("client"),
    uid: localStorage.getItem("uid")
  }
};

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
.article-form {
  margin: 5px;
  height: calc(100% - 64px - 10px);
  display: flex;
  flex-flow: column;
}
.title-form {
  flex: none;
}
</style>

<style lang="scss">
.body-form > .v-input__control {
  height: 100%;
}

.v-text-field .v-text-field__details {
  display: none;
}
</style>