# frozen_string_literal: true

module UI
  class ContextMenuComponent < ApplicationComponent
    renders_one :menu

    PANEL = "#{UI::Styles::POPOVER_PANEL} fixed min-w-[8rem] overflow-x-hidden overflow-y-auto p-1"

    ITEM = "#{UI::Styles::MENU_ITEM} w-full hover:bg-accent hover:text-accent-foreground " \
           "data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 " \
           "dark:data-[variant=destructive]:focus:bg-destructive/20 " \
           "[&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 " \
           "[&_svg:not([class*='text-'])]:text-muted-foreground"

    SEPARATOR = UI::Styles::MENU_SEPARATOR
    LABEL_CLS = "px-2 py-1.5 text-sm font-medium text-foreground"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("select-none", @extra_class),
        data: {
          controller: "context-menu",
          action: "contextmenu->context-menu#show click@document->context-menu#closeOnClickOutside"
        },
        **@html_attrs) do
        concat content
        concat panel
      end
    end

    private

    def panel
      content_tag(:div,
        data: { "context-menu-target": "panel" },
        hidden: true,
        class: PANEL,
        style: "top: 0; left: 0") do
        concat menu
      end
    end
  end
end
