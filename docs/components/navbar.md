# Navbar

Sticky top navigation bar with brand link, desktop nav links, an action area, and a mobile hamburger menu.

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Requires `navbar_controller.js` (copied automatically by the generator). On viewports below `md`, a hamburger button toggles a collapsible panel with the same nav links; choosing a link closes the panel.

## Installation

```bash
rails g view_primitives:add navbar
```

Creates `app/components/ui/navbar_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only navbar
```

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

## Mobile menu

When `items` is non-empty, a hamburger button appears on small screens (`md:hidden`). It toggles a panel below the header with the same links and the block action area. Links call `navbar#close` on click. The toggle sets `aria-expanded` and `aria-controls` for accessibility.

## Action area

Pass a block to add content (e.g. sign-in button) to the right side of the navbar. It is hidden on mobile.

```erb
<%= ui :navbar,
       brand: "Acme",
       items: [{ label: "Home", href: root_path }] do %>
  <%= ui :button, "Sign in", href: new_session_path, size: :sm %>
<% end %>
```

## Contained preview

The navbar renders `border-b border-border` on the `<nav>` element. When embedding it inside a bordered demo card, remove the overlapping bottom border to avoid a double line:

```erb
<div class="overflow-hidden rounded-lg border border-border">
  <%= ui :navbar, class: "static border-b-0 shadow-none", brand: "MyApp", items: [...] %>
</div>
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
