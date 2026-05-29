# ChatBubble

Styled message bubble for chat or comment interfaces. Supports sent and received orientations, timestamps, and avatars.

## Installation

```bash
rails g view_primitives:add chat_bubble
```

Creates `app/components/ui/chat_bubble_component.rb`.

## Usage

```erb
<%# Received message (default) %>
<%= ui :chat_bubble do %>
  Hello! How can I help you today?
<% end %>

<%# Sent message %>
<%= ui :chat_bubble, sent: true do %>
  I'd like to book an appointment.
<% end %>
```

## With timestamp

```erb
<%= ui :chat_bubble, sent: true, timestamp: "10:34 AM" do %>
  Sounds great, see you then!
<% end %>
```

## With avatar

The `avatar:` option only applies to received messages (`sent: false`).

```erb
<%= ui :chat_bubble, avatar: user_avatar_url(@agent), timestamp: "10:32 AM" do %>
  I'll check and get back to you shortly.
<% end %>
```

## In a conversation thread

```erb
<div class="flex flex-col gap-4 p-4">
  <% @messages.each do |msg| %>
    <%= ui :chat_bubble,
           sent: msg.mine?,
           timestamp: msg.sent_at.strftime("%H:%M"),
           avatar: msg.mine? ? nil : msg.sender.avatar_url do %>
      <%= msg.body %>
    <% end %>
  <% end %>
</div>
```

## API

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `sent` | Boolean | `false` | `true` → right-aligned primary bubble; `false` → left-aligned muted bubble |
| `timestamp` | String | `nil` | Time string shown below the bubble |
| `avatar` | String | `nil` | Avatar image URL — rendered only for received messages |
| `**html_attrs` | Hash | — | Forwarded to the outer `<div>` |
