import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "hidden", "panel", "option", "empty"]

  connect() {
    this.activeIndex = -1
  }

  get visibleOptions() {
    return this.optionTargets.filter(o => !o.hidden)
  }

  open() {
    this.inputTarget.setAttribute("aria-expanded", "true")
    this.panelTarget.hidden = false
    this.filter()
  }

  close() {
    this.inputTarget.setAttribute("aria-expanded", "false")
    this.panelTarget.hidden = true
    this._setActive(-1)
    const selected = this.optionTargets.find(o => o.dataset.comboboxValue === this.hiddenTarget.value)
    this.inputTarget.value = selected ? selected.dataset.comboboxLabel : ""
  }

  filter() {
    const query = this.inputTarget.value.toLowerCase()
    let visible = 0
    this.optionTargets.forEach(option => {
      const match = option.dataset.comboboxLabel.toLowerCase().includes(query)
      option.hidden = !match
      if (match) visible++
    })
    this.emptyTarget.hidden = visible > 0
    this._setActive(-1)
  }

  next(event) {
    event.preventDefault()
    this._move(1)
  }

  prev(event) {
    event.preventDefault()
    this._move(-1)
  }

  choose(event) {
    if (this.panelTarget.hidden) return
    event.preventDefault()
    const option = this.visibleOptions[this.activeIndex]
    if (option) this._select(option)
  }

  select(event) {
    this._select(event.currentTarget)
  }

  closeOnClickOutside({ target }) {
    if (!this.element.contains(target)) this.close()
  }

  _move(step) {
    if (this.panelTarget.hidden) {
      this.open()
      return
    }

    const options = this.visibleOptions
    if (options.length === 0) return

    const next = this.activeIndex === -1
      ? (step > 0 ? 0 : options.length - 1)
      : (this.activeIndex + step + options.length) % options.length

    this._setActive(next)
  }

  _setActive(index) {
    const options = this.visibleOptions
    options.forEach(o => { o.dataset.active = "false" })

    this.activeIndex = index
    const active = options[index]
    if (active) {
      active.dataset.active = "true"
      active.scrollIntoView({ block: "nearest" })
      this.inputTarget.setAttribute("aria-activedescendant", active.id)
    } else {
      this.inputTarget.removeAttribute("aria-activedescendant")
    }
  }

  _select(option) {
    const { comboboxValue, comboboxLabel } = option.dataset
    this.hiddenTarget.value = comboboxValue
    this.inputTarget.value = comboboxLabel
    this.optionTargets.forEach(o => o.setAttribute("aria-selected", String(o === option)))
    this.close()
  }
}
