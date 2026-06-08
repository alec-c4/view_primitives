# frozen_string_literal: true

module UI
  class CardFooterComponent < ApplicationComponent
    BASE = "flex items-center px-6 [.border-t]:pt-6"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, content, class: cn(BASE, @extra_class), **@html_attrs)
    end
  end
end
