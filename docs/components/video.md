# Video

HTML5 `<video>` element with multiple source formats, track (caption) support, and sensible defaults.

## Installation

```bash
rails g view_primitives:add video
```

Creates `app/components/ui/video_component.rb`.

## Usage

```erb
<%= ui :video do |v| %>
  <% v.with_source(src: "/videos/demo.mp4",  type: "video/mp4") %>
  <% v.with_source(src: "/videos/demo.webm", type: "video/webm") %>
<% end %>
```

## With poster and captions

```erb
<%= ui :video, poster: "/videos/demo-poster.jpg" do |v| %>
  <% v.with_source(src: "/videos/demo.mp4", type: "video/mp4") %>
  <% v.with_track(src: "/captions/demo.en.vtt",
                  kind: :subtitles,
                  label: "English",
                  srclang: "en",
                  default: true) %>
<% end %>
```

## Autoplay (muted required)

```erb
<%= ui :video, autoplay: true, muted: true, loop: true,
               controls: false, class: "w-full" do |v| %>
  <% v.with_source(src: "/videos/bg.mp4", type: "video/mp4") %>
<% end %>
```

Autoplay automatically sets `muted: true` regardless of the `muted:` option value.

## API

### VideoComponent

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `poster` | String | `nil` | Preview image URL |
| `controls` | Boolean | `true` | Show native browser controls |
| `autoplay` | Boolean | `false` | Auto-start playback (forces `muted: true`) |
| `muted` | Boolean | `false` | Mute the audio track |
| `loop` | Boolean | `false` | Loop playback |
| `preload` | Symbol | `:metadata` | `:auto`, `:metadata`, or `:none` |
| `playsinline` | Boolean | `true` | Play inline on iOS |
| `width` | Integer | `nil` | Explicit width |
| `height` | Integer | `nil` | Explicit height |
| `**html_attrs` | Hash | — | Forwarded to the `<video>` element |

### SourceComponent (via `with_source`)

| Option | Type | Required | Description |
|--------|------|----------|-------------|
| `src` | String | Yes | Video file URL |
| `type` | String | Yes | MIME type, e.g. `"video/mp4"` |

### TrackComponent (via `with_track`)

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `src` | String | required | WebVTT file URL |
| `kind` | Symbol | `:subtitles` | `:subtitles`, `:captions`, `:descriptions`, `:chapters`, or `:metadata` |
| `label` | String | `nil` | Human-readable track name |
| `srclang` | String | `nil` | BCP 47 language tag, e.g. `"en"` |
| `default` | Boolean | `false` | Activate this track by default |
