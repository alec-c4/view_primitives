# Indicator

Status dot or count badge overlaid on another element. Wraps any content and renders a small badge in one corner.

## Installation

```bash
rails g view_primitives:add indicator
```

Creates `app/components/ui/indicator_component.rb`.

## Usage

```erb
<%# Online dot over an avatar %>
<%= ui :indicator, variant: :success do %>
  <%= ui :avatar, fallback: "Alice" %>
<% end %>

<%# Notification count on a button %>
<%= ui :indicator, count: 3 do %>
  <%= ui :button, "Inbox", variant: :outline %>
<% end %>
```

## Variants

| Variant | Colour |
|---------|--------|
| `default` | Primary |
| `destructive` | Red |
| `success` | Green |
| `warning` | Yellow |

## Positions

| Position | Placement |
|----------|-----------|
| `top_right` *(default)* | Top-right corner |
| `top_left` | Top-left corner |
| `bottom_right` | Bottom-right corner |
| `bottom_left` | Bottom-left corner |

```erb
<%= ui :indicator, variant: :destructive, position: :bottom_right do %>
  <%= ui :avatar, fallback: "Bob" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `count` | Integer / nil | `nil` | When set, renders a numbered badge; otherwise renders a small dot |
| `variant` | Symbol | `:default` | Colour — `:default`, `:destructive`, `:success`, `:warning` |
| `position` | Symbol | `:top_right` | Corner — `:top_right`, `:top_left`, `:bottom_right`, `:bottom_left` |
| `**html_attrs` | Hash | — | Forwarded to the outer wrapper `<span>` |
