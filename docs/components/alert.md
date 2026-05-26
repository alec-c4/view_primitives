# Alert

Informational banner for surfacing status messages, warnings, and errors. Accepts plain-text content via kwargs or rich HTML via slots.

## Installation

```bash
rails g view_primitives:add alert
```

Creates `app/components/ui/alert_component.rb`.

## Usage

```erb
<%# Kwargs — plain text, no block needed %>
<%= ui :alert, title: "Heads up!", description: "You can change this in your account settings." %>

<%# Slots — for rich HTML content %>
<%= ui :alert do |alert| %>
  <% alert.with_alert_title { "Heads up!" } %>
  <% alert.with_alert_description { "You can change this in your account settings." } %>
<% end %>
```

Slots take precedence over kwargs when both are provided.

## Variants

| Variant | Description |
|---------|-------------|
| `default` | Neutral — uses `--background` and `--foreground` |
| `destructive` | Error or danger — uses `--destructive` colour |

```erb
<%= ui :alert, variant: :default,
                title: "Note",
                description: "Your free trial expires in 3 days." %>

<%= ui :alert, variant: :destructive,
                title: "Error",
                description: "Your session has expired. Please log in again." %>
```

## Slots

Use slots when the content contains HTML, links, or other components:

```erb
<%# Title only %>
<%= ui :alert, title: "Maintenance scheduled for Sunday 02:00 UTC." %>

<%# Rich description via slot %>
<%= ui :alert, title: "Action required" do |alert| %>
  <% alert.with_alert_description do %>
    Please <%= link_to "update your billing info", billing_path %> before Friday.
  <% end %>
<% end %>
```

## With an icon

Place an SVG before the slots. The component shifts content right automatically via `[&>svg~*]:pl-7`:

```erb
<%= ui :alert, variant: :destructive do |alert| %>
  <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4" ...>...</svg>
  <% alert.with_alert_title { "Error" } %>
  <% alert.with_alert_description { "Something went wrong." } %>
<% end %>
```

## Flash messages

```erb
<%# app/views/shared/_flash.html.erb %>
<% flash.each do |type, message| %>
  <%= ui :alert, variant: flash_variant(type), description: message %>
<% end %>
```

```ruby
# app/helpers/flash_helper.rb
module FlashHelper
  FLASH_VARIANTS = {
    "notice"  => :default,
    "success" => :default,
    "alert"   => :destructive,
    "error"   => :destructive,
    "warning" => :destructive
  }.freeze

  def flash_variant(type)
    FLASH_VARIANTS.fetch(type.to_s, :default)
  end
end
```

```erb
<%# app/views/layouts/application.html.erb %>
<body>
  <div class="container mx-auto px-4 py-2 space-y-2">
    <%= render "shared/flash" %>
  </div>
  <%= yield %>
</body>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `variant` | Symbol | `:default` | Visual style — see Variants table |
| `title` | String | `nil` | Plain-text title, alternative to `with_alert_title` slot |
| `description` | String | `nil` | Plain-text description, alternative to `with_alert_description` slot |

| Slot | Required | Description |
|------|----------|-------------|
| `alert_title` | No | Rich title — renders as `<h5>`. Takes precedence over `title:` kwarg |
| `alert_description` | No | Rich description — renders as `<div>`. Takes precedence over `description:` kwarg |
