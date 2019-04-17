<template>
    <v-app>
        <v-content>
            <v-container fluid fill-height>
                <v-layout align-center justify-center>
                    <v-flex xs12 sm8 md4>
                        <v-card class="elevation-12" transition="fade-transition" color="secondary">
                            <v-toolbar dark color="primary">
                                <v-toolbar-title>Sign Up</v-toolbar-title>
                            </v-toolbar>
                            <v-card-text>
                                <v-form ref="form" v-model="valid" lazy-validation>
                                    <v-text-field
                                            v-model="username"
                                            :counter="usernameLength"
                                            :rules="usernameRules"
                                            label="Username"
                                            required
                                    ></v-text-field>
                                    <v-text-field v-model="email" :rules="emailRules" label="E-mail"
                                                  required></v-text-field>
                                    <v-text-field
                                            :type="'password'"
                                            v-model="password"
                                            :rules="passwordRules"
                                            label="Password"
                                            required
                                    ></v-text-field>
                                </v-form>
                            </v-card-text>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="primary" @click="submit">Submit</v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-flex>
                </v-layout>
            </v-container>
        </v-content>
    </v-app>
</template>

<script>
    import MemerAPI from '../../js/MemerAPI';

    export default {
        data: () => ({
            valid: true,
            username: "",
            usernameLength: 30,
            usernameRules: [
                v => !!v || "Username is required",
                v => v.length <= 30 || "Username must be less than 30 characters"
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
            async submit() {
                if (this.$refs.form.validate()) {

                    const emailValid = await MemerAPI.User.checkEmail(this.email);
                    const usernameValide = await MemerAPI.User.checkUsername(this.username);

                    console.log(emailValid.data.is_free);
                    console.log(usernameValide.data.is_free);

                    if (emailValid.data.is_free) {
                        if (usernameValide.data.is_free) {
                            await MemerAPI.User.signup(this.username, this.email, this.password);
                            this.$router.push({path: '/NotSignedIn/Login'});
                        } else {
                            alert("Username already in use");
                        }
                    } else {
                        alert("Email already in use");
                    }
                }
            }
        }
    };
</script>