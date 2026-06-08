# Spinner

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Animated loading indicator for in-progress states.

## Installation

```bash
rails g view_primitives:add spinner
```

Creates `app/components/ui/spinner_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only spinner
```


## Usage

```erb
<%= ui :spinner %>
```

## Sizes

| Size | Class |
|------|-------|
| `sm` | `size-4` |
| `default` | `size-6` |
| `lg` | `size-10` |

```erb
<%= ui :spinner, size: :sm %>
<%= ui :spinner %>
<%= ui :spinner, size: :lg %>
```

## Loading button

```erb
<%= ui :button, variant: :outline, disabled: true do %>
  <%= ui :spinner, size: :sm, class: "mr-2" %>
  Saving…
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `size` | Symbol | `:default` | Spinner diameter — `:sm`, `:default`, `:lg` |
| `**html_attrs` | Hash | — | Forwarded to the outer `<span>` |

The component renders a `<span role="status">` with a visually hidden "Loading…" text for screen readers.
