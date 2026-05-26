# frozen_string_literal: true

module UI
  class BottomNavComponent < ApplicationComponent
    BASE = "fixed bottom-0 left-0 z-50 w-full border-t bg-background"

    # items: [{ label:, href:, active: (optional), icon: (optional HTML string) }]
    def initialize(items: [], **html_attrs)
      @items = items
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:nav, class: cn(BASE, @extra_class), **@html_attrs) do
        content_tag(:div, class: "mx-auto flex h-16 max-w-lg items-center justify-around") do
          safe_join(@items.map { |item| nav_item(item) })
        end
      end
    end

    private

    def nav_item(item)
      active = item[:active]
      content_tag(:a,
        href: item[:href],
        class: cn(
          "flex flex-col items-center justify-center gap-1 px-4 py-2 text-xs font-medium transition-colors",
          active ? "text-primary" : "text-muted-foreground hover:text-foreground"
        ),
        "aria-current": (active ? "page" : nil)) do
        concat raw(item[:icon]) if item[:icon]
        concat content_tag(:span, item[:label])
      end
    end
  end
end
