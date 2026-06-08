# frozen_string_literal: true

module UI
  class ChatBubbleComponent < ApplicationComponent
    # sent: true  → right-aligned, primary-colored bubble
    # sent: false → left-aligned, muted bubble (default)

    BUBBLE_BASE = "max-w-[80%] rounded-2xl px-4 py-2.5 text-sm leading-relaxed shadow-xs"
    BUBBLE_SENT = "rounded-br-md bg-primary text-primary-foreground"
    BUBBLE_RECV = "rounded-bl-md #{UI::Styles::BORDER} bg-muted text-foreground"

    TIMESTAMP_BASE = "mt-1 text-xs text-muted-foreground"

    # sent:      true for outgoing messages, false for incoming (default)
    # timestamp: optional time string rendered below the bubble
    # avatar:    optional URL for a small avatar image (incoming only)
    def initialize(sent: false, timestamp: nil, avatar: nil, **html_attrs)
      @sent      = sent
      @timestamp = timestamp
      @avatar    = avatar
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      wrapper_cls = cn("flex items-end gap-2", @sent ? "flex-row-reverse" : "flex-row", @extra_class)

      content_tag(:div, class: wrapper_cls, **@html_attrs) do
        concat avatar_img if @avatar && !@sent
        concat bubble_block
      end
    end

    private

    def avatar_img
      content_tag(:img, nil,
        src: @avatar,
        alt: "",
        class: "size-8 shrink-0 rounded-full object-cover ring-2 ring-background",
        "aria-hidden": "true")
    end

    def bubble_block
      content_tag(:div, class: cn("flex flex-col", @sent ? "items-end" : "items-start")) do
        concat content_tag(:div, content,
          class: cn(BUBBLE_BASE, @sent ? BUBBLE_SENT : BUBBLE_RECV))
        concat content_tag(:p, @timestamp,
          class: TIMESTAMP_BASE) if @timestamp
      end
    end
  end
end
