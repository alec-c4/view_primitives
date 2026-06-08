# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `UI::Styles::MENU_SEPARATOR` — shared menu divider class for dropdown, menubar, context menu, and command
- `UI::Styles::BORDER`, `FIELD_PANEL`, and `PICKER_TRIGGER` documented in [customization.md](docs/customization.md)
- Device mockup shell/bezel/screen structure for iPhone and iPad frames

### Changed

- **DataTable** — table cell padding, header styling, and `<caption>` align with [shadcn Table](https://ui.shadcn.com/docs/components/radix/table)
- **Accordion** — trigger weight, chevron SVG, and item borders match [shadcn Accordion](https://ui.shadcn.com/docs/components/radix/accordion)
- **DeviceMockup** — iPhone (Dynamic Island, side buttons, home indicator) and iPad (landscape `3/2`, front camera) visual refresh
- **Navbar**, **BottomNav**, **Footer**, **Drawer**, **Sheet** — edge borders use `border-border` token
- **ListGroup** — internal dividers use `divide-border`
- Menu components — separators use `<div role="separator">` with `UI::Styles::MENU_SEPARATOR` instead of bare `<hr>`

### Fixed

- Drawer and sheet Stimulus actions referenced missing controllers; now use `dialog#open` / `dialog#close`
- Bare Tailwind `border`, `border-b`, and `border-t` without a color token rendered black or double-weight lines
- Device mockup screen overflow when using `size-full` inside padded aspect-ratio containers
- Dynamic Island and side buttons clipped or invisible on phone mockup
- DataTable caption rendered outside `<table>` with extra borders
- Accordion `<summary>` default browser styling produced bold triggers and dark dividers

## [0.2.1] - 2026-06-08

### Added

- [docs/components/README.md](docs/components/README.md) — shared setup guide for all component pages
- `rails g view_primitives:install --force` — refresh `ApplicationComponent` and CSS from gem templates
- Component docs: prerequisites, update commands, and corrected Stimulus controller names

### Changed

- README: CSS layout, generators table, `tailwind_merge`, link to component setup guide
- Sheet and drawer docs document shared `dialog_controller.js` and focus trap behaviour

### Fixed

- Sheet and drawer components referenced `sheet#` / `drawer#` Stimulus actions while using `data-controller="dialog"`; actions and targets now use `dialog`
- Install generator skipped `ApplicationComponent` even with `--force`, leaving apps without `extract_html_attrs`

## [0.2.0] - 2026-06-08

### Added

- `rails g view_primitives:update` — refresh installed components, CSS bundle, and `UI::Styles` from gem templates
- `rails g view_primitives:theme <name>` — install optional color themes (e.g. `rose`)
- CSS layer split: entry `view_primitives.css`, `tokens.css`, `utilities.css` (`vp-*` primitives), `themes/default.css`
- `UI::Styles` module in `app/components/ui/styles.rb` with shared primitive class names
- `ApplicationComponent#extract_html_attrs` for consistent `class:` forwarding
- `vp-peer-focus-ring` primitive for switch track styling
- Focus trap in `dialog`, `alert_dialog`, `sheet`, and `drawer` Stimulus controllers (supports `role=dialog` and `role=alertdialog`)
- Focus trap in `command` Stimulus controller
- Mobile navigation panel in `NavbarComponent` with working hamburger toggle
- Optional `tailwind_merge` support in `cn()` when the gem is installed
- Auto-discovery of component templates in the test suite

### Changed

- Sheet and drawer reuse `dialog_controller.js` instead of duplicate Stimulus controllers
- ~45 components migrated to `UI::Styles` / `vp-*` primitives for focus rings, inputs, overlays, and menu items
- `ComponentCopier` shared module used by `add` and `update` generators
- README and `docs/customization.md` document update/theme workflow and CSS structure

### Fixed

- Navbar hamburger had a Stimulus controller but no mobile menu markup
- `ComponentCopier` used absolute paths and `copy_file` for `.rb.tt` templates; `update` now processes ERB correctly
- `UI::Styles` lived in `ui_styles.rb`, which Zeitwerk maps to `UI::UiStyles`; file is now `app/components/ui/styles.rb`

## [0.1.3] - 2026-06-04

### Fixed

- `AddGenerator` template files for `form_field`, `input_otp`, and `qr_code` contained unescaped ERB tags (`<%= %>` / `<% %>`) inside Ruby comments; the stricter ERB parser in Ruby 4.0 raised `SyntaxError` when processing these `.tt` files, making those three components impossible to generate; fixed by escaping the comment-only tags as `<%%=` / `<%%`

## [0.1.2] - 2026-06-04

### Fixed

- `InstallGenerator#verify_ui_inflection` checked `"ui/button".camelize` which can never equal `"UI::ButtonComponent"`, causing the warning to fire unconditionally even when inflections were correctly configured; fixed to check `"ui/button_component".camelize`
- `InstallGenerator#inject_css_import` used `String#include?` to detect `@import "tailwindcss"` (matches with or without semicolon) but passed `after: "@import \"tailwindcss\"\n"` (no semicolon) to `inject_into_file`; the anchor mismatch left the entry point unchanged ("File unchanged!") on Tailwind CSS v4 projects that use `@import "tailwindcss";`; fixed by probing for all four variants (double/single quotes × with/without semicolon) and passing the exact matching line as the anchor

## [0.1.1] - 2026-06-01

### Fixed

- `AddGenerator#copy_component` called `source_root` as an instance method; changed to `self.class.source_root` (caught by Ruby 4.0 stricter method dispatch)
- `template` and `copy_file` overrides in `AddGenerator` were treated as Thor generator actions and invoked with zero arguments; wrapped in `no_tasks` to exclude them from action dispatch
- Test helper did not require `ViewPrimitives::Generators::Components`, causing two tests to error with `NameError: uninitialized constant`

## [0.1.0] - 2026-05-30

### Added

**Generators**
- `rails g view_primitives:install` — copies `ApplicationComponent`, CSS variables, prints Tailwind config
- `rails g view_primitives:add <component>` — copies component files into `app/components/ui/`; warns before overwriting
- `rails g view_primitives:list` — shows all available components with installed status
- `ui` helper available in controllers, views, and Action Mailer views
- Install generator checks `UI` inflection and detects existing Tailwind entry point

**Phase 1 — Foundation**
- Button — 6 variants, 4 sizes, defaults to `type="button"` inside forms
- Alert — informational banner with title/description slots and destructive variant
- Accordion — collapsible `<details>` sections; optional `exclusive:` Stimulus mode

**Phase 2 — Display**
- Badge, Avatar, Card, Separator, Label, Skeleton, Progress, Aspect Ratio, Spinner, KBD
- Rating — read-only star display
- Rating Input — interactive star rating with form/AJAX submission
- Indicator — status dot/count badge overlaid on an element
- List Group — bordered list with optional links and active state
- Banner — announcement strip with variants
- Button Group — visually joined row of buttons

**Phase 3 — Forms**
- Input, Textarea, Checkbox, Radio Group, Select, Switch, Toggle, Toggle Group
- Form Field — label + input + hint + error layout wrapper
- File Input, Search Input, Number Input, Range, Floating Label

**Phase 4 — Navigation**
- Tabs — array API + Stimulus slot API
- Breadcrumb, Pagination, Stepper, Bottom Navigation, Footer
- Navbar — responsive top bar with hamburger
- Navigation Menu — top-level nav with dropdown flyouts
- Mega Menu — full-width dropdown with grouped links and images

**Phase 5 — Overlays**
- Dialog, Alert Dialog, Sheet, Drawer, Popover, Tooltip, Hover Card

**Phase 6 — Menus**
- Dropdown Menu, Context Menu, Menubar, Command, Combobox

**Phase 7 — Complex**
- Calendar, Date Picker, Timepicker, Carousel, Data Table, Sidebar, Input OTP
- Collapsible, Scroll Area, Resizable
- Gallery — responsive image grid with optional lightbox
- Chat Bubble, Speed Dial, Device Mockup, QR Code

**Phase 8 — Advanced**
- Chart — Chart.js adapter (bar, line, pie, doughnut, radar, polar area)
- Toaster — stacked toast notifications (Sonner-style)
- Timeline — vertical timeline with event items
- WYSIWYG — rich-text editor with Trix (default) or Quill adapter

**Phase 9 — Media & Semantic HTML**
- Picture — `<picture>` + `<source>` for art direction and modern formats (AVIF/WebP)
- Video — `<video>` + `<source>` with poster, controls, and `<track>` captions
- Figure — `<figure>` + `<figcaption>` wrapper
- Image — responsive `<img>` with `srcset` / `sizes`
- Audio — `<audio>` + `<source>` with optional transcript link
- Iframe — sandboxed embed wrapper with required `title` and lazy loading
- Map / Area — image map with clickable `<area>` regions
- Embed — third-party embeds with automatic provider detection from URL; supports YouTube, Vimeo, Spotify, Google Maps, Yandex Maps, Loom, SoundCloud, X (Twitter), Telegram, Facebook

### Changed

- Removed public `component` helper — use `ui` for primitives, `render` for other namespaces
- `AddGenerator` copies files from template directories automatically (no per-component methods)
- `Components.supported` is derived from template directories, not a duplicated list
- Simplified `Detector` and `ComponentHelper`
- `view_primitives:add` exits with status 1 on unknown components; prints copy summary
- Requires `view_component >= 4.0` and Rails `>= 7.1`

[0.2.1]: https://github.com/alec-c4/view_primitives/releases/tag/v0.2.1
[0.2.0]: https://github.com/alec-c4/view_primitives/releases/tag/v0.2.0
[0.1.0]: https://github.com/alec-c4/view_primitives/releases/tag/v0.1.0
