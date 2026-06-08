# frozen_string_literal: true

module UI
  class ImageComponent < ApplicationComponent
    BASE = "h-auto w-full max-w-full rounded-md"

    LOADING_MODES = %i[lazy eager auto].freeze

    # src:     image URL (required)
    # alt:     alternative text (required for accessibility)
    # srcset:  responsive image set, e.g. "img-sm.jpg 640w, img-lg.jpg 1280w"
    # sizes:   media conditions, e.g. "(max-width: 640px) 100vw, 50vw"
    # loading: :lazy (default) | :eager | :auto
    # width/height: native dimensions (prevents layout shift)
    def initialize(src:, alt:, srcset: nil, sizes: nil, loading: :lazy,
                   width: nil, height: nil, **html_attrs)
      @src     = src
      @alt     = alt
      @srcset  = srcset
      @sizes   = sizes
      @loading = LOADING_MODES.include?(loading.to_sym) ? loading.to_sym : :lazy
      @width   = width
      @height  = height
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { src: @src, alt: @alt, loading: @loading,
                class: cn(BASE, @extra_class) }
      attrs[:srcset]  = @srcset  if @srcset
      attrs[:sizes]   = @sizes   if @sizes
      attrs[:width]   = @width   if @width
      attrs[:height]  = @height  if @height
      tag.img(**attrs, **@html_attrs)
    end
  end
end
