<template>
  <v-app light>
    <v-content>
      <v-container fluid fill-height>
        <v-layout align-center justify-center>
          <v-flex xs12 sm8 md4>
            <v-card class="elevation-12" transition="fade-transition" color="secondary">
              <v-toolbar dark color="primary">
                <v-toolbar-title>Login</v-toolbar-title>
              </v-toolbar>
              <v-card-text>
                <v-form>
                  <v-text-field
                    v-model="email"
                    prepend-icon="person"
                    name="email"
                    label="email"
                    type="text"
                  ></v-text-field>
                  <v-text-field
                    v-model="password"
                    prepend-icon="lock"
                    name="password"
                    label="Password"
                    type="password"
                  ></v-text-field>
                </v-form>
              </v-card-text>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn color="primary" to="/NotSignedIn/Signup">Sign Up</v-btn>
                <v-btn color="primary" @click="login">Log in</v-btn>
              </v-card-actions>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
import { validationMixin } from "vuelidate";
import { required, email } from "vuelidate/lib/validators";
import MemerAPI from '../../js/MemerAPI';

export default {
  mixins: [validationMixin],

  validations: {
    email: { required, email },
    password: { required }
  },

  data: () => ({
    email: "",
    password: ""
  }),
  methods: {
    async login() {
      if (
        this.$v.email.email &&
        this.$v.email.required &&
        this.$v.password.required
      ) {
        try {
          const response = await MemerAPI.User.login(this.email, this.password);
          document.cookie = `AuthorizationMemer=${response.data.token}`;
          this.$router.push({path: '/Nav/Memes'})
        } catch (error) {
          console.log(error);
        }
      }
    }
  }
};
</script>