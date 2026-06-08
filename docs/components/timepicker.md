# Timepicker

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Trigger button that opens a clock popover with hour and minute spinners for selecting a time.

Requires `timepicker_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add timepicker
```

Creates `app/components/ui/timepicker_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only timepicker
```


## Usage

```erb
<%= ui :timepicker, name: "event[starts_at]" %>
```

## With initial value

```erb
<%= ui :timepicker, name: "event[starts_at]", value: "14:30" %>
```

## 12-hour format

```erb
<%= ui :timepicker, name: "alarm[time]", format: :h12 %>
```

## Minute step

Common steps are 5, 15, and 30 minutes:

```erb
<%= ui :timepicker, name: "meeting[starts_at]", step: 15, value: "09:00" %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | `nil` | Form field name for the hidden input |
| `value` | String | `nil` | Initial time as `"HH:MM"` |
| `format` | Symbol | `:h24` | `:h24` (24-hour) or `:h12` (12-hour with AM/PM) |
| `step` | Integer | `1` | Minute increment (1–60) |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
