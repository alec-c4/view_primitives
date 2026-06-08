# frozen_string_literal: true

module UI
  class BreadcrumbComponent < ApplicationComponent
    LINK    = "text-muted-foreground transition-colors hover:text-foreground"
    CURRENT = "font-normal text-foreground"

    # items: [{ label:, href: }, ..., { label: }]  — last item is the current page (no href)
    def initialize(items: [], separator: "/", **html_attrs)
      @items = items
      @separator = separator
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:nav, "aria-label": "Breadcrumb", **@html_attrs) do
        content_tag(:ol, class: cn("flex flex-wrap items-center gap-1.5 text-sm break-words text-muted-foreground sm:gap-2.5", @extra_class)) do
          safe_join(@items.each_with_index.map { |item, i| crumb(item, i == @items.size - 1) })
        end
      end
    end

    private

    def crumb(item, is_last)
      content_tag(:li, class: "inline-flex items-center gap-1.5") do
        if is_last
          content_tag(:span, item[:label], class: CURRENT, "aria-current": "page")
        else
          concat content_tag(:a, item[:label], href: item[:href], class: LINK)
          concat content_tag(:span, @separator, class: "text-muted-foreground select-none", "aria-hidden": "true")
        end
      end
    end
  end
end
