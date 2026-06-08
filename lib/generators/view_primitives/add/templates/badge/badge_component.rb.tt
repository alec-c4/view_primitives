# frozen_string_literal: true

module UI
  class BadgeComponent < ApplicationComponent
    BASE = "inline-flex w-fit shrink-0 items-center justify-center gap-1 overflow-hidden rounded-full " \
           "border border-transparent px-2 py-0.5 text-xs font-medium whitespace-nowrap " \
           "transition-[color,box-shadow] " \
           "#{UI::Styles::FOCUS_RING} " \
           "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
           "[&>svg]:pointer-events-none [&>svg]:size-3"

    VARIANTS = {
      default: "bg-primary text-primary-foreground [a&]:hover:bg-primary/90",
      secondary: "bg-secondary text-secondary-foreground [a&]:hover:bg-secondary/90",
      destructive: "bg-destructive text-white focus-visible:ring-destructive/20 " \
                   "dark:bg-destructive/60 dark:focus-visible:ring-destructive/40 [a&]:hover:bg-destructive/90",
      outline: "border-border text-foreground [a&]:hover:bg-accent [a&]:hover:text-accent-foreground",
      ghost: "[a&]:hover:bg-accent [a&]:hover:text-accent-foreground",
      link: "text-primary underline-offset-4 [a&]:hover:underline"
    }.freeze

    def initialize(label = nil, variant: :default, **html_attrs)
      @label = label || html_attrs.delete(:label)
      @variant = variant.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:span, content.presence || @label,
        class: cn(BASE, VARIANTS.fetch(@variant, VARIANTS[:default]), @extra_class),
        **@html_attrs)
    end
  end
end
