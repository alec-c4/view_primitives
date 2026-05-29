# FormField

Wrapper that composes a label, any input component, an optional hint, and an error message into a consistent vertical layout.

## Installation

```bash
rails g view_primitives:add form_field
```

Creates `app/components/ui/form_field_component.rb`.

## Usage

```erb
<%= ui :form_field, label: "Email" do %>
  <%= ui :input, type: "email", name: "user[email]", id: "user_email" %>
<% end %>
```

## With hint and error

```erb
<%= ui :form_field,
       label: "Username",
       hint:  "Letters and numbers only.",
       error: @user.errors[:username].first do %>
  <%= ui :input, name: "user[username]", id: "user_username",
                 value: @user.username,
                 "aria-invalid": @user.errors[:username].any? %>
<% end %>
```

When `error:` is present the hint is hidden and the error is shown instead.

## Required field

```erb
<%= ui :form_field, label: "Password", required: true do %>
  <%= ui :input, type: "password", name: "user[password]", id: "user_password" %>
<% end %>
```

A red asterisk (`*`) is appended to the label when `required: true`.

## Composing with other inputs

FormField works with any input component:

```erb
<%# With select %>
<%= ui :form_field, label: "Country" do %>
  <%= ui :select, name: "user[country]", options: ["US", "CA", "MX"] %>
<% end %>

<%# With textarea %>
<%= ui :form_field, label: "Bio", hint: "Max 280 characters." do %>
  <%= ui :textarea, name: "user[bio]", id: "user_bio" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Label text shown above the input |
| `hint` | String | `nil` | Muted helper text shown below the input (hidden when `error:` is present) |
| `error` | String | `nil` | Red error message shown below the input |
| `required` | Boolean | `false` | Appends a red `*` to the label |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` wrapper |
