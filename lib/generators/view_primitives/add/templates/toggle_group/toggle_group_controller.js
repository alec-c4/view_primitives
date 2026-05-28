import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { type: { type: String, default: "single" } }

  connect() {
    this.element.addEventListener("click", this.#handleClick)
  }

  disconnect() {
    this.element.removeEventListener("click", this.#handleClick)
  }

  #handleClick = (event) => {
    const btn = event.target.closest("button")
    if (!btn || !this.element.contains(btn)) return

    const alreadyOn = btn.dataset.state === "on"

    if (this.typeValue === "single") {
      this.#buttons.forEach(b => {
        b.dataset.state = "off"
        b.setAttribute("aria-pressed", "false")
      })
      if (!alreadyOn) {
        btn.dataset.state = "on"
        btn.setAttribute("aria-pressed", "true")
      }
    } else {
      btn.dataset.state = alreadyOn ? "off" : "on"
      btn.setAttribute("aria-pressed", String(!alreadyOn))
    }
  }

  get #buttons() {
    return Array.from(this.element.querySelectorAll("button"))
  }
}
