# frozen_string_literal: true

module UI
  class MapAreaComponent < ApplicationComponent
    # Image map — renders <img usemap> + <map> + <area> elements.
    #
    # Usage:
    #   ui :map_area,
    #     src: "/map.png", alt: "Office floor plan",
    #     width: 800, height: 600,
    #     areas: [
    #       { shape: :rect,   coords: "0,0,200,150",   href: "/room/1", alt: "Room 1" },
    #       { shape: :circle, coords: "400,300,50",    href: "/room/2", alt: "Room 2" },
    #       { shape: :poly,   coords: "10,10,50,10,30,40", href: "/room/3", alt: "Room 3" }
    #     ]
    #
    # area keys:
    #   shape:   :rect | :circle | :poly | :default (required)
    #   coords:  coordinate string (required for rect/circle/poly)
    #   href:    link target (omit or "#" for non-interactive areas)
    #   alt:     accessible label for the area (required for links)
    #   title:   tooltip text
    #   target:  link target, e.g. "_blank"
    #   rel:     link rel attribute

    WRAPPER_CLS = "relative inline-block overflow-hidden rounded-md #{UI::Styles::BORDER} shadow-xs"
    IMG_CLS     = "block h-auto w-full max-w-full rounded-md"

    def initialize(src:, alt:, areas: [], width: nil, height: nil,
                   loading: :lazy, map_name: nil, **html_attrs)
      @src       = src
      @alt       = alt
      @areas     = areas
      @width     = width
      @height    = height
      @loading   = loading
      @map_name  = map_name || "map-#{SecureRandom.hex(4)}"
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div, class: cn(WRAPPER_CLS, @extra_class), **@html_attrs) do
        safe_join([img_tag, map_tag])
      end
    end

    private

    def img_tag
      attrs = { src: @src, alt: @alt, usemap: "##{@map_name}", loading: @loading, class: IMG_CLS }
      attrs[:width]  = @width  if @width
      attrs[:height] = @height if @height
      tag.img(**attrs)
    end

    def map_tag
      content_tag(:map, name: @map_name) do
        safe_join(@areas.map { |area| area_tag(area) })
      end
    end

    def area_tag(area)
      attrs = { shape: area.fetch(:shape, :rect).to_s, alt: area.fetch(:alt, "") }
      attrs[:coords] = area[:coords]  if area[:coords]
      attrs[:href]   = area[:href]    if area[:href]
      attrs[:title]  = area[:title]   if area[:title]
      attrs[:target] = area[:target]  if area[:target]
      attrs[:rel]    = area[:rel]     if area[:rel]
      tag.area(**attrs)
    end
  end
end
