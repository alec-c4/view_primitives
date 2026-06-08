# frozen_string_literal: true

module UI
  class BannerComponent < ApplicationComponent
    BASE = "relative flex w-full items-center gap-3 rounded-lg #{UI::Styles::BORDER} px-4 py-3 text-sm"

    VARIANTS = {
      default:     "bg-card text-card-foreground",
      info:        "border-border bg-muted/50 text-foreground",
      warning:     "border-border bg-chart-4/10 text-foreground",
      destructive: "border-destructive/40 bg-card text-destructive",
      success:     "border-border bg-chart-2/10 text-foreground"
    }.freeze

    def initialize(message = nil, variant: :default, **html_attrs)
      @message = message || html_attrs.delete(:message) || html_attrs.delete(:label)
      @variant = variant.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        content.presence || @message,
        class: cn(BASE, VARIANTS.fetch(@variant, VARIANTS[:default]), @extra_class),
        **@html_attrs)
    end
  end
end
