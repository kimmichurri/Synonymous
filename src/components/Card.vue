<template>
  <div class="synonym-card">
    <h2 class="searched-word">{{currentSearchText}}</h2>
    <p class="synonyms-for-tag">Synonyms for: {{currentSearchText}}</p>
    <ul class="synonym-list">
      <li 
        class="synonym-text" 
        v-for="(synonym, index) in synonyms" 
        :key="index"
        v-on:click="captureText"
      >
        {{ synonym }}
      </li>
    </ul>
  </div>
</template>

<script>
  export default {
    props: {
      synonyms: Array,
      currentSearchText: String,
      handleText: { type: Function }
    },
    data() {
    return {
      selectedText: ''
    }
  },
    methods: {
      captureText(event) {
        this.selectedText = event.target.innerText
        this.$emit('send-text', this.selectedText)
      }
    }
  }
</script>

<style>

.synonym-list {
  display: flex;
  flex-direction: row;
  flex-wrap: wrap;
  background-color: #EEE;
}

.synonym-text {
  list-style-type: none;
  margin: 1.5em;
}

.synonym-text:hover {
  cursor: pointer;
}

.synonym-card {
  background-color: #FFF;
  padding: 30px;
}

.searched-word {
  text-align: left;
  font-weight: bold;
  font-size: 2.75em;
  color: #595959;
}

.synonyms-for-tag {
  text-align: left;
}

</style>