# Drawer

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Bottom sheet that slides up from the bottom of the viewport. Includes a drag handle and is suited for mobile actions.

Requires `dialog_controller.js` (copied automatically by the generator — shared with Dialog, Sheet, and AlertDialog). Focus is trapped inside the panel while open.

## Installation

```bash
rails g view_primitives:add drawer
```

Creates `app/components/ui/drawer_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only drawer
```


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

Clicking the overlay or pressing `Escape` closes the drawer. Stimulus actions use `dialog#open` and `dialog#close` on the shared `dialog_controller.js`. The drag handle is decorative; it does not enable drag-to-close.

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
