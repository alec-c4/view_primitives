# Tooltip

Small text label that appears near an element on hover. Pure CSS — no JavaScript required.

## Installation

```bash
rails g view_primitives:add tooltip
```

Creates `app/components/ui/tooltip_component.rb`.

## Usage

```erb
<%= ui :tooltip, text: "Save your changes" do %>
  <%= ui :button, size: :icon do %>
    <svg ...></svg>
  <% end %>
<% end %>
```

## Position

| Side | Description |
|------|-------------|
| `:top` | Above the element (default) |
| `:bottom` | Below the element |
| `:left` | Left of the element |
| `:right` | Right of the element |

```erb
<%= ui :tooltip, text: "Delete", side: :right do %>
  <%= ui :button, variant: :destructive, size: :icon do %><svg ...></svg><% end %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `text` | String | required | Tooltip bubble text |
| `side` | Symbol | `:top` | `:top`, `:bottom`, `:left`, or `:right` |
| `**html_attrs` | Hash | — | Forwarded to the outer `<span>` wrapper |
