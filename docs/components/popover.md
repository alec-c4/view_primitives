# Popover

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Floating panel that opens on trigger click, positioned relative to the trigger element.

Requires `popover_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add popover
```

Creates `app/components/ui/popover_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only popover
```


## Usage

```erb
<%= ui :popover do |pop| %>
  <% pop.with_trigger { ui :button, "Open" } %>
  <p class="text-sm">Popover content goes here.</p>
<% end %>
```

## Alignment

| Align | Description |
|-------|-------------|
| `:start` | Left-aligned (default) |
| `:center` | Centered below trigger |
| `:end` | Right-aligned |

## Side

| Side | Description |
|------|-------------|
| `:bottom` | Below trigger (default) |
| `:top` | Above trigger |
| `:left` | Left of trigger |
| `:right` | Right of trigger |

```erb
<%= ui :popover, align: :end, side: :bottom do |pop| %>
  <% pop.with_trigger { ui :button, "Settings", variant: :ghost, size: :icon do %>
    <svg ...></svg>
  <% end } %>
  <p class="text-sm">Quick settings panel.</p>
<% end %>
```

## Close on outside click

Clicking outside the popover closes it automatically.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `align` | Symbol | `:start` | `:start`, `:center`, or `:end` |
| `side` | Symbol | `:bottom` | `:bottom`, `:top`, `:left`, or `:right` |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that toggles the panel on click |
