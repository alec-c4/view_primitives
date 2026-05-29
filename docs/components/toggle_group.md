# ToggleGroup

Wrapper that coordinates a set of Toggle buttons as a single or multi-select group.

Requires `toggle_group_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add toggle_group
```

Creates `app/components/ui/toggle_group_component.rb`.

## Usage

Nest Toggle components inside the group:

```erb
<%# Single-select — only one item active at a time %>
<%= ui :toggle_group, type: :single, value: "center" do %>
  <%= ui :toggle, "Left",   value: "left" %>
  <%= ui :toggle, "Center", value: "center" %>
  <%= ui :toggle, "Right",  value: "right" %>
<% end %>

<%# Multi-select — several items can be active simultaneously %>
<%= ui :toggle_group, type: :multiple, value: ["bold", "italic"] do %>
  <%= ui :toggle, "Bold",   value: "bold" %>
  <%= ui :toggle, "Italic", value: "italic" %>
  <%= ui :toggle, "Under",  value: "underline" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `type` | Symbol | `:single` | `:single` (one active) or `:multiple` (many active) |
| `value` | String or Array | `nil` | Currently active value(s) |
| `**html_attrs` | Hash | — | Forwarded to the `<div role="group">` wrapper |
