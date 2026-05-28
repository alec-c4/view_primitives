import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle() {
    // Defer to toggle-group controller when nested inside one
    if (this.element.closest("[data-controller~='toggle-group']")) return

    const on = this.element.dataset.state === "on"
    this.element.dataset.state = on ? "off" : "on"
    this.element.setAttribute("aria-pressed", String(!on))
  }
}
