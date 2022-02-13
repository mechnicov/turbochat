import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="room-channel"
export default class extends Controller {
  static values = { id: String }

  async connect() {
    this.subscription = await window.cable.subscribeTo(this.channel, {
      received: this.dispatchMessageEvent.bind(this)
    })
  }

  disconnect() {
    if (this.subscription) this.subscription.unsubscribe()
  }

  dispatchMessageEvent(data) {
    Turbo.renderStreamMessage(data)
  }

  get channel() {
    const channel = "RoomChannel"
    const id = this.idValue
    return { channel, id }
  }
}
