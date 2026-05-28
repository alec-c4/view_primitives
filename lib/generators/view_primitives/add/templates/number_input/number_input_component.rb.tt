# frozen_string_literal: true

module UI
  class NumberInputComponent < ApplicationComponent
    BASE = "h-9 w-full min-w-0 rounded-md border border-input bg-transparent px-3 py-1 text-base shadow-xs " \
           "transition-[color,box-shadow] outline-none " \
           "placeholder:text-muted-foreground " \
           "focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 " \
           "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
           "disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 " \
           "[appearance:textfield] [&::-webkit-inner-spin-button]:appearance-none [&::-webkit-outer-spin-button]:appearance-none " \
           "md:text-sm dark:bg-input/30"

    # min / max / step: native number input attributes
    # value: initial value
    def initialize(min: nil, max: nil, step: nil, value: nil, **html_attrs)
      @min   = min
      @max   = max
      @step  = step
      @value = value
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { type: "number", class: cn(BASE, @extra_class) }
      attrs[:min]   = @min   unless @min.nil?
      attrs[:max]   = @max   unless @max.nil?
      attrs[:step]  = @step  unless @step.nil?
      attrs[:value] = @value unless @value.nil?
      content_tag(:input, nil, **attrs, **@html_attrs)
    end
  end
end
