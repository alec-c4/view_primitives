# Range

Styled range slider (`<input type="range">`) with a custom thumb and focus ring.

## Installation

```bash
rails g view_primitives:add range
```

Creates `app/components/ui/range_component.rb`.

## Usage

```erb
<%= ui :range, name: "volume" %>
```

## Custom bounds

```erb
<%= ui :range, name: "price", min: 0, max: 500, step: 10, value: 100 %>
```

## In a form

```erb
<%= ui :form_field, label: "Volume" do %>
  <%= ui :range, name: "settings[volume]", id: "volume", min: 0, max: 100, value: 50 %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `min` | Numeric | `0` | Minimum value |
| `max` | Numeric | `100` | Maximum value |
| `step` | Numeric | `1` | Increment step |
| `value` | Numeric | `nil` | Initial value |
| `**html_attrs` | Hash | — | Forwarded to the `<input type="range">` element |
