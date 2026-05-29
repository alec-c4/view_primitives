# Navbar

Sticky top navigation bar with brand link, desktop nav links, an action area, and a mobile hamburger menu.

Requires `navbar_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add navbar
```

Creates `app/components/ui/navbar_component.rb`.

## Usage

```erb
<%= ui :navbar,
       brand: "Acme",
       brand_href: root_path,
       items: [
         { label: "Home",     href: root_path,    active: true },
         { label: "Products", href: products_path },
         { label: "Pricing",  href: pricing_path }
       ] %>
```

## Action area

Pass a block to add content (e.g. sign-in button) to the right side of the navbar. It is hidden on mobile.

```erb
<%= ui :navbar,
       brand: "Acme",
       items: [{ label: "Home", href: root_path }] do %>
  <%= ui :button, "Sign in", href: new_session_path, size: :sm %>
<% end %>
```

## Brand only (no nav links)

```erb
<%= ui :navbar, brand: "Acme", brand_href: root_path %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `brand` | String | `nil` | Brand name shown as a link on the left |
| `brand_href` | String | `"/"` | URL for the brand link |
| `items` | Array | `[]` | Array of `{ label:, href:, active: }` hashes |
| `**html_attrs` | Hash | — | Forwarded to the `<nav>` element |

### Item hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `label` | String | Yes | Link text |
| `href` | String | Yes | Link destination |
| `active` | Boolean | No | Applies active text colour |
