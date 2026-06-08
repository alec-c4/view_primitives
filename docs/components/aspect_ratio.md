# Aspect Ratio

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Constrains child content to a fixed aspect ratio using the CSS `aspect-ratio` property.

## Installation

```bash
rails g view_primitives:add aspect_ratio
```

Creates `app/components/ui/aspect_ratio_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only aspect_ratio
```


## Usage

```erb
<%# 16:9 video embed %>
<%= ui :aspect_ratio, ratio: 16.0/9 do %>
  <iframe src="..." class="size-full"></iframe>
<% end %>

<%# Square image %>
<%= ui :aspect_ratio, ratio: 1 do %>
  <%= image_tag "photo.jpg", class: "size-full object-cover" %>
<% end %>

<%# 4:3 thumbnail %>
<%= ui :aspect_ratio, ratio: 4.0/3 do %>
  <%= image_tag "thumbnail.jpg", class: "size-full object-cover" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `ratio` | Float / Integer | `1` | Width-to-height ratio (e.g. `16.0/9` for widescreen) |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
