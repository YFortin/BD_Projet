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
          path: 'userprofile',
          name: 'UserProfile',
          component: UserProfile
        },
        {
          path: 'myaccount',
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

router.beforeEach((to, from, next) => {
  console.log(`🚦 navigating to ${to.name} from ${from.name}`);

  const autorization = document.cookie
  .split(';')
  .filter(item => item.trim().startsWith('AuthorizationMemer=')).length;

  if (to.matched.some(route => route.meta.requiresAuth)) {
    if (!autorization) {
      router.push({path: '/NotSignedIn/Login'})
    } else {
      next()
    }
} else if (to.matched.some(route => route.meta.unsigned)) {
  if (!autorization) {
    next()
  } else {
    router.push({path: '/Nav/UserProfile'});
  }
}
});
