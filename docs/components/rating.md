# Rating

Read-only star rating display.

## Installation

```bash
rails g view_primitives:add rating
```

Creates `app/components/ui/rating_component.rb`.

## Usage

```erb
<%= ui :rating, value: 4 %>
```

## Custom max

```erb
<%# 7 out of 10 %>
<%= ui :rating, value: 7, max: 10 %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `value` | Numeric | `0` | Number of filled stars. Clamped to `0..max`, rounded to nearest integer. |
| `max` | Integer | `5` | Total number of stars |
| `**html_attrs` | Hash | — | Forwarded to the wrapper `<div>` |

The wrapper renders with `role="img"` and an `aria-label` of `"Rating: N out of M"`.
