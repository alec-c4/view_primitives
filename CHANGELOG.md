# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.2.0] - 2026-06-08

### Added

- `rails g view_primitives:update` — refresh installed components, CSS bundle, and `UI::Styles` from gem templates; supports `--only`, `--skip-components`, `--skip-css`, `--skip-styles`, `--force`
- `rails g view_primitives:theme <name>` — install an optional color theme (e.g. `rose`) and enable its `@import` in `view_primitives.css`
- `UI::Styles` module (`app/components/ui/styles.rb`) — shared primitive class names: `FOCUS_RING`, `BORDER`, `OVERLAY`, `INPUT`, `MENU_SEPARATOR`, `FIELD_PANEL`, `PICKER_TRIGGER`, etc.
- CSS bundle split into `tokens.css`, `utilities.css` (`vp-*` primitives), and `themes/` — run `rails g view_primitives:update --skip-components` to pull in the new structure
- `--force` flag on both `add` and `update` generators — skips the per-file overwrite confirmation prompt
- Focus trap in `dialog`, `alert_dialog`, `sheet`, `drawer`, and `command` Stimulus controllers
- Mobile nav panel in `NavbarComponent` with working hamburger toggle
- Optional `tailwind_merge` support in `cn()` when the gem is present in the project
- [docs/components/README.md](docs/components/README.md) — shared prerequisites guide

### Changed

- ~45 component templates migrated to `UI::Styles` constants and `vp-*` utilities for consistent theming
- `add` generator prompts for confirmation before overwriting an existing file (previously overwrote silently); use `--force` to restore previous behaviour
- `update` generator default changed to prompt before overwriting; use `--force` to overwrite unconditionally
- Sheet and drawer share `dialog_controller.js` instead of maintaining separate Stimulus controllers
- **DataTable**, **Accordion**, **DeviceMockup**, **Navbar**, **BottomNav**, **Footer**, **Drawer**, **Sheet**, **ListGroup**, and menu components visually realigned with the shadcn/ui reference

### Fixed

- `add` and `update` generators recorded a failed component copy as success when the template directory was missing
- `add` generator printed a misleading "Copied" summary line for components with a missing template directory
- Setup notes (e.g. Chart.js importmap instructions) were never printed when the component list also contained an unknown name, because `abort` fired before `report_setup_notes` ran
- `ComponentCopier#with_source_root` used `source_paths.shift` in `ensure` — replaced with `source_paths.delete(path)` to always remove the correct entry
- `Components.supported` included non-directory entries from `Dir.children`; now filters to directories only
- `copy_js_controller` did not guard against an empty stimulus name (edge case: file named `_controller.js`)
- **Avatar** `lg` size accidentally reduced from `size-12` to `size-10` in the data-attribute refactor; restored to 48 px
- **Avatar** emitted `data-size="default"` on every default-size avatar; attribute is now omitted for `:default`
- **AlertDialog** content div lost `text-sm text-muted-foreground`; restored
- **Breadcrumb** inactive links lost `text-muted-foreground`; restored
- Sheet and drawer Stimulus actions used `sheet#` / `drawer#` targets while the controller was `dialog`; corrected to `dialog#open` / `dialog#close`
- `install --force` skipped `ApplicationComponent` regeneration; fixed
- Bare `border` / `border-b` / `border-t` classes without a color token rendered as black lines on some themes; replaced with `border-border`

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

[0.2.0]: https://github.com/alec-c4/view_primitives/releases/tag/v0.2.0
[0.1.0]: https://github.com/alec-c4/view_primitives/releases/tag/v0.1.0
