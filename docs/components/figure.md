# Figure

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Semantic `<figure>` wrapper with an optional `<figcaption>`. Use to pair an image, code block, or diagram with a caption.

## Installation

```bash
rails g view_primitives:add figure
```

Creates `app/components/ui/figure_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only figure
```


## Usage

```erb
<%= ui :figure, caption: "Tailwind CSS component library" do %>
  <%= image_tag "screenshot.png", alt: "Screenshot of the component library" %>
<% end %>
```

## Without caption

```erb
<%= ui :figure do %>
  <%= image_tag "chart.png", alt: "Revenue chart" %>
<% end %>
```

## Custom caption styles

```erb
<%= ui :figure, caption: "Figure 1: System architecture",
                caption_class: "text-center text-xs italic" do %>
  <%= image_tag "architecture.svg", alt: "Architecture diagram" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `caption` | String | `nil` | Text rendered in `<figcaption>` — omit to skip the caption |
| `caption_class` | String | `nil` | Additional CSS classes for `<figcaption>` |
| `**html_attrs` | Hash | — | Forwarded to the `<figure>` element |
