# Progress

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Horizontal progress bar with accessible ARIA attributes.

## Installation

```bash
rails g view_primitives:add progress
```

Creates `app/components/ui/progress_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only progress
```


## Usage

```erb
<%# 40% complete %>
<%= ui :progress, value: 40 %>

<%# Custom max %>
<%= ui :progress, value: 3, max: 10 %>

<%# Custom width %>
<%= ui :progress, value: 75, class: "w-64" %>
```

## Behaviour

- `value` is clamped between `0` and `max`
- The inner bar width is calculated as `(value / max) * 100%`
- Renders with `role="progressbar"` and `aria-valuenow` / `aria-valuemin` / `aria-valuemax`

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `value` | Numeric | `0` | Current progress value |
| `max` | Numeric | `100` | Maximum value |
| `**html_attrs` | Hash | — | Forwarded to the outer track `<div>` |
