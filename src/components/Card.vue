<template>
  <div class="synonym-card">
    <h2 class="searched-word">{{currentSearchText}}</h2>
    <p class="synonyms-for-tag">Synonyms for: {{currentSearchText}}</p>
    <ul class="synonym-list">
      <li class="synonym-text" v-for="(synonym, index) in synonyms" :key="index">
        {{ synonym }}
      </li>
    </ul>
  </div>
</template>

<script>
  export default {
    props: {
      synonyms: Array,
      currentSearchText: String
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