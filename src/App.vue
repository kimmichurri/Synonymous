<template>
  <div id="app">
    <Header />
    <div class="user-input-container-wrapper">
      <div class="user-input-container">
        <p class="input-label">synonyms: </p>
        <input
          v-model="currentSearchText"
          placeholder="enter a word"
          v-on:keyup.enter="setUrl"
        >
        <button 
          class="search-button" 
          v-on:click="setUrl"
          :disabled="currentSearchText.length === 0"
        >
          search
        </button>
      </div>
    </div>
    <Card
      v-if="synonyms.length && !loading"
      :synonyms="synonyms"
      :currentSearchText="currentSearchText"
      v-on:send-text="handleText"
    />
    <h2
      class="user-prompt"
      v-if="currentSearchText.length === 0"
    >
      Please enter a word in the search
    </h2>
    <h2
      class="error-message"
      v-if="error.length"
    >
      {{ error }}
    </h2>
    <img
      v-if="loading"
      src="./assets/spinner.gif"
    >
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
      error: '',
      loading: false
    }
  },
  methods: {
    setUrl() {
      const url = `https://www.dictionaryapi.com/api/v3/references/thesaurus/json/${this.currentSearchText}?key=${myKey}`
      this.getData(url)
    },
    async getData(url) {
      try {
        this.loading = true
        const response = await fetch(url)
        if(!response.ok) {
          throw Error (response.statusText)
        }
        const results = await response.json()
        this.loading = false
        if(typeof results[0] === 'object') {
          this.captureSyns(results)
        } else {
          this.loading = false
          this.synonyms = []
          this.error = 'Sorry, the word you entered does not exist in our database'
        }
      } catch(error) {
        this.error = 'Sorry, there was a problem retrieving the data'
      }
    },
    captureSyns(results) {
      results.reduce((acc, result) => {
        if(result.meta.id === this.currentSearchText) {
          result.meta.syns[0].forEach(word => {
            acc.push(word)
          })
        }
        this.error = ''
        this.synonyms = acc
        return acc
      }, [])
    },
    handleText(value) {
      this.currentSearchText = value
      const url = `https://www.dictionaryapi.com/api/v3/references/thesaurus/json/${value}?key=${myKey}`
      this.getData(url)
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
  width: 60%;
  margin: 10px;
  border-radius: 1px;
  padding-left: 1%;
}

input,
.search-button {
  height: 30px;
}

.input-label,
.search-button {
  color: #595959;
  font-weight: bold;
}

.search-button {
  margin: 12px;
  border-radius: 4px;
  background-color: #fbfbfb;
  width: 100px;
}

.search-button:hover {
  cursor: pointer;
  box-shadow: 0px 2px 6px #dcdcdc;
}

.search-button:disabled {
  color: #d6d6d6;
  background-color: #f1f1f1;
}

.user-prompt,
.error-message {
  font-weight: bold;
  font-size: 1.25em;
  color: #595959;
  margin: 20px 20%;
}

.user-input-container-wrapper {
  background-color: #f5a622ff;
  padding: 10px 40px 20px;
}

@media screen and (max-width: 750px) {
  .user-input-container {
    flex-direction: column;
    align-items: center;
  }
  .search-button {
    width: 61%;
    margin: 10px 12px 20px;
  }
  .input-label {
    align-self: flex-start;
    margin-left: 20%;
  }
}

</style>