# frozen_string_literal: true

module UI
  class MenubarMenuComponent < ApplicationComponent
    TRIGGER = "flex items-center rounded-sm px-2 py-1 text-sm font-medium outline-hidden select-none " \
              "focus:bg-accent focus:text-accent-foreground " \
              "data-[state=open]:bg-accent data-[state=open]:text-accent-foreground"

    PANEL = "#{UI::Styles::POPOVER_PANEL} left-0 top-full z-50 mt-1 w-max min-w-[12rem] overflow-hidden p-1"

    def initialize(label:, **html_attrs)
      @label       = label
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div, class: "relative", data: { menubar_target: "menu" }, **@html_attrs) do
        concat content_tag(:button,
          @label,
          type: "button",
          class: TRIGGER,
          data: { action: "click->menubar#toggle mouseenter->menubar#openOnHover" })
        concat content_tag(:div,
          data: { menubar_target: "panel" },
          hidden: true,
          class: cn(PANEL, @extra_class)) {
          concat content
        }
      end
    end
  end
end
