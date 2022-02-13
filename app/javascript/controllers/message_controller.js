import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static classes = [ "mine" ]
  static values = { ownerId: String }

  connect() {
    // Set class 'mine' for author message
    if (this.currentUserId && this.currentUserId === this.authorId) {
      this.element.classList.add(this.mineClass)
    } else if (this.currentUserId && this.hasMineClass && this.element.classList.contains(this.mineClass)) {
      this.element.classList.remove(this.mineClass)
    }
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
}
