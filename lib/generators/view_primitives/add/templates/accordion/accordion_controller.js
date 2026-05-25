import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  toggle(event) {
    const summary = event.target.closest("summary")
    if (!summary) return

    const target = summary.closest("details")
    if (!target || target.open) return

    this.element.querySelectorAll("details[open]").forEach(item => {
      if (item !== target) item.open = false
    })
  }
}
