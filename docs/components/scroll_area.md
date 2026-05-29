# ScrollArea

Scrollable container with a thin, themed scrollbar styled via CSS custom properties.

## Installation

```bash
rails g view_primitives:add scroll_area
```

Creates `app/components/ui/scroll_area_component.rb`.

## Usage

```erb
<%= ui :scroll_area do %>
  <% 50.times do |i| %>
    <p class="text-sm py-1">Item <%= i + 1 %></p>
  <% end %>
<% end %>
```

## Orientations

| Orientation | Scrolls |
|-------------|---------|
| `:vertical` | Up/down (default) |
| `:horizontal` | Left/right |
| `:both` | Both axes |

```erb
<%= ui :scroll_area, orientation: :horizontal, max_h: nil, max_w: "max-w-sm" do %>
  <div class="flex gap-4 w-max">…</div>
<% end %>
```

## Custom dimensions

```erb
<%= ui :scroll_area, max_h: "max-h-96" do %>
  <%# long content %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `orientation` | Symbol | `:vertical` | `:vertical`, `:horizontal`, or `:both` |
| `max_h` | String | `"max-h-72"` | Tailwind `max-height` class (used for vertical/both) |
| `max_w` | String | `nil` | Tailwind `max-width` class (used for horizontal/both) |
| `**html_attrs` | Hash | — | Forwarded to the `<div>` |
