# InputOtp

One-time-password digit input group. Renders N individual single-character inputs that auto-advance on entry and support paste.

Requires `input_otp_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add input_otp
```

Creates `app/components/ui/input_otp_component.rb`.

## Usage

```erb
<%= ui :input_otp, name: "otp" %>
```

By default this renders 6 digit cells.

## Custom length

```erb
<%= ui :input_otp, name: "pin", length: 4 %>
```

## With separator

Pass an integer to add a separator character before a specific cell index:

```erb
<%# Separator before index 3 → renders "XXX - XXX" %>
<%= ui :input_otp, name: "otp", length: 6, separator: 3 %>

<%# Custom character and position %>
<%= ui :input_otp, name: "otp", length: 6, separator: { 3 => "—" } %>
```

## In a form

```erb
<%= form_with url: verify_path do %>
  <%= ui :input_otp, name: "otp", length: 6 %>
  <%= ui :button, "Verify", type: "submit" %>
<% end %>
```

Each digit is submitted as `otp[0]`, `otp[1]`, … `otp[5]`. The first cell sets `autocomplete="one-time-code"` for browser autofill.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `length` | Integer | `6` | Number of digit cells |
| `name` | String | `"otp"` | Base field name; cells submit as `name[0]`, `name[1]`, etc. |
| `separator` | Integer or Hash | `nil` | Position (Integer) or `{ position => char }` for a visual separator |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
