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
    const palette = colors?.length ? colors : DEFAULT_COLORS
    const coloredDatasets = datasets.map((dataset, index) => {
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
        color: "var(--muted-foreground)",
        ...options
      }
    })
  }

  disconnect() {
    this.#chart?.destroy()
    this.#chart = null
  }
}
