# Image

Responsive `<img>` with lazy loading, srcset/sizes support, and layout-shift prevention.

## Installation

```bash
rails g view_primitives:add image
```

Creates `app/components/ui/image_component.rb`.

## Usage

```erb
<%= ui :image, src: "/photos/hero.jpg", alt: "Hero photo" %>
```

## Responsive images

```erb
<%= ui :image,
       src:    "/photos/hero-1280.jpg",
       alt:    "Hero",
       srcset: "/photos/hero-640.jpg 640w, /photos/hero-1280.jpg 1280w",
       sizes:  "(max-width: 640px) 100vw, 1280px",
       width:  1280,
       height: 720 %>
```

## Eager loading

Pass `loading: :eager` for above-the-fold images to avoid the lazy-load delay:

```erb
<%= ui :image, src: "/photos/lcp.jpg", alt: "Main image", loading: :eager,
               width: 800, height: 600 %>
```

## Prevent layout shift

Always supply `width:` and `height:` for images with known dimensions:

```erb
<%= ui :image, src: "/avatar.png", alt: "User avatar",
               width: 48, height: 48, class: "rounded-full" %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `src` | String | required | Image URL |
| `alt` | String | required | Alternative text (use `""` for decorative images) |
| `srcset` | String | `nil` | Responsive image set |
| `sizes` | String | `nil` | Media conditions for srcset |
| `loading` | Symbol | `:lazy` | `:lazy`, `:eager`, or `:auto` |
| `width` | Integer | `nil` | Native width — prevents layout shift |
| `height` | Integer | `nil` | Native height — prevents layout shift |
| `**html_attrs` | Hash | — | Forwarded to the `<img>` element |
