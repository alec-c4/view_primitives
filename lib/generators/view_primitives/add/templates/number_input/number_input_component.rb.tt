# frozen_string_literal: true

module UI
  class NumberInputComponent < ApplicationComponent
    SPINNER_HIDE = "[appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none " \
                   "[&::-webkit-outer-spin-button]:appearance-none"

    # min / max / step: native number input attributes
    # value: initial value
    def initialize(min: nil, max: nil, step: nil, value: nil, **html_attrs)
      @min   = min
      @max   = max
      @step  = step
      @value = value
      extract_html_attrs(**html_attrs)
    end

    def call
      attrs = { type: "number", class: cn(UI::Styles::INPUT, SPINNER_HIDE, @extra_class) }
      attrs[:min]   = @min   unless @min.nil?
      attrs[:max]   = @max   unless @max.nil?
      attrs[:step]  = @step  unless @step.nil?
      attrs[:value] = @value unless @value.nil?
      content_tag(:input, nil, **attrs, **@html_attrs)
    end
  end
end
