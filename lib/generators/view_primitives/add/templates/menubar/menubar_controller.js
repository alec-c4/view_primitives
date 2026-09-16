import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "trigger", "panel"]

  get openIndex() {
    return this.panelTargets.findIndex(p => !p.hidden)
  }

  toggle(event) {
    const menu = event.currentTarget.closest("[data-menubar-target='menu']")
    const index = this.menuTargets.indexOf(menu)
    const wasOpen = !this.panelTargets[index].hidden
    this.closeAll()
    if (!wasOpen) this._open(index)
  }

  openOnHover(event) {
    if (this.openIndex === -1) return
    const menu = event.currentTarget.closest("[data-menubar-target='menu']")
    const index = this.menuTargets.indexOf(menu)
    this.closeAll()
    this._open(index)
  }

  closeAll() {
    this.panelTargets.forEach(p => p.hidden = true)
    this.triggerTargets.forEach(t => t.setAttribute("aria-expanded", "false"))
  }

  closeOnClickOutside({ target }) {
    if (!this.element.contains(target)) this.closeAll()
  }

  _open(index) {
    this.panelTargets[index].hidden = false
    this.triggerTargets[index].setAttribute("aria-expanded", "true")
  }
}
