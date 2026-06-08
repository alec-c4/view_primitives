# Combobox

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Searchable select with a text input that filters the option list as the user types.

Requires `combobox_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add combobox
```

Creates `app/components/ui/combobox_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only combobox
```


## Usage

```erb
<%= ui :combobox,
       name: "country",
       options: [
         { value: "us", label: "United States" },
         { value: "ca", label: "Canada" },
         { value: "mx", label: "Mexico" }
       ] %>
```

## Pre-selected value

```erb
<%= ui :combobox,
       name: "country",
       value: "ca",
       options: [
         { value: "us", label: "United States" },
         { value: "ca", label: "Canada" },
         { value: "mx", label: "Mexico" }
       ] %>
```

## Custom placeholder

```erb
<%= ui :combobox,
       name: "category",
       placeholder: "Pick a category…",
       options: [
         { value: "news",   label: "News" },
         { value: "events", label: "Events" }
       ] %>
```

## How it works

The component renders a hidden `<input type="hidden">` (submitted with the form) and a visible text input for filtering. Selecting an option updates the hidden input's value and closes the dropdown. When no options match the search term, a "No results." message is displayed.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | required | Form field name for the hidden input |
| `options` | Array | `[]` | Array of `{ value:, label: }` hashes |
| `value` | String | `nil` | Currently selected value |
| `placeholder` | String | `"Select..."` | Text shown when nothing is selected |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
