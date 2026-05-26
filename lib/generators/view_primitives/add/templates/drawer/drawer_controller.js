import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  open() {
    this.panelTarget.hidden = false
    document.body.style.overflow = "hidden"
  }

  close() {
    this.panelTarget.hidden = true
    document.body.style.overflow = ""
  }
}
