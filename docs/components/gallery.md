# Gallery

Responsive image grid with an optional click-to-enlarge lightbox.

Requires `gallery_controller.js` (copied automatically by the generator) when `lightbox: true`.

## Installation

```bash
rails g view_primitives:add gallery
```

Creates `app/components/ui/gallery_component.rb`.

## Usage

```erb
<%= ui :gallery do |g| %>
  <% g.with_image(src: "/photos/a.jpg", alt: "Mountain view") %>
  <% g.with_image(src: "/photos/b.jpg", alt: "Beach sunset", caption: "Malibu, 2024") %>
  <% g.with_image(src: "/photos/c.jpg", alt: "City at night") %>
<% end %>
```

## Column count

```erb
<%= ui :gallery, cols: 4 do |g| %>
  <% g.with_image(src: "/p/1.jpg", alt: "Photo 1") %>
  <% g.with_image(src: "/p/2.jpg", alt: "Photo 2") %>
  <% g.with_image(src: "/p/3.jpg", alt: "Photo 3") %>
  <% g.with_image(src: "/p/4.jpg", alt: "Photo 4") %>
<% end %>
```

## Disable lightbox

```erb
<%= ui :gallery, lightbox: false, cols: 2 do |g| %>
  <% g.with_image(src: "/thumb/a.jpg", alt: "A") %>
  <% g.with_image(src: "/thumb/b.jpg", alt: "B") %>
<% end %>
```

## Custom aspect ratio

```erb
<%= ui :gallery, aspect: "aspect-video" do |g| %>
  <% g.with_image(src: "/screens/1.png", alt: "Screenshot") %>
<% end %>
```

## API

### GalleryComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `cols` | Integer | `3` | Grid columns (1–6) |
| `lightbox` | Boolean | `true` | Enable click-to-enlarge overlay |
| `aspect` | String | `"aspect-square"` | Tailwind aspect-ratio class applied to each cell |
| `**html_attrs` | Hash | — | Forwarded to the `<div>` grid |

### ImageComponent (via `with_image`)

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `src` | String | Yes | Image URL |
| `alt` | String | Yes | Alternative text |
| `caption` | String | No | Text shown on hover over the image |
