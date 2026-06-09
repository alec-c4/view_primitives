import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "panel", "option", "empty", "chip", "chipTemplate"]

  open() {
    this.panelTarget.hidden = false
    this.filter()
  }

  close() {
    this.panelTarget.hidden = true
    this.inputTarget.value = ""
    this.#resetOptionVisibility()
  }

  filter() {
    const query = this.inputTarget.value.toLowerCase()
    let visible = 0
    this.optionTargets.forEach(option => {
      if (option.hidden) return
      const match = option.dataset.tagsInputLabel.toLowerCase().includes(query)
      option.style.display = match ? "" : "none"
      if (match) visible++
    })
    if (this.hasEmptyTarget) this.emptyTarget.hidden = visible > 0
  }

  select(event) {
    const { tagsInputValue, tagsInputLabel } = event.currentTarget.dataset
    event.currentTarget.hidden = true
    event.currentTarget.style.display = ""
    this.#addChip(tagsInputValue, tagsInputLabel)
    this.inputTarget.value = ""
    this.filter()
    this.inputTarget.focus()
  }

  remove(event) {
    event.stopPropagation()
    const value = event.currentTarget.dataset.tagsInputValue
    const option = this.optionTargets.find(o => o.dataset.tagsInputValue === value)
    if (option) { option.hidden = false; option.style.display = "" }
    event.currentTarget.closest("[data-tags-input-target~='chip']").remove()
    this.filter()
  }

  focusInput() {
    this.inputTarget.focus()
    if (this.panelTarget.hidden) this.open()
  }

  keydown(event) {
    if (event.key === "Backspace" && this.inputTarget.value === "") {
      const chips = this.chipTargets
      if (chips.length > 0) {
        chips[chips.length - 1].querySelector("[data-action*='tags-input#remove']")?.click()
      }
    }
    if (event.key === "Escape") this.close()
    if (event.key === "Enter") {
      event.preventDefault()
      const first = this.optionTargets.find(o => !o.hidden && o.style.display !== "none")
      if (first) first.click()
    }
  }

  closeOnClickOutside({ target }) {
    if (!this.element.contains(target)) this.close()
  }

  #addChip(value, label) {
    const chip = this.chipTemplateTarget.content.cloneNode(true).firstElementChild
    chip.dataset.tagsInputValue = value
    chip.querySelector(".tags-input-chip-label").textContent = label
    const hidden = chip.querySelector("input[type='hidden']")
    if (hidden) hidden.value = value
    const btn = chip.querySelector("[data-action*='tags-input#remove']")
    if (btn) btn.dataset.tagsInputValue = value
    this.inputTarget.insertAdjacentElement("beforebegin", chip)
  }

  #resetOptionVisibility() {
    const selected = new Set(this.chipTargets.map(c => c.dataset.tagsInputValue))
    this.optionTargets.forEach(o => {
      o.hidden = selected.has(o.dataset.tagsInputValue)
      o.style.display = ""
    })
  }
}
