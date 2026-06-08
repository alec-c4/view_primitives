# Carousel

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Scrollable slide container with previous/next controls and optional dot indicators.

Requires `carousel_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add carousel
```

Creates `app/components/ui/carousel_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only carousel
```


## Usage

```erb
<%= ui :carousel do |c| %>
  <% c.with_slide { image_tag "slide1.jpg", alt: "Slide 1", class: "w-full object-cover" } %>
  <% c.with_slide { image_tag "slide2.jpg", alt: "Slide 2", class: "w-full object-cover" } %>
  <% c.with_slide { image_tag "slide3.jpg", alt: "Slide 3", class: "w-full object-cover" } %>
<% end %>
```

## Autoplay

```erb
<%= ui :carousel, autoplay: 3000 do |c| %>
  <% c.with_slide { "Slide 1" } %>
  <% c.with_slide { "Slide 2" } %>
<% end %>
```

## No loop

```erb
<%= ui :carousel, loop: false do |c| %>
  <% c.with_slide { "First" } %>
  <% c.with_slide { "Last" } %>
<% end %>
```

## Without indicators

```erb
<%= ui :carousel, indicators: false do |c| %>
  <% c.with_slide { "Slide" } %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `loop` | Boolean | `true` | Wrap from the last slide to the first (and vice versa) |
| `indicators` | Boolean | `true` | Show dot indicators below the slides |
| `autoplay` | Integer | `0` | Auto-advance interval in milliseconds; `0` disables autoplay |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
