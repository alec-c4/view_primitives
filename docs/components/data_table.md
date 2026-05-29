# DataTable

Sortable, filterable data table with client-side search and pagination.

Requires `data_table_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add data_table
```

Creates `app/components/ui/data_table_component.rb`.

## Usage

```erb
<%= ui :data_table,
       columns: [
         { key: :name,  label: "Name",   sortable: true },
         { key: :email, label: "Email",  sortable: true },
         { key: :role,  label: "Role" }
       ],
       rows: @users.map { |u| { name: u.name, email: u.email, role: u.role } } %>
```

## Pagination

```erb
<%= ui :data_table,
       columns: [...],
       rows: @products,
       per_page: 25 %>
```

Set `per_page: 0` to disable pagination and show all rows.

## Caption

```erb
<%= ui :data_table,
       caption: "Active users as of today",
       columns: [...],
       rows: @users %>
```

## Sorting

Columns with `sortable: true` are clickable. Clicking the same column twice reverses the sort direction. Sorting is client-side only.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `columns` | Array | required | Column definitions — see table below |
| `rows` | Array | required | Array of hashes with keys matching column `key:` values |
| `per_page` | Integer | `10` | Rows per page; `0` disables pagination |
| `caption` | String | `nil` | Optional `<caption>` element text |
| `**html_attrs` | Hash | — | Forwarded to the outer wrapper `<div>` |

### Column hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `key` | Symbol or String | Yes | Matches the key in each row hash |
| `label` | String | No | Column heading; defaults to `key.humanize` |
| `sortable` | Boolean | No | Enables client-side sort on this column |
