# Label

Accessible form label that pairs with an input via `for:`.

## Installation

```bash
rails g view_primitives:add label
```

Creates `app/components/ui/label_component.rb`.

## Usage

```erb
<%# Positional text %>
<%= ui :label, "Email address", for: "email" %>

<%# Keyword label %>
<%= ui :label, label: "Password", for: "password" %>

<%# Block content (for rich labels) %>
<%= ui :label, for: "terms" do %>
  I accept the <a href="/terms">terms of service</a>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `text` | String | `nil` | Label text — positional or `label:` keyword |
| `for` | String | `nil` | The `id` of the associated input element |
| `**html_attrs` | Hash | — | Forwarded to the `<label>` element |
