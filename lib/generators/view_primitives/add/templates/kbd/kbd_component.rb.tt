# frozen_string_literal: true

module UI
  class KbdComponent < ApplicationComponent
    BASE = "pointer-events-none inline-flex h-5 w-fit min-w-5 items-center justify-center gap-1 " \
           "rounded-sm bg-muted px-1 font-sans text-xs font-medium text-muted-foreground select-none " \
           "[&_svg:not([class*='size-'])]:size-3 " \
           "[[data-slot=tooltip-content]_&]:bg-background/20 [[data-slot=tooltip-content]_&]:text-background " \
           "dark:[[data-slot=tooltip-content]_&]:bg-background/10"

    def initialize(key = nil, **html_attrs)
      @key = key || html_attrs.delete(:label)
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:kbd, content.presence || @key,
        class: cn(BASE, @extra_class),
        **@html_attrs)
    end
  end
end
