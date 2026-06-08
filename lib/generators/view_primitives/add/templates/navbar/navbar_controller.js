import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "toggle"]

  toggle() {
    const open = this.menuTarget.hidden
    this.menuTarget.hidden = !open
    this.toggleTarget.setAttribute("aria-expanded", open ? "true" : "false")
  }

  close() {
    this.menuTarget.hidden = true
    this.toggleTarget.setAttribute("aria-expanded", "false")
  }
}
