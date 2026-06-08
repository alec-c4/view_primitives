# SearchInput

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Text input with a built-in search icon on the left. Renders `<input type="search">`.

## Installation

```bash
rails g view_primitives:add search_input
```

Creates `app/components/ui/search_input_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only search_input
```


## Usage

```erb
<%= ui :search_input, name: "q" %>
```

## Custom placeholder

```erb
<%= ui :search_input, name: "q", placeholder: "Search products…" %>
```

## With Turbo form submission

```erb
<%= form_with url: search_path, method: :get, data: { turbo_frame: "results" } do %>
  <%= ui :search_input, name: "q", value: params[:q], autofocus: true %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `placeholder` | String | `"Search…"` | Placeholder text |
| `**html_attrs` | Hash | — | Forwarded to the `<input type="search">` element |
