# ViewPrimitives Roadmap

Components are copied into your app via `rails g view_primitives:add <component>`.
No runtime dependency — Tailwind classes live in your files.

Legend: JS = requires JavaScript | Status: done / planned

---

## Phase 1 — Foundation

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| install generator | Copies ApplicationComponent + CSS variables, prints Tailwind config | No | done |
| add generator | Copies component files into app/components/ui/ | No | done |
| Button | Clickable element with variants (default, destructive, outline, secondary, ghost, link) and sizes | No | done |
| Alert | Informational banner with title and description slots, default and destructive variants | No | done |
| Accordion | Collapsible content sections using native `<details>`/`<summary>`, no JS | No | done |

## Phase 2 — Display

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Badge | Small status label with variants | No | planned |
| Avatar | User avatar with image fallback and initials | No | planned |
| Card | Container with header, content, and footer slots | No | planned |
| Separator | Horizontal or vertical divider line | No | planned |
| Label | Accessible form label | No | planned |
| Skeleton | Loading placeholder with pulse animation | No | planned |
| Progress | Progress bar with value prop | No | planned |
| Aspect Ratio | Constrains child content to a given aspect ratio | No | planned |

## Phase 3 — Forms

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Input | Styled text input with consistent ring/border | No | planned |
| Textarea | Styled multi-line input | No | planned |
| Checkbox | Accessible checkbox with label | No | planned |
| Radio Group | Group of radio inputs | No | planned |
| Select | Native styled select element | No | planned |
| Switch | Toggle on/off using checkbox hack | No | planned |
| Toggle | Single pressable toggle button | No | planned |
| Toggle Group | Group of related toggles (single or multiple selection) | No | planned |
| Form | Wrapper that wires labels, inputs, and error messages together | No | planned |

## Phase 4 — Navigation

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Tabs | Tab bar with content panels (CSS-only via radio hack or Stimulus) | Optional | planned |
| Breadcrumb | Navigational breadcrumb with separator | No | planned |
| Pagination | Page number links with prev/next controls | No | planned |
| Navigation Menu | Top-level navigation with optional dropdown flyouts | Optional | planned |

## Phase 5 — Overlays

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Dialog | Modal dialog with overlay, title, description, and action slots | Yes | planned |
| Alert Dialog | Blocking confirmation dialog | Yes | planned |
| Sheet | Slide-in panel (drawer from an edge) | Yes | planned |
| Drawer | Bottom sheet / mobile drawer | Yes | planned |
| Popover | Floating panel anchored to a trigger | Yes | planned |
| Tooltip | Short contextual label on hover | Yes | planned |
| Hover Card | Rich hover preview card | Yes | planned |

## Phase 6 — Menus

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Dropdown Menu | Trigger-anchored menu with items, sub-menus, and separators | Yes | planned |
| Context Menu | Right-click context menu | Yes | planned |
| Menubar | Horizontal application-style menu bar | Yes | planned |
| Command | Command palette / search interface | Yes | planned |
| Combobox | Autocomplete select with search | Yes | planned |

## Phase 7 — Complex

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Calendar | Date picker calendar grid | Yes | planned |
| Date Picker | Input that opens a Calendar popover | Yes | planned |
| Carousel | Scrollable item carousel with prev/next controls | Yes | planned |
| Data Table | Sortable, filterable table with pagination | Yes | planned |
| Sidebar | Collapsible application sidebar with nav groups | Yes | planned |
| Input OTP | One-time-password digit input group | Yes | planned |
| Collapsible | Single collapsible section (simpler than Accordion) | No | planned |
| Resizable | Drag-to-resize panel layout | Yes | planned |
| Scroll Area | Custom scrollbar container | No | planned |

## Phase 8 — Advanced

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Chart | Wrapper for charting (line, bar, pie) via a JS adapter | Yes | planned |
| Sonner (Toast) | Stacked toast notifications | Yes | planned |
| Timeline | Vertical timeline with event items | No | planned |
