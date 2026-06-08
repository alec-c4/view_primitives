# frozen_string_literal: true

module UI
  class RatingInputComponent < ApplicationComponent
    STAR_PATH = "M12 2l3.09 6.26L22 9.27l-5 4.87 1.18 6.88L12 17.77l-6.18 3.25L7 14.14 2 9.27l6.91-1.01L12 2z"

    # value: current rating (integer)
    # max:   total stars (default 5)
    # name:  hidden input name for use inside a <form>
    # url:   endpoint for direct AJAX submission on click
    def initialize(value: 0, max: 5, name: nil, url: nil, **html_attrs)
      @value = value.to_i.clamp(0, max)
      @max = max
      @name = name
      @url = url
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("inline-flex items-center gap-0.5", @extra_class),
        data: controller_data,
        **@html_attrs) do
        concat stars
        concat hidden_input if @name
      end
    end

    private

    def controller_data
      data = { controller: "rating", rating_value_value: @value }
      data[:rating_url_value] = @url if @url
      data
    end

    def stars
      @max.times.map { |i| star_button(i + 1) }.join.html_safe
    end

    def star_button(index)
      filled = index <= @value
      content_tag(:button,
        star_svg(filled),
        type: "button",
        class: cn(
          "rounded-sm transition-colors outline-none",
          UI::Styles::FOCUS_RING,
          filled ? "text-primary" : "text-muted-foreground"
        ),
        data: {
          rating_target: "star",
          action: "mouseenter->rating#preview mouseleave->rating#resetPreview click->rating#select",
          rating_index_param: index
        },
        "aria-label": "Rate #{index} out of #{@max}")
    end

    def star_svg(filled)
      content_tag(:svg,
        content_tag(:path, nil, d: STAR_PATH, "stroke-linecap": "round", "stroke-linejoin": "round"),
        class: "size-5 pointer-events-none",
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: filled ? "currentColor" : "none",
        stroke: "currentColor",
        "stroke-width": "2",
        "aria-hidden": "true")
    end

    def hidden_input
      content_tag(:input, nil,
        type: "hidden",
        name: @name,
        value: @value,
        data: { rating_target: "input" })
    end
  end
end
