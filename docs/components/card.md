# Card

Bordered container with composable header, title, description, content, and footer sub-components.

## Installation

```bash
rails g view_primitives:add card
```

Creates 6 files under `app/components/ui/`: `card_component.rb`, `card_header_component.rb`,
`card_title_component.rb`, `card_description_component.rb`, `card_content_component.rb`,
`card_footer_component.rb`.

## Usage

```erb
<%= ui :card do %>
  <%= ui :card_header do %>
    <%= ui :card_title, "Account Settings" %>
    <%= ui :card_description, "Manage your account preferences." %>
  <% end %>
  <%= ui :card_content do %>
    <p>Content goes here.</p>
  <% end %>
  <%= ui :card_footer do %>
    <%= ui :button, "Save" %>
  <% end %>
<% end %>
```

## Sub-components

| Component | Element | Description |
|-----------|---------|-------------|
| `card` | `<div>` | Outer container |
| `card_header` | `<div>` | Top area with padding |
| `card_title` | `<h3>` | Heading — positional, `label:`, or block |
| `card_description` | `<div>` | Muted subtitle text |
| `card_content` | `<div>` | Main body area |
| `card_footer` | `<div>` | Bottom action bar |

## API

All sub-components accept `**html_attrs` forwarded to their root element.
`CardTitleComponent` also accepts a positional `title` argument or `label:` / `title:` keywords.
