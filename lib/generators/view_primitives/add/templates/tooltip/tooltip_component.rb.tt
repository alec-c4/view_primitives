# frozen_string_literal: true

module UI
  class TooltipComponent < ApplicationComponent
    BUBBLE_BASE = "pointer-events-none absolute z-50 w-fit rounded-md bg-foreground px-3 py-1.5 " \
                  "text-xs text-balance whitespace-nowrap text-background opacity-0 " \
                  "transition-opacity duration-200 group-hover:opacity-100"

    POSITIONS = {
      top:    "bottom-full left-1/2 -translate-x-1/2 mb-2",
      bottom: "top-full left-1/2 -translate-x-1/2 mt-2",
      left:   "right-full top-1/2 -translate-y-1/2 mr-2",
      right:  "left-full top-1/2 -translate-y-1/2 ml-2"
    }.freeze

    def initialize(text:, side: :top, **html_attrs)
      @text        = text
      @side        = side.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:span,
        class: cn("group relative inline-flex", @extra_class),
        data: { slot: "tooltip" },
        **@html_attrs) do
        concat content
        concat tooltip_bubble
      end
    end

    private

    def tooltip_bubble
      content_tag(:span,
        @text,
        class: cn(BUBBLE_BASE, POSITIONS.fetch(@side, POSITIONS[:top])),
        role: "tooltip",
        data: { slot: "tooltip-content" })
    end
  end
end
