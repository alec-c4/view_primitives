# Stepper

Multi-step progress indicator with horizontal or vertical orientation.

## Installation

```bash
rails g view_primitives:add stepper
```

Creates `app/components/ui/stepper_component.rb`.

## Usage

Each step requires a `status:` of `:complete`, `:current`, or `:pending`.

```erb
<%= ui :stepper, steps: [
  { label: "Account",  status: :complete },
  { label: "Profile",  status: :current },
  { label: "Billing",  status: :pending },
  { label: "Confirm",  status: :pending }
] %>
```

## Vertical orientation

```erb
<%= ui :stepper, orientation: :vertical, steps: [
  { label: "Order placed",    status: :complete,
    description: "Jan 12 at 09:00" },
  { label: "Processing",      status: :current,
    description: "Estimated 1–2 business days" },
  { label: "Shipped",         status: :pending },
  { label: "Delivered",       status: :pending }
] %>
```

## Step statuses

| Status | Appearance |
|--------|------------|
| `:complete` | Filled circle with a check mark |
| `:current` | Outlined circle with a filled dot; `aria-current="step"` |
| `:pending` | Outlined circle, muted colour |

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `steps` | Array | required | Array of step hashes — see table below |
| `orientation` | Symbol | `:horizontal` | `:horizontal` or `:vertical` |
| `**html_attrs` | Hash | — | Forwarded to the `<ol>` element |

### Step hash

| Key | Type | Required | Description |
|-----|------|----------|-------------|
| `label` | String | Yes | Step name |
| `status` | Symbol | Yes | `:complete`, `:current`, or `:pending` |
| `description` | String | No | Supporting text (vertical orientation only) |
