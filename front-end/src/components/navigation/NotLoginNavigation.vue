<template>
  <v-content>
    <v-toolbar flat color="primary" dark>
      <v-toolbar-title>
        Memer
        <div class="subheading">Find your favorites memes</div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn flat to="/NotSignedIn/Login">Log in</v-btn>
        <v-btn flat to="/NotSignedIn/Signup">Sign Up</v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </v-content>
</template>