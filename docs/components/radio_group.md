# RadioGroup

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Group of radio inputs rendered from an array of items.

## Installation

```bash
rails g view_primitives:add radio_group
```

Creates `app/components/ui/radio_group_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only radio_group
```


## Usage

```erb
<%= ui :radio_group, name: "plan",
       items: [
         { value: "free",  label: "Free" },
         { value: "pro",   label: "Pro" },
         { value: "team",  label: "Team", checked: true }
       ] %>
```

## Pre-selected item

Mark one item with `checked: true`:

```erb
<%= ui :radio_group, name: "color",
       items: [
         { value: "red",   label: "Red" },
         { value: "green", label: "Green", checked: true },
         { value: "blue",  label: "Blue" }
       ] %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | required | Shared `name` attribute for all radio inputs |
| `items` | Array | `[]` | Array of `{ value:, label:, checked: }` hashes |
| `**html_attrs` | Hash | — | Forwarded to the wrapper `<div role="radiogroup">` |

### Item hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `value` | String | Yes | Submitted value |
| `label` | String | Yes | Visible label text |
| `checked` | Boolean | No | Pre-selects this option |
