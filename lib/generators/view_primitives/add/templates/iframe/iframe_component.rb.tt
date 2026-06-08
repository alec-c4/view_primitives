# frozen_string_literal: true

module UI
  class IframeComponent < ApplicationComponent
    BASE = "w-full border-0"

    # src:     URL to embed (required)
    # title:   accessible label (required — describes the iframe content)
    # loading: :lazy (default) | :eager
    # sandbox: space-separated token string or true for strict defaults
    #          pass false to disable sandboxing entirely (not recommended)
    # aspect:  CSS aspect-ratio value, e.g. "16/9", "4/3" (wraps in a div)
    #          omit if you set explicit width/height
    # width / height: explicit pixel dimensions (applied to <iframe>)
    def initialize(src:, title:, loading: :lazy, sandbox: true,
                   aspect: nil, width: nil, height: nil, **html_attrs)
      @src     = src
      @title   = title
      @loading = loading.to_sym
      @sandbox = sandbox
      @aspect  = aspect
      @width   = width
      @height  = height
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      if @aspect
        content_tag(:div,
          style: "aspect-ratio: #{@aspect}",
          class: cn("w-full overflow-hidden rounded-md #{UI::Styles::BORDER} shadow-xs", @extra_class)) do
          iframe_tag(wrapped: true)
        end
      else
        iframe_tag
      end
    end

    private

    def iframe_tag(wrapped: false)
      attrs = {
        src: @src,
        title: @title,
        loading: @loading,
        class: cn(BASE, (wrapped ? "h-full" : @extra_class))
      }
      attrs[:sandbox] = sandbox_value if @sandbox != false
      attrs[:width]   = @width  if @width
      attrs[:height]  = @height if @height
      tag.iframe(**attrs, **@html_attrs)
    end

    def sandbox_value
      return "allow-scripts allow-same-origin allow-forms allow-popups" if @sandbox == true

      @sandbox
    end
  end
end
