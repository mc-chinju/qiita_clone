<template>
  <v-container class="item elevation-3 articles-container">
    <h2>下書き一覧</h2>
    <v-list two-line>
      <template v-for="(article, index) in articles">
        <v-list-tile :key="article.title" avatar>
          <v-list-tile-avatar>
            <img :src="article.avatar" />
          </v-list-tile-avatar>

          <v-list-tile-content>
            <v-list-tile-title class="article-title">
              <a @click="moveToEditPage(article.id)">{{ article.title }}</a>
            </v-list-tile-title>
            <v-list-tile-sub-title>
              by {{ article.user.name }}
              <time-ago
                :refresh="60"
                :datetime="article.updated_at"
                locale="en"
                tooltip="right"
                long
              ></time-ago>
            </v-list-tile-sub-title>
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
import TimeAgo from "vue2-timeago";
import Router from "../router/router";

const headers = {
  headers: {
    Authorization: "Bearer",
    "Access-Control-Allow-Origin": "*",
    "access-token": localStorage.getItem("access-token"),
    client: localStorage.getItem("client"),
    uid: localStorage.getItem("uid")
  }
};

@Component({
  components: {
    TimeAgo
  }
})
export default class DraftArticlesContainer extends Vue {
  articles: string[] = [];

  async mounted(): Promise<void> {
    await this.fetchArticles();
  }

  async fetchArticles(): Promise<void> {
    await axios.get("/api/v1/articles/drafts", headers).then(response => {
      response.data.map((article: any) => {
        this.articles.push(article);
      });
    });
  }

  moveToEditPage(id: string) {
    Router.push(`/articles/drafts/${id}/edit`);
  }
}
</script>

<style lang="scss" scoped>
.articles-container {
  margin-top: 2em;
  .article-title {
    a {
      color: #000;
      font-weight: bold;
      text-decoration: none;
    }
    a:hover {
      text-decoration: underline;
    }
    a:visited {
      color: #777;
    }
  }
}
</style>