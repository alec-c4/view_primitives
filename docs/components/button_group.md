# Button Group

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Wraps multiple buttons into a visually joined row — shared border, collapsed inner radii.

## Installation

```bash
rails g view_primitives:add button_group
```

Creates `app/components/ui/button_group_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only button_group
```


## Usage

```erb
<%= ui :button_group do %>
  <%= ui :button, "Previous", variant: :outline %>
  <%= ui :button, "Current",  variant: :outline %>
  <%= ui :button, "Next",     variant: :outline %>
<% end %>
```

## Mixed variants

Each child button can use a different variant:

```erb
<%= ui :button_group do %>
  <%= ui :button, "Copy",   variant: :secondary %>
  <%= ui :button, "Paste",  variant: :secondary %>
  <%= ui :button, "Delete", variant: :destructive %>
<% end %>
```

## Notes

`ButtonGroupComponent` uses Tailwind child-selector utilities to:

- Remove border radius from all inner children (`[&>*]:rounded-none`)
- Re-apply left radius to the first child (`[&>*:first-child]:rounded-l-md`)
- Re-apply right radius to the last child (`[&>*:last-child]:rounded-r-md`)
- Collapse adjacent borders (`[&>*:not(:first-child)]:-ml-px`)

The individual `ButtonComponent` variants are preserved — only the shape is affected.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the wrapper `<div role="group">` |
