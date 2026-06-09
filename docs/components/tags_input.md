# Tags Input

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Multi-select input that renders selected values as removable chips/tags. The user types to filter remaining options and clicks to add them.

Requires `tags_input_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add tags_input
```

Creates `app/components/ui/tags_input_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only tags_input
```


## Usage

```erb
<%= ui :tags_input,
       name: "colors",
       options: [
         { value: "red",   label: "Red" },
         { value: "green", label: "Green" },
         { value: "blue",  label: "Blue" }
       ] %>
```

## Pre-selected values

```erb
<%= ui :tags_input,
       name: "colors",
       values: ["red", "blue"],
       options: [
         { value: "red",   label: "Red" },
         { value: "green", label: "Green" },
         { value: "blue",  label: "Blue" }
       ] %>
```

## Custom placeholder

```erb
<%= ui :tags_input,
       name: "tags",
       placeholder: "Add a tag…",
       options: [
         { value: "ruby",       label: "Ruby" },
         { value: "rails",      label: "Rails" },
         { value: "javascript", label: "JavaScript" }
       ] %>
```

## In a form

The component submits selected values as `name[]` (array notation), which Rails automatically maps to an array in `params`:

```ruby
# params[:colors] => ["red", "blue"]
```

```erb
<%= form_with url: "/search" do |f| %>
  <%= ui :tags_input,
         name: "colors[]",  # or just "colors" — the component appends [] automatically
         options: Color.all.map { |c| { value: c.id.to_s, label: c.name } } %>
  <%= f.submit %>
<% end %>
```

## Keyboard shortcuts

| Key | Action |
|-----|--------|
| `Enter` | Select the first visible option |
| `Backspace` (on empty input) | Remove the last chip |
| `Escape` | Close the dropdown |

## How it works

Selected items appear as chips in the trigger area. Each chip contains a hidden `<input type="hidden" name="name[]">` so the selection is submitted with the form. When a chip is removed, the corresponding option reappears in the dropdown. A `<template>` element is used to clone chip markup when new options are selected via JavaScript.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | required | Base name for hidden inputs (`name[]`) |
| `options` | Array | `[]` | Array of `{ value:, label: }` hashes |
| `values` | Array | `[]` | Pre-selected values |
| `placeholder` | String | `"Select..."` | Shown when no chips are present |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
