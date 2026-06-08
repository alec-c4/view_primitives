# frozen_string_literal: true

module UI
  class FooterComponent < ApplicationComponent
    BASE = "border-t border-border bg-background"
    LINK = "inline-flex rounded-md px-1 py-0.5 text-sm text-muted-foreground transition-colors " \
           "outline-none hover:text-foreground #{UI::Styles::FOCUS_RING}"

    # columns: [{ title:, links: [{ label:, href: }] }]
    def initialize(copyright: nil, columns: [], **html_attrs)
      @copyright = copyright
      @columns   = columns
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:footer, class: cn(BASE, @extra_class), **@html_attrs) do
        content_tag(:div, class: "container mx-auto px-6 py-10") do
          concat columns_grid if @columns.any?
          concat content if content?
          concat copyright_row if @copyright
        end
      end
    end

    private

    def columns_grid
      content_tag(:div, class: "grid gap-8 sm:grid-cols-2 md:grid-cols-#{[@columns.size, 4].min} mb-10") do
        safe_join(@columns.map { |col| column(col) })
      end
    end

    def column(col)
      content_tag(:div) do
        concat content_tag(:h3, col[:title], class: "mb-3 text-sm font-medium text-foreground")
        concat content_tag(:ul, class: "space-y-2") {
          safe_join((col[:links] || []).map { |link|
            content_tag(:li) { content_tag(:a, link[:label], href: link[:href], class: LINK) }
          })
        }
      end
    end

    def copyright_row
      content_tag(:div, class: "mt-8 border-t border-border pt-8 text-center") do
        content_tag(:p, @copyright, class: "text-sm text-muted-foreground")
      end
    end
  end
end
