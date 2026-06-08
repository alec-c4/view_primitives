# frozen_string_literal: true

module UI
  class SearchInputComponent < ApplicationComponent
    WRAPPER = "relative w-full"
    ICON_WRAP = "pointer-events-none absolute inset-y-0 left-3 flex items-center text-muted-foreground"
    SEARCH_PATH = "m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
    # placeholder: default "Search…"
    # name / id / value: passed through as html_attrs
    def initialize(placeholder: "Search…", **html_attrs)
      @placeholder = placeholder
      extract_html_attrs(**html_attrs)
    end

    def call
      content_tag(:div, class: WRAPPER) do
        concat icon_span
        concat content_tag(:input, nil,
          type: "search",
          placeholder: @placeholder,
          class: cn(UI::Styles::INPUT, "pl-9 pr-3", @extra_class),
          **@html_attrs)
      end
    end

    private

    def icon_span
      svg = content_tag(:svg,
        content_tag(:path, nil, d: SEARCH_PATH, "stroke-linecap": "round", "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        "stroke-width": "1.5",
        class: "size-4",
        "aria-hidden": "true")
      content_tag(:span, svg, class: ICON_WRAP)
    end
  end
end
