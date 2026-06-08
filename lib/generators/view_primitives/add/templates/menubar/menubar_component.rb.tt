# frozen_string_literal: true

module UI
  class MenubarComponent < ApplicationComponent
    renders_many :menus, "UI::MenubarMenuComponent"

    BAR  = "flex h-9 items-center gap-1 rounded-md #{UI::Styles::BORDER} bg-background p-1 shadow-xs"
    ITEM = "#{UI::Styles::MENU_ITEM} w-full whitespace-nowrap hover:bg-accent hover:text-accent-foreground " \
           "data-[variant=destructive]:text-destructive data-[variant=destructive]:focus:bg-destructive/10 " \
           "dark:data-[variant=destructive]:focus:bg-destructive/20 " \
           "[&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 " \
           "[&_svg:not([class*='text-'])]:text-muted-foreground"
    SEPARATOR = UI::Styles::MENU_SEPARATOR
    LABEL_CLS = "px-2 py-1.5 text-sm font-medium"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn(BAR, @extra_class),
        data: {
          controller: "menubar",
          action: "click@document->menubar#closeOnClickOutside keydown.escape@document->menubar#closeAll"
        },
        **@html_attrs) do
        menus.each { |m| concat m }
      end
    end
  end
end
