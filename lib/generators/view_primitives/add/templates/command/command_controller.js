import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "input", "list", "empty"]

  connect() {
    this._onKeydown = this._onKeydown.bind(this)
    document.addEventListener("keydown", this._onKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this._onKeydown)
    this._releaseFocusTrap()
  }

  _onKeydown(event) {
    if (event.key === "k" && (event.metaKey || event.ctrlKey)) {
      event.preventDefault()
      this.panelTarget.hidden ? this.open() : this.close()
    }
  }

  open() {
    this.panelTarget.hidden = false
    document.body.style.overflow = "hidden"

    this._previouslyFocused = document.activeElement
    this._dialog = this.panelTarget.querySelector("[role=dialog]")
    this._trapFocus = this.#trapFocus.bind(this)
    this._dialog?.addEventListener("keydown", this._trapFocus)

    this.inputTarget.value = ""
    this.inputTarget.focus()
    this.filter()
  }

  close() {
    this.panelTarget.hidden = true
    document.body.style.overflow = ""
    this._releaseFocusTrap()
  }

  filter() {
    const query = this.inputTarget.value.toLowerCase().trim()
    const items = this.listTarget.querySelectorAll("[data-command-value]")
    items.forEach(item => {
      item.hidden = query.length > 0 && !item.dataset.commandValue.toLowerCase().includes(query)
    })

    this.listTarget.querySelectorAll("[data-command-group]").forEach(group => {
      const hasVisible = Array.from(group.querySelectorAll("[data-command-value]")).some(i => !i.hidden)
      group.hidden = !hasVisible
    })

    const totalVisible = Array.from(items).filter(i => !i.hidden).length
    this.emptyTarget.hidden = totalVisible > 0
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

  _releaseFocusTrap() {
    this._dialog?.removeEventListener("keydown", this._trapFocus)
    this._previouslyFocused?.focus?.()
    this._previouslyFocused = null
    this._dialog = null
  }
}
