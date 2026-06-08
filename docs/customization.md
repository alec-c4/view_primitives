# Customizing ViewPrimitives

ViewPrimitives follows the shadcn/ui philosophy: **you own the code**. Components are copied into your app by the generator, so you can change anything without forking the gem.

There are three levels of customization, from lightest to deepest:

---

## Level 1 — Design tokens (colors, radius, spacing)

Visual properties are driven by CSS variables in `view_primitives/themes/default.css`, imported from the entry file `app/assets/stylesheets/view_primitives.css` (exact path depends on your setup — see `rails g view_primitives:install`).

The `:root` block in `default.css` sets the light theme. Override any variable there to change it globally:

```css
/* app/assets/stylesheets/view_primitives/themes/default.css */

:root {
  /* Brand color — all primary buttons, links, active states */
  --primary: oklch(0.55 0.2 264);           /* indigo */
  --primary-foreground: oklch(0.98 0 0);

  /* Softer destructive */
  --destructive: oklch(0.6 0.22 15);

  /* More rounded corners */
  --radius: 0.875rem;
}
```

### Available tokens

| Token | Used by |
|-------|---------|
| `--primary` / `--primary-foreground` | Button default, Badge default, active states |
| `--secondary` / `--secondary-foreground` | Button secondary, Badge secondary |
| `--destructive` | Button destructive, Alert destructive, Badge destructive |
| `--muted` / `--muted-foreground` | Skeleton, placeholder text, helper text |
| `--accent` / `--accent-foreground` | Hover backgrounds on ghost/outline elements |
| `--card` / `--card-foreground` | Card background and text |
| `--background` / `--foreground` | Page background and default text |
| `--border` | Borders on inputs, separators, cards |
| `--input` | Input field border color |
| `--ring` | Focus ring on interactive elements |
| `--radius` | Base border radius (sm/md/lg/xl are derived from this) |

### Colors use OKLCH

OKLCH gives perceptually uniform brightness. The format is `oklch(L C H)`:

- **L** — lightness `0` (black) → `1` (white)
- **C** — chroma (saturation) `0` (grey) → `~0.3+` (vivid)
- **H** — hue angle in degrees (`0` = red, `120` = green, `264` = indigo, `300` = purple)

Quick brand color recipes:

```css
/* Blue */   --primary: oklch(0.55 0.22 250);
/* Green */  --primary: oklch(0.55 0.18 145);
/* Purple */ --primary: oklch(0.55 0.22 300);
/* Orange */ --primary: oklch(0.65 0.18 50);
/* Red */    --primary: oklch(0.55 0.22 15);
```

### Dark mode

The `.dark` class overrides the same tokens for dark mode. Add `class="dark"` to `<html>` to activate it. Override the dark variants the same way:

```css
.dark {
  --primary: oklch(0.75 0.18 264);   /* lighter indigo for dark bg */
  --background: oklch(0.12 0.01 264); /* slightly tinted dark bg */
}
```

---

## Level 2 — Shared primitives (`UI::Styles`)

Repeated Tailwind patterns (focus rings, inputs, overlays, menu items) live in `view_primitives/utilities.css` as `@utility vp-*` classes. Ruby components reference them through `UI::Styles` in `app/components/ui/styles.rb`:

```ruby
UI::Styles::FOCUS_RING     # => "vp-focus-ring"
UI::Styles::BORDER         # => "vp-border" (border-border token)
UI::Styles::INPUT          # => "vp-input"
UI::Styles::FIELD_PANEL    # => calendar / picker popover shell
UI::Styles::PICKER_TRIGGER # => date/time picker button shell
UI::Styles::MENU_SEPARATOR # => menu divider between item groups
```

Change a primitive once in `utilities.css` and every component that uses the constant updates. Refresh the file with:

```bash
rails g view_primitives:update --skip-components
```

### Optional color themes

```bash
rails g view_primitives:theme rose
```

Add `data-theme="rose"` on `<html>` to activate. Dark mode still uses the `.dark` class.

### When to add a new `vp-*` primitive

ViewPrimitives is **not** a Bootstrap-style class system. The `vp-*` layer is for **cross-cutting building blocks** only — not full components.

Add a new `@utility vp-*` only when **all** of these are true:

1. The same Tailwind block appears in **five or more** component files
2. Those files should stay in sync when the pattern changes (focus ring, input shell, overlay)
3. The class is referenced from Ruby via `UI::Styles`, not typed directly in app views

Do **not** add `vp-button`, `vp-card`, or other component-level classes. Use ViewComponent constants and design tokens instead.

Current primitives: `vp-focus-ring`, `vp-peer-focus-ring`, `vp-border`, `vp-input`, `vp-textarea`, `vp-select`, `vp-overlay`, `vp-popover-panel`, `vp-menu-item`. Menu separators use `UI::Styles::MENU_SEPARATOR` (`bg-border`, not a bare `<hr>`).

