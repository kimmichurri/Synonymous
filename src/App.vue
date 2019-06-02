<template>
  <div id="app">
    <Header/>
    <Card />
  </div>
</template>

<script>
import Header from './components/Header.vue'
import Card from './components/Card.vue'
import { myKey } from '../utils/myKey'

export default {
  name: 'app',
  components: {
    Header,
    Card
  },
  mounted: async function() {
    this.getSyns()
  },
  methods: {
    async getSyns() {
    const url = `https://www.dictionaryapi.com/api/v3/references/thesaurus/json/umpire?key=${myKey}`
    const response = await fetch(url)
    const results = await response.json()
    console.log(results)
    }
  }
}
</script>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
