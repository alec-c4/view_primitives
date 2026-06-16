# AGENTS.md

## Cursor Cloud specific instructions

`view_primitives` is a single Ruby **gem** (a ViewComponent-based UI component
library for Rails). There are **no long-running services, servers, databases, or
ports** — "running" the project means running its test suite, linter, and the
gem build. See `README.md` for the gem's purpose and public API, and
`Rakefile` / `.github/workflows/main.yml` for the canonical commands.

### Ruby toolchain (non-obvious)
- Ruby is managed by **mise** (pinned to the version in `mise.toml` / `.ruby-version`).
  Ruby is **not** a system package; it lives under `~/.local/share/mise`.
- A **global** mise Ruby is configured (`mise use -g`), so `ruby`/`bundle` resolve
  in any directory. Inside this repo `mise.toml` also pins the same version.
- In a non-interactive shell where mise isn't activated, call it explicitly, e.g.
  `~/.local/bin/mise exec -- bundle exec rake`. Interactive shells get mise via
  `~/.bashrc`.

### Commands (run from repo root)
- Tests: `bundle exec rake test`
- Lint: `bundle exec rubocop`
- Tests + lint (default task): `bundle exec rake`
- Build gem: `bundle exec rake build`
- REPL with the gem loaded: `bin/console`
- Multi-Rails matrix (optional): `bundle exec appraisal rails-8.1 rake test`
  (matrix names: `rails-7.1`, `rails-7.2`, `rails-8.0`, `rails-8.1`).

### Verifying the gem end-to-end (host Rails app)
The gem's real flow is: install it into a Rails app, run generators to copy
components, then render them with the `ui` helper. To exercise this manually,
create a throwaway Rails app, add `gem "view_primitives", path: "<repo>"` plus
`view_component` and `tailwindcss-rails`, then run
`rails g view_primitives:install` and `rails g view_primitives:add button card badge`,
import `@import "../stylesheets/view_primitives";` in the Tailwind entry, and
render the components in a view. This is only needed for manual UI verification;
the bundled `bundle exec rake test` already covers component rendering in-memory.
