# Component setup

Every component page assumes this one-time app setup. Run it before `view_primitives:add`.

## Install the gem

Add to your Gemfile and run:

```bash
bundle install
rails g view_primitives:install
```

The install generator creates:

| File | Purpose |
|------|---------|
| `app/components/application_component.rb` | Base class with `cn()` and `extract_html_attrs` |
| `app/components/ui/styles.rb` | `UI::Styles` constants pointing at `vp-*` CSS primitives |
| `app/assets/stylesheets/view_primitives.css` | CSS entry that imports tokens, utilities, and themes |

Import the bundle in your Tailwind entry point:

```css
@import "./view_primitives";
```

If `ApplicationComponent` already exists, re-run with `--force` to refresh it from the gem template:

```bash
rails g view_primitives:install --force
```

## Add components

```bash
rails g view_primitives:list
rails g view_primitives:add button input dialog
```

Each component is copied into `app/components/ui/` as Ruby and ERB you own. Re-running `add` overwrites files (a warning is printed).

## Update after a gem upgrade

```bash
rails g view_primitives:update
rails g view_primitives:update --only button input   # selected components
rails g view_primitives:update --skip-css              # skip CSS and styles.rb
```

Back up local edits first — the update generator overwrites installed files from gem templates.

## Optional themes

```bash
rails g view_primitives:theme rose
```

Set `data-theme="rose"` on `<html>`. Dark mode still uses the `.dark` class.

## Shared styling (`UI::Styles`)

Repeated Tailwind patterns live in `view_primitives/utilities.css` as `@utility vp-*` classes. Components reference them through constants in `app/components/ui/styles.rb`:

```ruby
UI::Styles::FOCUS_RING   # => "vp-focus-ring"
UI::Styles::INPUT        # => "vp-input"
UI::Styles::OVERLAY      # => "vp-overlay"
```

See [customization guide](../customization.md#level-2--shared-primitives-ui-styles) for when to add new primitives and how to override tokens.

## Stimulus controllers

Interactive components copy a Stimulus controller to `app/javascript/controllers/`. With importmap, controllers are auto-registered via `eagerLoadControllersFrom`; with esbuild or Vite they are picked up by the standard glob import.

Dialog, sheet, drawer, and alert dialog share `dialog_controller.js` (focus trap, Escape to close, body scroll lock).

## `class:` overrides

Pass `class:` to any component to append Tailwind utilities:

```erb
<%= ui :button, "Save", class: "w-full" %>
```

The `cn()` helper merges classes. Install the optional `tailwind_merge` gem for conflict-aware merging:

```ruby
# Gemfile
gem "tailwind_merge"
```

## Per-component docs

Browse the [component index](../../README.md#components) in the main README.
