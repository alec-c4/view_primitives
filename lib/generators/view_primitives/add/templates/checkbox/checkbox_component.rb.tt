# frozen_string_literal: true

module UI
  class CheckboxComponent < ApplicationComponent
    BASE = "peer size-4 shrink-0 rounded-[4px] border border-input shadow-xs transition-shadow outline-none " \
           "#{UI::Styles::FOCUS_RING} " \
           "disabled:cursor-not-allowed disabled:opacity-50 " \
           "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
           "checked:border-primary checked:bg-primary checked:text-primary-foreground " \
           "dark:bg-input/30 dark:checked:bg-primary"

    def initialize(label: nil, checked: false, **html_attrs)
      @label = label
      @checked = checked
      @id = html_attrs[:id] || html_attrs[:name]&.gsub(/\W/, "_")
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      if @label
        content_tag(:div, class: "flex items-center gap-2") do
          concat checkbox_input
          concat label_tag
        end
      else
        checkbox_input
      end
    end

    private

    def checkbox_input
      attrs = @html_attrs.merge(
        type: "checkbox",
        class: cn(BASE, @extra_class)
      )
      attrs[:checked] = true if @checked
      attrs[:id] = @id if @id
      content_tag(:input, nil, **attrs)
    end

    def label_tag
      content_tag(:label,
        @label,
        for: @id,
        class: "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-50")
    end
  end
end
