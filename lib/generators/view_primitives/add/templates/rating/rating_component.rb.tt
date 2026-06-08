# frozen_string_literal: true

module UI
  class RatingComponent < ApplicationComponent
    STAR_PATH = "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"

    def initialize(value: 0, max: 5, **html_attrs)
      @value = value.to_f.clamp(0, max)
      @max = max
      @filled_count = @value.round
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        stars,
        class: cn("inline-flex gap-0.5", @extra_class),
        role: "img",
        "aria-label": "Rating: #{@value} out of #{@max}",
        **@html_attrs)
    end

    private

    def stars
      @max.times.map { |i| star(i + 1 <= @filled_count) }.join.html_safe
    end

    def star(filled)
      content_tag(:svg,
        content_tag(:path, nil, d: STAR_PATH, "stroke-linecap": "round", "stroke-linejoin": "round"),
        class: filled ? "size-4 fill-primary text-primary" : "size-4 fill-muted text-muted",
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: filled ? "currentColor" : "none",
        stroke: "currentColor",
        "stroke-width": "2",
        "aria-hidden": "true")
    end
  end
end
