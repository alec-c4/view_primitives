# Skeleton

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Animated loading placeholder. Size is controlled entirely by classes passed by the caller.

## Installation

```bash
rails g view_primitives:add skeleton
```

Creates `app/components/ui/skeleton_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only skeleton
```


## Usage

```erb
<%# Text line placeholder %>
<%= ui :skeleton, class: "h-4 w-48" %>

<%# Avatar placeholder %>
<%= ui :skeleton, class: "size-10 rounded-full" %>

<%# Card placeholder %>
<div class="space-y-2">
  <%= ui :skeleton, class: "h-4 w-full" %>
  <%= ui :skeleton, class: "h-4 w-3/4" %>
  <%= ui :skeleton, class: "h-4 w-1/2" %>
</div>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `class` | String | `nil` | Required — sets the size and shape of the placeholder |
| `**html_attrs` | Hash | — | Forwarded to the `<div>` element |
