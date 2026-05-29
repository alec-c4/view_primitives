# NumberInput

Numeric input with browser spin buttons hidden and consistent focus styling.

## Installation

```bash
rails g view_primitives:add number_input
```

Creates `app/components/ui/number_input_component.rb`.

## Usage

```erb
<%= ui :number_input, name: "quantity" %>
```

## Bounds and step

```erb
<%= ui :number_input, name: "quantity", min: 1, max: 99, step: 1, value: 1 %>
```

## In a form

```erb
<%= ui :form_field, label: "Quantity" do %>
  <%= ui :number_input, name: "order[quantity]", id: "order_quantity",
                        min: 1, max: 100, value: @order.quantity %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `min` | Numeric | `nil` | Minimum allowed value |
| `max` | Numeric | `nil` | Maximum allowed value |
| `step` | Numeric | `nil` | Increment/decrement step |
| `value` | Numeric | `nil` | Initial value |
| `**html_attrs` | Hash | — | Forwarded to the `<input type="number">` element |
