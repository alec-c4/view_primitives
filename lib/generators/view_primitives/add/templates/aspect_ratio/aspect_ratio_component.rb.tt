# frozen_string_literal: true

module UI
  class AspectRatioComponent < ApplicationComponent
    def initialize(ratio: 1, **html_attrs)
      @ratio = ratio
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, content,
        style: "aspect-ratio: #{@ratio}",
        class: cn("overflow-hidden rounded-md", @extra_class),
        **@html_attrs)
    end
  end
end
