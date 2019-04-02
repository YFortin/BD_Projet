<template>
  <v-layout align-space-around justify-center row wrap fill-height>
    <v-flex xs8 align-self-center>
      <v-card color="#FAFAFA" flat>
        <v-card-title primary-title>
          <h3 class="headline font-weight-bold mb-2">My memes</h3>
        </v-card-title>
        <v-carousel hide-delimiters>
          <v-carousel-item contain v-for="(item,i) in items" :key="i" :src="item.src"></v-carousel-item>
        </v-carousel>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
export default {
  data: () => ({
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
  })
};
</script>

