# frozen_string_literal: true

module UI
  class SwitchComponent < ApplicationComponent
    # sr-only input, track label, and thumb are all siblings inside a relative wrapper
    # so every element can use peer-checked: / peer-focus-visible: / peer-disabled: directly.
    WRAPPERS = {
      default: "relative inline-flex h-[1.15rem] w-8 shrink-0",
      sm: "relative inline-flex h-3.5 w-6 shrink-0"
    }.freeze

    TRACK = "absolute inset-0 cursor-pointer rounded-full border border-transparent shadow-xs " \
            "transition-all bg-input peer-checked:bg-primary dark:bg-input/80 " \
            "#{UI::Styles::PEER_FOCUS_RING} " \
            "peer-disabled:cursor-not-allowed peer-disabled:opacity-50"

    THUMBS = {
      default: "pointer-events-none absolute inset-y-0 left-[1px] my-auto z-10 block size-4 rounded-full " \
               "bg-background ring-0 transition-transform translate-x-0 " \
               "peer-checked:translate-x-[calc(100%-2px)] " \
               "dark:bg-foreground dark:peer-checked:bg-primary-foreground",
      sm: "pointer-events-none absolute inset-y-0 left-[1px] my-auto z-10 block size-3 rounded-full " \
          "bg-background ring-0 transition-transform translate-x-0 " \
          "peer-checked:translate-x-[calc(100%-2px)] " \
          "dark:bg-foreground dark:peer-checked:bg-primary-foreground"
    }.freeze

    def initialize(label: nil, checked: false, size: :default, **html_attrs)
      @label = label
      @checked = checked
      @size = size.to_sym
      @id = html_attrs[:id] || html_attrs[:name]&.gsub(/[\[\]]+/, "_") || "switch_#{object_id}"
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div, class: cn("inline-flex items-center gap-2", @extra_class)) do
        concat switch_widget
        concat text_label if @label
      end
    end

    private

    def switch_widget
      content_tag(:div, class: WRAPPERS.fetch(@size, WRAPPERS[:default])) do
        input_attrs = { type: "checkbox", id: @id, class: "peer sr-only", role: "switch",
                        "aria-checked": @checked.to_s, "data-size": @size.to_s }
        input_attrs[:checked] = true if @checked
        input_attrs.merge!(@html_attrs)
        concat content_tag(:input, nil, **input_attrs)
        concat content_tag(:label, nil, for: @id, class: TRACK)
        concat content_tag(:span, nil, class: THUMBS.fetch(@size, THUMBS[:default]), "aria-hidden": "true")
      end
    end

    def text_label
      content_tag(:label, @label,
        for: @id,
        class: "cursor-pointer text-sm font-medium leading-none peer-disabled:cursor-not-allowed peer-disabled:opacity-50")
    end
  end
end
