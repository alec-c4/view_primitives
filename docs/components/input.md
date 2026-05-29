# Input

Single-line text input with consistent focus, invalid, and disabled states.

## Installation

```bash
rails g view_primitives:add input
```

Creates `app/components/ui/input_component.rb`.

## Usage

```erb
<%= ui :input, name: "email", type: "email", placeholder: "you@example.com" %>
```

## Types

Pass any valid `<input>` type via the `type:` option:

```erb
<%= ui :input, type: "text",     name: "username" %>
<%= ui :input, type: "email",    name: "email" %>
<%= ui :input, type: "password", name: "password" %>
<%= ui :input, type: "file" %>
```

## States

```erb
<%# Disabled %>
<%= ui :input, name: "locked", value: "readonly value", disabled: true %>

<%# Invalid (aria-driven styling) %>
<%= ui :input, name: "email", "aria-invalid": "true" %>
```

## With a form builder

```erb
<%= form_with model: @user do |f| %>
  <%= ui :input, name: "user[email]", id: "user_email", type: "email",
                 value: @user.email, "aria-invalid": @user.errors[:email].any? %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `type` | String | `"text"` | HTML input type |
| `**html_attrs` | Hash | — | Forwarded to the `<input>` element |