### Border conventions

Tailwind `border`, `border-b`, and `border-t` **without a color** resolve to `currentColor` and often render as heavy black lines. Always pair directional borders with a token:

```erb
<%# ✅ GOOD %>
<div class="border-b border-border">

<%# ❌ BAD — black or double-weight lines %>
<div class="border-b">
<div class="border rounded-lg">  <%# preview wrapper + component border-b = 2px bottom %>
```

When placing a component inside a bordered preview card, remove the overlapping edge on the component:

```erb
<div class="overflow-hidden rounded-lg border border-border">
  <%= ui :navbar, class: "static border-b-0 shadow-none", brand: "MyApp", items: [...] %>
</div>
```

| Class / constant | Use for |
|------------------|---------|
| `border border-input` / `UI::Styles::FIELD_PANEL` | Form fields, pickers, calendar shells |
| `border-b border-border`, `border-t border-border` | Navbar, footer, accordion items, table rows |
| `UI::Styles::BORDER` (`vp-border`) | Cards, tables, media wrappers, dialog panels |
| `UI::Styles::MENU_SEPARATOR` | Dividers inside dropdown, menubar, context menu, command |
| `divide-y divide-border` | List group and stacked list dividers |
| `UI::Styles::PICKER_TRIGGER` | Date and time picker trigger buttons |

---

## Level 3 — Component classes

Each component file lives in `app/components/ui/` and is plain Ruby. The Tailwind classes are defined as constants at the top of the file — edit them directly:

```ruby
# app/components/ui/button_component.rb

BASE_CLASSES = "inline-flex items-center justify-center gap-2 rounded-md text-sm font-semibold ..."

VARIANTS = {
  default: "bg-primary text-primary-foreground hover:bg-primary/90",
  outline: "border bg-background hover:bg-accent",
  # Add a new variant:
  brand:   "bg-gradient-to-r from-indigo-500 to-purple-600 text-white hover:opacity-90"
}.freeze
```

Then use it:

```erb
<%= ui :button, "Subscribe", variant: :brand %>
```

### Adding a variant to Badge

```ruby
# app/components/ui/badge_component.rb
VARIANTS = {
  default:     "...",
  secondary:   "...",
  destructive: "...",
  outline:     "...",
  # Your additions:
  success: "border-transparent bg-green-500 text-white",
  warning: "border-transparent bg-yellow-400 text-foreground"
}.freeze
```

### Changing the tag or structure

Components use `content_tag` in `call` — you can change the HTML tag or structure freely:

```ruby
# Make Button render a <span> by default instead of <button>
def call
  content_tag(:span, content.presence || @label, class: component_classes, **@html_attrs)
end
```

---

## Level 4 — Per-instance overrides

Pass `class:` to any component to append Tailwind utilities to the generated classes. Your classes are merged **after** the base classes via `cn()`:

```erb
<%# Wider button %>
<%= ui :button, "Continue", class: "w-full" %>

<%# Tighter card %>
<%= ui :card, class: "p-3 gap-3" %>

<%# Muted badge with extra spacing %>
<%= ui :badge, "Draft", variant: :outline, class: "ml-2 opacity-60" %>
```

`cn()` joins class strings and, when the optional [`tailwind_merge`](https://rubygems.org/gems/tailwind_merge) gem is installed, resolves conflicting utilities (for example `px-2` + `px-4` → `px-4`). Without the gem, classes are joined with a space.

Add to your Gemfile if you want smart merging:

```ruby
gem "tailwind_merge"
```

---

## Theming example — full brand override

Suppose your brand is indigo with rounded corners and a warm dark mode:

```css
/* app/assets/stylesheets/view_primitives.css */

:root {
  --primary:            oklch(0.52 0.22 264);
  --primary-foreground: oklch(0.98 0 0);
  --accent:             oklch(0.93 0.04 264);
  --accent-foreground:  oklch(0.3 0.1 264);
  --ring:               oklch(0.6 0.18 264);
  --radius:             0.75rem;
}

.dark {
  --primary:            oklch(0.72 0.18 264);
  --primary-foreground: oklch(0.15 0.05 264);
  --background:         oklch(0.14 0.02 264);
  --card:               oklch(0.18 0.02 264);
  --accent:             oklch(0.25 0.05 264);
}
```

No component files need to change — the design tokens propagate everywhere automatically.

---

## Keeping components up to date

After upgrading the gem, refresh everything you have already copied:

```bash
rails g view_primitives:update
rails g view_primitives:update --only button dialog   # selected components
rails g view_primitives:update --skip-css             # components only
```

To overwrite a single component:

```bash
rails g view_primitives:add button
```

Any customizations in overwritten files will be lost. Prefer token and `UI::Styles` overrides, or track local edits in git so you can re-apply them as a patch.
