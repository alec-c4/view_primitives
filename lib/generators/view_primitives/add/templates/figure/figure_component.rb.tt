# frozen_string_literal: true

module UI
  class FigureComponent < ApplicationComponent
    CAPTION = "mt-4 text-sm text-muted-foreground"

    # caption:       text shown in <figcaption> (optional; omit to render none)
    # caption_class: override the figcaption classes
    def initialize(caption: nil, caption_class: nil, **html_attrs)
      @caption       = caption
      @caption_class = caption_class
      @extra_class   = html_attrs.delete(:class)
      @html_attrs    = html_attrs
    end

    def call
      content_tag(:figure, class: @extra_class, **@html_attrs) do
        concat content
        concat content_tag(:figcaption, @caption,
          class: cn(CAPTION, @caption_class)) if @caption
      end
    end
  end
end
