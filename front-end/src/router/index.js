import Vue from "vue";
import Router from "vue-router";
import Signup from "@/components/signup-login/Signup";
import Login from "@/components/signup-login/Login";
import NotFound from "@/components/error/NotFound";
import NavigationBar from "@/components/navigation/NavigationBar";
import UserProfile from "@/components/userprofile/UserProfile";
import Memes from "@/components/memes/Memes";
import NotLoginNavigation from "@/components/navigation/NotLoginNavigation";
import MyAccount from "@/components/userprofile/MyAccount";

Vue.use(Router);

export default new Router({
  routes: [
    {
      path: "/",
      redirect: "Login"
    },
    {
      path: "/nav",
      component: NavigationBar,
      name: "Nav",
      redirect: "NotFoundLogin ",
      children: [
        {
          path: "userprofile",
          name: "UserProfile",
          component: UserProfile
        },
        {
          path: "myaccount",
          name: "MyAccount",
          component: MyAccount
        },
        {
          path: "memes",
          name: "Memes",
          component: Memes
        },
        {
          path: "*",
          name: "NotFoundLogin",
          component: NotFound
        }
      ]
    },
    {
      path: "/notsignin",
      name: "NotSignedIn",
      component: NotLoginNavigation,
      children: [
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
    },
    {
      path: "*",
      component: NotFound
    }
  ]
});
