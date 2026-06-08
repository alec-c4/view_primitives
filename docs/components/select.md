# Select

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Native `<select>` element with consistent border, focus, and disabled styles. Base styles come from `UI::Styles::SELECT` (`vp-select` in CSS).

## Installation

```bash
rails g view_primitives:add select
```

Creates `app/components/ui/select_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only select
```


## Usage

```erb
<%# Array of strings (value = label) %>
<%= ui :select, name: "country",
       options: ["United States", "Canada", "Mexico"] %>

<%# Array of [value, label] pairs %>
<%= ui :select, name: "country",
       options: [["us", "United States"], ["ca", "Canada"], ["mx", "Mexico"]] %>

<%# Hash (value => label) %>
<%= ui :select, name: "country",
       options: { "us" => "United States", "ca" => "Canada", "mx" => "Mexico" } %>
```

## Pre-selected value

```erb
<%= ui :select, name: "role",
       options: [["admin", "Admin"], ["editor", "Editor"], ["viewer", "Viewer"]],
       selected: "editor" %>
```

## Blank option

```erb
<%= ui :select, name: "category",
       options: ["News", "Events", "Guides"],
       include_blank: true %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `options` | Array or Hash | `[]` | Strings, `[value, label]` pairs, or `{ value => label }` hash |
| `selected` | String | `nil` | Value of the pre-selected option |
| `include_blank` | Boolean | `false` | Prepends an empty `<option>` |
| `**html_attrs` | Hash | — | Forwarded to the `<select>` element |
