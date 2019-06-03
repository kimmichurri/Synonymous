<template>
  <div id="app">
    <Header/>
    <div class="user-input-container">
        <p>synonyms: </p>
        <input v-model="currentSearchText" placeholder="enter a word">
        <button 
          class="search-button" 
          v-on:click="this.getData"
          :disabled="currentSearchText.length === 0"
          >
          search
        </button>
    </div>
    <Card
      v-if="synonyms.length" 
      :synonyms="synonyms"
      :currentSearchText="currentSearchText"
    />
    <h2
      class="user-prompt"
      v-if="currentSearchText.length === 0 "
    >
      Please enter a word in the search
    </h2>
    <h2
      class="error-message"
      v-if="error.length"
    >
      {{ error }}
    </h2>
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
      currentSearchText: '',
      error: ''
    }
  },
  methods: {
    async getData() {
    const url = `https://www.dictionaryapi.com/api/v3/references/thesaurus/json/${this.currentSearchText}?key=${myKey}`
    const response = await fetch(url)
    const results = await response.json()
    if(typeof results[0] === 'object') {
      this.captureSyns(results)
    } else {
      this.synonyms = []
      this.error = 'Sorry, the word does not exist in our database'
    }
    },
    captureSyns(results) {
      results.reduce((acc, result) => {
        result.meta.syns[0].forEach(word => {
          acc.push(word)
        })
        this.error = ''
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

.search-button:hover {
  cursor: pointer;
}

.user-prompt,
.error-message {
  font-weight: bold;
  font-size: 1.25em;
  color: #595959;
}

</style>