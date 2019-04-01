<template>
  <v-content>
    <v-toolbar flat color="primary" dark>
      <v-toolbar-side-icon to="Memes" color="accent">
        <v-img src="https://cdn3.iconfinder.com/data/icons/popular-memes/48/JD-26-512.png"></v-img>
      </v-toolbar-side-icon>
      <v-toolbar-title>
        Memer
        <div class="subheading">Find your favorites memes</div>
      </v-toolbar-title>
      <v-spacer></v-spacer>
      <v-toolbar-items>
        <v-btn flat to="Memes">Memes</v-btn>
        <v-btn flat to="MyAccount">My account</v-btn>
        <v-btn flat to="UserProfile">Search User</v-btn>
        <v-btn flat to="../Login">Back to log in</v-btn>
      </v-toolbar-items>
    </v-toolbar>

    <transition name="fade" mode="out-in">
      <router-view></router-view>
    </transition>
  </v-content>
</template>