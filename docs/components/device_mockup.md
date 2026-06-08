# DeviceMockup

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Decorative device frame — iPhone, iPad, or browser window — that wraps screenshot or live content.

## Installation

```bash
rails g view_primitives:add device_mockup
```

Creates `app/components/ui/device_mockup_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only device_mockup
```

## Usage

Fill the screen area with `absolute inset-0` so content covers the full display:

```erb
<%= ui :device_mockup do %>
  <%= image_tag "app-screenshot.png", alt: "App screenshot", class: "absolute inset-0 size-full object-cover" %>
<% end %>
```

For placeholder or live UI previews:

```erb
<%= ui :device_mockup, variant: :phone do %>
  <div class="absolute inset-0 flex items-center justify-center bg-background">
    <%= render MyAppPreviewComponent.new %>
  </div>
<% end %>
```

## Variants

| Variant | Description |
|---------|-------------|
| `:phone` | iPhone-style portrait frame: Dynamic Island, volume/power buttons, home indicator. `max-w-[280px]`, `aspect-[393/852]`. |
| `:tablet` | iPad-style landscape frame: front camera dot, home indicator. `max-w-[640px]`, `aspect-[3/2]`. |
| `:browser` | macOS-style browser window with traffic-light dots. Up to `max-w-3xl`. |

```erb
<%= ui :device_mockup, variant: :browser, url: "https://example.com/dashboard" do %>
  <%= image_tag "dashboard.png", alt: "Dashboard", class: "w-full" %>
<% end %>

<%= ui :device_mockup, variant: :tablet do %>
  <%= image_tag "tablet-app.png", alt: "Tablet view", class: "absolute inset-0 size-full object-cover" %>
<% end %>
```

## Structure

Phone and tablet variants use three layers:

1. **Shell** — holds aspect ratio and hardware buttons (outside `overflow-hidden`)
2. **Bezel** — metallic gradient frame with rounded corners
3. **Screen** — inset display area; overlays (Dynamic Island, home indicator) sit above slot content

Do not pass `w-full` on the component root for tablet — it breaks the fixed aspect ratio. Size the parent container instead.

## Browser address bar

Pass `url:` with `:browser` to show a fake address bar:

```erb
<%= ui :device_mockup, variant: :browser, url: "https://example.com/dashboard" do %>
  ...
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `variant` | Symbol | `:phone` | `:phone`, `:browser`, or `:tablet` |
| `url` | String | `nil` | Address bar text (`:browser` variant only) |
| `**html_attrs` | Hash | — | Forwarded to the outer shell `<div>` |
