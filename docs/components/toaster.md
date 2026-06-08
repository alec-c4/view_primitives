# Toaster

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Fixed-position toast stack for transient notifications. Place once in your application layout.

Requires `toaster_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add toaster
```

Creates `app/components/ui/toaster_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only toaster
```


## Setup

Add the component once to your application layout, inside `<body>`:

```erb
<%# app/views/layouts/application.html.erb %>
<body>
  <%= yield %>
  <%= ui :toaster %>
</body>
```

## Server-side toasts

Pass toasts via the slot when you want to render them from Rails (e.g. after a form submission):

```erb
<%= ui :toaster do |t| %>
  <% t.with_toast(message: "Profile saved", variant: :success) %>
<% end %>
```

## Client-side toasts

Dispatch the `toaster:add` window event from any Stimulus controller or JavaScript:

```javascript
window.dispatchEvent(new CustomEvent("toaster:add", {
  detail: { message: "Done!", variant: "success", duration: 3000 }
}))
```

## Toast variants

| Variant | Icon colour |
|---------|-------------|
| `:default` | None |
| `:success` | Green |
| `:warning` | Amber |
| `:destructive` | Red |
| `:info` | Blue |

## Position

| Position | Description |
|----------|-------------|
| `:bottom_right` | Fixed bottom-right (default) |
| `:bottom_left` | Fixed bottom-left |
| `:bottom_center` | Fixed bottom-center |
| `:top_right` | Fixed top-right |
| `:top_left` | Fixed top-left |
| `:top_center` | Fixed top-center |

```erb
<%= ui :toaster, position: :top_right %>
```

## API

### ToasterComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `position` | Symbol | `:bottom_right` | Corner to anchor the toast stack |
| `**html_attrs` | Hash | — | Forwarded to the container `<div>` |

### ToastComponent (via `with_toast` or `toaster:add` event)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `message` | String | required | Toast body text |
| `title` | String | `nil` | Optional bold heading above the message |
| `variant` | Symbol | `:default` | Colour scheme — see Variants table |
| `duration` | Integer | `4000` | Auto-dismiss delay in milliseconds; `0` = no auto-dismiss |
