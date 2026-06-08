# frozen_string_literal: true

module UI
  class PictureComponent < ApplicationComponent
    # Each source is added via p.with_source(srcset:, type:, media:, sizes:)
    renders_many :sources, "UI::PictureComponent::SourceComponent"

    # src:     fallback <img> URL (required)
    # alt:     alternative text on the fallback <img> (required)
    # loading: :lazy (default) | :eager
    # width / height: applied to the fallback <img>
    def initialize(src:, alt:, loading: :lazy, width: nil, height: nil, **html_attrs)
      @src     = src
      @alt     = alt
      @loading = loading.to_sym
      @width   = width
      @height  = height
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:picture, **@html_attrs) do
        sources.each { |s| concat s }
        concat fallback_img
      end
    end

    # Represents a <source> element inside <picture>.
    # Declare via: p.with_source(srcset: "img.avif", type: "image/avif")
    # Optional: media:, sizes:, width:, height:
    class SourceComponent < ApplicationComponent
      def initialize(srcset:, type: nil, media: nil, sizes: nil, width: nil, height: nil, **html_attrs)
        @srcset  = srcset
        @type    = type
        @media   = media
        @sizes   = sizes
        @width   = width
        @height  = height
        @html_attrs = html_attrs
      end

      def call
        attrs = { srcset: @srcset }
        attrs[:type]   = @type   if @type
        attrs[:media]  = @media  if @media
        attrs[:sizes]  = @sizes  if @sizes
        attrs[:width]  = @width  if @width
        attrs[:height] = @height if @height
        tag.source(**attrs, **@html_attrs)
      end
    end

    private

    def fallback_img
      attrs = { src: @src, alt: @alt, loading: @loading,
                class: cn("h-auto w-full max-w-full rounded-md", @extra_class) }
      attrs[:width]  = @width  if @width
      attrs[:height] = @height if @height
      tag.img(**attrs)
    end
  end
end
