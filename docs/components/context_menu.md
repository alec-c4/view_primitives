# ContextMenu

Right-click menu that appears at the cursor position over a target area.

Requires `context_menu_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add context_menu
```

Creates `app/components/ui/context_menu_component.rb`.

## Usage

Wrap the target area in the component. The `menu` slot provides the panel content.

```erb
<%= ui :context_menu do |ctx| %>
  <% ctx.with_menu do %>
    <a href="#" class="<%= UI::ContextMenuComponent::ITEM %>">Open</a>
    <a href="#" class="<%= UI::ContextMenuComponent::ITEM %>">Rename</a>
    <div class="<%= UI::ContextMenuComponent::SEPARATOR %>"></div>
    <a href="#" class="<%= UI::ContextMenuComponent::ITEM %>">Delete</a>
  <% end %>

  <%# The right-clickable area %>
  <div class="rounded-lg border p-10 text-center text-sm text-muted-foreground">
    Right-click here
  </div>
<% end %>
```

## Panel CSS constants

| Constant | Use for |
|----------|---------|
| `ITEM` | Actionable links or buttons |
| `SEPARATOR` | Horizontal rule between groups |
| `LABEL_CLS` | Non-interactive section headings |

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the target area `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `menu` | No | Panel content rendered at cursor position on right-click |
