# Customizing ViewPrimitives

ViewPrimitives follows the shadcn/ui philosophy: **you own the code**. Components are copied into your app by the generator, so you can change anything without forking the gem.

There are three levels of customization, from lightest to deepest:

---

## Level 1 — Design tokens (colors, radius, spacing)

All visual properties are driven by CSS variables defined in `app/assets/stylesheets/view_primitives.css` (exact path depends on your setup — see `rails g view_primitives:install`).

The `:root` block sets the default light theme. Override any variable there to change it globally:

```css
/* app/assets/stylesheets/view_primitives.css */

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

## Level 2 — Component classes

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
<%= ui "button", "Subscribe", variant: :brand %>
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

## Level 3 — Per-instance overrides

Pass `class:` to any component to append Tailwind utilities to the generated classes. Your classes are added **after** the base classes, so they win:

```erb
<%# Wider button %>
<%= ui "button", "Continue", class: "w-full" %>

<%# Tighter card %>
<%= ui "card", class: "p-3 gap-3" %>

<%# Muted badge with extra spacing %>
<%= ui "badge", "Draft", variant: :outline, class: "ml-2 opacity-60" %>
```

This works because all components pass `@extra_class` last through the `cn()` helper, which joins and deduplicates class names.

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

If a new version of ViewPrimitives ships improvements to a component, re-run the generator with `--force` to overwrite your local copy:

```bash
rails g view_primitives:add button --force
```

Any customizations you made to that file will be lost. The recommended workflow is to keep local changes minimal (prefer token overrides) or track them in git so you can re-apply them as a patch.
