# frozen_string_literal: true

module UI
  class HoverCardComponent < ApplicationComponent
    renders_one :trigger

    CARD_BASE = "#{UI::Styles::POPOVER_PANEL} w-64 p-4 " \
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
        class: cn("group relative inline-block", @extra_class),
        data: { slot: "hover-card" },
        **@html_attrs) do
        concat content_tag(:span, trigger, class: "contents", data: { slot: "hover-card-trigger" }) if trigger
        concat card_panel
      end
    end

    private

    def card_panel
      content_tag(:div,
        class: cn(CARD_BASE, POSITIONS.fetch(@side, POSITIONS[:bottom])),
        data: { slot: "hover-card-content" }) do
        content
      end
    end
  end
end
