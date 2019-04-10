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
                <h3 class="headline font-weight-bold mb-2">Start Swiping!</h3>
              </v-card-title>
              <v-carousel
                vertical
                v-model="carouselIndex"
                hide-delimiters
                hide-controls
                :cycle="false"
              >
                <v-carousel-item contain v-for="(item,i) in items" :key="i" :src="item.src"></v-carousel-item>
              </v-carousel>
            </v-card>
          </v-flex>
        </v-layout>
        <v-layout justify-center row>
          <v-flex xs1>
            <v-btn fab @click="thumbDown" :disabled="true">
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
export default {
  data: () => ({
    carouselIndex: 0,
    items: [
      {
        src: "https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg"
      },
      {
        src: "https://cdn.vuetifyjs.com/images/carousel/sky.jpg"
      },
      {
        src: "https://cdn.vuetifyjs.com/images/carousel/bird.jpg"
      },
      {
        src: "https://cdn.vuetifyjs.com/images/carousel/planet.jpg"
      },
      {
        src: "https://s.hdnux.com/photos/73/53/27/15644125/6/920x920.jpg"
      },
      {
        src: "https://img-9gag-fun.9cache.com/photo/aD1X1d7_700bwp.webp"
      }
    ]
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
    addImage() {
      if (this.items.length < 3) {
        this.items.push(
          {
            src:
              "https://pay.google.com/about/static/images/social/og_image.jpg"
          },
          {
            src: "https://cdn.vuetifyjs.com/images/carousel/squirrel.jpg"
          },
          {
            src: "https://cdn.vuetifyjs.com/images/carousel/sky.jpg"
          },
          {
            src: "https://cdn.vuetifyjs.com/images/carousel/bird.jpg"
          },
          {
            src: "https://cdn.vuetifyjs.com/images/carousel/planet.jpg"
          },
          {
            src: "https://s.hdnux.com/photos/73/53/27/15644125/6/920x920.jpg"
          },
          {
            src: "https://img-9gag-fun.9cache.com/photo/aD1X1d7_700bwp.webp"
          }
        );
      }
    },

    setup() {
      console.log('getMemes');
    }
  },

  beforeMount() {
    this.setup();
  }
};
</script>
