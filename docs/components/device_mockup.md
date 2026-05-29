# DeviceMockup

Decorative device frame — phone, tablet, or browser window — that wraps any content.

## Installation

```bash
rails g view_primitives:add device_mockup
```

Creates `app/components/ui/device_mockup_component.rb`.

## Usage

```erb
<%= ui :device_mockup do %>
  <%= image_tag "app-screenshot.png", alt: "App screenshot", class: "w-full" %>
<% end %>
```

## Variants

| Variant | Description |
|---------|-------------|
| `:phone` | Portrait phone frame with top notch (default) |
| `:tablet` | Landscape tablet frame |
| `:browser` | Browser window with macOS-style traffic-light dots |

```erb
<%= ui :device_mockup, variant: :browser do %>
  <%= image_tag "dashboard.png", alt: "Dashboard", class: "w-full" %>
<% end %>

<%= ui :device_mockup, variant: :tablet do %>
  <%= image_tag "tablet-app.png", alt: "Tablet view", class: "w-full h-full object-cover" %>
<% end %>
```

## Browser address bar

Pass `url:` when using `:browser` to display a fake address bar:

```erb
<%= ui :device_mockup, variant: :browser, url: "https://example.com/dashboard" do %>
  <%= image_tag "dashboard.png", alt: "Dashboard", class: "w-full" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `variant` | Symbol | `:phone` | `:phone`, `:browser`, or `:tablet` |
| `url` | String | `nil` | Address bar text (`:browser` variant only) |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
