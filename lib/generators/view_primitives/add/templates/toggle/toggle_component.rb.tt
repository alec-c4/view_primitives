# frozen_string_literal: true

module UI
  class ToggleComponent < ApplicationComponent
    BASE = "inline-flex items-center justify-center gap-2 rounded-md text-sm font-medium whitespace-nowrap " \
           "transition-[color,box-shadow] outline-none hover:bg-muted hover:text-muted-foreground " \
           "#{UI::Styles::FOCUS_RING} " \
           "disabled:pointer-events-none disabled:opacity-50 " \
           "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
           "data-[state=on]:bg-accent data-[state=on]:text-accent-foreground " \
           "[&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"

    VARIANTS = {
      default: "bg-transparent",
      outline: "border border-input bg-transparent shadow-xs hover:bg-accent hover:text-accent-foreground"
    }.freeze

    SIZES = {
      default: "h-9 min-w-9 px-2",
      sm:      "h-8 min-w-8 px-1.5",
      lg:      "h-10 min-w-10 px-2.5"
    }.freeze

    def initialize(label = nil, pressed: false, variant: :default, size: :default, value: nil, **html_attrs)
      @label = label || html_attrs.delete(:label)
      @pressed = pressed
      @variant = variant.to_sym
      @size = size.to_sym
      @value = value
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:button,
        content.presence || @label,
        type: "button",
        "aria-pressed": @pressed.to_s,
        "data-state": @pressed ? "on" : "off",
        "data-controller": "toggle",
        "data-action": "click->toggle#toggle",
        value: @value,
        class: cn(BASE, VARIANTS.fetch(@variant, VARIANTS[:default]),
          SIZES.fetch(@size, SIZES[:default]), @extra_class),
        **@html_attrs)
    end
  end
end
