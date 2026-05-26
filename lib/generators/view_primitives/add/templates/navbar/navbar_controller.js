import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "toggle"]

  toggle() {
    const menu = this.element.nextElementSibling
    if (!menu?.dataset.navbarTarget?.includes("menu")) return
    menu.hidden = !menu.hidden
  }
}
