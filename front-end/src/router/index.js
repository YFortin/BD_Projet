import Vue from 'vue';
import Router from 'vue-router';
import Signup from '@/components/signup-login/Signup';
import Login from '@/components/signup-login/Login';
import NotFound from '@/components/error/NotFound';
import NavigationBar from '@/components/navigation/NavigationBar';
import UserProfile from '@/components/userprofile/UserProfile';
import Memes from '@/components/memes/Memes';
import NotLoginNavigation from '@/components/navigation/NotLoginNavigation';
import MyAccount from '@/components/userprofile/MyAccount';
import MemerAPI from "../js/MemerAPI";

Vue.use(Router);

const router = new Router({
  routes: [
    {
      path: '/',
      redirect: '/Nav/UserProfile'
    },
    {
      path: '/nav',
      component: NavigationBar,
      name: 'Nav',
      redirect: 'NotFoundLogin ',
      meta: { requiresAuth: true },
      children: [
        {
          path: 'userprofile/:username',
          name: 'UserProfile',
          component: UserProfile
        },
        {
          path: 'myaccount/',
          name: 'MyAccount',
          component: MyAccount
        },
        {
          path: 'memes',
          name: 'Memes',
          component: Memes
        },
        {
          path: '*',
          name: 'NotFoundLogin',
          component: NotFound
        }
      ]
    },
    {
      path: '/notsignedin',
      name: 'NotSignedIn',
      component: NotLoginNavigation,
      meta: { unsigned: true },
      children: [
        {
          path: 'signup',
          name: 'Signup',
          component: Signup
        },
        {
          path: 'login',
          name: 'Login',
          component: Login
        },
        {
          path: '*',
          name: 'NotfoundNotLog',
          component: NotFound
        }
      ]
    },
    {
      path: '*',
      component: NotFound
    }
  ]
});

export default router;

router.beforeEach( async(to, from, next) => {

  const autorization = document.cookie
  .split(';')
  .filter(item => item.trim().startsWith('AuthorizationMemer=')).length;

  // const validation = await MemerAPI.User.validateToken();

  const validation = {
    'status': 200
  }

  console.log(validation);

  if (to.matched.some(route => route.meta.requiresAuth)) {
    if (!autorization) {
      router.push({path: '/NotSignedIn/Login'})
    } else if(validation.status == 200) {
      next()
    } else {
      router.push({path: '/NotSignedIn/Login'})
    }
} else if (to.matched.some(route => route.meta.unsigned)) {
  if (!autorization) {
    next()
  } else if (validation.status == 200) {
    router.push({path: '/Nav/memes'});
  } else {
    router.push({path: '/NotSignedIn/Login'})
  }
}
});
