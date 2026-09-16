import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["toggle"]

  toggle() {
    const collapsed = this.element.dataset.collapsed === "true"
    this._setCollapsed(!collapsed)
  }

  open()  { this._setCollapsed(false) }
  close() { this._setCollapsed(true) }

  _setCollapsed(collapsed) {
    this.element.dataset.collapsed = String(collapsed)
    if (this.hasToggleTarget) this.toggleTarget.setAttribute("aria-expanded", String(!collapsed))
  }
}
