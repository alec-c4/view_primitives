# KBD

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Keyboard shortcut key display. Renders a `<kbd>` element styled to look like a physical key.

## Installation

```bash
rails g view_primitives:add kbd
```

Creates `app/components/ui/kbd_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only kbd
```


## Usage

```erb
<%# Positional key label %>
<%= ui :kbd, "⌘" %>

<%# Keyword label %>
<%= ui :kbd, label: "Enter" %>

<%# Block content %>
<%= ui :kbd do %>Ctrl<% end %>
```

## Shortcut combinations

Render multiple `KbdComponent`s inline with separator text:

```erb
<span class="text-sm text-muted-foreground">
  Press <%= ui :kbd, "⌘" %> + <%= ui :kbd, "K" %> to open search.
</span>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `key` | String | `nil` | Key label — positional or `label:` keyword, alternative to block |
| `**html_attrs` | Hash | — | Forwarded to the `<kbd>` element |
