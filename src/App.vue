<template>
  <div id="app">
    <Header/>
    <div class="user-input-container">
        <p>synonyms: </p>
        <input v-model="currentSearchText" placeholder="enter a word">
        <button class="search-button" v-on:click="this.getData">search</button>
    </div>
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
  box-sizing: border-box;
}

.user-input-container {
  background-color: #EEEEEE;
  display: flex;
  flex-direction: row;
  justify-content: center;
}

body {
  margin: 0px;
  padding: 0px;
}

input {
  width: 400px;
  margin: 10px;
}

input,
.search-button {
  height: 30px;
}

.search-button {
  margin: 12px;
}

</style>