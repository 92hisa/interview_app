// $(document).on('turbolinks:load', function() {
  
  import Vue from 'vue/dist/vue.esm'
  import Room from '../room.vue'
  
  // document.addEventListener('DOMContentLoaded', () => {
    function loading(){
  
  
    const app = new Vue({
      el: '#room',
      data: {
      },
      components: { Room }
    })
  }
  // })
  setTimeout(loading,   500)
