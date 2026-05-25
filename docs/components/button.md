# Button

Clickable element with variant and size support. Renders as a `<button>` by default and can be switched to any HTML tag via the `href:` shorthand or `tag:` option.

## Installation

```bash
rails g view_primitives:add button
```

Creates `app/components/ui/button_component.rb`.

## Usage

```erb
<%# Positional label — no block needed %>
<%= ui "button", "Save changes" %>

<%# Block — for icons or complex content %>
<%= ui "button" do %>Save changes<% end %>
```

## Variants

| Variant | Description |
|---------|-------------|
| `default` | Primary action — filled with `--primary` colour |
| `destructive` | Dangerous action — filled with `--destructive` colour |
| `outline` | Bordered, transparent background |
| `secondary` | Lower-emphasis filled button |
| `ghost` | No background, hover only |
| `link` | Looks like a text link, no border or background |

```erb
<%= ui "button", "Save",   variant: :default %>
<%= ui "button", "Delete", variant: :destructive %>
<%= ui "button", "Cancel", variant: :outline %>
<%= ui "button", "Draft",  variant: :secondary %>
<%= ui "button", "Skip",   variant: :ghost %>
<%= ui "button", "More",   variant: :link %>
```

## Sizes

| Size | Description |
|------|-------------|
| `default` | Standard height (`h-9`), auto-reduces padding when an SVG is present |
| `sm` | Compact (`h-8`, smaller gap), auto-reduces padding when an SVG is present |
| `lg` | Large (`h-10`), auto-reduces padding when an SVG is present |
| `icon` | Square (`size-9`), for icon-only buttons |

```erb
<%= ui "button", "Small",  size: :sm %>
<%= ui "button", "Normal", size: :default %>
<%= ui "button", "Large",  size: :lg %>
<%= ui "button", size: :icon do %><!-- svg --><% end %>
```

## Links

Pass `href:` to render an `<a>` tag automatically:

```erb
<%= ui "button", "Go home",      href: root_path %>
<%= ui "button", "Edit profile", href: edit_profile_path, variant: :ghost %>
<%= ui "button", "Delete",       href: item_path(@item), variant: :destructive,
                                 data: { turbo_method: :delete, turbo_confirm: "Are you sure?" } %>
```

To use a different element explicitly, use `tag:`:

```erb
<%= ui "button", tag: :a, href: root_path do %>Home<% end %>
```

## HTML attributes

Any extra keyword arguments are forwarded to the element:

```erb
<%= ui "button", "Submit", disabled: true %>
<%= ui "button", "Confirm", data: { turbo_confirm: "Are you sure?" } %>
<%= ui "button", "Submit", form: "my-form", type: "submit" %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Plain-text label — positional (`"text"`) or keyword (`label: "text"`), alternative to block |
| `variant` | Symbol | `:default` | Visual style — see Variants table |
| `size` | Symbol | `:default` | Size — see Sizes table |
| `href` | String | `nil` | Renders `<a>` with this href; sets `tag: :a` automatically |
| `tag` | Symbol | `:button` | Override HTML element |
| `**html_attrs` | Hash | — | Forwarded to the element |
