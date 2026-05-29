# Iframe

Accessible `<iframe>` with sandboxing, lazy loading, and optional aspect-ratio wrapper.

## Installation

```bash
rails g view_primitives:add iframe
```

Creates `app/components/ui/iframe_component.rb`.

## Usage

```erb
<%= ui :iframe, src: "https://www.youtube.com/embed/dQw4w9WgXcQ",
                title: "YouTube video: Rick Astley — Never Gonna Give You Up",
                aspect: "16/9" %>
```

## Aspect ratio wrapper

Pass `aspect:` to wrap the iframe in a `<div>` with `aspect-ratio` inline style. This avoids the need for explicit `width` and `height` values.

```erb
<%= ui :iframe, src: "https://player.vimeo.com/video/123456",
                title: "Product demo video",
                aspect: "4/3" %>
```

## Explicit dimensions

```erb
<%= ui :iframe, src: "https://maps.google.com/...",
                title: "Store location map",
                width: 600, height: 450 %>
```

## Custom sandbox

The default sandbox permits scripts, same-origin, forms, and popups. Supply a string to restrict further, or pass `sandbox: false` to disable sandboxing (not recommended):

```erb
<%# Stricter sandbox — scripts only %>
<%= ui :iframe, src: "...", title: "Widget",
                sandbox: "allow-scripts" %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `src` | String | required | URL to embed |
| `title` | String | required | Accessible description of the embedded content |
| `loading` | Symbol | `:lazy` | `:lazy` or `:eager` |
| `sandbox` | Boolean or String | `true` | `true` = default safe tokens; string = custom tokens; `false` = no sandbox |
| `aspect` | String | `nil` | CSS `aspect-ratio` value — wraps iframe in a `<div>` when present |
| `width` | Integer | `nil` | Explicit pixel width |
| `height` | Integer | `nil` | Explicit pixel height |
| `**html_attrs` | Hash | — | Forwarded to the `<iframe>` element |
