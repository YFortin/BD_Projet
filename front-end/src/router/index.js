import Vue from "vue";
import Router from "vue-router";
import Signup from "@/components/signup-login/Signup";
import Login from "@/components/signup-login/Login";
import NotFound from "@/components/Error/NotFound";

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
    },
    {
      path: "/login",
      name: "Login",
      component: Login
    },
    {
      path: "*",
      name: "Not found",
      component: NotFound
    }
  ]
});
