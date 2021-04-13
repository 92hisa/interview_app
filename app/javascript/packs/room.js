// $(document).on('turbolinks:load', function() {

  function down(){
    const videoEnd = document.getElementById("video-end")
    // if (videoEnd.getAttribute("data-load") != null) {
    //   return null;
    // }
    // videoEnd.setAttribute("data-load", "true");
    videoEnd.addEventListener('click', () => {
    location.reload();
    // videoEnd.removeAttribute("data-load");
  })
  }
  setInterval(down, 500)

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
