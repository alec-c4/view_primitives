# Resizable

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Two-panel layout with a draggable handle that resizes the panels at runtime.

Requires `resizable_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add resizable
```

Creates `app/components/ui/resizable_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only resizable
```


## Usage

```erb
<%= ui :resizable do |r| %>
  <% r.with_panel(default: 30) do %>
    <div class="p-4">Left panel</div>
  <% end %>
  <% r.with_panel do %>
    <div class="p-4">Right panel</div>
  <% end %>
<% end %>
```

## Vertical split

```erb
<%= ui :resizable, direction: :vertical do |r| %>
  <% r.with_panel(default: 40) do %>
    <div class="p-4">Top panel</div>
  <% end %>
  <% r.with_panel do %>
    <div class="p-4">Bottom panel</div>
  <% end %>
<% end %>
```

## Panel constraints

```erb
<% r.with_panel(min: 20, max: 60, default: 35) do %>
  <div>Constrained panel</div>
<% end %>
```

## API

### ResizableComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `direction` | Symbol | `:horizontal` | `:horizontal` (side by side) or `:vertical` (stacked) |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

### PanelComponent (via `with_panel`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `min` | Integer | `10` | Minimum panel size as a percentage |
| `max` | Integer | `90` | Maximum panel size as a percentage |
| `default` | Integer | `nil` | Initial size as a percentage; unset panels share remaining space equally |
