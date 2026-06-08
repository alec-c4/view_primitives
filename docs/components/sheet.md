# Sheet

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Slide-in panel attached to one edge of the viewport. Use for secondary content, filters, or navigation drawers on desktop.

Requires `dialog_controller.js` (copied automatically by the generator — shared with Dialog, Drawer, and AlertDialog). Focus is trapped inside the panel while open.

## Installation

```bash
rails g view_primitives:add sheet
```

Creates `app/components/ui/sheet_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only sheet
```


## Usage

```erb
<%= ui :sheet, title: "Cart", side: :right do |sheet| %>
  <% sheet.with_trigger { ui :button, "Open cart" } %>

  <p>Your cart is empty.</p>

  <% sheet.with_footer do %>
    <%= ui :button, "Checkout", class: "w-full" %>
  <% end %>
<% end %>
```

## Sides

| Side | Description |
|------|-------------|
| `:right` | Slides in from the right (default) |
| `:left` | Slides in from the left |
| `:top` | Slides down from the top |
| `:bottom` | Slides up from the bottom |

```erb
<%= ui :sheet, side: :left, title: "Navigation" do |sheet| %>
  <% sheet.with_trigger { ui :button, "Menu", variant: :ghost } %>
  <nav>…</nav>
<% end %>
```

## Close on overlay click or Escape

Clicking the backdrop, the × button, or pressing `Escape` closes the sheet. Stimulus actions use `dialog#open` and `dialog#close` on the shared `dialog_controller.js`.

Footer buttons must also target `dialog#close`:

```erb
<% sheet.with_footer do %>
  <%= ui :button, "Close", variant: :outline, data: { action: "click->dialog#close" } %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | `nil` | Panel heading |
| `description` | String | `nil` | Muted subtext below the title |
| `side` | Symbol | `:right` | `:right`, `:left`, `:top`, or `:bottom` |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that opens the sheet on click |
| `footer` | No | Action buttons at the bottom of the panel |
