# Footer

Site footer with optional link columns, block content area, and a copyright row.

## Installation

```bash
rails g view_primitives:add footer
```

Creates `app/components/ui/footer_component.rb`.

## Usage

```erb
<%= ui :footer,
       copyright: "© 2025 Acme Inc.",
       columns: [
         { title: "Product",  links: [{ label: "Features", href: "#" }, { label: "Pricing", href: "#" }] },
         { title: "Company",  links: [{ label: "About",    href: "#" }, { label: "Blog",    href: "#" }] },
         { title: "Legal",    links: [{ label: "Privacy",  href: "#" }, { label: "Terms",   href: "#" }] }
       ] %>
```

## Custom block content

Place any HTML inside the footer between the columns grid and the copyright row:

```erb
<%= ui :footer, copyright: "© 2025 Acme" do %>
  <p class="text-sm text-muted-foreground text-center mb-6">
    Built with ViewPrimitives.
  </p>
<% end %>
```

## Copyright only

```erb
<%= ui :footer, copyright: "© 2025 Acme Inc. All rights reserved." %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `copyright` | String | `nil` | Text shown in the bottom row below a divider |
| `columns` | Array | `[]` | Array of column hashes — see table below |
| `**html_attrs` | Hash | — | Forwarded to the `<footer>` element |

### Column hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `title` | String | Yes | Column heading |
| `links` | Array | Yes | Array of `{ label:, href: }` hashes |
