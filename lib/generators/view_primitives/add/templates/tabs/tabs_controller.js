import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { index: Number }
  static targets = ["trigger", "panel"]

  connect() {
    this.#render(this.indexValue)
  }

  select({ params: { index } }) {
    this.indexValue = index
    this.#render(index)
  }

  #render(active) {
    this.triggerTargets.forEach((trigger, i) => {
      const isActive = i === active
      trigger.dataset.state = isActive ? "active" : "inactive"
      trigger.setAttribute("aria-selected", isActive)
    })
    this.panelTargets.forEach((panel, i) => {
      panel.hidden = i !== active
    })
  }
}
