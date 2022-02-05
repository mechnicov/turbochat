import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static classes = ["mine", "container"]
  static values = { ownerId: String, containerSelector: String }

  connect() {
    // Set class 'mine' for author message
    if (this.currentUserId === this.authorId) {
      this.element.classList.add(this.mineClass)
    } else if (this.hasMineClass && this.element.classList.contains(this.mineClass)) {
      this.element.classList.remove(this.mineClass)
    }
    // autoscroll after form submit
    this.scrollChatDown()
  }

  get currentUserId() {
    return document.querySelector("[name='current-user-id']").content
  }

  get authorId() {
    return this.ownerIdValue
  }

  clearInput() {
    this.element.reset()
  }

  scrollChatDown() {
    // console.log('this.element: ', this.element)
    // console.log('this.containerSelectorValue: ', this.containerSelectorValue)
    // console.log('this.element.closest(this.containerSelectorValue): ', this.element.closest(this.containerSelectorValue))
    // let messagesContainer = this.element.closest(this.containerSelectorValue)
    let messagesContainer = this.element.parentElement
    if (messagesContainer) {
      messagesContainer.scrollTop = messagesContainer.scrollHeight
      setTimeout(() => {
        if (messagesContainer.scrollTop != messagesContainer.scrollHeight) {
          messagesContainer.scrollTop = messagesContainer.scrollHeight
        }
      }, 200)
    }
  }
}
