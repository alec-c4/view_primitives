# frozen_string_literal: true

module UI
  class NavbarComponent < ApplicationComponent
    LINK_BASE  = "text-sm font-medium transition-colors hover:text-foreground"
    LINK_IDLE  = "text-muted-foreground"
    LINK_ACTIVE = "text-foreground"

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
        class: cn("sticky top-0 z-50 w-full border-b bg-background/95 backdrop-blur supports-[backdrop-filter]:bg-background/60", @extra_class),
        data: { controller: "navbar" },
        **@html_attrs) do
        content_tag(:div, class: "container mx-auto flex h-14 items-center gap-4 px-4") do
          concat brand_link
          concat desktop_menu
          concat spacer
          concat action_area
          concat hamburger
        end
      end
    end

    private

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
        class: "md:hidden inline-flex items-center justify-center rounded-md p-2 text-muted-foreground hover:bg-accent hover:text-foreground",
        data: { action: "click->navbar#toggle", navbar_target: "toggle" },
        "aria-label": "Toggle menu") do
        hamburger_icon
      end
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
