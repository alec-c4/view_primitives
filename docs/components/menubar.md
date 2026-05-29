# Menubar

Horizontal application menu bar with multiple top-level menus, each opening a dropdown panel. Keyboard navigation and outside-click dismissal are handled by Stimulus.

Requires `menubar_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add menubar
```

Creates `app/components/ui/menubar_component.rb`.

## Usage

Menus are composed via the `with_menus` slot on `MenubarMenuComponent`. The MenubarMenuComponent class is generated alongside the parent.

```erb
<%= ui :menubar do |bar| %>
  <% bar.with_menus(label: "File") do %>
    <a href="#" class="<%= UI::MenubarComponent::ITEM %>">New file</a>
    <a href="#" class="<%= UI::MenubarComponent::ITEM %>">Open…</a>
    <div class="<%= UI::MenubarComponent::SEPARATOR %>"></div>
    <a href="#" class="<%= UI::MenubarComponent::ITEM %>">Save</a>
  <% end %>
  <% bar.with_menus(label: "Edit") do %>
    <a href="#" class="<%= UI::MenubarComponent::ITEM %>">Undo</a>
    <a href="#" class="<%= UI::MenubarComponent::ITEM %>">Redo</a>
  <% end %>
<% end %>
```

## Panel CSS constants

| Constant | Use for |
|----------|---------|
| `ITEM` | Actionable links or buttons inside a menu |
| `SEPARATOR` | Horizontal rule between groups |
| `LABEL_CLS` | Non-interactive group headings |

## API

### MenubarComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the `<div>` bar wrapper |

### MenubarMenuComponent (via `with_menus`)

Accepts a `label:` keyword (the menu trigger text) and a block for the panel content. Read the generated `menubar_menu_component.rb` for the full signature.
