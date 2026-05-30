# ViewPrimitives

A [shadcn/ui](https://ui.shadcn.com)-inspired component library for Rails built on [ViewComponent](https://viewcomponent.org).

> **Acknowledgements** — The visual design, CSS class choices, and component structure of ViewPrimitives are heavily inspired by [shadcn/ui](https://ui.shadcn.com) and its Svelte port [shadcn-svelte](https://www.shadcn-svelte.com). We are grateful to [@shadcn](https://github.com/shadcn) and all contributors for their outstanding open-source work. ViewPrimitives is an independent Rails adaptation and is not affiliated with or endorsed by the shadcn/ui project.

Components are **copied into your app** via a generator — not imported from a package. Tailwind classes live in your own files, so any Tailwind setup works out of the box: `tailwindcss-rails`, `cssbundling-rails`, Vite, esbuild — no configuration required.

## Requirements

- Ruby >= 3.2 (developed with 4.0.5 — use [mise](https://mise.jdx.dev) or see `.ruby-version`)
- Rails >= 7.1 (required by ViewComponent 4)
- [ViewComponent](https://viewcomponent.org) >= 4.0
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
/* tailwindcss-rails  → app/assets/tailwind/application.css              */
/* tailwind (legacy)  → app/assets/stylesheets/application.tailwind.css  */
/* cssbundling/Vite   → app/javascript/application.css                    */

@import "./view_primitives";
```

The install generator auto-detects these entry points and injects the import when possible.

### UI namespace

Components live under `UI::` (files in `app/components/ui/`). The gem registers the `UI` acronym with ActiveSupport so `ui :button` resolves to `UI::ButtonComponent`.

That's it — no `tailwind.config.js` required. Tailwind 4 reads the `@theme inline` block directly from the CSS.

## Adding components

```bash
rails g view_primitives:list                         # available + installed status
rails g view_primitives:add button
rails g view_primitives:add button alert accordion   # multiple at once
```

Each component is copied into `app/components/ui/` as plain Ruby and ERB files you own and can modify freely. Re-running `add` overwrites existing files (a warning is printed). Unknown component names fail with a non-zero exit code.

## View helpers

ViewPrimitives adds the `ui` helper to views and mailers:

```erb
<%# Positional label — no block needed %>
<%= ui :button, "Save changes", variant: :outline %>
<%= ui :alert, title: "Heads up!", description: "Check your settings." %>
<%= ui :accordion, items: [{ title: "FAQ", content: "Answer here." }] %>

<%# Block — for icons, slots, or complex content %>
<%= ui :button do %><svg .../> Save<% end %>
<%= ui :alert do |a| %><% a.with_alert_title { "Note" } %><% end %>
```

`ui` is shorthand for `render UI::SomeComponent.new(...)`. For components outside `app/components/ui/`, use `render` as usual.

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
| Input | Styled text input with ring/border | [docs](docs/components/input.md) |
| Textarea | Styled multi-line input | [docs](docs/components/textarea.md) |
| Checkbox | Accessible checkbox with optional label | [docs](docs/components/checkbox.md) |
| Radio Group | Group of radio inputs | [docs](docs/components/radio_group.md) |
| Select | Native styled select element | [docs](docs/components/select.md) |
| Switch | CSS-only on/off toggle | [docs](docs/components/switch.md) |
| Toggle | Single pressable toggle button | [docs](docs/components/toggle.md) |
| Toggle Group | Group of related toggles (single or multiple) | [docs](docs/components/toggle_group.md) |
| Form Field | Label + input + hint + error layout wrapper | [docs](docs/components/form_field.md) |
| File Input | Styled file upload input | [docs](docs/components/file_input.md) |
| Search Input | Text input with built-in search icon and clear button | [docs](docs/components/search_input.md) |
| Number Input | Text input with increment/decrement controls | [docs](docs/components/number_input.md) |
| Range | Styled range slider | [docs](docs/components/range.md) |
| Floating Label | Input with floating placeholder label | [docs](docs/components/floating_label.md) |
| Breadcrumb | Navigational breadcrumb trail with separator | [docs](docs/components/breadcrumb.md) |
| Pagination | Page number links with prev/next and ellipsis | [docs](docs/components/pagination.md) |
| Stepper | Multi-step progress indicator (horizontal + vertical) | [docs](docs/components/stepper.md) |
| Tabs | Tab bar with content panels (array API + slot API) | [docs](docs/components/tabs.md) |
| Navbar | Responsive top navigation bar with hamburger menu | [docs](docs/components/navbar.md) |
| Navigation Menu | Top-level navigation with optional dropdown flyouts | [docs](docs/components/navigation_menu.md) |
| Bottom Nav | Mobile-style tab bar fixed to the bottom | [docs](docs/components/bottom_nav.md) |
| Footer | Page footer with columns, links, and copyright | [docs](docs/components/footer.md) |
| Mega Menu | Full-width dropdown panel with grouped links and images | [docs](docs/components/mega_menu.md) |
| Dialog | Modal dialog with trigger, title, description, footer slots | [docs](docs/components/dialog.md) |
| Alert Dialog | Blocking confirmation dialog | [docs](docs/components/alert_dialog.md) |
| Sheet | Slide-in panel from any edge (left/right/top/bottom) | [docs](docs/components/sheet.md) |
| Drawer | Bottom sheet with drag handle — mobile drawer pattern | [docs](docs/components/drawer.md) |
| Popover | Floating panel anchored to a trigger | [docs](docs/components/popover.md) |
| Tooltip | Hover label — CSS-only, no JS | [docs](docs/components/tooltip.md) |
| Hover Card | Rich hover preview card — CSS-only, no JS | [docs](docs/components/hover_card.md) |
| Dropdown Menu | Trigger-anchored menu with items and separators | [docs](docs/components/dropdown_menu.md) |
| Context Menu | Right-click context menu positioned at cursor | [docs](docs/components/context_menu.md) |
| Menubar | Horizontal application-style menu bar | [docs](docs/components/menubar.md) |
| Command | Modal command palette with live search filtering | [docs](docs/components/command.md) |
| Combobox | Autocomplete select with live search | [docs](docs/components/combobox.md) |
| Calendar | Date picker calendar grid | [docs](docs/components/calendar.md) |
| Date Picker | Input that opens a Calendar popover | [docs](docs/components/date_picker.md) |
| Timepicker | Input for selecting a time value | [docs](docs/components/timepicker.md) |
| Carousel | Scrollable item carousel with prev/next controls | [docs](docs/components/carousel.md) |
| Data Table | Sortable, filterable table with pagination | [docs](docs/components/data_table.md) |
| Sidebar | Collapsible application sidebar with nav groups | [docs](docs/components/sidebar.md) |
| Input OTP | One-time-password digit input group | [docs](docs/components/input_otp.md) |
| Collapsible | Single collapsible section (simpler than Accordion) | [docs](docs/components/collapsible.md) |
| Resizable | Drag-to-resize panel layout | [docs](docs/components/resizable.md) |
| Scroll Area | Custom scrollbar container | [docs](docs/components/scroll_area.md) |
| Gallery | Responsive image grid with optional lightbox | [docs](docs/components/gallery.md) |
| Chat Bubble | Styled message bubble for chat or comment threads | [docs](docs/components/chat_bubble.md) |
| Speed Dial | Floating action button that expands into sub-actions | [docs](docs/components/speed_dial.md) |
| Device Mockup | Phone or browser frame for marketing screenshots | [docs](docs/components/device_mockup.md) |
| QR Code | QR code display from a given value | [docs](docs/components/qr_code.md) |
| Timeline | Vertical timeline with event items | [docs](docs/components/timeline.md) |
| Toaster | Stacked toast notifications (Sonner-style) | [docs](docs/components/toaster.md) |
| Chart | Chart.js adapter — bar, line, pie, doughnut, radar, polar area | [docs](docs/components/chart.md) |
| Picture | `<picture>` + `<source>` for art direction and modern formats (AVIF/WebP) | [docs](docs/components/picture.md) |
| Video | `<video>` + `<source>` with poster, controls, and caption tracks | [docs](docs/components/video.md) |
| Figure | `<figure>` + `<figcaption>` wrapper for media content | [docs](docs/components/figure.md) |
| Image | Responsive `<img>` with `srcset` / `sizes` | [docs](docs/components/image.md) |
| Audio | `<audio>` + `<source>` with optional transcript link | [docs](docs/components/audio.md) |
| Iframe | Sandboxed embed wrapper with required `title` and lazy loading | [docs](docs/components/iframe.md) |
| WYSIWYG | Rich-text editor — Trix (default) or Quill adapter | [docs](docs/components/wysiwyg.md) |
| Map / Area | Image map with clickable `<area>` regions | [docs](docs/components/map_area.md) |
| Embed | Third-party embeds — YouTube, Vimeo, Spotify, Google Maps, Yandex Maps, Loom, SoundCloud, X, Telegram, Facebook | [docs](docs/components/embed.md) |

See [ROADMAP.md](ROADMAP.md) for the full component list organised by phase.

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
