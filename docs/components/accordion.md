# Accordion

Collapsible content sections. Built on native `<details>`/`<summary>` — no JavaScript required. The chevron rotates on open via Tailwind's `group-open:` modifier.

## Installation

```bash
rails g view_primitives:add accordion
```

Creates:
- `app/components/ui/accordion_component.rb`
- `app/components/ui/accordion_component.html.erb`
- `app/components/ui/accordion_item_component.rb`
- `app/components/ui/accordion_item_component.html.erb`

## Usage

```erb
<%# items: array — plain text, no block needed %>
<%= ui "accordion", items: [
  { title: "What is ViewPrimitives?",      content: "A shadcn-inspired component library for Rails." },
  { title: "Do I need to configure it?",   content: "No. Works with any Tailwind setup." },
  { title: "Can I customise the styles?",  content: "Yes — the files are yours to edit." }
] %>

<%# Slot API — for rich HTML inside items %>
<%= ui "accordion" do |accordion| %>
  <% accordion.with_item(title: "What is ViewPrimitives?") do %>
    A shadcn-inspired component library for Rails using ViewComponent and Tailwind.
  <% end %>
<% end %>
```

## Open by default

Pass `open: true` in the data hash or slot:

```erb
<%# Data array %>
<%= ui "accordion", items: [
  { title: "Expanded on load", content: "Visible immediately.", open: true },
  { title: "Collapsed",        content: "Click to expand." }
] %>

<%# Slot API %>
<%= ui "accordion" do |accordion| %>
  <% accordion.with_item(title: "Expanded on load", open: true) do %>
    Visible immediately.
  <% end %>
<% end %>
```

## Rich content

Use the slot API when items contain HTML, links, or other components:

```erb
<%= ui "accordion" do |accordion| %>
  <% accordion.with_item(title: "Pricing") do %>
    <ul class="list-disc pl-4 space-y-1">
      <li>Starter — free forever</li>
      <li>Pro — $12/month</li>
      <li>Enterprise — <%= link_to "contact us", contact_path %></li>
    </ul>
  <% end %>
<% end %>
```

## Exclusive mode (one open at a time)

Pass `exclusive: true` to close all other items when one opens. Powered by a Stimulus controller that is copied into your app by the generator.

```erb
<%# items: array %>
<%= ui "accordion", exclusive: true, items: [
  { title: "First",  content: "Opening this closes the others." },
  { title: "Second", content: "No page reload, no Turbo frames." },
  { title: "Third",  content: "Works with the slot API too." }
] %>

<%# Slot API %>
<%= ui "accordion", exclusive: true do |accordion| %>
  <% accordion.with_item(title: "One") do %>Content<% end %>
  <% accordion.with_item(title: "Two", open: true) do %>Starts open<% end %>
  <% accordion.with_item(title: "Three") do %>Content<% end %>
<% end %>
```

The generator copies `accordion_controller.js` to `app/javascript/controllers/`. With importmap it is auto-registered via `eagerLoadControllersFrom`; with esbuild/Vite it is picked up by the standard glob import.

The controller uses click event delegation on the wrapper — no `data-*` attributes are needed on individual items:

```javascript
// app/javascript/controllers/accordion_controller.js
toggle(event) {
  const summary = event.target.closest("summary")
  if (!summary) return
  const target = summary.closest("details")
  if (!target || target.open) return          // already open → user is closing it, skip
  this.element.querySelectorAll("details[open]").forEach(item => {
    if (item !== target) item.open = false    // close all others
  })
}
```

## How it works

Each item renders a `<details>` element with `class="group"`. The chevron SVG uses `group-open:rotate-180` to animate when the browser sets the `open` attribute — no JavaScript required for basic behavior.

## API

### AccordionComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `items` | Array | `nil` | Array of `{ title:, content:, open: }` hashes for plain-text items |
| `exclusive` | Boolean | `false` | When `true`, opening one item closes all others via Stimulus |

### AccordionItemComponent (slot)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `title` | String | required | Text shown in the summary bar |
| `open` | Boolean | `false` | Whether the item is expanded on page load |
