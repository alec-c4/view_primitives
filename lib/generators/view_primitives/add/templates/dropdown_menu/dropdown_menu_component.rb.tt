# frozen_string_literal: true

module UI
  class DropdownMenuComponent < ApplicationComponent
    renders_one :trigger

    PANEL = "#{UI::Styles::POPOVER_PANEL} min-w-[8rem] overflow-x-hidden overflow-y-auto p-1"

    ALIGN = {
      start: "top-full left-0 mt-1",
      end:   "top-full right-0 mt-1",
    }.freeze

    ITEM      = "#{UI::Styles::MENU_ITEM} w-full hover:bg-accent hover:text-accent-foreground " \
                "data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 " \
                "dark:data-[variant=destructive]:focus:bg-destructive/20 " \
                "[&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 " \
                "[&_svg:not([class*='text-'])]:text-muted-foreground"
    SEPARATOR = UI::Styles::MENU_SEPARATOR
    LABEL_CLS = "px-2 py-1.5 text-sm font-medium"

    def initialize(align: :start, **html_attrs)
      @align       = align.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: "relative inline-block",
        data: {
          controller: "dropdown",
          action: "click@document->dropdown#closeOnClickOutside"
        },
        **@html_attrs) do
        concat content_tag(:span, trigger, data: { action: "click->dropdown#toggle" }, class: "contents") if trigger
        concat panel
      end
    end

    private

    def panel
      content_tag(:div,
        data: { dropdown_target: "panel" },
        hidden: true,
        class: cn(PANEL, ALIGN.fetch(@align, ALIGN[:start]), @extra_class)) do
        concat content
      end
    end
  end
end
