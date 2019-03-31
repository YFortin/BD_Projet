<template>
  <v-app>
    <v-content>
      <v-container>
        <v-layout column fill-height>
          <v-card>
            <v-form ref="form" v-model="valid" lazy-validation>
              <v-flex grow pa-4>
                <v-text-field
                  v-model="username"
                  :counter="usernameLength"
                  :rules="userNameRules"
                  label="Username"
                  required
                ></v-text-field>
              </v-flex>
              <v-flex grow pa-4>
                <v-text-field v-model="email" :rules="emailRules" label="E-mail" required></v-text-field>
              </v-flex>
              <v-flex grow pa-4>
                <v-text-field
                  :type="'password'"
                  v-model="password"
                  :rules="passwordRules"
                  label="Password"
                  required
                ></v-text-field>
              </v-flex>
              <v-flex>
                <v-btn color="#007ac1" @click="submit">Submit</v-btn>
              </v-flex>
            </v-form>
          </v-card>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
export default {
  data: () => ({
    valid: true,
    username: "",
    usernameLength: 30,
    userNameRules: [
      v => !!v || "Username is required",
      v =>
        (v && v.length <= this.usernameLength) ||
        "Username must be less than 30 characters"
    ],
    email: "",
    emailRules: [
      v => !!v || "E-mail is required",
      v => /.+@.+/.test(v) || "E-mail must be valid"
    ],
    password: "",
    passwordRules: [v => !!v || "Password is required"]
  }),
  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        console.log("patate");
      }
    }
  }
};
</script>