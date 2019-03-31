import Vue from "vue";
import Router from "vue-router";
import Signup from "@/components/signup-login/Signup";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      redirect: "Signup"
    },
    {
      path: "/signup",
      name: "Signup",
      component: Signup
    }
  ]
});
