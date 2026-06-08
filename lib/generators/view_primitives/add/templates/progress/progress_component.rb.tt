# frozen_string_literal: true

module UI
  class ProgressComponent < ApplicationComponent
    TRACK = "relative h-2 w-full overflow-hidden rounded-full bg-primary/20"
    BAR = "h-full w-full flex-1 bg-primary transition-all"

    def initialize(value: 0, max: 100, **html_attrs)
      @value = value
      @max = max
      @pct = [[@value.to_f / @max * 100, 0].max, 100].min
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        class: cn(TRACK, @extra_class),
        data: { slot: "progress" },
        role: "progressbar",
        "aria-valuenow": @value,
        "aria-valuemin": 0,
        "aria-valuemax": @max,
        **@html_attrs) do
        content_tag(:div, nil, class: BAR, style: "width: #{@pct.round(2)}%",
          data: { slot: "progress-indicator" })
      end
    end
  end
end
