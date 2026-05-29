# Collapsible

Expandable section built on native `<details>`/`<summary>`. No JavaScript required.

## Installation

```bash
rails g view_primitives:add collapsible
```

Creates `app/components/ui/collapsible_component.rb`.

## Usage

```erb
<%= ui :collapsible do |c| %>
  <% c.with_trigger do %>
    <span class="text-sm font-medium">Show details</span>
    <svg class="size-4 text-muted-foreground" ...></svg>
  <% end %>

  <p class="text-sm text-muted-foreground">
    This content is revealed when the trigger is clicked.
  </p>
<% end %>
```

## Open by default

```erb
<%= ui :collapsible, open: true do |c| %>
  <% c.with_trigger { "Hide details" } %>
  <p>Visible on page load.</p>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `open` | Boolean | `false` | Render the section expanded on page load |
| `**html_attrs` | Hash | — | Forwarded to the `<details>` element |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Content of the `<summary>` row |
