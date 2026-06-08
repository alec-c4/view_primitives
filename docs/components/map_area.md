# Map / Area

**Prerequisites:** run [component setup](README.md) (`view_primitives:install`) once per app.

Renders an `<img usemap>` + `<map>` + `<area>` elements. Use it for image maps with clickable regions — floor plans, world maps, diagrams.

## Usage

```erb
<%= ui :map_area,
      src: "/images/floor-plan.png",
      alt: "Office floor plan",
      width: 800, height: 600,
      areas: [
        { shape: :rect,   coords: "0,0,200,150",      href: "/room/1", alt: "Room A" },
        { shape: :circle, coords: "400,300,50",        href: "/room/2", alt: "Central hub" },
        { shape: :poly,   coords: "600,100,750,100,700,250", href: "/room/3", alt: "Room B" }
      ] %>
```

## Parameters

| Parameter   | Type    | Default | Description                                                  |
|-------------|---------|---------|--------------------------------------------------------------|
| `src`       | String  | required | Image URL                                                   |
| `alt`       | String  | required | Alt text for the image                                      |
| `areas`     | Array   | `[]`    | Array of area hashes (see below)                             |
| `width`     | Integer | `nil`   | Image width                                                  |
| `height`    | Integer | `nil`   | Image height                                                 |
| `loading`   | Symbol  | `:lazy` | `:lazy` or `:eager`                                          |
| `map_name`  | String  | auto    | `<map name>` — auto-generated if not provided               |
| `class`     | String  | `nil`   | Extra classes on the wrapper `<div>`                         |

## Area hash keys

| Key      | Required | Description                                                  |
|----------|----------|--------------------------------------------------------------|
| `shape`  | yes      | `:rect`, `:circle`, `:poly`, or `:default`                   |
| `coords` | yes*     | Coordinate string — required for rect/circle/poly            |
| `alt`    | yes      | Accessible label (required when `href` is present)           |
| `href`   | no       | Link target                                                  |
| `title`  | no       | Tooltip text                                                 |
| `target` | no       | Link target window, e.g. `"_blank"`                          |
| `rel`    | no       | Link rel attribute                                           |

### Coordinate format

| Shape    | Format                             | Example                        |
|----------|------------------------------------|--------------------------------|
| `rect`   | `"x1,y1,x2,y2"`                   | `"0,0,200,150"`                |
| `circle` | `"cx,cy,radius"`                   | `"400,300,50"`                 |
| `poly`   | `"x1,y1,x2,y2,x3,y3,..."`         | `"10,10,50,10,30,40"`          |
| `default`| (no coords)                        | covers the entire image        |

## Notes

- The `<map name>` attribute is auto-generated with a random suffix so multiple maps on the same page don't conflict.
- Provide meaningful `alt` text on each area with a `href` — screen readers announce it as link text.
- Combine with the **Aspect Ratio** component to keep the image responsive while preserving proportions.
