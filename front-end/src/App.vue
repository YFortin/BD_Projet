<template>
  <v-app>
    <v-content>
      <transition name="fade" mode="out-in">
        <router-view></router-view>
      </transition>
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

<style>
.fade-enter-active,
.fade-leave-active {
  transition-duration: 0.3s;
  transition-property: opacity;
  transition-timing-function: ease;
}

.fade-enter,
.fade-leave-active {
  opacity: 0;
}
</style>

