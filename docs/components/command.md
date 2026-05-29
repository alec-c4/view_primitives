# Command

Command palette dialog with a search input and filterable item list. Opens over an overlay on trigger click.

Requires `command_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add command
```

Creates `app/components/ui/command_component.rb`.

## Usage

```erb
<%= ui :command do |cmd| %>
  <% cmd.with_trigger { ui :button, "⌘K", variant: :outline } %>

  <%# Group heading + items %>
  <div class="<%= UI::CommandComponent::GROUP_WRAPPER %>">
    <p class="<%= UI::CommandComponent::GROUP %>">Pages</p>
    <button class="<%= UI::CommandComponent::ITEM %>" type="button">
      Dashboard
      <span class="<%= UI::CommandComponent::SHORTCUT %>">⌘D</span>
    </button>
    <button class="<%= UI::CommandComponent::ITEM %>" type="button">Settings</button>
  </div>

  <hr class="<%= UI::CommandComponent::SEPARATOR %>">

  <div class="<%= UI::CommandComponent::GROUP_WRAPPER %>">
    <p class="<%= UI::CommandComponent::GROUP %>">Actions</p>
    <button class="<%= UI::CommandComponent::ITEM %>" type="button">New document</button>
  </div>
<% end %>
```

## Filtering

The search input filters visible items client-side. Any item whose text content does not match the query is hidden. When no items match, a "No results found." message is shown automatically.

## Panel CSS constants

| Constant | Use for |
|----------|---------|
| `GROUP_WRAPPER` | Container `<div>` for a group |
| `GROUP` | Group heading `<p>` |
| `ITEM` | Actionable `<button>` or `<a>` items |
| `SHORTCUT` | Keyboard shortcut hint placed inside an item |
| `SEPARATOR` | `<hr>` rule between groups |

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that opens the command palette on click |
