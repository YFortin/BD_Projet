<template>
  <v-app>
    <v-content>
      <NavigationBar></NavigationBar>
      <router-view></router-view>
    </v-content>
    <v-footer app></v-footer>
  </v-app>
</template>

<script>
import NavigationBar from "./components/navigation/NavigationBar";
export default {
  name: "App",
  components: {
    NavigationBar
  },
  data() {
    return {
      //
    };
  }
};
</script>
