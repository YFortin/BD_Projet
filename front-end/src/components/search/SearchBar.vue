<template>
  <v-toolbar color="accent">
    <v-toolbar-title>Search</v-toolbar-title>
    <v-autocomplete
      v-model="select"
      :items="items"
      :search-input.sync="search"
      class="mx-3"
      flat
      hide-no-data
      hide-details
      label="Find a user!"
      solo-inverted
      item-text='username'
      return-object
      :loading="loading"
    ></v-autocomplete>
  </v-toolbar>
</template>

<script>
import MemerAPI from "../../js/MemerAPI";

export default {
  data() {
    return {
      loading: false,
      items: [],
      search: '',
      select: '',
    };
  },
  watch: {
    search(val) {
      val && val !== this.select && this.querySelections(val);
    },
    select(val) {
      this.$router.push({path: `/Nav/UserProfile/${val.username}`});
    },
  },
  methods: {
    async querySelections(input) {
      this.loading = true;

      try {

        const response = await MemerAPI.User.autocomplete_username(input);

        this.items = response.data.results;
      } catch (e) {
        console.log(e.message);
      }

      this.loading = false;
    }
  }
};
</script>