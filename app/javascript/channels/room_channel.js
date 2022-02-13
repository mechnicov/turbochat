import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log('Connected!')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    console.log('Disconnected!')
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('Data: ', data)
    // Called when there's incoming data on the websocket for this channel
  }
});
