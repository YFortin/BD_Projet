<template>
    <v-app>
        <v-content>
            <v-container grid-list-md v-if="numberOfFollowers">
                <h1 class="display-1 black--text text-xs-center">
                    <span class="font-weight-bold">{{ username }}'s</span> Profile
                </h1>
                <v-layout align-center justify-center row wrap fill-height>
                    <v-flex xs6>
                        <v-avatar size="200">
                            <img
                                    :src="avatarUrl"
                            >
                        </v-avatar>
                    </v-flex>
                    <v-flex xs6>
                        <h3>
                            {{ numberOfFollowers }} followers!
                            <v-btn @click="follow" :color="followColor">{{ follower }}</v-btn>
                        </h3>
                        <v-divider></v-divider>
                        <div>
                            <h3>{{ numberOfLikes }} likes!</h3>
                        </div>
                    </v-flex>
                </v-layout>
                <v-divider></v-divider>

                <v-layout align-space-around justify-center row wrap fill-height>
                    <v-flex xs8 align-self-center>
                        <v-card color="#FAFAFA" flat v-if="items">

                            <h3 class="headline font-weight-bold mb-2">Category: {{ items[carouselIndex].category
                                }}</h3>
                            <v-card-title primary-title>
                                <h3 class="headline font-weight-bold mb-2">Title: {{ items[carouselIndex].title }}</h3>
                            </v-card-title>
                            <v-carousel
                                    v-model="carouselIndex"
                            >
                                <v-carousel-item contain v-for="(item,i) in items" :key="i"
                                                 :src="item.url"></v-carousel-item>
                            </v-carousel>
                            <v-card-text v-for="(comment, i) in items[carouselIndex].comments" :key="i"> {{ comment.text
                                }} --
                                {{comment.user_name}}
                                <v-divider></v-divider>
                            </v-card-text>
                        </v-card>
                    </v-flex>
                </v-layout>


            </v-container>
        </v-content>
    </v-app>
</template>

<script>
    import MemerAPI from "../../js/MemerAPI";

    export default {
        data: () => ({
            carouselIndex: 0,
            username: null,
            numberOfFollowers: null,
            follower: "Follow",
            followColor: "info",
            avatarUrl: "",
            numberOfLikes: null,
            items: null
        }),
        watch: {
            '$route.params.username': function update() {
                this.setup();
            }
        },
        methods: {
            follow() {
                if (this.follower === "Follow") {
                    this.follower = "Unfollow";
                    this.followColor = "error";
                    this.numberOfFollowers++;
                } else {
                    this.follower = "Follow";
                    this.followColor = "info";
                    this.numberOfFollowers--;
                }
                MemerAPI.User.followUser(this.username);
            },

            async setup() {
                this.username = this.$route.params.username;
                const response = await MemerAPI.User.getUserProfile(this.username);
                console.log(response.data.avatar);

                if (response.data.avatar === null) {
                    this.avatarUrl = "https://cdn4.iconfinder.com/data/icons/user-avatar-flat-icons/512/User_Avatar-04-512.png";
                } else {
                    this.avatarUrl = response.data.avatar;
                }

                this.numberOfFollowers = response.data.followers;
                this.numberOfLikes = response.data.likes;

                if (response.data.memes.length === 0) {
                    this.items = [{
                        "category": 'No memes',
                        "title": 'this user never uploaded a meme!',
                        "comments": [],
                        "url": "https://i.imgur.com/DKUR9Tk.png",
                    }]
                } else {
                    this.items = response.data.memes;
                }

                if (!response.data.following) {
                    this.follower = "Follow";
                    this.followColor = "info";
                } else {
                    this.follower = "Unfollow";
                    this.followColor = "error";
                }
            }
        },

        async created() {
            this.username = this.$route.params.username;
            const response = await MemerAPI.User.getUserProfile(this.username);
            console.log(response.data.avatar);

            if (response.data.avatar === null) {
                this.avatarUrl = "https://cdn4.iconfinder.com/data/icons/user-avatar-flat-icons/512/User_Avatar-04-512.png";
            } else {
                this.avatarUrl = response.data.avatar;
            }

            this.numberOfFollowers = response.data.followers;
            this.numberOfLikes = response.data.likes;

            if (response.data.memes.length === 0) {
                this.items = [{
                    "category": 'No memes',
                    "title": 'this user never uploaded a meme!',
                    "comments": [],
                    "url": "https://i.imgur.com/DKUR9Tk.png",
                }]
            } else {
                this.items = response.data.memes;
            }

            if (!response.data.following) {
                this.follower = "Follow";
                this.followColor = "info";
            } else {
                this.follower = "Unfollow";
                this.followColor = "error";
            }
        },
    };
</script>


