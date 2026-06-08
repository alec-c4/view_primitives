# Timeline

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Vertical list of dated events with coloured dot indicators.

## Installation

```bash
rails g view_primitives:add timeline
```

Creates `app/components/ui/timeline_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only timeline
```


## Usage

```erb
<%= ui :timeline do |t| %>
  <% t.with_item(date: "Jan 2025",  title: "Project kickoff") %>
  <% t.with_item(date: "Feb 2025",  title: "Alpha release",
                 description: "Core features complete.", variant: :success) %>
  <% t.with_item(date: "Mar 2025",  title: "Performance issue found",
                 variant: :destructive) %>
  <% t.with_item(date: "Apr 2025",  title: "v1.0 shipped", variant: :success) %>
<% end %>
```

## Item variants

| Variant | Dot colour |
|---------|-----------|
| `:default` | Primary |
| `:success` | Green |
| `:warning` | Amber |
| `:destructive` | Destructive |
| `:muted` | Muted foreground |

## Rich item content

Add any HTML via a block after the named options:

```erb
<% t.with_item(date: "May 2025", title: "Conference") do %>
  <p class="text-sm text-muted-foreground mt-1">
    Presented at <%= link_to "RailsConf", "https://railsconf.com" %>.
  </p>
<% end %>
```

## API

### TimelineComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the `<ol>` element |

### ItemComponent (via `with_item`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | required | Event label |
| `date` | String | `nil` | Date or time string shown above the title |
| `description` | String | `nil` | Supporting text shown below the title |
| `variant` | Symbol | `:default` | Dot colour — see Variants table |
| `**html_attrs` | Hash | — | Forwarded to the `<li>` element |
