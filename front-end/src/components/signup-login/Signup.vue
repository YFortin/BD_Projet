<template>
  <v-container>
    <v-layout column fill-height>
      <v-form ref="form" v-model="valid" lazy-validation dark>
        <v-text-field
          v-model="username"
          :counter="10"
          :rules="userNameRules"
          label="Username"
          required
        ></v-text-field>

        <v-text-field v-model="email" :rules="emailRules" label="E-mail" required></v-text-field>

        <v-text-field
          :type="'password'"
          v-model="password"
          :rules="passwordRules"
          label="Password"
          required
        ></v-text-field>

        <v-btn color="#007ac1" @click="submit">Submit</v-btn>
      </v-form>
    </v-layout>
  </v-container>
</template>

<script>
export default {
  data: () => ({
    valid: true,
    username: "",
    userNameRules: [
      v => !!v || "Username is required",
      v => (v && v.length <= 10) || "Username must be less than 10 characters"
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