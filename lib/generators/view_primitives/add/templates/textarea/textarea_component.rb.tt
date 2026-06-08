# frozen_string_literal: true

module UI
  class TextareaComponent < ApplicationComponent
    def initialize(**html_attrs)
      extract_html_attrs(**html_attrs)
    end

    def call
      content_tag(:textarea, content,
        class: cn(UI::Styles::TEXTAREA, @extra_class),
        **@html_attrs)
    end
  end
end
