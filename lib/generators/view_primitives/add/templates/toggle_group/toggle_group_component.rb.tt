# frozen_string_literal: true

module UI
  class ToggleGroupComponent < ApplicationComponent
    BASE = "group/toggle-group flex w-fit items-center gap-1 rounded-md " \
           "data-[variant=outline]:shadow-xs"

    def initialize(type: :single, value: nil, variant: :default, **html_attrs)
      @type = type.to_sym
      @value = Array(value).map(&:to_s)
      @variant = variant.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        content,
        class: cn(BASE, @extra_class),
        role: "group",
        "data-variant": @variant.to_s,
        "data-controller": "toggle-group",
        "data-toggle-group-type-value": @type,
        "data-slot": "toggle-group",
        **@html_attrs)
    end

    def item_pressed?(item_value)
      @value.include?(item_value.to_s)
    end
  end
end
