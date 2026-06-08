# frozen_string_literal: true

module UI
  class SidebarComponent < ApplicationComponent
    # Collapsible application sidebar with nav groups.
    #
    # Usage:
    #   ui :sidebar do |s|
    #     s.with_group(label: "Main") do |g|
    #       g.with_item(label: "Dashboard", href: "/", icon: :home, active: true)
    #       g.with_item(label: "Settings",  href: "/settings", icon: :settings)
    #     end
    #   end

    RAIL_CLS = "group peer fixed inset-y-0 left-0 z-30 flex h-full flex-col " \
               "border-r border-sidebar-border bg-sidebar text-sidebar-foreground " \
               "transition-[width] duration-300 " \
               "data-[collapsed=true]:w-16 data-[collapsed=false]:w-64"

    HEADER_CLS = "flex h-14 shrink-0 items-center justify-between border-b border-sidebar-border px-4 " \
                 "group-data-[collapsed=true]:justify-center group-data-[collapsed=true]:px-2"

    TOGGLE_CLS = "inline-flex size-7 shrink-0 items-center justify-center rounded-md " \
                 "text-sidebar-foreground ring-sidebar-ring outline-hidden " \
                 "hover:bg-sidebar-accent hover:text-sidebar-accent-foreground " \
                 "focus-visible:ring-2 transition"

    NAV_CLS = "flex flex-1 flex-col gap-1 overflow-y-auto px-2 py-3"

    GROUP_WRAP = "mb-4 last:mb-0 group-data-[collapsed=true]:mb-0"

    GROUP_LABEL = "mb-1 flex h-8 shrink-0 items-center rounded-md px-2 text-xs font-medium " \
                  "text-sidebar-foreground/70 group-data-[collapsed=true]:hidden"

    ITEM_CLS = "flex w-full items-center gap-2 overflow-hidden rounded-md p-2 " \
               "text-left text-sm ring-sidebar-ring outline-hidden transition-[width,height,padding] " \
               "group-data-[collapsed=true]:size-8 group-data-[collapsed=true]:justify-center " \
               "group-data-[collapsed=true]:gap-0 group-data-[collapsed=true]:p-2 " \
               "hover:bg-sidebar-accent hover:text-sidebar-accent-foreground " \
               "focus-visible:ring-2 active:bg-sidebar-accent active:text-sidebar-accent-foreground " \
               "aria-[current]:bg-sidebar-accent aria-[current]:font-medium " \
               "aria-[current]:text-sidebar-accent-foreground [&>span:last-child]:truncate " \
               "[&_svg]:size-4 [&_svg]:shrink-0"

    ITEM_LABEL = "whitespace-nowrap transition-[opacity,width] " \
                 "group-data-[collapsed=true]:hidden"

    renders_many :groups, "UI::SidebarComponent::GroupComponent"
    renders_many :items,  "UI::SidebarComponent::ItemComponent"

    # brand:     text shown in the header
    # collapsed: initial collapsed state (default: false)
    def initialize(brand: nil, collapsed: false, **html_attrs)
      @brand       = brand
      @collapsed   = collapsed
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:aside,
        class: cn(RAIL_CLS, @extra_class),
        "data-collapsed": @collapsed.to_s,
        data: { controller: "sidebar" },
        **@html_attrs) do
        concat header
        concat nav_body
      end
    end

    private

    def header
      content_tag(:div, class: HEADER_CLS) do
        concat content_tag(:span, @brand,
          class: "truncate font-semibold group-data-[collapsed=true]:hidden") if @brand
        concat toggle_btn
      end
    end

    def toggle_btn
      content_tag(:button, type: "button",
        class: TOGGLE_CLS,
        "aria-label": "Toggle sidebar",
        data: { action: "click->sidebar#toggle" }) { chevron_icon }
    end

    def nav_body
      content_tag(:nav, class: NAV_CLS) do
        concat safe_join(groups) if groups.any?
        concat content_tag(:div, safe_join(items), class: "flex flex-col gap-0.5") if items.any?
        concat content if content?
      end
    end

    def chevron_icon
      content_tag(:svg,
        content_tag(:path, nil, d: "m15 18-6-6 6-6", "stroke-linecap": "round", "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
        fill: "none", stroke: "currentColor", "stroke-width": "2",
        class: "size-4 transition-transform group-data-[collapsed=true]:rotate-180",
        "aria-hidden": "true")
    end

    class GroupComponent < ApplicationComponent
      renders_many :items, "UI::SidebarComponent::ItemComponent"

      def initialize(label: nil, **html_attrs)
        @label      = label
        @html_attrs = html_attrs
      end

      def call
        content_tag(:div, class: SidebarComponent::GROUP_WRAP, **@html_attrs) do
          concat content_tag(:p, @label, class: SidebarComponent::GROUP_LABEL) if @label
          concat content_tag(:div, safe_join(items), class: "flex flex-col gap-0.5")
          concat content if content?
        end
      end
    end

    class ItemComponent < ApplicationComponent
      ICONS = {
        home:        "M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z M9 22V12h6v10",
        dashboard:   "M3 3h7v9H3z M14 3h7v5h-7z M14 12h7v9h-7z M3 16h7v6H3z",
        folder:      "M22 19a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h5l2 3h9a2 2 0 0 1 2 2z",
        tasks:       "M9 11l3 3L22 4 M21 12v7a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h11",
        settings:    "M12 15a3 3 0 1 0 0-6 3 3 0 0 0 0 6z M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1-2.83 2.83l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-4 0v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83-2.83l.06-.06A1.65 1.65 0 0 0 4.68 15a1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1 0-4h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 2.83-2.83l.06.06A1.65 1.65 0 0 0 9 4.68a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 4 0v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 2.83l-.06.06A1.65 1.65 0 0 0 19.4 9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 0 4h-.09a1.65 1.65 0 0 0-1.51 1z",
        users:       "M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2 M9 11a4 4 0 1 0 0-8 4 4 0 0 0 0 8z M23 21v-2a4 4 0 0 0-3-3.87 M16 3.13a4 4 0 0 1 0 7.75",
        chart:       "M18 20V10 M12 20V4 M6 20v-6",
        mail:        "M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z M22 6l-10 7L2 6",
        bell:        "M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9 M13.73 21a2 2 0 0 1-3.46 0",
        credit_card: "M1 4h22v16H1z M1 10h22",
        logout:      "M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4 M16 17l5-5-5-5 M21 12H9",
      }.freeze

      def initialize(label:, href: "#", active: false, icon: nil, **html_attrs)
        @label      = label
        @href       = href
        @active     = active
        @icon       = icon
        @html_attrs = html_attrs
      end

      def call
        content_tag(:a,
          href: @href,
          class: SidebarComponent::ITEM_CLS,
          "aria-current": (@active ? "page" : nil),
          **@html_attrs) do
          concat icon_or_fallback
          concat content_tag(:span, @label, class: SidebarComponent::ITEM_LABEL)
        end
      end

      private

      def icon_or_fallback
        path = @icon && ICONS[@icon.to_sym]
        if path
          content_tag(:svg,
            content_tag(:path, nil, d: path, "stroke-linecap": "round", "stroke-linejoin": "round"),
            xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
            fill: "none", stroke: "currentColor", "stroke-width": "2",
            class: "size-4 shrink-0",
            "aria-hidden": "true")
        else
          content_tag(:span, @label[0],
            class: "hidden size-5 shrink-0 items-center justify-center rounded text-xs font-semibold group-data-[collapsed=true]:flex",
            "aria-hidden": "true")
        end
      end
    end
  end
end
