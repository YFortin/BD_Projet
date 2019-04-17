<template>
    <v-app>
        <v-content>
            <v-container grid-list-md>
                <h1 class="display-1 black--text text-xs-center">
                    <span class="font-weight-bold">Memes</span>
                </h1>
                <v-layout align-space-around justify-center row wrap fill-height>
                    <v-flex xs8 align-self-center>
                        <v-card color="#FAFAFA" flat v-if="items">

                            <h3 class="headline font-weight-bold mb-2">Category: {{ items[0].category }}</h3>
                            <v-card-title primary-title>
                                <h3 class="headline font-weight-bold mb-2">Title: {{ items[0].title }}</h3>
                            </v-card-title>
                            <v-carousel
                                    hide-delimiters
                                    hide-controls
                                    :cycle="false"
                            >
                                <v-carousel-item contain v-for="(item,i) in items" :key="i"
                                                 :src="item.url"></v-carousel-item>
                            </v-carousel>
                            <v-layout justify-center row>
                                <v-flex xs1>
                                    <v-btn fab :disabled="likeDislikeDisable" @click="thumbDown">
                                        <v-icon color="pink">thumb_down_alt</v-icon>
                                    </v-btn>
                                </v-flex>
                                <v-flex xs1>
                                    <v-btn fab :disabled="likeDislikeDisable" @click="thumbUp">
                                        <v-icon color="pink">thumb_up_alt</v-icon>
                                    </v-btn>
                                </v-flex>
                            </v-layout>

                            <v-layout justify-center row>
                                <v-flex xs6>
                                    <v-textarea
                                            outline
                                            v-model="inputComment"
                                            label="Comment"
                                    ></v-textarea>
                                    <v-btn @click ="comment" >
                                        Submit
                                    </v-btn>
                                </v-flex>
                            </v-layout>



                                <v-card-text v-for="(comment, i) in items[0].comments" :key="i"> {{ comment.text }} --
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
    import MemberAPI from '../../js/MemerAPI';

    export default {
        data: () => ({
            likeDislikeDisable: false,
            items: null,
            inputComment: '',
        }),
        methods: {
            async thumbUp() {
                this.likeDislikeDisable = true;
                await MemberAPI.Memes.upvote(this.items[0].id);
                this.items.shift();
                this.likeDislikeDisable = false;
                this.addImage();
            },
            thumbDown() {
                this.likeDislikeDisable = true;
                MemberAPI.Memes.downvote(this.items[0].id);
                this.items.shift();
                this.likeDislikeDisable = false;
                this.addImage();
            },
            async addImage() {
                if (this.items.length < 3) {
                    const response = await MemberAPI.Memes.getUnseenMemes();
                    response.data.unseen_memes.forEach(meme => {
                        this.items.push(meme);
                    });
                }

                if (this.items.length == 0) {
                    this.likeDislikeDisable = true;
                }
            },
            async comment(){
                let comment = this.inputComment;
                this.inputComment = '';
                const res = await MemberAPI.User.getMyAccount()
                const commentToInsert = {"user_name": res.data.username, "text" : comment}
                this.items[0].comments.push(commentToInsert)

                MemberAPI.Memes.comment(comment, this.items[0].id);

            }
        },

        async created() {
            const response = await MemberAPI.Memes.getUnseenMemes();
            this.items = [];
            response.data.unseen_memes.forEach(meme => {
                this.items.push(meme);
            });
        }
    };
</script>
