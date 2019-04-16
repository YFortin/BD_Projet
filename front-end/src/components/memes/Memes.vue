<template>
  <v-app>
    <v-content>
      <v-container grid-list-md>
        <h1 class="display-1 black--text text-xs-center">
          <span class="font-weight-bold">Memes</span>
        </h1>
        <v-layout align-space-around justify-center row wrap fill-height>
          <v-flex xs8 align-self-center>
            <v-card color="#FAFAFA" flat>
              <v-card-title primary-title>
                <h3 class="headline font-weight-bold mb-2">{{ items[0].title }}</h3>
              </v-card-title>
              <v-carousel
                hide-delimiters
                hide-controls
                :cycle="false"
              >
                <v-carousel-item contain v-for="(item,i) in items" :key="i" :src="item.url"></v-carousel-item>
              </v-carousel>
                <v-card-text v-for="(comment, i) in items[0].comments" :key="i"> {{ comment.comment }} -- {{comment.userName}}<v-divider></v-divider></v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
        <v-layout justify-center row>
          <v-flex xs1>
            <v-btn fab @click="thumbDown">
              <v-icon color="pink">thumb_down_alt</v-icon>
            </v-btn>
          </v-flex>
          <v-flex xs1>
            <v-btn fab @click="thumbUp">
              <v-icon color="pink">thumb_up_alt</v-icon>
            </v-btn>
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
    items: []
  }),
  methods: {
    thumbUp() {
      this.items.shift();
      this.addImage();
    },
    thumbDown() {
      this.items.shift();
      this.addImage();
    },
    async addImage() {
      if (this.items.length < 3) {
        const response = await MemberAPI.Memes.getUnseenMemes();
        console.log("Ajout de memes");
        console.log(response.data);
        response.data.forEach(memes => {
          console.log(memes.comments);
          this.items.push(memes);
        });
      }
    },

    setup() {
      this.addImage();
    }
  },

  beforeMount() {
    this.setup();
  }
};
</script>
