# frozen_string_literal: true

module UI
  class InputComponent < ApplicationComponent
    def initialize(type: "text", **html_attrs)
      @type = type
      extract_html_attrs(**html_attrs)
    end

    def call
      content_tag(:input, nil,
        type: @type,
        class: cn(UI::Styles::INPUT, @extra_class),
        **@html_attrs)
    end
  end
end
