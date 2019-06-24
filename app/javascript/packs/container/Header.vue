<template>
  <v-toolbar dark color="#55c500">
    <router-link to="/" class="header-link">
      <v-toolbar-title class="white--text">Qiita</v-toolbar-title>
    </router-link>

    <!-- <v-btn icon>
      <v-icon>search</v-icon>
    </v-btn>-->

    <v-spacer></v-spacer>

    <router-link to="/sign_up" class="header-link">
      <v-btn flat class="register font-weight-bold">ユーザー登録</v-btn>
    </router-link>
    <router-link to="/" class="header-link">
      <v-btn flat class="font-weight-bold">ログイン</v-btn>
    </router-link>
  </v-toolbar>
</template>

<style lang="scss" scoped>
.header-link {
  text-decoration: none;
}

.register {
  border: 2px solid #fff;
  border-radius: 5px;
}

.login {
  font-weight: bold;
}
</style>