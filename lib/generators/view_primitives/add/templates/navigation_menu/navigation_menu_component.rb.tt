# frozen_string_literal: true

module UI
  class NavigationMenuComponent < ApplicationComponent
    ROOT = "group/navigation-menu relative flex max-w-max flex-1 items-center justify-center"
    LIST = "group flex flex-1 list-none items-center justify-center gap-1"

    TRIGGER = "group inline-flex h-9 w-max items-center justify-center rounded-md bg-background " \
              "px-4 py-2 text-sm font-medium transition-[color,box-shadow] outline-none " \
              "hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground " \
              "#{UI::Styles::FOCUS_RING} " \
              "disabled:pointer-events-none disabled:opacity-50 " \
              "data-[state=open]:bg-accent/50 data-[state=open]:text-accent-foreground " \
              "data-[state=open]:hover:bg-accent data-[state=open]:focus:bg-accent"

    LINK_CLS = "inline-flex h-9 w-max items-center justify-center rounded-md bg-background " \
               "px-4 py-2 text-sm font-medium transition-[color,box-shadow] outline-none " \
               "hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground " \
               "#{UI::Styles::FOCUS_RING} " \
               "aria-[current]:bg-accent/50 aria-[current]:text-accent-foreground"

    CONTENT = "#{UI::Styles::POPOVER_PANEL} top-full left-0 mt-1.5 min-w-48 overflow-hidden p-2 shadow"

    PANEL_LINK = "flex flex-col gap-1 rounded-md p-2 text-sm transition-all outline-none " \
                 "hover:bg-accent hover:text-accent-foreground focus:bg-accent focus:text-accent-foreground " \
                 "#{UI::Styles::FOCUS_RING} " \
                 "aria-[current]:bg-accent/50 aria-[current]:text-accent-foreground"

    CHEVRON_PATH = "m6 9 6 6 6-6"

    renders_many :items, "UI::NavigationMenuComponent::ItemComponent"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:nav, class: cn(ROOT, @extra_class), **@html_attrs) do
        content_tag(:ul, class: LIST) do
          safe_join(items.map { |item| content_tag(:li, item, class: "relative") })
        end
      end
    end

    # Represents one entry in the navigation bar.
    # href: present  → plain styled link
    # href: absent   → trigger button + flyout (add content via block)
    class ItemComponent < ApplicationComponent
      CHEVRON_PATH = "m6 9 6 6 6-6"

      def initialize(label:, href: nil, active: false, **html_attrs)
        @label  = label
        @href   = href
        @active = active
        @extra_class = html_attrs.delete(:class)
        @html_attrs  = html_attrs
      end

      def call
        if @href
          link_item
        else
          trigger_item
        end
      end

      private

      def link_item
        content_tag(:a, @label,
          href: @href,
          class: cn(NavigationMenuComponent::LINK_CLS, @extra_class),
          "aria-current": (@active ? "page" : nil),
          **@html_attrs)
      end

      def trigger_item
        content_tag(:div,
          class: "relative",
          data: {
            controller: "navigation-menu",
            action: "mouseenter->navigation-menu#open mouseleave->navigation-menu#scheduleClose " \
                    "click@document->navigation-menu#closeOnClickOutside"
          }) do
          concat trigger_btn
          concat flyout
        end
      end

      def trigger_btn
        content_tag(:button,
          type: "button",
          class: cn(NavigationMenuComponent::TRIGGER, @extra_class),
          "aria-expanded": "false",
          data: { navigation_menu_target: "trigger", state: "closed" },
          **@html_attrs) do
          concat @label
          concat chevron
        end
      end

      def flyout
        content_tag(:div,
          content,
          class: NavigationMenuComponent::CONTENT,
          hidden: true,
          data: {
            navigation_menu_target: "content",
            action: "mouseenter->navigation-menu#open mouseleave->navigation-menu#scheduleClose"
          })
      end

      def chevron
        content_tag(:svg,
          content_tag(:path, nil, d: CHEVRON_PATH, "stroke-linecap": "round", "stroke-linejoin": "round"),
          xmlns: "http://www.w3.org/2000/svg",
          viewBox: "0 0 24 24",
          fill: "none",
          stroke: "currentColor",
          "stroke-width": "2",
          class: "relative top-[1px] ml-1 size-3 transition-transform duration-200 " \
                 "group-data-[state=open]:rotate-180",
          "aria-hidden": "true")
      end
    end
  end
end
