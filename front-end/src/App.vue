<template>
  <v-app>
    <v-content>
      <Signup/>
    </v-content>
  </v-app>
</template>

<script>
import Signup from "./components/signup-login/Signup";

export default {
  name: "App",
  components: {
    Signup
  },
  data() {
    return {
      //
    };
  }
};
</script>
