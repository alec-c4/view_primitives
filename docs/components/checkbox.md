# Checkbox

Styled checkbox input with optional inline label.

## Installation

```bash
rails g view_primitives:add checkbox
```

Creates `app/components/ui/checkbox_component.rb`.

## Usage

```erb
<%# Standalone (no label) %>
<%= ui :checkbox, name: "agreed", id: "agreed" %>

<%# With inline label %>
<%= ui :checkbox, name: "agreed", id: "agreed", label: "I agree to the terms" %>
```

## Checked by default

```erb
<%= ui :checkbox, name: "subscribe", id: "subscribe",
                  label: "Subscribe to newsletter", checked: true %>
```

## States

```erb
<%# Disabled %>
<%= ui :checkbox, name: "locked", id: "locked", label: "Not available", disabled: true %>

<%# Invalid %>
<%= ui :checkbox, name: "agreed", id: "agreed", "aria-invalid": "true" %>
```

## In a form builder

```erb
<%= form_with model: @user do |f| %>
  <%= ui :checkbox, name: "user[newsletter]", id: "user_newsletter",
                    label: "Subscribe to newsletter",
                    checked: @user.newsletter %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Text shown next to the checkbox in a `<label>` |
| `checked` | Boolean | `false` | Pre-checked state |
| `**html_attrs` | Hash | — | Forwarded to the `<input type="checkbox">` element |
