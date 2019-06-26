<template>
  <v-container class="item elevation-3 articles-container"></v-container>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
import TimeAgo from "vue2-timeago";

@Component({
  components: {
    TimeAgo
  }
})
export default class ArticleContainer extends Vue {
  article: any = "";

  async mounted(): Promise<void> {
    await this.fetchArticle("1");
  }

  async fetchArticle(id: string): Promise<void> {
    await axios.get(`/api/v1/articles/${id}`).then(response => {
      this.article = response.data;
    });
  }
}
</script>

<style lang="scss" scoped>
.articles-container {
  margin-top: 2em;
}
</style>