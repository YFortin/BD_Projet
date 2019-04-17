<template>
    <v-content>
        <v-toolbar flat color="primary" dark>
            <v-toolbar-side-icon to="/Nav/Memes" color="accent">
                <v-img src="https://cdn3.iconfinder.com/data/icons/popular-memes/48/JD-26-512.png"></v-img>
            </v-toolbar-side-icon>
            <v-toolbar-title>
                Memer
                <div class="subheading">Find your favorites memes</div>
            </v-toolbar-title>
            <v-spacer></v-spacer>
            <v-toolbar-items>
                <v-btn flat to="/Nav/Memes">Memes</v-btn>
                <v-btn flat @click="upLoadMeme">Upload Meme</v-btn>
                <v-btn flat @click="showSearch">Search User</v-btn>
                <v-btn flat to="/Nav/MyAccount">My account</v-btn>
                <v-btn flat @click="signout">Sign out</v-btn>
            </v-toolbar-items>
        </v-toolbar>
        <v-expand-transition>
            <SearchBar v-show="show"></SearchBar>
        </v-expand-transition>
        <transition name="fade" mode="out-in">
            <router-view></router-view>
        </transition>
        <v-bottom-sheet v-model="sheet">

            <v-card>

                <v-layout align-center>
                    <v-flex>
                        <v-text-field
                                label="Meme title"
                                type="text"
                                v-model="memeTitle"
                                single-line
                                counter="199"
                        ></v-text-field>
                    </v-flex>
                </v-layout>
                <v-layout>
                    <v-flex>
                        <v-text-field
                                label="Meme category"
                                type="text"
                                v-model="memeCategory"
                                single-line
                                counter="199"
                        ></v-text-field>
                    </v-flex>
                </v-layout>
                <v-layout>
                    <v-flex>
                        <v-text-field
                                label="Meme url"
                                type="text"
                                v-model="memeUrl"
                                single-line
                                counter="499"
                        ></v-text-field>
                    </v-flex>
                </v-layout>
                <v-layout>
                    <v-btn @click="submitMeme">Submit</v-btn>
                </v-layout>
            </v-card>
        </v-bottom-sheet>
    </v-content>
</template>

<script>
    import SearchBar from "../search/SearchBar";
    import MemerAPI from "../../js/MemerAPI";

    export default {
        data: () => ({
            show: false,
            sheet: false,
            memeUrl: "",
            memeTitle: "",
            memeCategory: ""
        }),
        methods: {
            showSearch() {
                this.show = !this.show;
            },

            upLoadMeme() {
                this.sheet = !this.sheet;
            },

            submitMeme() {

                if (!!this.memeTitle && !!this.memeUrl && !!this.memeCategory && this.memeTitle.length < 200 && this.memeUrl.length < 500 && this.memeCategory.length < 200) {
                    const meme = {
                        'title': this.memeTitle,
                        'url': this.memeUrl,
                        'category': this.memeCategory
                    }
                    MemerAPI.Memes.addMeme(meme);
                    this.sheet = false;
                    alert("Meme has been uploaded!");
                }
            },

            signout() {
                document.cookie = "AuthorizationMemer= ; expires = Thu, 01 Jan 1970 00:00:00 GMT";
                this.$router.push('/NotSignedIn/Login');
            }
        },
        components: {
            SearchBar
        }
    };
</script>
