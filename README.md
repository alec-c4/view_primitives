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
<%= ui :button, "Save changes", variant: :outline %>
<%= ui :alert, title: "Heads up!", description: "Check your settings." %>
<%= ui :accordion, items: [{ title: "FAQ", content: "Answer here." }] %>

<%# Block — for icons, slots, or complex content %>
<%= ui :button do %><svg .../> Save<% end %>
<%= ui :alert do |a| %><% a.with_alert_title { "Note" } %><% end %>

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
| Accordion | Collapsible sections via native `<details>`, optional exclusive mode | [docs](docs/components/accordion.md) |
| Badge | Small status label with variants | [docs](docs/components/badge.md) |
| Avatar | User avatar with image and initials fallback | [docs](docs/components/avatar.md) |
| Card | Container with header, content, and footer slots | [docs](docs/components/card.md) |
| Separator | Horizontal or vertical divider | [docs](docs/components/separator.md) |
| Label | Accessible form label | [docs](docs/components/label.md) |
| Skeleton | Loading placeholder with pulse animation | [docs](docs/components/skeleton.md) |
| Progress | Progress bar with value prop | [docs](docs/components/progress.md) |
| Aspect Ratio | Constrains child content to a given aspect ratio | [docs](docs/components/aspect_ratio.md) |
| Spinner | Animated loading indicator | [docs](docs/components/spinner.md) |
| KBD | Keyboard shortcut key display | [docs](docs/components/kbd.md) |
| Rating | Read-only star rating display | [docs](docs/components/rating.md) |
| Rating Input | Interactive star rating — form or AJAX submission | [docs](docs/components/rating_input.md) |
| Indicator | Status dot or count badge overlaid on an element | [docs](docs/components/indicator.md) |
| List Group | Bordered list with optional links and active state | [docs](docs/components/list_group.md) |
| Banner | Styled announcement strip with variants | [docs](docs/components/banner.md) |
| Button Group | Visually joined row of buttons | [docs](docs/components/button_group.md) |
| Input | Styled text input with ring/border | — |
| Textarea | Styled multi-line input | — |
| Checkbox | Accessible checkbox with optional label | — |
| Radio Group | Group of radio inputs | — |
| Select | Native styled select element | — |
| Switch | CSS-only on/off toggle | — |
| Toggle | Single pressable toggle button | — |
| Toggle Group | Group of related toggles (single or multiple) | — |
| Form Field | Label + input + hint + error layout wrapper | — |
| Breadcrumb | Navigational breadcrumb trail with separator | — |
| Pagination | Page number links with prev/next and ellipsis | — |
| Stepper | Multi-step progress indicator (horizontal + vertical) | — |
| Tabs | Tab bar with content panels (array API + slot API) | — |
| Navbar | Responsive top navigation bar with hamburger menu | — |
| Bottom Nav | Mobile-style tab bar fixed to the bottom | — |
| Footer | Page footer with columns, links, and copyright | — |
| Dialog | Modal dialog with trigger, title, description, footer slots | — |
| Alert Dialog | Blocking confirmation dialog | — |
| Sheet | Slide-in panel from any edge (left/right/top/bottom) | — |
| Drawer | Bottom sheet with drag handle — mobile drawer pattern | — |
| Popover | Floating panel anchored to a trigger | — |
| Tooltip | Hover label — CSS-only, no JS | — |
| Hover Card | Rich hover preview card — CSS-only, no JS | — |

### Coming soon

See [ROADMAP.md](ROADMAP.md) for the full planned component list organised by phase.

## Customisation

See **[docs/customization.md](docs/customization.md)** for the full guide covering:

- Design tokens (OKLCH colors, radius) — change the whole palette in one file
- Editing component constants — add variants, change classes
- Per-instance `class:` overrides — append utilities without touching the file
- Full brand theming example

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
