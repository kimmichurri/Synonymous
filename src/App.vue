<template>
  <div id="app">
    <Header/>
    <p>synonyms: </p>
    <input v-model="currentSearchText" placeholder="enter a word">
    <button v-on:click="this.getData">search</button>
    <Card
      v-if="synonyms.length" 
      :synonyms="synonyms"
      :currentSearchText="currentSearchText"
    />
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
  data() {
    return {
      synonyms: [],
      currentSearchText: ''
    }
  },
  methods: {
    async getData() {
    const url = `https://www.dictionaryapi.com/api/v3/references/thesaurus/json/${this.currentSearchText}?key=${myKey}`
    const response = await fetch(url)
    const results = await response.json()
    this.captureSyns(results)
    },
    captureSyns(results) {
      results.reduce((acc, result) => {
        result.meta.syns[0].forEach(word => {
          acc.push(word)
        })
        this.synonyms = acc
        return acc
      }, [])
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
