# frozen_string_literal: true

module UI
  class ScrollAreaComponent < ApplicationComponent
    ROOT = "relative"

    ORIENTATIONS = {
      vertical:   "overflow-y-auto",
      horizontal: "overflow-x-auto",
      both:       "overflow-auto"
    }.freeze

    VIEWPORT = "size-full rounded-[inherit] transition-[color,box-shadow] outline-none " \
               "#{UI::Styles::FOCUS_RING} focus-visible:outline-1"

    SCROLLBAR_CLS = "[scrollbar-width:thin] " \
                    "[scrollbar-color:var(--color-border)_transparent] " \
                    "[&::-webkit-scrollbar]:w-2.5 [&::-webkit-scrollbar]:h-2.5 " \
                    "[&::-webkit-scrollbar-track]:bg-transparent " \
                    "[&::-webkit-scrollbar-thumb]:rounded-full " \
                    "[&::-webkit-scrollbar-thumb]:bg-border"

    def initialize(orientation: :vertical, max_h: "max-h-72", max_w: nil, **html_attrs)
      @orientation = orientation.to_sym
      @max_h = max_h
      @max_w = max_w
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      overflow = ORIENTATIONS.fetch(@orientation, ORIENTATIONS[:vertical])
      content_tag(:div, class: cn(ROOT, @extra_class), **@html_attrs) do
        content_tag(:div,
          content,
          class: cn(overflow, VIEWPORT, SCROLLBAR_CLS, @max_h, @max_w))
      end
    end
  end
end
