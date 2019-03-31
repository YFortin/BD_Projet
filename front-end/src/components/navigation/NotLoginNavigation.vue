<template>
  <v-content>
    <v-toolbar>
      <v-toolbar-title>
        Memer
        <div class="subheading">Find your favorites memes</div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn flat to="Login">Log in</v-btn>
        <v-btn flat to="Signup">Sign Up</v-btn>
      </v-toolbar-items>
    </v-toolbar>
    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </v-content>
</template>