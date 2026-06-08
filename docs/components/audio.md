# Audio

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

HTML5 `<audio>` element with multiple source formats and playback controls.

## Installation

```bash
rails g view_primitives:add audio
```

Creates `app/components/ui/audio_component.rb`.

Refresh after a gem upgrade:

```bash
rails g view_primitives:update --only audio
```


## Usage

```erb
<%= ui :audio do |a| %>
  <% a.with_source(src: "/audio/podcast.mp3",  type: "audio/mpeg") %>
  <% a.with_source(src: "/audio/podcast.ogg",  type: "audio/ogg") %>
<% end %>
```

## Without controls

```erb
<%= ui :audio, controls: false, autoplay: true, loop: true do |a| %>
  <% a.with_source(src: "/audio/background.mp3", type: "audio/mpeg") %>
<% end %>
```

## Preload hints

```erb
<%# Download nothing until the user interacts %>
<%= ui :audio, preload: :none do |a| %>
  <% a.with_source(src: "/audio/intro.mp3", type: "audio/mpeg") %>
<% end %>
```

## API

### AudioComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `controls` | Boolean | `true` | Show native browser controls |
| `autoplay` | Boolean | `false` | Auto-start playback |
| `muted` | Boolean | `false` | Mute the audio |
| `loop` | Boolean | `false` | Loop playback |
| `preload` | Symbol | `:metadata` | `:auto`, `:metadata`, or `:none` |
| `**html_attrs` | Hash | — | Forwarded to the `<audio>` element |

### SourceComponent (via `with_source`)

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `src` | String | Yes | Audio file URL |
| `type` | String | Yes | MIME type, e.g. `"audio/mpeg"` |
