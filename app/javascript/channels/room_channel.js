import consumer from "./consumer"

const appRoom = consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const Messages = document.getElementById('messages');
    Messages.insertAdjacentHTML('beforeend', data['message']);
  },

  speak: function(message, room_id) {
    return this.perform('speak', { message: message, room_id: room_id });
  }
});

if(/rooms/.test(location.pathname)) {
  $(document).on("keypress", ".room__message-form_textarea", function(e) {
    if (e.key === "Enter") {
      const room_id = $('textarea').data('room_id')
      appRoom.speak(e.target.value, room_id);
      e.target.value = '';
      return e.preventDefault();
    }
  })
}
