# frozen_string_literal: true

module UI
  class RangeComponent < ApplicationComponent
    BASE = "h-2 w-full cursor-pointer appearance-none rounded-full bg-muted outline-none accent-primary " \
           "#{UI::Styles::FOCUS_RING} " \
           "disabled:pointer-events-none disabled:opacity-50 " \
           "[&::-webkit-slider-thumb]:size-4 [&::-webkit-slider-thumb]:appearance-none " \
           "[&::-webkit-slider-thumb]:rounded-full [&::-webkit-slider-thumb]:bg-primary " \
           "[&::-webkit-slider-thumb]:border-2 [&::-webkit-slider-thumb]:border-background " \
           "[&::-webkit-slider-thumb]:shadow-xs [&::-webkit-slider-thumb]:transition-[color,box-shadow] " \
           "[&::-moz-range-thumb]:size-4 [&::-moz-range-thumb]:appearance-none " \
           "[&::-moz-range-thumb]:rounded-full [&::-moz-range-thumb]:bg-primary " \
           "[&::-moz-range-thumb]:border-2 [&::-moz-range-thumb]:border-background " \
           "[&::-moz-range-thumb]:border-solid [&::-moz-range-thumb]:shadow-xs"

    # min / max / step / value: native range attributes
    def initialize(min: 0, max: 100, step: 1, value: nil, **html_attrs)
      @min   = min
      @max   = max
      @step  = step
      @value = value
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = {
        type: "range",
        min: @min,
        max: @max,
        step: @step,
        class: cn(BASE, @extra_class)
      }
      attrs[:value] = @value unless @value.nil?
      content_tag(:input, nil, **attrs, **@html_attrs)
    end
  end
end
