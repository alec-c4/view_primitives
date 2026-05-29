# DropdownMenu

Floating menu that opens below a trigger element. Use for actions, options, or navigation items.

Requires `dropdown_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add dropdown_menu
```

Creates `app/components/ui/dropdown_menu_component.rb`.

## Usage

Build the panel content using the CSS constants exported by the component:

```erb
<%= ui :dropdown_menu do |menu| %>
  <% menu.with_trigger { ui :button, "Options" } %>
  <div class="<%= UI::DropdownMenuComponent::LABEL_CLS %>">My Account</div>
  <a href="<%= profile_path %>" class="<%= UI::DropdownMenuComponent::ITEM %>">Profile</a>
  <a href="<%= settings_path %>" class="<%= UI::DropdownMenuComponent::ITEM %>">Settings</a>
  <div class="<%= UI::DropdownMenuComponent::SEPARATOR %>"></div>
  <a href="<%= sign_out_path %>" class="<%= UI::DropdownMenuComponent::ITEM %>"
     data-turbo-method="delete">Sign out</a>
<% end %>
```

## Alignment

| Align | Description |
|-------|-------------|
| `:start` | Left-aligned (default) |
| `:end` | Right-aligned |

```erb
<%= ui :dropdown_menu, align: :end do |menu| %>
  <% menu.with_trigger { ui :button, "Actions", variant: :outline } %>
  <a href="#" class="<%= UI::DropdownMenuComponent::ITEM %>">Edit</a>
  <a href="#" class="<%= UI::DropdownMenuComponent::ITEM %>">Duplicate</a>
<% end %>
```

## Panel CSS constants

These constants are available for use in the panel body:

| Constant | Use for |
|----------|---------|
| `ITEM` | Actionable links or buttons |
| `SEPARATOR` | Horizontal rule between groups |
| `LABEL_CLS` | Non-interactive group headings |

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `align` | Symbol | `:start` | `:start` or `:end` — panel alignment relative to trigger |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that toggles the menu on click |
