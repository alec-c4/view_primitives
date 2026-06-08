# HoverCard

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Rich floating card that appears when the user hovers over a trigger element. Pure CSS via Tailwind `group-hover` — no JavaScript required.

## Installation

```bash
rails g view_primitives:add hover_card
```

Creates `app/components/ui/hover_card_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only hover_card
```


## Usage

```erb
<%= ui :hover_card do |card| %>
  <% card.with_trigger do %>
    <%= link_to "@alec", profile_path, class: "underline" %>
  <% end %>
  <div>
    <p class="font-semibold">Alec P.</p>
    <p class="text-sm text-muted-foreground">Joined January 2024</p>
  </div>
<% end %>
```

## Position

| Side | Description |
|------|-------------|
| `:bottom` | Below trigger (default) |
| `:top` | Above trigger |
| `:left` | Left of trigger |
| `:right` | Right of trigger |

```erb
<%= ui :hover_card, side: :right do |card| %>
  <% card.with_trigger { link_to "More info", "#" } %>
  <p class="text-sm">Additional details appear here.</p>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `side` | Symbol | `:bottom` | `:bottom`, `:top`, `:left`, or `:right` |
| `**html_attrs` | Hash | — | Forwarded to the outer `<span>` wrapper |

| Slot | Required | Description |
|------|----------|-------------|
| `trigger` | No | Element that triggers the hover card |
