# Sidebar

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Collapsible application sidebar with branded header, grouped navigation items, and built-in icon support.

Requires `sidebar_controller.js` (copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add sidebar
```

Creates `app/components/ui/sidebar_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only sidebar
```


## Usage

```erb
<%= ui :sidebar, brand: "Acme" do |s| %>
  <% s.with_group(label: "Main") do |g| %>
    <% g.with_item(label: "Dashboard", href: dashboard_path, icon: :home, active: true) %>
    <% g.with_item(label: "Users",     href: users_path,     icon: :users) %>
    <% g.with_item(label: "Settings",  href: settings_path,  icon: :settings) %>
  <% end %>
  <% s.with_group(label: "Reports") do |g| %>
    <% g.with_item(label: "Analytics", href: analytics_path, icon: :chart) %>
  <% end %>
<% end %>
```

## Collapsed by default

```erb
<%= ui :sidebar, brand: "Acme", collapsed: true do |s| %>
  <%# … %>
<% end %>
```

## Items without groups

```erb
<%= ui :sidebar do |s| %>
  <% s.with_item(label: "Home",     href: root_path,  icon: :home) %>
  <% s.with_item(label: "Settings", href: settings_path, icon: :settings) %>
<% end %>
```

## Built-in icons

Pass an `icon:` symbol to one of these built-in paths:

`home`, `dashboard`, `folder`, `tasks`, `settings`, `users`, `chart`, `mail`, `bell`, `credit_card`, `logout`

Custom SVGs can be rendered inside a block instead.

## Toggling

The sidebar collapses to a 16px rail showing only icons. Clicking the chevron in the header toggles the state.

## API

### SidebarComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `brand` | String | `nil` | Brand name shown in the header (hidden when collapsed) |
| `collapsed` | Boolean | `false` | Initial collapsed state |
| `**html_attrs` | Hash | — | Forwarded to the `<aside>` element |

### GroupComponent (via `with_group`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | `nil` | Section heading shown above items |

### ItemComponent (via `with_item` or `g.with_item`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `label` | String | required | Navigation link text |
| `href` | String | `"#"` | Link destination |
| `active` | Boolean | `false` | Highlights the item as the current page |
| `icon` | Symbol | `nil` | One of the built-in icon names |
