# frozen_string_literal: true

module UI
  class SelectComponent < ApplicationComponent
    WRAPPER = "group/native-select relative w-fit has-[select:disabled]:opacity-50"

    BASE = UI::Styles::SELECT

    # options: array of strings, or [value, label] pairs, or { value: label } hash
    def initialize(options: [], selected: nil, include_blank: false, size: :default, **html_attrs)
      @options = options
      @selected = selected
      @include_blank = include_blank
      @size = size.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, class: WRAPPER) do
        concat content_tag(:select,
          safe_join(option_tags),
          class: cn(BASE, @extra_class),
          "data-size": (@size == :sm ? "sm" : "default"),
          **@html_attrs)
        concat chevron_icon
      end
    end

    private

    def chevron_icon
      svg = content_tag(:svg,
        content_tag(:path, nil, d: "m6 9 6 6 6-6", fill: "none", stroke: "currentColor",
          "stroke-linecap": "round", "stroke-linejoin": "round", "stroke-width": "2"),
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: "none",
        class: "size-4",
        "aria-hidden": "true")
      content_tag(:span, svg,
        class: "pointer-events-none absolute top-1/2 right-3.5 size-4 -translate-y-1/2 text-muted-foreground opacity-50 select-none")
    end

    def option_tags
      tags = []
      tags << content_tag(:option, "", value: "") if @include_blank
      normalized_options.each do |(val, label)|
        attrs = { value: val }
        attrs[:selected] = true if val.to_s == @selected.to_s
        tags << content_tag(:option, label, **attrs)
      end
      tags
    end

    def normalized_options
      case @options
      when Hash  then @options.map { |v, l| [v, l] }
      when Array then @options.map { |o| o.is_a?(Array) ? o : [o, o] }
      else []
      end
    end
  end
end
