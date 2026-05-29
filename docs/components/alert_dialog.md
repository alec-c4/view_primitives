# AlertDialog

Confirmation dialog that blocks interaction with the rest of the page. Use for destructive or irreversible actions.

Requires `dialog_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add alert_dialog
```

Creates `app/components/ui/alert_dialog_component.rb`.

## Usage

```erb
<%= ui :alert_dialog,
       title: "Delete account",
       description: "This action cannot be undone. Your data will be permanently removed." do |dialog| %>
  <% dialog.with_trigger { ui :button, "Delete account", variant: :destructive } %>

  <% dialog.with_footer do %>
    <%= ui :button, "Cancel", variant: :outline,
                    data: { action: "click->dialog#close" } %>
    <%= ui :button, "Yes, delete", variant: :destructive,
                    data: { turbo_method: :delete, turbo_confirm: false } %>
  <% end %>
<% end %>
```

## Differences from Dialog

AlertDialog uses `role="alertdialog"` and a darker overlay (`bg-black/80`). It also has no close button — the user must choose an action via the footer.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | `nil` | Bold heading |
| `description` | String | `nil` | Muted description |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that opens the dialog on click |
| `footer` | No | Action buttons (cancel + confirm) |
