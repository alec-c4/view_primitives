# frozen_string_literal: true

module UI
  class SpinnerComponent < ApplicationComponent
    LOADER_PATH = "M21 12a9 9 0 1 1-6.219-8.56"

    SIZES = {
      sm: "size-4",
      default: "size-4",
      lg: "size-6"
    }.freeze

    def initialize(size: :default, **html_attrs)
      @size = size.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:svg,
        content_tag(:path, nil,
          d: LOADER_PATH,
          "stroke-linecap": "round",
          "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        "stroke-width": "2",
        class: cn("animate-spin text-muted-foreground", SIZES.fetch(@size, SIZES[:default]), @extra_class),
        role: "status",
        "aria-label": "Loading",
        **@html_attrs)
    end
  end
end
