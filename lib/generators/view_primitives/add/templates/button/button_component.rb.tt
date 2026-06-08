# frozen_string_literal: true

module UI
  class ButtonComponent < ApplicationComponent
    BASE_CLASSES = "inline-flex shrink-0 items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm " \
                   "font-medium transition-all " \
                   "#{UI::Styles::FOCUS_RING} " \
                   "disabled:pointer-events-none disabled:opacity-50 " \
                   "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
                   "[&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4"

    VARIANTS = {
      default: "bg-primary text-primary-foreground hover:bg-primary/90",
      destructive: "bg-destructive text-white hover:bg-destructive/90 " \
                   "focus-visible:ring-destructive/20 dark:bg-destructive/60 dark:focus-visible:ring-destructive/40",
      outline: "border border-input bg-background shadow-xs hover:bg-accent hover:text-accent-foreground " \
               "dark:bg-input/30 dark:hover:bg-input/50",
      secondary: "bg-secondary text-secondary-foreground hover:bg-secondary/80",
      ghost: "hover:bg-accent hover:text-accent-foreground dark:hover:bg-accent/50",
      link: "text-primary underline-offset-4 hover:underline"
    }.freeze

    SIZES = {
      default: "h-9 px-4 py-2 has-[>svg]:px-3",
      xs: "h-6 gap-1 rounded-md px-2 text-xs has-[>svg]:px-1.5 [&_svg:not([class*='size-'])]:size-3",
      sm: "h-8 gap-1.5 rounded-md px-3 has-[>svg]:px-2.5",
      lg: "h-10 rounded-md px-6 has-[>svg]:px-4",
      icon: "size-9",
      "icon-xs": "size-6 rounded-md [&_svg:not([class*='size-'])]:size-3",
      "icon-sm": "size-8",
      "icon-lg": "size-10"
    }.freeze

    # label — positional or keyword shorthand for plain-text buttons without a block.
    # href  — renders an <a> tag; sets tag: :a automatically.
    def initialize(label = nil, variant: :default, size: :default, href: nil, **html_attrs)
      @label = label || html_attrs.delete(:label)
      @variant = variant.to_sym
      @size = size.to_sym
      @tag = html_attrs.delete(:tag)
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs

      if href
        @html_attrs[:href] = href
        @tag ||= :a
      end
    end

    def call
      body = content.presence || @label
      tag = @tag || :button
      attrs = @html_attrs.merge(class: component_classes)
      attrs[:type] ||= "button" if tag == :button && !attrs.key?(:type)
      content_tag(tag, body, **attrs)
    end

    private

    def component_classes
      cn(BASE_CLASSES, VARIANTS.fetch(@variant, VARIANTS[:default]), SIZES.fetch(@size, SIZES[:default]), @extra_class)
    end
  end
end
