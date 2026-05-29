# Calendar

Month-grid calendar with selectable days, today highlight, min/max bounds, and prev/next navigation.

Requires `calendar_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add calendar
```

Creates `app/components/ui/calendar_component.rb`.

## Usage

```erb
<%# Standalone (no form) %>
<%= ui :calendar %>

<%# With selected date %>
<%= ui :calendar, selected: Date.today %>
```

## With a form

Pass `name:` to add a hidden input that submits the selected date in ISO 8601 format (`YYYY-MM-DD`).

```erb
<%= form_with model: @booking do |f| %>
  <%= ui :calendar, name: "booking[date]", selected: @booking.date %>
  <%= ui :button, "Reserve", type: "submit" %>
<% end %>
```

## Specific month

```erb
<%= ui :calendar, month: Date.new(2025, 12, 1) %>
```

## Date bounds

```erb
<%= ui :calendar,
       name: "availability[date]",
       min: Date.today,
       max: Date.today + 90 %>
```

Days outside `min`/`max` are rendered as disabled.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `selected` | Date | `nil` | Highlighted selected day |
| `month` | Date | `Date.today` | Month displayed on load |
| `name` | String | `nil` | Form field name for the hidden input |
| `min` | Date | `nil` | Earliest selectable date (earlier days are disabled) |
| `max` | Date | `nil` | Latest selectable date (later days are disabled) |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
