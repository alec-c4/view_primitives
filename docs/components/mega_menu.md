# MegaMenu

Full-width dropdown panel anchored to a trigger button, organised into titled columns.

Requires `mega_menu_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add mega_menu
```

Creates `app/components/ui/mega_menu_component.rb`.

## Usage

```erb
<%= ui :mega_menu, label: "Products" do |menu| %>
  <% menu.with_column(heading: "Design", items: [
    { title: "UI Kit",     description: "Tailwind component library", href: "/ui-kit" },
    { title: "Templates",  description: "Ready-to-use page templates", href: "/templates" }
  ]) %>
  <% menu.with_column(heading: "Developer", items: [
    { title: "CLI",        description: "Command-line generator",     href: "/cli" },
    { title: "API",        description: "Full API reference",         href: "/api" }
  ]) %>
<% end %>
```

## Fixed column count

By default the panel uses as many columns as slots. Override with `cols:`:

```erb
<%= ui :mega_menu, label: "Solutions", cols: 3 do |menu| %>
  <% menu.with_column(items: [...]) %>
  <% menu.with_column(items: [...]) %>
<% end %>
```

## API

### MegaMenuComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | required | Trigger button text |
| `cols` | Integer | `nil` | Grid column count; defaults to number of `with_column` slots |
| `**html_attrs` | Hash | — | Forwarded to the outer wrapper `<div>` |

### ColumnComponent (via `with_column`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `heading` | String | `nil` | Optional column heading shown in small uppercase text |
| `items` | Array | `[]` | Array of `{ title:, description:, href: }` hashes |
