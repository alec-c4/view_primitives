# WYSIWYG

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Rich-text editor wrapper. Defaults to **Trix** (bundled with Rails via ActionText). Switch to **Quill** by passing `adapter: :quill`.

## Setup

### Trix (default)

```bash
bundle add actiontext
rails action_text:install
```

### Quill

```ruby
# config/importmap.rb
pin "quill", to: "https://esm.sh/quill@2"
```

```css
/* your CSS entry point */
@import url("https://esm.sh/quill@2/dist/quill.snow.css");
```

## Usage

```erb
<%# Trix — default, no extra setup beyond ActionText %>
<%= ui :wysiwyg, name: "body" %>

<%# Trix with initial value %>
<%= ui :wysiwyg, name: "body", value: @post.body %>

<%# Quill with placeholder and custom height %>
<%= ui :wysiwyg, name: "body", adapter: :quill,
      placeholder: "Write something...",
      height: 400 %>

<%# Quill without toolbar %>
<%= ui :wysiwyg, name: "notes", adapter: :quill, toolbar: false %>
```

## Parameters

| Parameter     | Type    | Default  | Description                                              |
|---------------|---------|----------|----------------------------------------------------------|
| `name`        | String  | required | Form field name for the hidden input                     |
| `adapter`     | Symbol  | `:trix`  | Editor to use — `:trix` or `:quill`                      |
| `value`       | String  | `nil`    | Initial HTML content                                     |
| `placeholder` | String  | `nil`    | Placeholder text shown in the empty editor               |
| `toolbar`     | Boolean | `true`   | Show the editor toolbar (Quill only)                     |
| `height`      | Integer | `200`    | Editor content area height in px (Quill only)            |
| `class`       | String  | `nil`    | Extra classes on the wrapper `<div>`                     |

## How it works

**Trix** renders `<input type="hidden">` + `<trix-editor input="…">`. The custom element is self-initializing — no Stimulus controller needed.

**Quill** renders a `<div data-controller="wysiwyg">` with an editor target and a hidden input. `wysiwyg_controller.js` dynamically imports Quill and syncs the editor HTML back to the hidden input on every change, so the value is submitted with the form normally.

## Styling Trix

Override toolbar and content styles in your own CSS:

```css
trix-toolbar { /* toolbar customisation */ }
.trix-content { /* editor content area */ }
```

## Form integration

Both adapters submit a plain HTML string via the hidden input. For ActionText's `rich_text_area`, use Rails' own helper instead — this component is for cases where you need a standalone `name:`-based field without the ActionText storage layer.
