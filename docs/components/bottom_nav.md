# BottomNav

Fixed bottom navigation bar for mobile layouts. Shows up to five icon+label links.

## Installation

```bash
rails g view_primitives:add bottom_nav
```

Creates `app/components/ui/bottom_nav_component.rb`.

## Usage

```erb
<%= ui :bottom_nav, items: [
  { label: "Home",    href: root_path,    active: true,
    icon: '<svg ...>…</svg>' },
  { label: "Search",  href: search_path,
    icon: '<svg ...>…</svg>' },
  { label: "Profile", href: profile_path,
    icon: '<svg ...>…</svg>' }
] %>
```

The `icon:` value is an HTML string (raw SVG). Omit it to render a text-only link.

## Active state

Pass `active: true` on one item. It receives `text-primary` styling and `aria-current="page"`.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `items` | Array | `[]` | Array of item hashes — see table below |
| `**html_attrs` | Hash | — | Forwarded to the `<nav>` element |

### Item hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `label` | String | Yes | Text label |
| `href` | String | Yes | Link destination |
| `active` | Boolean | No | Marks the current page |
| `icon` | String | No | Raw HTML/SVG string displayed above the label |
