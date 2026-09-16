import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["trigger", "panel"]

  toggle() {
    this._setOpen(this.panelTarget.hidden)
  }

  close() {
    this._setOpen(false)
  }

  closeOnClickOutside({ target }) {
    if (!this.element.contains(target)) this.close()
  }

  _setOpen(open) {
    this.panelTarget.hidden = !open
    if (this.hasTriggerTarget) this.triggerTarget.setAttribute("aria-expanded", String(open))
  }
}
