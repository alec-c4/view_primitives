# List Group

Bordered list of items with optional active state, links, and muted variant. Copies two files: `ListGroupComponent` (the `<ul>` wrapper) and `ListGroupItemComponent` (each `<li>` or `<a>`).

## Installation

```bash
rails g view_primitives:add list_group
```

Creates:
- `app/components/ui/list_group_component.rb`
- `app/components/ui/list_group_item_component.rb`

## Usage

```erb
<%= ui :list_group do %>
  <%= ui :list_group_item, "Dashboard" %>
  <%= ui :list_group_item, "Settings", active: true %>
  <%= ui :list_group_item, "Billing" %>
  <%= ui :list_group_item, "Help", variant: :muted %>
<% end %>
```

## With links

Pass `href:` to render each item as an `<a>` tag:

```erb
<%= ui :list_group do %>
  <%= ui :list_group_item, "Home",     href: "/" %>
  <%= ui :list_group_item, "Profile",  href: "/profile", active: true %>
  <%= ui :list_group_item, "Logout",   href: "/logout" %>
<% end %>
```

## Rich content via block

```erb
<%= ui :list_group do %>
  <%= ui :list_group_item do %>
    <span class="font-medium">Alice</span>
    <span class="text-muted-foreground text-xs">Online</span>
  <% end %>
<% end %>
```

## ListGroupItem variants

| Variant | Description |
|---------|-------------|
| `default` | Normal item with hover background |
| `active` | Filled with `--primary` colour — also set via `active: true` |
| `muted` | Muted text colour |

## API — ListGroupComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the `<ul>` element |

## API — ListGroupItemComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Item text — positional or `label:` keyword, alternative to block |
| `href` | String | `nil` | Renders an `<a>` tag instead of `<li>` when set |
| `active` | Boolean | `false` | Applies the active variant |
| `variant` | Symbol | `:default` | `:default`, `:active`, `:muted` |
| `**html_attrs` | Hash | — | Forwarded to the rendered element |
