# DatePicker

Trigger button that opens a Calendar popover for selecting a date. Submits the chosen date via a hidden input.

Requires `date_picker_controller.js` and `calendar_controller.js` (both copied automatically by the generator).

## Installation

```bash
rails g view_primitives:add date_picker
```

Creates `app/components/ui/date_picker_component.rb`.

## Usage

```erb
<%= ui :date_picker, name: "event[date]" %>
```

## With initial date

```erb
<%= ui :date_picker, name: "event[date]", value: @event.date %>
```

## Custom placeholder

```erb
<%= ui :date_picker, name: "due_at", placeholder: "Choose a due date" %>
```

## Date bounds

```erb
<%= ui :date_picker,
       name: "appointment[date]",
       min: Date.today,
       max: Date.today + 60 %>
```

## How it works

The trigger button displays the selected date formatted as "Month D, YYYY". On click, a Calendar popover opens. When the user picks a day, the `calendar:change` event updates the trigger label and the hidden input value, then closes the popover.

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `name` | String | `nil` | Form field name for the hidden input |
| `value` | Date | `nil` | Initially selected date |
| `placeholder` | String | `"Pick a date"` | Text shown when no date is selected |
| `min` | Date | `nil` | Earliest selectable date |
| `max` | Date | `nil` | Latest selectable date |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
