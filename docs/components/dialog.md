# Dialog

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Accessible modal dialog with an overlay, title, description, body, and footer slot.

Requires `dialog_controller.js` (copied automatically by the generator). Focus is trapped inside the panel while open; Tab cycles through focusable elements. Escape closes the dialog and restores focus to the trigger.

## Installation

```bash
rails g view_primitives:add dialog
```

Creates `app/components/ui/dialog_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only dialog
```


## Usage

```erb
<%= ui :dialog, title: "Edit profile", description: "Make changes to your profile here." do |dialog| %>
  <% dialog.with_trigger { ui :button, "Open dialog" } %>

  <%= ui :form_field, label: "Name" do %>
    <%= ui :input, name: "name", id: "name" %>
  <% end %>

  <% dialog.with_footer do %>
    <%= ui :button, "Cancel",       variant: :outline,
                    data: { action: "click->dialog#close" } %>
    <%= ui :button, "Save changes", type: "submit" %>
  <% end %>
<% end %>
```

## Without a trigger slot

Open programmatically by calling `dialog#open` from another Stimulus action:

```erb
<%= ui :dialog, title: "Confirmation" do |dialog| %>
  <p>Are you sure you want to proceed?</p>
  <% dialog.with_footer do %>
    <%= ui :button, "Confirm", variant: :destructive %>
  <% end %>
<% end %>
```

## Close on Escape

The dialog closes automatically when the user presses `Escape`. Focus returns to the element that was active before the dialog opened.

## Focus trap

While open, Tab and Shift+Tab cycle only through focusable elements inside the panel (`role="dialog"`). The overlay click and close button also call `dialog#close`.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | `nil` | Bold heading rendered inside the panel |
| `description` | String | `nil` | Muted subtext below the title |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that opens the dialog on click |
| `footer` | No | Action buttons shown at the bottom of the panel |
