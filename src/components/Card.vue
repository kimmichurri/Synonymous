<template>
  <div>
    <h2>Current synonyms</h2>
    <ul>
      <li v-for="(synonym, index) in synonyms" :key="index">
        {{ synonym }}
      </li>
    </ul>
  </div>
</template>

<script>
  export default {
    props: {
      synonyms: Array
    }
  }
</script>