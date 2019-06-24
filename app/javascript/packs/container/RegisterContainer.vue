<template>
  <form>
    <v-text-field
      v-model="name"
      v-validate="'required|max:10'"
      :counter="10"
      :error-messages="errors.collect('name')"
      label="ユーザー名"
      data-vv-name="name"
      required
    ></v-text-field>
    <v-text-field
      v-model="email"
      v-validate="'required|email'"
      :error-messages="errors.collect('email')"
      label="メールアドレス"
      data-vv-name="email"
      required
    ></v-text-field>
    <v-text-field
      v-model="password"
      :append-icon="show ? 'visibility' : 'visibility_off'"
      :type="show ? 'text' : 'password'"
      v-validate="'required|min:8|max:50'"
      :error-messages="errors.collect('password')"
      name="password"
      label="パスワード"
      hint="At least 8 characters"
      counter
      @click:append="show = !show"
    ></v-text-field>

    <v-btn @click="submit" color="#55c500" class="white--text font-weight-bold">登録</v-btn>
  </form>
</template>

<script lang="ts">
import { Vue, Component } from "vue-property-decorator";
import VeeValidate from "vee-validate";

Vue.use(VeeValidate, { locale: "ja" });

@Component
export default class RegisterContainer extends Vue {
  $_veeValidate: {
    validator: "new";
  };

  name: string = "";
  email: string = "";
  show: boolean = false;
  password: string = "";
  dictionary: {
    attributes: {
      email: "Email Addresss";
    };
    custom: {
      name: {
        required: () => "Name can not be empty";
        max: "The name field may not be greater than 10 characters";
      };
    };
  };

  mounted() {
    this.$validator.localize("en", this.dictionary);
  }

  submit() {
    this.$validator.validateAll();
  }
  clear() {
    this.name = "";
    this.email = "";
    this.$validator.reset();
  }
}
</script>

<style lang="scss" scoped>
</style>