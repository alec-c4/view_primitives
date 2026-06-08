# Breadcrumb

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Accessible `<nav>` trail showing the current page's path through a hierarchy.

## Installation

```bash
rails g view_primitives:add breadcrumb
```

Creates `app/components/ui/breadcrumb_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only breadcrumb
```


## Usage

Pass an `items:` array. The last item is the current page (no `href:` needed).

```erb
<%= ui :breadcrumb, items: [
  { label: "Home",     href: root_path },
  { label: "Products", href: products_path },
  { label: "Widget Pro" }
] %>
```

## Custom separator

```erb
<%= ui :breadcrumb,
       separator: "›",
       items: [
         { label: "Home",     href: root_path },
         { label: "Settings", href: settings_path },
         { label: "Security" }
       ] %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `items` | Array | `[]` | Array of `{ label:, href: }` hashes; last item is the current page (no `href:`) |
| `separator` | String | `"/"` | Character rendered between items |
| `**html_attrs` | Hash | — | Forwarded to the `<nav>` element |

### Item hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `label` | String | Yes | Display text |
| `href` | String | No | Link destination; omit for the current page |
