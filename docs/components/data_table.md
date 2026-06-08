# DataTable

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Sortable, filterable data table with client-side search and pagination. Table markup and spacing follow [shadcn Table](https://ui.shadcn.com/docs/components/radix/table); search toolbar and pagination wrap the table in a bordered card shell.

Requires `data_table_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add data_table
```

Creates `app/components/ui/data_table_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only data_table
```

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

Renders a semantic `<caption>` inside the `<table>` (shadcn `TableCaption` style — below the grid, muted text, no extra border):

```erb
<%= ui :data_table,
       caption: "Active users as of today",
       columns: [...],
       rows: @users %>
```

## Sorting

Columns with `sortable: true` are clickable. Clicking the same column twice reverses the sort direction. Sorting is client-side only.

## Styling

The component constants mirror shadcn Table primitives:

| Constant | shadcn equivalent | Notes |
|----------|---------------------|-------|
| `TABLE_CLS` | `Table` | `w-full caption-bottom text-sm` |
| `THEAD_CLS` | `TableHeader` | `[&_tr]:border-b`, no muted header background |
| `TH_CLS` | `TableHead` | `h-10 px-2 font-medium` |
| `TR_CLS` | `TableRow` | `border-b border-border hover:bg-muted/50` |
| `TD_CLS` | `TableCell` | `p-2 align-middle` |
| `CAPTION_CLS` | `TableCaption` | `mt-4 text-sm text-muted-foreground` |

Edit constants in `app/components/ui/data_table_component.rb` to match your design system.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `columns` | Array | required | Column definitions — see table below |
| `rows` | Array | required | Array of hashes with keys matching column `key:` values |
| `per_page` | Integer | `10` | Rows per page; `0` disables pagination |
| `caption` | String | `nil` | Optional `<caption>` text below the table body |
| `**html_attrs` | Hash | — | Forwarded to the outer wrapper `<div>` |

### Column hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `key` | Symbol or String | Yes | Matches the key in each row hash |
| `label` | String | No | Column heading; defaults to `key.humanize` |
| `sortable` | Boolean | No | Enables client-side sort on this column |
