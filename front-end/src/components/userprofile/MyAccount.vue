<template>
    <v-app>
        <v-content>
            <v-container grid-list-xl fluid v-if="username.oldUserName">
                <h1 class="display-1 black--text text-xs-center">
                    My
                    <span class="font-weight-bold">Account</span>
                </h1>
                <v-divider class="mx-5 my-4"></v-divider>

                <v-layout align-center>
                    <v-flex xs2 font-weight-bold>Username</v-flex>
                    <v-text-field
                            v-model="username.username"
                            full-width
                            :disabled="username.enableEdit"
                            :rules="username.usernameRules"
                    ></v-text-field>
                    <v-flex text-xs-right>
                        <a @click="usernameEdit()">{{ username.editButton }}</a>
                    </v-flex>
                </v-layout>
                <v-divider></v-divider>

                <v-layout align-center>
                    <v-flex xs2 font-weight-bold>Email</v-flex>
                    <v-text-field
                            full-width
                            v-model="email.email"
                            :disabled="email.enableEdit"
                            :rules="email.emailRules"
                    ></v-text-field>
                    <v-flex text-xs-right>
                        <a @click="emailEdit()">{{ email.editButton }}</a>
                    </v-flex>
                </v-layout>

                <v-divider></v-divider>

                <v-layout align-center>
                    <v-flex xs2 font-weight-bold>Password</v-flex>
                    <v-text-field
                            label="New password"
                            type="password"
                            full-width
                            v-model="password.password"
                            :disabled="password.enableEdit"
                            :rules="password.passwordRules"
                            single-line
                    ></v-text-field>
                    <v-flex text-xs-right>
                        <a @click="passwordEdit()">{{ password.editButton }}</a>
                    </v-flex>
                </v-layout>

                <v-divider></v-divider>

                <v-layout align-center>
                    <v-flex xs2 font-weight-bold>Avatar</v-flex>
                    <v-flex>
                        <v-avatar size="64" color="grey">
                            <img :src="avatar.oldURL">
                        </v-avatar>
                    </v-flex>
                    <v-flex>
                        <v-text-field
                                label="New avatar URL"
                                type="text"
                                v-model="avatar.newURL"
                                :disabled="avatar.enableEdit"
                                single-line
                        ></v-text-field>
                    </v-flex>
                    <v-flex text-xs-right>
                        <a @click="avatarEdit()">{{ avatar.editButton }}</a>
                    </v-flex>
                </v-layout>

                <v-divider></v-divider>

                <v-layout>
                    <v-dialog v-model="dialog" persistent max-width="500">
                        <template v-slot:activator="{ on }">
                            <v-btn class="ma-0 mt-4" color="error" v-on="on" depressed>Delete My Account</v-btn>
                        </template>
                        <v-card>
                            <v-card-title class="headline">Do you really want to delete your account?</v-card-title>
                            <v-card-text>
                                All your informations will be
                                <span class="font-weight-bold">deleted</span>. This action cannot be undone.
                            </v-card-text>
                            <v-card-actions>
                                <v-spacer></v-spacer>
                                <v-btn color="green darken-1" flat @click="dialog = false">Cancel</v-btn>
                                <v-btn color="red darken-1" flat @click="dialog = false">I want to delete my account
                                </v-btn>
                            </v-card-actions>
                        </v-card>
                    </v-dialog>
                </v-layout>
            </v-container>
        </v-content>
    </v-app>
</template>

<script>
    import MemerAPI from "../../js/MemerAPI";

    export default {
        data: () => ({
            username: {
                username: null,
                oldUserName: null,
                editButton: "edit",
                enableEdit: true,
                usernameRules: [
                    v => !!v || "Username is required",
                    v => v.length <= 30 || "Username must be less than 30 characters"
                ]
            },
            email: {
                email: "",
                oldEmail: "",
                editButton: "edit",
                enableEdit: true,
                emailRules: [
                    v => !!v || "E-mail is required",
                    v => /.+@.+/.test(v) || "E-mail must be valid"
                ]
            },
            password: {
                password: "",
                editButton: "edit",
                enableEdit: true,
                passwordRules: [v => !!v || "Password is required"]
            },
            avatar: {
                oldURL:
                    "",
                newURL: "",
                editButton: "edit",
                enableEdit: true
            },
            dialog: false
        }),
        methods: {
            usernameEdit() {
                if (this.username.enableEdit) {
                    this.username.editButton = "submit changes";
                    this.username.enableEdit = false;
                } else if (this.usernameValidation()) {
                    this.username.editButton = "edit";
                    this.username.oldUserName = this.username.username;
                    this.username.enableEdit = true;
                    this.submit();
                }
            },
            async usernameValidation() {

                if (this.username.username === this.username.oldUserName) {
                    return true;
                } else if (
                    !!this.username.username &&
                    String(this.username.username).length <= 30
                ) {
                    const usernameValide = await MemerAPI.User.checkUsername(this.username.username);
                    if (usernameValide.data.is_free) {
                        return true;
                    } else if (!usernameValide.data.is_free) {
                        alert("Username already in use");
                    }
                } else {
                    return false;
                }
            },
            passwordEdit() {
                if (this.password.enableEdit) {
                    this.password.editButton = "submit changes";
                    this.password.enableEdit = false;
                } else if (this.password.password) {
                    this.password.editButton = "edit";
                    this.password.enableEdit = true;
                    this.submit();
                }
            },
            emailEdit() {
                if (this.email.enableEdit) {
                    this.email.editButton = "submit changes";
                    this.email.enableEdit = false;
                } else if (this.emailValidation()) {
                    this.email.editButton = "edit";
                    this.email.oldEmail = this.email.email;
                    this.email.enableEdit = true;
                    this.submit();
                }
            },
            async emailValidation() {

                if (this.email.email === this.email.oldEmail) {
                    return true;
                } else if (/.+@.+/.test(this.email.email)) {

                    const emailValid = await MemerAPI.User.checkEmail(this.email.email);
                    if (emailValid.data.is_free) {
                        return true;
                    } else if (!emailValid.data.is_free) {
                        alert("Email already in use");
                    }
                } else if (!(/.+@.+/.test(this.email.email))) {
                    return false;
                } else {
                    return false;
                }
            },
            avatarEdit() {
                if (this.avatar.enableEdit) {
                    this.avatar.editButton = "submit changes";
                    this.avatar.enableEdit = false;
                } else {
                    this.avatar.editButton = "edit";
                    this.avatar.enableEdit = true;
                    this.avatar.oldURL = this.avatar.newURL;
                    this.submit();
                }
            },

            async submit() {
                const user = {
                    "username": this.username.username,
                    "email": this.email.email,
                    "password": this.password.password,
                    "avatar": this.avatar.oldURL,
                }
                await MemerAPI.User.updateMyAccount(user);
            }
        },

        async created() {
            const response = await MemerAPI.User.getMyAccount();

            this.avatar.oldURL = response.data.avatar;
            this.avatar.newURL = response.data.avatar;
            this.email.email = response.data.email;
            this.email.oldEmail = response.data.email;
            this.username.username = response.data.username;
            this.username.oldUserName = response.data.username;

        }

    };
</script>