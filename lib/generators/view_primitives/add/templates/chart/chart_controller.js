// Requires Chart.js — add to your importmap before use:
//   pin "chart.js", to: "https://esm.sh/chart.js@4"
import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from "chart.js"

Chart.register(...registerables)

const DEFAULT_COLORS = [
  "var(--chart-1)",
  "var(--chart-2)",
  "var(--chart-3)",
  "var(--chart-4)",
  "var(--chart-5)"
]

export default class extends Controller {
  static values = {
    type: { type: String, default: "bar" },
    config: { type: String, default: "{}" }
  }

  #chart = null

  connect() {
    const { labels, datasets, options = {}, colors } = JSON.parse(this.configValue)
    const palette = (colors?.length ? colors : DEFAULT_COLORS).map((c) => this.#resolveColor(c))
    const perSegment = ["pie", "doughnut", "polarArea"].includes(this.typeValue) && datasets.length === 1
    const coloredDatasets = datasets.map((dataset, index) => {
      if (perSegment) {
        const segmentColors = (dataset.data ?? []).map((_, i) => palette[i % palette.length])
        return {
          ...dataset,
          backgroundColor: dataset.backgroundColor ?? segmentColors,
          borderColor: dataset.borderColor ?? segmentColors
        }
      }

      const color = palette[index % palette.length]
      return {
        ...dataset,
        backgroundColor: dataset.backgroundColor ?? color,
        borderColor: dataset.borderColor ?? color
      }
    })

    this.#chart = new Chart(this.element, {
      type: this.typeValue,
      data: { labels, datasets: coloredDatasets },
      options: {
        responsive: true,
        maintainAspectRatio: true,
        color: this.#resolveColor("var(--muted-foreground)"),
        ...options
      }
    })
  }

  disconnect() {
    this.#chart?.destroy()
    this.#chart = null
  }

  // Canvas fillStyle can't resolve CSS custom properties on its own —
  // read the computed value from the DOM before handing it to Chart.js.
  #resolveColor(value) {
    const match = /^var\((--[^),]+)\)$/.exec(value?.trim() ?? "")
    if (!match) return value

    const resolved = getComputedStyle(document.documentElement).getPropertyValue(match[1]).trim()
    return resolved || value
  }
}
