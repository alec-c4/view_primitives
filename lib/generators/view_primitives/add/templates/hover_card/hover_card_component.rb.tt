# frozen_string_literal: true

module UI
  class HoverCardComponent < ApplicationComponent
    renders_one :trigger

    CARD_BASE = "absolute z-50 w-64 rounded-lg border bg-popover p-4 text-sm " \
                "text-popover-foreground shadow-md " \
                "opacity-0 group-hover:opacity-100 pointer-events-none " \
                "transition-opacity duration-200"

    POSITIONS = {
      bottom: "top-full left-0 mt-2",
      top:    "bottom-full left-0 mb-2",
      left:   "right-full top-0 mr-2",
      right:  "left-full top-0 ml-2"
    }.freeze

    def initialize(side: :bottom, **html_attrs)
      @side        = side.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:span,
        class: cn("relative inline-block group", @extra_class),
        **@html_attrs) do
        concat trigger if trigger
        concat card_panel
      end
    end

    private

    def card_panel
      content_tag(:div,
        class: cn(CARD_BASE, POSITIONS.fetch(@side, POSITIONS[:bottom]))) do
        content
      end
    end
  end
end
