# SpeedDial

Floating action button (FAB) that expands into a stack of sub-action buttons on click.

Requires `speed_dial_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add speed_dial
```

Creates `app/components/ui/speed_dial_component.rb`.

## Usage

```erb
<%= ui :speed_dial do |dial| %>
  <% dial.with_action(label: "New document", href: new_document_path) %>
  <% dial.with_action(label: "Upload file",  href: uploads_path) %>
  <% dial.with_action(label: "New folder",   href: new_folder_path) %>
<% end %>
```

## Position

| Position | Description |
|----------|-------------|
| `:bottom_right` | Fixed bottom-right (default) |
| `:bottom_left` | Fixed bottom-left |
| `:bottom_center` | Fixed bottom-center |

```erb
<%= ui :speed_dial, position: :bottom_left do |dial| %>
  <% dial.with_action(label: "Add item", href: new_item_path) %>
<% end %>
```

## Button actions (no link)

Pass a block with `data-*` attributes instead of `href:` for JavaScript-triggered actions:

```erb
<%= ui :speed_dial do |dial| %>
  <% dial.with_action(label: "Share", data: { action: "click->share#open" }) %>
<% end %>
```

## API

### SpeedDialComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `position` | Symbol | `:bottom_right` | `:bottom_right`, `:bottom_left`, or `:bottom_center` |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

### ActionComponent (via `with_action`)

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `label` | String | Yes | Button text |
| `href` | String | No | Renders `<a>` when present; otherwise renders `<button>` |
| `**html_attrs` | Hash | — | Forwarded to the `<a>` or `<button>` |
