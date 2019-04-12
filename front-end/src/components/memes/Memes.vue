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
                hide-delimiters
                hide-controls
                :cycle="false"
              >
                <v-carousel-item contain v-for="(item,i) in items" :key="i" :src="item.URL"></v-carousel-item>
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
export default {
  data: () => ({
    items: [
      {
        URL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/NYCS-bull-trans-1.svg/1024px-NYCS-bull-trans-1.svg.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Yan', comment: 'Jaime les pommes'}, {userName: 'Xav', comment: 'Jaime les poires'}],
      },
      {
        URL: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/NYCS-bull-trans-2.svg/1024px-NYCS-bull-trans-2.svg.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Will', comment: 'Spa si pire java'}, {userName: 'MPP', comment: 'Je fais du théatre'}]
      },
      {
        URL: "https://i.redd.it/0cscovjonpi11.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Yan', comment: 'Jaime les pommes'}, {userName: 'Xav', comment: 'Jaime les poires'}],
      },
      {
        URL: "http://mrconsultis.fr/wp-content/uploads/2016/09/4-13.jpeg",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Will', comment: 'Spa si pire java'}, {userName: 'MPP', comment: 'Je fais du théatre'}]
      },
      {
        URL: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/TV5_%28ABC5%29_Logo.svg/220px-TV5_%28ABC5%29_Logo.svg.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Yan', comment: 'Jaime les pommes'}, {userName: 'Xav', comment: 'Jaime les poires'}],
      },
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
        URL: "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3f/NYCS-bull-trans-1.svg/1024px-NYCS-bull-trans-1.svg.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Yan', comment: 'Jaime les pommes'}, {userName: 'Xav', comment: 'Jaime les poires'}],
      },
      {
        URL: "https://upload.wikimedia.org/wikipedia/commons/thumb/6/61/NYCS-bull-trans-2.svg/1024px-NYCS-bull-trans-2.svg.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Will', comment: 'Spa si pire java'}, {userName: 'MPP', comment: 'Je fais du théatre'}]
      },
      {
        URL: "https://i.redd.it/0cscovjonpi11.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Yan', comment: 'Jaime les pommes'}, {userName: 'Xav', comment: 'Jaime les poires'}],
      },
      {
        URL: "http://mrconsultis.fr/wp-content/uploads/2016/09/4-13.jpeg",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Will', comment: 'Spa si pire java'}, {userName: 'MPP', comment: 'Je fais du théatre'}]
      },
      {
        URL: "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/TV5_%28ABC5%29_Logo.svg/220px-TV5_%28ABC5%29_Logo.svg.png",
              Title: 'Titre',
              Category: 'Category',
              id: '1233242342312',
              comments: [{userName: 'Yan', comment: 'Jaime les pommes'}, {userName: 'Xav', comment: 'Jaime les poires'}],
      },
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
