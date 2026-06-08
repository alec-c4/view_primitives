import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel"]

  open() {
    this.panelTarget.hidden = false
    document.body.style.overflow = "hidden"

    this._previouslyFocused = document.activeElement
    this._dialog = this.panelTarget.querySelector("[role=dialog], [role=alertdialog]")
    this._trapFocus = this.#trapFocus.bind(this)
    this._dialog?.addEventListener("keydown", this._trapFocus)

    const focusable = this.#focusableElements(this._dialog)
    if (focusable.length > 0) {
      focusable[0].focus()
    } else {
      this._dialog?.focus()
    }
  }

  close() {
    this.panelTarget.hidden = true
    document.body.style.overflow = ""

    this._dialog?.removeEventListener("keydown", this._trapFocus)
    this._previouslyFocused?.focus?.()
    this._previouslyFocused = null
    this._dialog = null
  }

  #trapFocus(event) {
    if (event.key !== "Tab" || !this._dialog) return

    const focusable = this.#focusableElements(this._dialog)
    if (focusable.length === 0) return

    const first = focusable[0]
    const last = focusable[focusable.length - 1]

    if (event.shiftKey && document.activeElement === first) {
      event.preventDefault()
      last.focus()
    } else if (!event.shiftKey && document.activeElement === last) {
      event.preventDefault()
      first.focus()
    }
  }

  #focusableElements(container) {
    if (!container) return []

    const selector = [
      "a[href]",
      "button:not([disabled])",
      "input:not([disabled])",
      "select:not([disabled])",
      "textarea:not([disabled])",
      "[tabindex]:not([tabindex='-1'])",
    ].join(", ")

    return Array.from(container.querySelectorAll(selector)).filter(
      (el) => !el.hasAttribute("hidden") && el.offsetParent !== null
    )
  }
}
