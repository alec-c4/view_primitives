# Pagination

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Page navigation with previous/next controls, page number links, and ellipsis for long ranges.

## Installation

```bash
rails g view_primitives:add pagination
```

Creates `app/components/ui/pagination_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only pagination
```


## Usage

```erb
<%= ui :pagination,
       current_page: @pagy.page,
       total_pages:  @pagy.pages,
       url: ->(page) { articles_path(page: page) } %>
```

The `url:` option must be a callable (lambda or proc) that receives a page number and returns a path string.

## Render nothing on one page

The component renders nothing when `total_pages` is 1 or fewer.

## Window size

The `window:` option controls how many page numbers appear on each side of the current page before an ellipsis is shown (default: 2).

```erb
<%= ui :pagination,
       current_page: 5,
       total_pages:  20,
       url: ->(page) { posts_path(page: page) },
       window: 1 %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `current_page` | Integer | required | Active page number |
| `total_pages` | Integer | required | Total number of pages |
| `url` | Callable | required | Receives a page number, returns a URL string |
| `window` | Integer | `2` | Pages shown on each side of the current page |
| `**html_attrs` | Hash | — | Forwarded to the `<nav>` element |
