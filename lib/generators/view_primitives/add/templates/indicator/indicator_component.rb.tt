# frozen_string_literal: true

module UI
  class IndicatorComponent < ApplicationComponent
    DOT_BASE = "absolute flex items-center justify-center rounded-full text-[10px] font-medium leading-none " \
               "ring-2 ring-background"

    VARIANTS = {
      default:     "bg-primary text-primary-foreground",
      destructive: "bg-destructive text-white dark:bg-destructive/60",
      success:     "bg-chart-2 text-white",
      warning:     "bg-chart-4 text-foreground"
    }.freeze

    POSITIONS = {
      top_right:    "-top-1 -right-1",
      top_left:     "-top-1 -left-1",
      bottom_right: "-bottom-1 -right-1",
      bottom_left:  "-bottom-1 -left-1"
    }.freeze

    def initialize(count: nil, position: :top_right, variant: :default, **html_attrs)
      @count = count
      @position = position.to_sym
      @variant = variant.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:span, class: cn("relative inline-flex", @extra_class), **@html_attrs) do
        concat content
        concat dot
      end
    end

    private

    def dot
      dot_size = @count ? "size-5 min-w-5 px-0.5" : "size-2"
      content_tag(:span, @count,
        class: cn(DOT_BASE, dot_size,
          VARIANTS.fetch(@variant, VARIANTS[:default]),
          POSITIONS.fetch(@position, POSITIONS[:top_right])))
    end
  end
end
