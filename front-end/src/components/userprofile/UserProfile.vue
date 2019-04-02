<template>
  <v-app>
    <v-content>
      <v-container grid-list-md>
        <h1 class="display-1 black--text text-xs-center">
          <span class="font-weight-bold">{{ userName }}'s</span> Profile
        </h1>
        <v-layout align-center justify-center row wrap fill-height>
          <v-flex xs6>
            <v-avatar size="200">
              <img
                src="https://scontent.fyhu2-1.fna.fbcdn.net/v/t1.0-9/23130781_10155622945611539_6417421965758236618_n.jpg?_nc_cat=109&_nc_ht=scontent.fyhu2-1.fna&oh=56c4ec24f459476146859d0cc1494f04&oe=5D4B2B0C"
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
              <h3>27 likes!</h3>
            </div>
          </v-flex>
        </v-layout>
        <v-divider></v-divider>
        <v-layout align-center justify-center row wrap fill-height>
          <v-flex xs8 align-self-center>
            <v-card color="secondary">
              <v-card-title primary-title>
                <h3 class="headline font-weight-bold mb-2">My memes</h3>
              </v-card-title>
              <v-carousel>
                <v-carousel-item v-for="(item,i) in items" :key="i" :src="item.src"></v-carousel-item>
              </v-carousel>
            </v-card>
          </v-flex>
        </v-layout>
      </v-container>
    </v-content>
  </v-app>
</template>

<script>
export default {
  data: () => ({
    userName: "MPP",
    numberOfFollowers: 0,
    follower: "Follow",
    followColor: "success",
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
      }
    ]
  }),
  methods: {
    follow() {
      if (this.follower === "Follow") {
        this.follower = "Unfollow";
        this.followColor = "error";
        this.numberOfFollowers++;
      } else {
        this.follower = "Follow";
        this.followColor = "success";
        this.numberOfFollowers--;
      }
    }
  }
};
</script>

