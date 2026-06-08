# Badge

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Small inline label for status, counts, or categories.

## Installation

```bash
rails g view_primitives:add badge
```

Creates `app/components/ui/badge_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only badge
```


## Usage

```erb
<%# Positional label %>
<%= ui :badge, "New" %>

<%# Keyword label %>
<%= ui :badge, label: "Draft" %>

<%# Block content %>
<%= ui :badge do %>In Review<% end %>
```

## Variants

| Variant | Description |
|---------|-------------|
| `default` | Filled with `--primary` colour |
| `secondary` | Filled with `--secondary` colour |
| `destructive` | Filled with `--destructive` colour |
| `outline` | Border only, transparent background |

```erb
<%= ui :badge, "Active",   variant: :default %>
<%= ui :badge, "Draft",    variant: :secondary %>
<%= ui :badge, "Removed",  variant: :destructive %>
<%= ui :badge, "Pending",  variant: :outline %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Plain-text label — positional or `label:` keyword, alternative to block |
| `variant` | Symbol | `:default` | Visual style |
| `**html_attrs` | Hash | — | Forwarded to the `<span>` element |
