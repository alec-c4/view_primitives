# Input

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Single-line text input with consistent focus, invalid, and disabled states. Base styles come from `UI::Styles::INPUT` (`vp-input` in CSS).

## Installation

```bash
rails g view_primitives:add input
```

Creates `app/components/ui/input_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only input
```


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
