# frozen_string_literal: true

module UI
  class ButtonGroupComponent < ApplicationComponent
    BASE = "flex w-fit items-stretch " \
           "[&>*]:focus-visible:relative [&>*]:focus-visible:z-10 " \
           "[&>*:not(:first-child)]:rounded-l-none [&>*:not(:first-child)]:border-l-0 " \
           "[&>*:not(:last-child)]:rounded-r-none"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, content,
        class: cn(BASE, @extra_class),
        role: "group",
        "data-slot": "button-group",
        **@html_attrs)
    end
  end
end
