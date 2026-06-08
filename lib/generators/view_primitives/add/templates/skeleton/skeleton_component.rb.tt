# frozen_string_literal: true

module UI
  class SkeletonComponent < ApplicationComponent
    BASE = "animate-pulse rounded-md bg-accent"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, nil, class: cn(BASE, @extra_class), **@html_attrs)
    end
  end
end
