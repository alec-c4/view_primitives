# frozen_string_literal: true

module UI
  class FileInputComponent < ApplicationComponent
    FILE_EXTRA = "cursor-pointer file:mr-3 file:cursor-pointer"

    # accept:   MIME types or extensions, e.g. "image/*" or ".pdf,.docx"
    # multiple: allow selecting multiple files
    def initialize(accept: nil, multiple: false, **html_attrs)
      @accept   = accept
      @multiple = multiple
      extract_html_attrs(**html_attrs)
    end

    def call
      attrs = { type: "file", class: cn(UI::Styles::INPUT, FILE_EXTRA, @extra_class) }
      attrs[:accept]   = @accept if @accept
      attrs[:multiple] = true    if @multiple
      content_tag(:input, nil, **attrs, **@html_attrs)
    end
  end
end
