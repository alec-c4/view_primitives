# Drawer

Bottom sheet that slides up from the bottom of the viewport. Includes a drag handle and is suited for mobile actions.

Requires `drawer_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add drawer
```

Creates `app/components/ui/drawer_component.rb`.

## Usage

```erb
<%= ui :drawer, title: "Share post" do |drawer| %>
  <% drawer.with_trigger { ui :button, "Share" } %>

  <p class="text-sm text-muted-foreground">Choose how you want to share this post.</p>

  <% drawer.with_footer do %>
    <%= ui :button, "Copy link", class: "w-full" %>
  <% end %>
<% end %>
```

## Close behaviour

Clicking the overlay or pressing `Escape` closes the drawer. The drag handle is decorative; it does not enable drag-to-close.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | `nil` | Bold heading inside the panel |
| `description` | String | `nil` | Muted subtext below the title |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that opens the drawer on click |
| `footer` | No | Action buttons at the bottom of the panel |
