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
| Badge | Small status label with variants | No | done |
| Avatar | User avatar with image fallback and initials | No | done |
| Card | Container with header, content, and footer slots | No | done |
| Separator | Horizontal or vertical divider line | No | done |
| Label | Accessible form label | No | done |
| Skeleton | Loading placeholder with pulse animation | No | done |
| Progress | Progress bar with value prop | No | done |
| Aspect Ratio | Constrains child content to a given aspect ratio | No | done |
| Spinner | Animated loading spinner | No | done |
| KBD | Keyboard shortcut key display (e.g. `Ctrl+K`) | No | done |
| Rating | Read-only star rating display | No | done |
| Rating Input | Interactive star rating — click to select, submits via form or AJAX | Yes | done |
| Indicator | Status dot overlaid on another element (online, count, etc.) | No | done |
| List Group | Bordered list of items with optional actions or links | No | done |
| Banner | Dismissible announcement strip (top of page or sticky) | No | done |
| Button Group | Visually joined row of buttons sharing a border | No | done |

## Phase 3 — Forms

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Input | Styled text input with consistent ring/border | No | done |
| Textarea | Styled multi-line input | No | done |
| Checkbox | Accessible checkbox with optional label | No | done |
| Radio Group | Group of radio inputs with items: array API | No | done |
| Select | Native styled select with value/label pairs and blank option | No | done |
| Switch | CSS-only toggle using checkbox + peer classes | No | done |
| Toggle | Single pressable toggle button with pressed state | No | done |
| Toggle Group | Group of toggles, single or multiple selection | No | done |
| Form Field | Wraps label + input + hint + error into a consistent layout | No | done |
| File Input | Styled file upload input | No | planned |
| Search Input | Input with built-in search icon and clear button | No | planned |
| Number Input | Input with increment/decrement controls | No | planned |
| Range | Styled range slider | No | planned |
| Floating Label | Input with a floating placeholder label | No | planned |

## Phase 4 — Navigation

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Tabs | Tab bar with content panels (CSS-only via radio hack or Stimulus) | Optional | planned |
| Breadcrumb | Navigational breadcrumb with separator | No | planned |
| Pagination | Page number links with prev/next controls | No | planned |
| Navigation Menu | Top-level navigation with optional dropdown flyouts | Optional | planned |
| Navbar | Responsive top navigation bar with branding and links | Optional | planned |
| Footer | Page footer with columns, links, and copyright | No | planned |
| Bottom Navigation | Mobile-style tab bar fixed to the bottom of the screen | No | planned |
| Mega Menu | Full-width dropdown panel with grouped links and images | Yes | planned |
| Stepper | Multi-step progress indicator for wizards and flows | No | planned |

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
| Timepicker | Input for selecting a time value | Yes | planned |
| Carousel | Scrollable item carousel with prev/next controls | Yes | planned |
| Data Table | Sortable, filterable table with pagination | Yes | planned |
| Sidebar | Collapsible application sidebar with nav groups | Yes | planned |
| Input OTP | One-time-password digit input group | Yes | planned |
| Collapsible | Single collapsible section (simpler than Accordion) | No | planned |
| Resizable | Drag-to-resize panel layout | Yes | planned |
| Scroll Area | Custom scrollbar container | No | planned |
| Gallery | Responsive image grid with optional lightbox | Yes | planned |
| Chat Bubble | Styled message bubble for chat or comment threads | No | planned |
| Speed Dial | Floating action button that expands into sub-actions | Yes | planned |
| Device Mockup | Phone or browser frame for marketing screenshots | No | planned |
| QR Code | QR code display from a given value | No | planned |

## Phase 8 — Advanced

| Component | Description | JS needed | Status |
|-----------|-------------|-----------|--------|
| Chart | Wrapper for charting (line, bar, pie) via a JS adapter | Yes | planned |
| Sonner (Toast) | Stacked toast notifications | Yes | planned |
| Timeline | Vertical timeline with event items | No | planned |
| WYSIWYG | Rich text editor wrapper (e.g. Trix or Quill adapter) | Yes | planned |
