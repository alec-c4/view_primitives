# Toggle

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Pressable button that tracks an on/off state via `aria-pressed` and a Stimulus controller.

Requires `toggle_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add toggle
```

Creates `app/components/ui/toggle_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only toggle
```


## Usage

```erb
<%# Label as positional argument %>
<%= ui :toggle, "Bold" %>

<%# Pre-pressed %>
<%= ui :toggle, "Italic", pressed: true %>

<%# Block content (e.g. icon + label) %>
<%= ui :toggle do %>
  <svg ...></svg> Bold
<% end %>
```

## Sizes

| Size | Description |
|------|-------------|
| `default` | `h-9 min-w-9` |
| `sm` | `h-8 min-w-8` |
| `lg` | `h-10 min-w-10` |

```erb
<%= ui :toggle, "B", size: :sm %>
<%= ui :toggle, "B", size: :default %>
<%= ui :toggle, "B", size: :lg %>
```

## With a value

Use `value:` when toggling options in a group or form:

```erb
<%= ui :toggle, "Left",   value: "left" %>
<%= ui :toggle, "Center", value: "center" %>
<%= ui :toggle, "Right",  value: "right" %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Button text — positional or `label:` keyword, alternative to block |
| `pressed` | Boolean | `false` | Initial pressed state |
| `size` | Symbol | `:default` | `:default`, `:sm`, or `:lg` |
| `value` | String | `nil` | Value attribute passed to the `<button>` |
| `**html_attrs` | Hash | — | Forwarded to the `<button>` element |
