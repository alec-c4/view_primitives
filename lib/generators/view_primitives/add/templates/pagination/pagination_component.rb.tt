# frozen_string_literal: true

module UI
  class PaginationComponent < ApplicationComponent
    ITEM   = "inline-flex h-9 w-9 items-center justify-center whitespace-nowrap rounded-md border border-input " \
             "bg-background text-sm font-medium shadow-xs transition-colors outline-none " \
             "hover:bg-accent hover:text-accent-foreground " \
             "#{UI::Styles::FOCUS_RING}"
    ACTIVE = "bg-primary text-primary-foreground shadow hover:bg-primary/90 border-transparent"
    MUTED  = "cursor-not-allowed opacity-50 pointer-events-none"

    # url: callable — receives a page number, returns a path string
    #   url: ->(page) { posts_path(page: page) }
    def initialize(current_page:, total_pages:, url:, window: 2, **html_attrs)
      @current  = current_page.to_i
      @total    = total_pages.to_i
      @url      = url
      @window   = window
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      return "" if @total <= 1

      content_tag(:nav, "aria-label": "Pagination", **@html_attrs) do
        content_tag(:ul, class: cn("flex items-center gap-1", @extra_class)) do
          safe_join([prev_item, *page_items, next_item])
        end
      end
    end

    private

    def prev_item
      content_tag(:li) do
        if @current > 1
          content_tag(:a, prev_svg, href: @url.call(@current - 1), class: ITEM, "aria-label": "Previous page")
        else
          content_tag(:span, prev_svg, class: cn(ITEM, MUTED), "aria-disabled": "true")
        end
      end
    end

    def next_item
      content_tag(:li) do
        if @current < @total
          content_tag(:a, next_svg, href: @url.call(@current + 1), class: ITEM, "aria-label": "Next page")
        else
          content_tag(:span, next_svg, class: cn(ITEM, MUTED), "aria-disabled": "true")
        end
      end
    end

    def page_items
      pages.map { |page| page == :ellipsis ? ellipsis_item : page_item(page) }
    end

    def page_item(page)
      is_current = page == @current
      content_tag(:li) do
        if is_current
          content_tag(:span, page.to_s, class: cn(ITEM, ACTIVE), "aria-current": "page")
        else
          content_tag(:a, page.to_s, href: @url.call(page), class: ITEM)
        end
      end
    end

    def ellipsis_item
      content_tag(:li) do
        content_tag(:span, "…", class: "flex h-9 w-9 items-center justify-center text-sm text-muted-foreground")
      end
    end

    def pages
      return (1..@total).to_a if @total <= (@window * 2 + 5)

      left  = [@current - @window, 1].max
      right = [@current + @window, @total].min

      result = [1]
      result << :ellipsis if left > 2
      result.concat((left..right).to_a)
      result << :ellipsis if right < @total - 1
      result << @total
      result.uniq
    end

    def prev_svg
      raw('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m15 18-6-6 6-6"/></svg>')
    end

    def next_svg
      raw('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="m9 18 6-6-6-6"/></svg>')
    end
  end
end
