import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="turbo-modal"
export default class extends Controller {
  connect() {
  }

  hideModal(e) {
    if (e) {
      // prevent default link behavior
      e.preventDefault()
      // prevent bubbling up the DOM tree to avoid triggering the click event on the window
      e.stopPropagation()
    }
    document.getElementById("modal").removeAttribute("src")
    document.querySelector(".modal-base").remove()
  }

  // hide modal when clicking ESC
  // action: "keyup@window->turbo-modal#closeWithKeyboard"
  closeWithKeyboard(e) {
    if (e.code === "Escape") {
      this.hideModal()
    }
  }

  // hide modal when clicking outside of modal
  // action: "click@window->turbo-modal#closeBackground"
  closeBackground(e) {
    if (e && this.element.contains(e.target)) {
      return
    }
    this.hideModal()
  }
}
