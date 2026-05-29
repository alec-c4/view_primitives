# NavigationMenu

Horizontal navigation bar with plain links and optional flyout dropdown panels.

Requires `navigation_menu_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add navigation_menu
```

Creates `app/components/ui/navigation_menu_component.rb`.

## Usage

### Plain links

```erb
<%= ui :navigation_menu do |nav| %>
  <% nav.with_item(label: "Home",     href: root_path, active: true) %>
  <% nav.with_item(label: "Products", href: products_path) %>
  <% nav.with_item(label: "Pricing",  href: pricing_path) %>
<% end %>
```

### Item with flyout panel

Omit `href:` to render a trigger button. Add any HTML content to the block — it becomes the flyout.

```erb
<%= ui :navigation_menu do |nav| %>
  <% nav.with_item(label: "Home", href: root_path) %>
  <% nav.with_item(label: "Products") do %>
    <ul class="space-y-1 p-2">
      <li><%= link_to "Widget Pro", widget_pro_path %></li>
      <li><%= link_to "Widget Lite", widget_lite_path %></li>
    </ul>
  <% end %>
<% end %>
```

## API

### NavigationMenuComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the `<nav>` element |

### ItemComponent (via `with_item`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | required | Link or trigger text |
| `href` | String | `nil` | Present → plain link; absent → trigger with flyout |
| `active` | Boolean | `false` | Applies `aria-current="page"` styling |
| `**html_attrs` | Hash | — | Forwarded to the `<a>` or `<button>` element |
