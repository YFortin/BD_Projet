import Vue from "vue";
import Router from "vue-router";
import Signup from "@/components/signup-login/Signup";
import Login from "@/components/signup-login/Login";
import NotFound from "@/components/error/NotFound";
import NavigationBar from "@/components/navigation/NavigationBar";
import UserProfile from "@/components/userprofile/UserProfile";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      redirect: "Signup"
    },
    {
      path: "/nav",
      name: "Navigation",
      component: NavigationBar,
      children: [
        {
          path: "/",
          component: UserProfile
        },
        {
          path: "*",
          name: "NotfoundLog",
          component: NotFound
        }
      ]
    },
    {
      path: "*",
      name: "NotfoundNotLog",
      component: NotFound
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
    }
  ]
});
