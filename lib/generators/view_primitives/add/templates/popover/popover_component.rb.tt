# frozen_string_literal: true

module UI
  class PopoverComponent < ApplicationComponent
    renders_one :trigger

    PANEL_BASE = "#{UI::Styles::POPOVER_PANEL} w-72 p-4"

    ALIGN = {
      start:  "left-0",
      center: "left-1/2 -translate-x-1/2",
      end:    "right-0"
    }.freeze

    SIDE = {
      bottom: "top-full mt-2",
      top:    "bottom-full mb-2",
      left:   "right-full mr-2 top-0",
      right:  "left-full ml-2 top-0"
    }.freeze

    def initialize(align: :start, side: :bottom, **html_attrs)
      @align       = align.to_sym
      @side        = side.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: "relative inline-block",
        data: { controller: "popover", action: "click@document->popover#closeOnClickOutside" },
        **@html_attrs) do
        concat content_tag(:span, trigger, data: { action: "click->popover#toggle" }, class: "contents") if trigger
        concat panel
      end
    end

    private

    def panel
      content_tag(:div,
        class: cn(
          PANEL_BASE,
          ALIGN.fetch(@align, ALIGN[:start]),
          SIDE.fetch(@side, SIDE[:bottom]),
          @extra_class
        ),
        data: { popover_target: "panel" },
        hidden: true) do
        content
      end
    end
  end
end
