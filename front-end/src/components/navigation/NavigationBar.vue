<template>
  <v-content>
    <v-toolbar flat color="primary" dark>
      <v-toolbar-side-icon to="/Nav/Memes" color="accent">
        <v-img src="https://cdn3.iconfinder.com/data/icons/popular-memes/48/JD-26-512.png"></v-img>
      </v-toolbar-side-icon>
      <v-toolbar-title>
        Memer
        <div class="subheading">Find your favorites memes</div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn flat to="/Nav/Memes">Memes</v-btn>
        <v-btn flat @click="showSearch">Search User</v-btn>
        <v-btn flat to="/Nav/UserProfile">User Profile</v-btn>
        <v-btn flat to="/Nav/MyAccount">My account</v-btn>
        <v-btn flat @click="signout">Sign out</v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <v-expand-transition>
      <SearchBar v-show="show"></SearchBar>
    </v-expand-transition>
    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </v-content>
</template>

<script>
import SearchBar from "../search/SearchBar";

export default {
  data: () => ({
    show: false
  }),
  methods: {
    showSearch() {
      this.show = !this.show;
    },

    signout() {
      document.cookie = "AuthorizationMemer= ; expires = Thu, 01 Jan 1970 00:00:00 GMT";
      this.$router.push('/NotSignedIn/Login');
    }
  },
  components: {
    SearchBar
  }
};
</script>
