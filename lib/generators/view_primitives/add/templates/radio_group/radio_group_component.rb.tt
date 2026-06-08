# frozen_string_literal: true

module UI
  class RadioGroupComponent < ApplicationComponent
    # items: [{ value:, label:, checked: (optional) }]
    def initialize(name:, items: [], **html_attrs)
      @name = name
      @items = items
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("grid gap-3", @extra_class),
        role: "radiogroup",
        **@html_attrs) do
        if @items.any?
          safe_join(@items.map { |item| radio_item(item) })
        else
          content
        end
      end
    end

    private

    def radio_item(item)
      id = "#{@name}_#{item[:value].to_s.gsub(/\W/, "_")}"
      content_tag(:div, class: "flex items-center gap-2") do
        concat radio_input(item, id)
        concat radio_label(item, id)
      end
    end

    def radio_input(item, id)
      attrs = { type: "radio", name: @name, value: item[:value], id: id,
                class: "aspect-square size-4 shrink-0 rounded-full border border-input text-primary shadow-xs " \
                       "transition-[color,box-shadow] outline-none accent-primary " \
                       "#{UI::Styles::FOCUS_RING} " \
                       "disabled:cursor-not-allowed disabled:opacity-50 " \
                       "aria-invalid:border-destructive aria-invalid:ring-destructive/20 " \
                       "dark:bg-input/30 dark:aria-invalid:ring-destructive/40" }
      attrs[:checked] = true if item[:checked]
      content_tag(:input, nil, **attrs)
    end

    def radio_label(item, id)
      content_tag(:label, item[:label],
        for: id,
        class: "text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-50")
    end
  end
end
