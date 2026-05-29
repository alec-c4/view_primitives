# Textarea

Multi-line text input that grows to fit its content via CSS `field-sizing: content`.

## Installation

```bash
rails g view_primitives:add textarea
```

Creates `app/components/ui/textarea_component.rb`.

## Usage

```erb
<%= ui :textarea, name: "bio", placeholder: "Tell us about yourself…" %>
```

## With initial content

```erb
<%= ui :textarea, name: "message" do %>
  Initial text here.
<% end %>
```

## States

```erb
<%# Disabled %>
<%= ui :textarea, name: "notes", disabled: true %>

<%# Invalid %>
<%= ui :textarea, name: "content", "aria-invalid": "true" %>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `**html_attrs` | Hash | — | Forwarded to the `<textarea>` element |
