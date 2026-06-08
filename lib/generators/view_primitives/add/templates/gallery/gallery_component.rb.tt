# frozen_string_literal: true

module UI
  class GalleryComponent < ApplicationComponent
    # Responsive image grid with optional lightbox on click.
    #
    # Usage:
    #   ui :gallery, cols: 3 do |g|
    #     g.with_image(src: "/img/a.jpg", alt: "Photo A")
    #     g.with_image(src: "/img/b.jpg", alt: "Photo B", caption: "The coast")
    #   end

    GRID_BASE = "grid gap-4"
    GRID_COLS = {
      1 => "grid-cols-1", 2 => "grid-cols-2", 3 => "grid-cols-3",
      4 => "grid-cols-4", 5 => "grid-cols-5", 6 => "grid-cols-6"
    }.freeze

    ITEM_CLS  = "group relative cursor-zoom-in overflow-hidden rounded-md #{UI::Styles::BORDER} bg-muted shadow-xs"
    IMG_CLS   = "h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
    CAP_CLS   = "absolute inset-x-0 bottom-0 bg-gradient-to-t from-black/70 to-transparent px-3 py-2 " \
                "text-sm text-white opacity-0 transition-opacity group-hover:opacity-100"

    renders_many :images, "UI::GalleryComponent::ImageComponent"

    # cols:      number of grid columns (1–6, default: 3)
    # lightbox:  enable click-to-enlarge (default: true)
    # aspect:    Tailwind aspect-ratio class applied to each cell, e.g. "aspect-square"
    def initialize(cols: 3, lightbox: true, aspect: "aspect-square", **html_attrs)
      @cols        = cols.to_i.clamp(1, 6)
      @lightbox    = lightbox
      @aspect      = aspect
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      grid_cls = cn(GRID_BASE, GRID_COLS[@cols], @extra_class)

      attrs = { class: grid_cls }
      if @lightbox
        attrs[:data] = { controller: "gallery",
                         action: "click@document->gallery#closeOnClickOutside keydown.escape@document->gallery#close" }
      end
      attrs.merge!(@html_attrs)

      content_tag(:div, **attrs) do
        safe_join(images.map { |img| wrap_image(img) })
      end
    end

    private

    def wrap_image(img)
      cell_attrs = { class: cn(ITEM_CLS, @aspect) }
      if @lightbox
        cell_attrs[:data] = { action: "click->gallery#open",
                               gallery_src_param: img.src,
                               gallery_alt_param: img.alt }
      end
      content_tag(:figure, **cell_attrs) do
        concat img
        concat content_tag(:figcaption, img.caption, class: CAP_CLS) if img.caption
      end
    end

    class ImageComponent < ApplicationComponent
      attr_reader :src, :alt, :caption

      def initialize(src:, alt: "", caption: nil, **html_attrs)
        @src     = src
        @alt     = alt
        @caption = caption
        @html_attrs = html_attrs
      end

      def call
        tag.img(src: @src, alt: @alt, class: GalleryComponent::IMG_CLS,
          loading: "lazy", **@html_attrs)
      end
    end
  end
end
