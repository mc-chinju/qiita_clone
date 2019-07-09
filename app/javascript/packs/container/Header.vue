<template>
  <v-toolbar dark color="#55c500">
    <router-link to="/" class="header-link">
      <v-toolbar-title class="white--text font-weight-bold">Qiita</v-toolbar-title>
    </router-link>

    <v-spacer></v-spacer>

    <div v-if="isLoggedIn">
      <router-link to="/articles/new" class="header-link">
        <v-btn flat class="post font-weight-bold">投稿する</v-btn>
      </router-link>
      <v-menu bottom left min-width="120">
        <template v-slot:activator="{ on }">
          <v-btn dark icon v-on="on">
            <v-icon>more_vert</v-icon>
          </v-btn>
        </template>

        <v-list>
          <v-list-tile v-for="(menu, i) in menus" :key="i" @click="undefined">
            <v-list-tile-title @click="menu.click">{{ menu.title }}</v-list-tile-title>
          </v-list-tile>
        </v-list>
      </v-menu>
    </div>
    <div v-else>
      <router-link to="/sign_up" class="header-link">
        <v-btn flat class="register font-weight-bold">ユーザー登録</v-btn>
      </router-link>
      <router-link to="/sign_in" class="header-link">
        <v-btn flat class="font-weight-bold">ログイン</v-btn>
      </router-link>
    </div>
  </v-toolbar>
</template>

<script lang="ts">
import axios from "axios";
import { Vue, Component } from "vue-property-decorator";
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

@Component
export default class Header extends Vue {
  isLoggedIn: boolean = !!localStorage.getItem("access-token");
  items: any = [
    { title: "Menu" },
    { title: "Menu" },
    { title: "Menu" },
    { title: "Menu" }
  ];
  menus: any = [
    {
      title: "マイページ",
      click: () => {
        this.moveToMyPage();
      }
    },
    {
      title: "下書き一覧",
      click: () => {
        this.moveToDrafts();
      }
    },
    {
      title: "ログアウト",
      click: () => {
        this.logout();
      }
    }
  ];

  async logout(): Promise<void> {
    await axios
      .delete("/api/v1/auth/sign_out", headers)
      .then(_response => {
        this.refresh();
      })
      .catch(e => {
        // TODO: 適切な Error 表示
        alert(e.response.data.errors);

        // localStorage は残っているが、
        // ログアウトはしてしまっている状態なのですべてリセットする
        this.refresh();
      });
  }

  moveToMyPage(): void {
    Router.push("/mypage");
  }

  moveToDrafts(): void {
    Router.push("/articles/drafts");
  }

  private refresh(): void {
    localStorage.clear();
    Router.push("/");
    // TODO: Vuex でログイン状態を管理するようになったら消す
    window.location.reload();
  }
}
</script>

<style lang="scss" scoped>
.header-link {
  text-decoration: none;
}

.register,
.post {
  border: 2px solid #fff;
  border-radius: 5px;
}

.login {
  font-weight: bold;
}
</style>