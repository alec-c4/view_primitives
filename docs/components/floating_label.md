# FloatingLabel

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Input with a label that floats above the field when it is focused or has a value. Pure CSS via Tailwind `peer` utilities — no JavaScript required.

## Installation

```bash
rails g view_primitives:add floating_label
```

Creates `app/components/ui/floating_label_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only floating_label
```


## Usage

```erb
<%= ui :floating_label, label: "Email", name: "user[email]", type: "email" %>
```

## Types

```erb
<%= ui :floating_label, label: "Name",     name: "name",     type: "text" %>
<%= ui :floating_label, label: "Email",    name: "email",    type: "email" %>
<%= ui :floating_label, label: "Password", name: "password", type: "password" %>
```

## Explicit ID

If you omit `id:`, the component derives one from the `name:` attribute. Supply it explicitly when needed:

```erb
<%= ui :floating_label, label: "Username", name: "user[username]", id: "user_username" %>
```

## In a form

```erb
<%= form_with model: @user do |f| %>
  <%= ui :floating_label, label: "Email",
                          name: "user[email]",
                          id:   "user_email",
                          type: "email",
                          value: @user.email %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | required | Visible label text — also used as the input placeholder |
| `type` | String | `"text"` | HTML input type |
| `id` | String | `nil` | Explicit input ID; derived from `name:` when omitted |
| `**html_attrs` | Hash | — | Forwarded to the `<input>` element |
