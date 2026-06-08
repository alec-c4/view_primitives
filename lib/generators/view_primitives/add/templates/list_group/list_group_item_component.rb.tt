# frozen_string_literal: true

module UI
  class ListGroupItemComponent < ApplicationComponent
    BASE = "flex items-center justify-between gap-4 px-4 py-3 text-sm transition-colors duration-100 " \
           "outline-none #{UI::Styles::FOCUS_RING}"

    VARIANTS = {
      default: "text-foreground hover:bg-accent/50",
      active:  "bg-accent font-medium text-accent-foreground",
      muted:   "text-muted-foreground hover:bg-accent/50"
    }.freeze

    def initialize(label = nil, href: nil, active: false, variant: :default, **html_attrs)
      @label = label || html_attrs.delete(:label)
      @href = href
      @variant = active ? :active : variant.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      tag_name = @href ? :a : :li
      extra = @href ? { href: @href } : {}
      content_tag(tag_name,
        content.presence || @label,
        class: cn(BASE, VARIANTS.fetch(@variant, VARIANTS[:default]), @extra_class),
        data: { slot: "item" },
        **extra,
        **@html_attrs)
    end
  end
end
