# Switch

Toggle switch built from a styled checkbox. Thumb slides on check; no JavaScript required.

## Installation

```bash
rails g view_primitives:add switch
```

Creates `app/components/ui/switch_component.rb`.

## Usage

```erb
<%# Standalone %>
<%= ui :switch, name: "notifications", id: "notifications" %>

<%# With label %>
<%= ui :switch, name: "dark_mode", id: "dark_mode", label: "Dark mode" %>
```

## Checked by default

```erb
<%= ui :switch, name: "emails", id: "emails", label: "Email notifications", checked: true %>
```

## In a form

```erb
<%= form_with model: @settings do |f| %>
  <%= ui :switch, name: "settings[dark_mode]", id: "settings_dark_mode",
                  label: "Dark mode", checked: @settings.dark_mode %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Visible label rendered beside the switch |
| `checked` | Boolean | `false` | Initial on/off state |
| `**html_attrs` | Hash | — | Forwarded to the hidden `<input type="checkbox">` |
