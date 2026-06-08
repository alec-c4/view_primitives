# FileInput

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Styled `<input type="file">` with support for MIME-type filtering and multiple file selection.

## Installation

```bash
rails g view_primitives:add file_input
```

Creates `app/components/ui/file_input_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only file_input
```


## Usage

```erb
<%= ui :file_input, name: "avatar" %>
```

## Accept filter

```erb
<%# Images only %>
<%= ui :file_input, name: "photo", accept: "image/*" %>

<%# Specific extensions %>
<%= ui :file_input, name: "document", accept: ".pdf,.docx" %>
```

## Multiple files

```erb
<%= ui :file_input, name: "attachments[]", multiple: true %>
```

## With FormField

```erb
<%= ui :form_field, label: "Profile picture" do %>
  <%= ui :file_input, name: "user[avatar]", accept: "image/*" %>
<% end %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `accept` | String | `nil` | MIME types or file extensions, e.g. `"image/*"` or `".pdf,.docx"` |
| `multiple` | Boolean | `false` | Allow selecting multiple files |
| `**html_attrs` | Hash | — | Forwarded to the `<input type="file">` element |
