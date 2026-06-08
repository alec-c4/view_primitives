# Tabs

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Tabbed panel that shows one content pane at a time.

Requires `tabs_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add tabs
```

Creates `app/components/ui/tabs_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only tabs
```


## Usage

### Data array shorthand

```erb
<%= ui :tabs, items: [
  { title: "Account",  content: "Manage your account settings." },
  { title: "Password", content: "Change your password here." },
  { title: "Billing",  content: "View and manage billing information." }
] %>
```

### Slot API (for rich tab content)

```erb
<%= ui :tabs do |tabs| %>
  <% tabs.with_tab(title: "Account") do %>
    <p>Manage your account settings.</p>
    <%= ui :button, "Save changes", type: "submit" %>
  <% end %>
  <% tabs.with_tab(title: "Password") do %>
    <%= ui :input, type: "password", name: "password", placeholder: "New password" %>
  <% end %>
<% end %>
```

## Default open tab

```erb
<%= ui :tabs, default_index: 1, items: [
  { title: "Overview", content: "…" },
  { title: "Activity", content: "Opens by default." }
] %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `items` | Array | `nil` | Array of `{ title:, content: }` hashes for plain-text content |
| `default_index` | Integer | `0` | Zero-based index of the initially open tab |
| `**html_attrs` | Hash | — | Forwarded to the outer wrapper element |
