# Chart

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Canvas-based chart powered by Chart.js. Renders bar, line, pie, doughnut, radar, and polar area charts.

Requires `chart_controller.js` (copied automatically by the generator) and the Chart.js library in your importmap.

## Setup

Add Chart.js to your importmap before using this component:

```ruby
# config/importmap.rb
pin "chart.js", to: "https://esm.sh/chart.js@4"
```

## Installation

```bash
rails g view_primitives:add chart
```

Creates:
- `app/components/ui/chart_component.rb`
- `app/javascript/controllers/chart_controller.js`

## Usage

```erb
<%= ui :chart,
       type: :bar,
       labels: ["Jan", "Feb", "Mar", "Apr", "May"],
       datasets: [
         { label: "Revenue", data: [120, 190, 80, 210, 150] }
       ] %>
```

## Chart types

| Type | Description |
|------|-------------|
| `:bar` | Vertical bar chart (default) |
| `:line` | Line chart |
| `:pie` | Pie chart |
| `:doughnut` | Doughnut chart |
| `:radar` | Radar/spider chart |
| `:polarArea` | Polar area chart |

## Multiple datasets

```erb
<%= ui :chart,
       type: :line,
       labels: ["Q1", "Q2", "Q3", "Q4"],
       datasets: [
         { label: "2024", data: [100, 140, 130, 180] },
         { label: "2025", data: [110, 160, 150, 200],
           background_color: "#3b82f6", border_color: "#3b82f6" }
       ] %>
```

Dataset keys use snake_case and are automatically camelized for Chart.js (e.g. `background_color:` becomes `backgroundColor`).

## Chart.js options

Pass any Chart.js `options` hash to override defaults:

```erb
<%= ui :chart,
       type: :bar,
       labels: ["A", "B", "C"],
       datasets: [{ label: "Score", data: [70, 85, 90] }],
       options: { responsive: false, plugins: { legend: { display: false } } } %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `type` | Symbol | `:bar` | Chart type — see Chart types table |
| `labels` | Array | `[]` | X-axis or category labels |
| `datasets` | Array | `[]` | Array of dataset hashes (snake_case keys are camelized) |
| `options` | Hash | `{}` | Merged into the Chart.js `options` object |
| `**html_attrs` | Hash | — | Forwarded to the `<canvas>` element |
