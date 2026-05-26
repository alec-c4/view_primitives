# Rating Input

Interactive star rating — hover to preview, click to select. Submits the chosen value via a `<form>` hidden input or directly via AJAX.

## Installation

```bash
rails g view_primitives:add rating_input
```

Creates:
- `app/components/ui/rating_input_component.rb`
- `app/javascript/controllers/rating_controller.js`

Register the controller in your Stimulus setup:

```js
import RatingController from "./rating_controller"
application.register("rating", RatingController)
```

## Usage

### Standalone (no submission)

```erb
<%= ui :rating_input, value: 3 %>
```

### Inside a form

Pass `name:` to render a hidden `<input>` that is submitted with the form:

```erb
<%= form_with url: reviews_path do |f| %>
  <%= ui :rating_input, value: 0, name: "review[rating]" %>
  <%= f.submit "Submit" %>
<% end %>
```

### Direct AJAX submission

Pass `url:` to have the controller `POST { value: N }` as JSON on every click:

```erb
<%= ui :rating_input, value: @post.rating, url: rate_post_path(@post) %>
```

Server receives: `{ "value" => 4 }` with `Content-Type: application/json` and the CSRF token.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `value` | Integer | `0` | Pre-selected rating. Clamped to `0..max`. |
| `max` | Integer | `5` | Total number of stars |
| `name` | String | `nil` | Hidden input `name` for form submission |
| `url` | String | `nil` | Endpoint for AJAX `POST` on click |
| `**html_attrs` | Hash | — | Forwarded to the wrapper `<div>` |

`name:` and `url:` can be used together or independently.

## Stimulus controller

The `rating_controller.js` manages three interactions:

| Action | Trigger | Behaviour |
|--------|---------|-----------|
| `preview` | `mouseenter` on a star | Highlights stars up to the hovered index |
| `resetPreview` | `mouseleave` on a star | Restores the committed value |
| `select` | `click` on a star | Commits the value, updates hidden input, optionally POSTs to `url` |
