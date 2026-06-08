import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["body", "search", "pageLabel", "sortIndicator"]
  static values = {
    perPage: { type: Number, default: 10 },
    total:   { type: Number, default: 0 }
  }

  connect() {
    this.#allRows = Array.from(this.bodyTarget.querySelectorAll("tr[data-data-table-row]"))
    this.#filtered = [...this.#allRows]
    this.#page = 1
    this.#sortKey = null
    this.#sortDir = null
    this.#render()
  }

  filter() {
    const q = this.searchTarget.value.trim().toLowerCase()
    this.#filtered = q
      ? this.#allRows.filter(row =>
          row.textContent.toLowerCase().includes(q)
        )
      : [...this.#allRows]
    this.#page = 1
    this.#sortKey = null
    this.#sortDir = null
    this.#clearSortIndicators()
    this.#render()
  }

  sort({ params: { key } }) {
    if (this.#sortKey === key) {
      this.#sortDir = this.#sortDir === "asc" ? "desc" : null
      if (!this.#sortDir) this.#sortKey = null
    } else {
      this.#sortKey = key
      this.#sortDir = "asc"
    }

    this.#clearSortIndicators()
    if (this.#sortKey) {
      const indicator = this.sortIndicatorTargets.find(
        el => el.dataset.dataTableSortKey === this.#sortKey &&
              el.dataset.dataTableDir === this.#sortDir
      )
      if (indicator) indicator.dataset.active = this.#sortDir
    }

    if (this.#sortKey) {
      const colIdx = this.#columnIndex(this.#sortKey)
      this.#filtered.sort((a, b) => {
        const av = a.cells[colIdx]?.textContent.trim() ?? ""
        const bv = b.cells[colIdx]?.textContent.trim() ?? ""
        const n = parseFloat(av) - parseFloat(bv)
        const cmp = isNaN(n) ? av.localeCompare(bv) : n
        return this.#sortDir === "asc" ? cmp : -cmp
      })
    }

    this.#page = 1
    this.#render()
  }

  prevPage() {
    if (this.#page > 1) { this.#page--; this.#render() }
  }

  nextPage() {
    if (this.#page < this.#totalPages) { this.#page++; this.#render() }
  }

  #render() {
    const rows = this.#filtered
    const perPage = this.perPageValue
    const total = rows.length

    const start = perPage > 0 ? (this.#page - 1) * perPage : 0
    const end   = perPage > 0 ? start + perPage : total

    this.#allRows.forEach(row => { row.style.display = "none" })
    rows.slice(start, end).forEach(row => { row.style.display = "" })

    if (this.hasPageLabelTarget) {
      if (perPage > 0 && total > 0) {
        this.pageLabelTarget.textContent =
          `Page ${this.#page} of ${this.#totalPages} (${total} rows)`
      } else {
        this.pageLabelTarget.textContent = `${total} rows`
      }
    }
  }

  #clearSortIndicators() {
    this.sortIndicatorTargets.forEach(el => delete el.dataset.active)
  }

  #columnIndex(key) {
    const headers = this.element.querySelectorAll("th[data-data-table-column-key]")
    return Array.from(headers).findIndex(h => h.dataset.dataTableColumnKey === key)
  }

  get #totalPages() {
    return this.perPageValue > 0
      ? Math.max(1, Math.ceil(this.#filtered.length / this.perPageValue))
      : 1
  }

  #allRows = []
  #filtered = []
  #page = 1
  #sortKey = null
  #sortDir = null
}
