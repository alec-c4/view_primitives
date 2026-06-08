# Embed

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Embeds third-party content. Pass `url:` — the provider is detected automatically from the domain. No `type:` needed.

## Usage

```erb
<%# YouTube %>
<%= ui :embed, url: "https://youtu.be/dQw4w9WgXcQ" %>
<%= ui :embed, url: "https://www.youtube.com/watch?v=dQw4w9WgXcQ" %>

<%# Vimeo %>
<%= ui :embed, url: "https://vimeo.com/148751763" %>

<%# Spotify — track, album, or playlist %>
<%= ui :embed, url: "https://open.spotify.com/track/4iV5W9uYEdYUVa79Axb7Rh" %>
<%= ui :embed, url: "https://open.spotify.com/album/1DFixLWuPkv3KT3TnV35m3" %>
<%= ui :embed, url: "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M" %>

<%# Google Maps — share URL or search query %>
<%= ui :embed, url: "https://www.google.com/maps/place/Eiffel+Tower" %>
<%= ui :embed, query: "Eiffel Tower, Paris" %>

<%# Yandex Maps %>
<%= ui :embed, url: "https://yandex.ru/maps/213/moscow/?ll=37.617685,55.755814&z=10" %>

<%# Loom %>
<%= ui :embed, url: "https://www.loom.com/share/abc123def456" %>

<%# SoundCloud %>
<%= ui :embed, url: "https://soundcloud.com/artist/track" %>

<%# X (Twitter) %>
<%= ui :embed, url: "https://x.com/jack/status/20" %>

<%# Telegram %>
<%= ui :embed, url: "https://t.me/telegram/193" %>

<%# Facebook video %>
<%= ui :embed, url: "https://www.facebook.com/watch/?v=123456" %>

<%# Custom aspect ratio / height %>
<%= ui :embed, url: "https://youtu.be/dQw4w9WgXcQ", aspect: "4/3" %>
<%= ui :embed, url: "https://open.spotify.com/playlist/37i9dQZF1DXcBWIGoYBM5M", height: 380 %>
```

## Parameters

| Parameter | Type    | Default      | Description                                                       |
|-----------|---------|--------------|-------------------------------------------------------------------|
| `url`     | String  | `nil`        | Full URL — provider detected automatically                        |
| `query`   | String  | `nil`        | Google Maps search query (alternative to `url:` for Maps only)    |
| `aspect`  | String  | per provider | CSS `aspect-ratio` value, e.g. `"4/3"` — overrides default       |
| `height`  | Integer | per provider | Explicit height in px — used when provider has no natural ratio   |
| `title`   | String  | per provider | Accessible `<iframe>` title                                       |
| `class`   | String  | `nil`        | Extra classes on the wrapper `<div>`                              |

## Supported providers

| Detected from URL                         | Default sizing     | Notes                              |
|-------------------------------------------|--------------------|------------------------------------|
| `youtube.com`, `youtu.be`                 | 16/9 aspect        | `rel=0` suppresses related videos  |
| `vimeo.com`                               | 16/9 aspect        | `dnt=1` (do not track)             |
| `open.spotify.com`                        | 152px height       | Pass `height: 380` for full player |
| `google.com/maps`, `maps.app.goo.gl`      | 16/9 aspect        | Also accepts `query:` shorthand    |
| `yandex.ru/maps`, `yandex.com/maps`       | 16/9 aspect        | Share URL converted to widget URL  |
| `loom.com`                                | 16/9 aspect        |                                    |
| `soundcloud.com`                          | 166px height       |                                    |
| `x.com`, `twitter.com`                    | auto-height        | Official JS widget (Twitter widgets.js) |
| `t.me`, `telegram.org`                    | auto-height        | Official JS widget                 |
| `facebook.com`, `fb.com`                  | 16/9 aspect        |                                    |

## Notes

- All embeds render with a `sandbox` attribute appropriate to the provider — scripts are allowed only when required.
- The wrapper `<div>` has `bg-black` so providers with letterboxed content don't show a white gap.
- For Spotify albums/playlists pass `height: 380` to show the full expanded player.
- Google Maps: if the share URL contains `output=embed` or `/maps/embed`, it is used as-is. Otherwise the component appends `output=embed` automatically. For complex encoded URLs (e.g. copied from the Maps "Embed" tab), pass as-is — they work directly.
- Yandex Maps: share URL (`yandex.ru/maps/...`) is converted to widget URL (`yandex.ru/map-widget/v1/...`) automatically.
- **X and Telegram** use official JS widgets — sizing is handled natively by the provider. No fixed height needed.
