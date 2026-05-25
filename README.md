# ViewPrimitives

A [shadcn/ui](https://ui.shadcn.com)-inspired component library for Rails built on [ViewComponent](https://viewcomponent.org).

Components are **copied into your app** via a generator — not imported from a package. Tailwind classes live in your own files, so any Tailwind setup works out of the box: `tailwindcss-rails`, `cssbundling-rails`, Vite, esbuild — no configuration required.

## Requirements

- Ruby >= 3.2
- Rails >= 7.0
- [ViewComponent](https://viewcomponent.org)
- [Tailwind CSS](https://tailwindcss.com) (any setup)

## Installation

Add to your Gemfile:

```ruby
gem "view_primitives"
```

Then run the install generator:

```bash
rails g view_primitives:install
```

This will:
- Create `app/components/application_component.rb` with `ViewPrimitives::ClassHelper` included (skipped if you already have one — add `include ViewPrimitives::ClassHelper` manually)
- Create `app/assets/stylesheets/view_primitives.css` with the design token definitions (`@theme inline` + oklch light/dark theme)

Then import it in your Tailwind CSS entry point:

```css
/* tailwindcss-rails  → app/assets/stylesheets/application.tailwind.css  */
/* cssbundling/Vite   → app/javascript/application.css                    */

@import "./view_primitives";
```

That's it — no `tailwind.config.js` required. Tailwind 4 reads the `@theme inline` block directly from the CSS.

## Adding components

```bash
rails g view_primitives:add button
rails g view_primitives:add button alert accordion   # multiple at once
```

Each component is copied into `app/components/ui/` as plain Ruby and ERB files you own and can modify freely.

## View helpers

ViewPrimitives automatically adds two helpers to all views:

```erb
<%# Positional label — no block needed %>
<%= ui "button", "Save changes", variant: :outline %>
<%= ui "alert", title: "Heads up!", description: "Check your settings." %>
<%= ui "accordion", items: [{ title: "FAQ", content: "Answer here." }] %>

<%# Block — for icons, slots, or complex content %>
<%= ui "button" do %><svg .../> Save<% end %>
<%= ui "alert" do |a| %><% a.with_alert_title { "Note" } %><% end %>

<%# Any component by namespaced path %>
<%= component "ui/button", "Go back", href: root_path %>
<%= component "admin/stats_card", title: "Revenue" %>
```

`ui` is a shorthand for the `UI::` namespace. `component` resolves any path. Both are equivalent to `render UI::ButtonComponent.new(...)` but shorter and consistent across all components.

## Components

### Available now

| Component | Description | Docs |
|-----------|-------------|------|
| Button | Clickable element with 6 variants and 4 sizes | [docs](docs/components/button.md) |
| Alert | Informational banner with title and description slots | [docs](docs/components/alert.md) |
| Accordion | Collapsible sections via native `<details>`, no JS | [docs](docs/components/accordion.md) |

### Coming soon

| Component | Description |
|-----------|-------------|
| Badge | Small status label with variants |
| Avatar | User avatar with image and initials fallback |
| Card | Container with header, content, and footer slots |
| Separator | Horizontal or vertical divider |
| Label | Accessible form label |
| Skeleton | Loading placeholder with pulse animation |
| Progress | Progress bar with value prop |
| Tabs | Tab bar with content panels |
| Input | Styled text input |
| Textarea | Styled multi-line input |
| Checkbox | Accessible checkbox with label |
| Select | Native styled select element |
| Switch | Toggle on/off control |
| Breadcrumb | Navigational breadcrumb with separator |
| Pagination | Page number links with prev/next |
| Dialog | Modal dialog with overlay and action slots |
| Alert Dialog | Blocking confirmation dialog |
| Sheet | Slide-in panel from any edge |
| Popover | Floating panel anchored to a trigger |
| Tooltip | Short contextual label on hover |
| Dropdown Menu | Trigger-anchored menu with items and sub-menus |
| Sonner | Stacked toast notifications |

See [ROADMAP.md](ROADMAP.md) for the full list organised by release phase.

## Customisation

### Theming

Override CSS custom properties in your stylesheet to change the colour palette:

```css
:root {
  --primary: 262.1 83.3% 57.8%;   /* purple */
  --radius: 0.75rem;
}
```

### Modifying components

Because components live in your `app/components/ui/` directory, you can edit them directly. Add variants, change classes, or extend with new slots — there is no upstream to conflict with.

## Development

```bash
bin/setup          # install dependencies
bundle exec rake   # run tests + linter
bin/console        # interactive prompt
```

To run tests against a specific Rails version:

```bash
bundle exec appraisal rails-8.1 rake test
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alec-c4/view_primitives.

## License

MIT License. See [LICENSE.txt](LICENSE.txt).
