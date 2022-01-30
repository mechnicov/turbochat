import { Controller } from "@hotwired/stimulus"
import { cable } from "@hotwired/turbo-rails"

export default class extends Controller {
  connect() {
    this.subscribe()
    this.scrollMessages()
  }

  subscribe() {
    const turboStreamFromTag = document.querySelector("turbo-cable-stream-source")
    const channelName = turboStreamFromTag.getAttribute("channel")
    const signedStreamName = turboStreamFromTag.getAttribute("signed-stream-name")

    const scrollMessages = this.scrollMessages.bind(this)

    this.channel = cable.subscribeTo({ channel: channelName, signed_stream_name: signedStreamName }, {
      received(data) {
        setTimeout(scrollMessages, 100)
      }
    })
  }

  clearInput() {
    this.element.reset()
  }

  scrollMessages() {
    const chatContainer = document.getElementById("chat-container")
    if (chatContainer) chatContainer.scrollTop = chatContainer.scrollHeight
  }
}
