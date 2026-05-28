# frozen_string_literal: true

module UI
  class ScrollAreaComponent < ApplicationComponent
    # Custom-styled scrollbar container using CSS pseudo-elements.
    # Works without a plugin in Tailwind v4 via arbitrary property syntax.

    ORIENTATIONS = {
      vertical:   "overflow-y-auto",
      horizontal: "overflow-x-auto",
      both:       "overflow-auto"
    }.freeze

    # Thin, themed scrollbar applied to the viewport
    SCROLLBAR_CLS = "[scrollbar-width:thin] " \
                    "[scrollbar-color:var(--color-border)_transparent] " \
                    "[&::-webkit-scrollbar]:w-1.5 [&::-webkit-scrollbar]:h-1.5 " \
                    "[&::-webkit-scrollbar-track]:bg-transparent " \
                    "[&::-webkit-scrollbar-thumb]:rounded-full " \
                    "[&::-webkit-scrollbar-thumb]:bg-border"

    # orientation: :vertical (default) | :horizontal | :both
    # max_h:       Tailwind max-height class, e.g. "max-h-72" (vertical / both)
    # max_w:       Tailwind max-width class, e.g. "max-w-sm" (horizontal / both)
    def initialize(orientation: :vertical, max_h: "max-h-72", max_w: nil, **html_attrs)
      @orientation = orientation.to_sym
      @max_h = max_h
      @max_w = max_w
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      overflow = ORIENTATIONS.fetch(@orientation, ORIENTATIONS[:vertical])
      content_tag(:div,
        content,
        class: cn(overflow, SCROLLBAR_CLS, @max_h, @max_w, @extra_class),
        **@html_attrs)
    end
  end
end
