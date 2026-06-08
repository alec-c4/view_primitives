# frozen_string_literal: true

module UI
  class NavbarComponent < ApplicationComponent
    LINK_BASE  = "inline-flex h-9 items-center rounded-md px-3 text-sm font-medium transition-[color,box-shadow] " \
                 "outline-none hover:bg-accent hover:text-accent-foreground " \
                 "#{UI::Styles::FOCUS_RING}"
    LINK_IDLE  = "text-muted-foreground"
    LINK_ACTIVE = "bg-accent/50 text-accent-foreground"
    MOBILE_LINK = "block rounded-md px-3 py-2 text-sm font-medium transition-colors outline-none " \
                  "hover:bg-accent hover:text-accent-foreground #{UI::Styles::FOCUS_RING}"

    # items: [{ label:, href:, active: (optional) }]
    # Block content is placed in the right action area (e.g. a Sign in button).
    def initialize(brand: nil, brand_href: "/", items: [], **html_attrs)
      @brand      = brand
      @brand_href = brand_href
      @items      = items
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:nav,
        class: cn("sticky top-0 z-50 w-full border-b border-border bg-background/95 shadow-xs backdrop-blur supports-[backdrop-filter]:bg-background/80", @extra_class),
        "aria-label": "Main navigation",
        data: { controller: "navbar" },
        **@html_attrs) do
        concat header_bar
        concat mobile_menu if @items.any?
      end
    end

    private

    def header_bar
      content_tag(:div, class: "container mx-auto flex h-14 items-center gap-4 px-4") do
        concat brand_link
        concat desktop_menu
        concat spacer
        concat action_area
        concat hamburger
      end
    end

    def brand_link
      return "" unless @brand

      content_tag(:a, @brand,
        href: @brand_href,
        class: "flex items-center font-semibold text-foreground mr-2")
    end

    def desktop_menu
      return "" if @items.empty?

      content_tag(:div, class: "hidden md:flex items-center gap-1") do
        safe_join(@items.map { |item| nav_link(item) })
      end
    end

    def nav_link(item)
      content_tag(:a, item[:label],
        href: item[:href],
        class: cn(LINK_BASE, item[:active] ? LINK_ACTIVE : LINK_IDLE))
    end

    def spacer
      content_tag(:div, nil, class: "flex-1")
    end

    def action_area
      return "" unless content?

      content_tag(:div, content, class: "hidden md:flex items-center gap-2")
    end

    def hamburger
      return "" if @items.empty?

      content_tag(:button, nil,
        type: "button",
        class: "inline-flex size-9 items-center justify-center rounded-md text-muted-foreground transition-colors outline-none hover:bg-accent hover:text-accent-foreground #{UI::Styles::FOCUS_RING} md:hidden",
        data: { action: "click->navbar#toggle", navbar_target: "toggle" },
        "aria-expanded": "false",
        "aria-controls": mobile_menu_id,
        "aria-label": "Toggle menu") do
        hamburger_icon
      end
    end

    def mobile_menu
      content_tag(:div,
        id: mobile_menu_id,
        class: "md:hidden border-b border-border bg-background px-4 py-3",
        data: { navbar_target: "menu" },
        hidden: true) do
        concat content_tag(:div, class: "flex flex-col gap-1") {
          safe_join(@items.map { |item| mobile_nav_link(item) })
        }
        concat mobile_action_area if content?
      end
    end

    def mobile_nav_link(item)
      content_tag(:a, item[:label],
        href: item[:href],
        class: cn(MOBILE_LINK, item[:active] ? LINK_ACTIVE : LINK_IDLE),
        data: { action: "click->navbar#close" })
    end

    def mobile_action_area
      content_tag(:div, content, class: "mt-3 flex flex-col gap-2 border-t border-border pt-3")
    end

    def mobile_menu_id
      @mobile_menu_id ||= "navbar-menu-#{object_id}"
    end

    def hamburger_icon
      raw(<<~SVG)
        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true">
          <line x1="4" x2="20" y1="6" y2="6"/>
          <line x1="4" x2="20" y1="12" y2="12"/>
          <line x1="4" x2="20" y1="18" y2="18"/>
        </svg>
      SVG
    end
  end
end
