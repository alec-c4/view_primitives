# Separator

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Thin divider line for horizontal or vertical layout separation.

## Installation

```bash
rails g view_primitives:add separator
```

Creates `app/components/ui/separator_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only separator
```


## Usage

```erb
<%# Horizontal (default) %>
<%= ui :separator %>

<%# Vertical %>
<%= ui :separator, orientation: :vertical %>

<%# Non-decorative (semantic separator for screen readers) %>
<%= ui :separator, decorative: false %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `orientation` | Symbol | `:horizontal` | `:horizontal` or `:vertical` |
| `decorative` | Boolean | `true` | When `true`, sets `role="none"`; when `false`, sets `role="separator"` |
| `**html_attrs` | Hash | — | Forwarded to the `<div>` element |
