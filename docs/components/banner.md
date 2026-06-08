# Banner

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Styled announcement strip for notices, warnings, and status messages.

## Installation

```bash
rails g view_primitives:add banner
```

Creates `app/components/ui/banner_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only banner
```


## Usage

```erb
<%# Positional message %>
<%= ui :banner, "We just released version 2.0!" %>

<%# Keyword message %>
<%= ui :banner, message: "Scheduled maintenance on Sunday." %>

<%# Block content with a link %>
<%= ui :banner, variant: :info do %>
  New components are available.
  <a href="/changelog" class="ml-1 font-medium underline underline-offset-4">View changelog</a>
<% end %>
```

## Variants

| Variant | Description |
|---------|-------------|
| `default` | Neutral, matches the page background |
| `info` | Blue tones |
| `warning` | Yellow tones |
| `destructive` | Red tones |
| `success` | Green tones |

```erb
<%= ui :banner, "Trial expires in 3 days.",          variant: :warning %>
<%= ui :banner, "Payment failed. Update billing.",   variant: :destructive %>
<%= ui :banner, "Deployment succeeded.",             variant: :success %>
<%= ui :banner, "Read the updated privacy policy.",  variant: :info %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `message` | String | `nil` | Banner text — positional, `message:`, or `label:` keyword, alternative to block |
| `variant` | Symbol | `:default` | Visual style |
| `**html_attrs` | Hash | — | Forwarded to the `<div>` element |
