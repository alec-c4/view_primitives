# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- `.ruby-version` / `mise.toml` for Ruby 4.0.5
- `ui` helper in Action Mailer views
- `rails g view_primitives:list` — shows available components and installed status
- Shared `ViewPrimitives::Generators::Components` registry for add/list generators
- Phase 5 overlay components: Dialog, Alert Dialog, Sheet, Drawer, Popover, Tooltip, Hover Card
- Install generator checks `UI` inflection; clearer Tailwind entry detection
- Button template defaults to `type="button"` inside forms

### Changed

- Removed public `component` helper — use `ui` for primitives; `render` for other namespaces
- `AddGenerator` copies files from template directories automatically (no per-component methods)
- `Components.supported` is derived from template directories, not a duplicated list
- Simplified `Detector` and `ComponentHelper`
- `view_primitives:add` exits with status 1 on unknown components; prints copy summary
- `view_primitives:add` warns before overwriting existing files
- Requires `view_component` `>= 4.0` and Rails `>= 7.1`
