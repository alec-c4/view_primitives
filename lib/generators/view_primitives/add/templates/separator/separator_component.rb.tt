# frozen_string_literal: true

module UI
  class SeparatorComponent < ApplicationComponent
    BASE = "shrink-0 bg-border"

    ORIENTATIONS = {
      horizontal: "h-px w-full",
      vertical: "h-full w-px"
    }.freeze

    def initialize(orientation: :horizontal, decorative: true, **html_attrs)
      @orientation = orientation.to_sym
      @decorative = decorative
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, nil,
        role: (@decorative ? "none" : "separator"),
        "aria-orientation": @orientation.to_s,
        "data-orientation": @orientation.to_s,
        class: cn(BASE, ORIENTATIONS[@orientation], @extra_class),
        **@html_attrs)
    end
  end
end
