import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "messages" ]

  connect() {
    const container = this.messagesTarget  // document.querySelector('#chat-container')
    const observer = new ResizeObserver(() => {
      if (container) {
        container.scrollTop = container.scrollHeight
      }
    })

    for (var i = 0; i < container.children.length; i++) {
      observer.observe(container.children[i])
    }
  }
}
