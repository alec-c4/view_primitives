# frozen_string_literal: true

module UI
  class TagsInputComponent < ApplicationComponent
    TRIGGER = "flex flex-wrap items-center gap-1.5 min-h-9 w-full rounded-md border border-input " \
              "bg-transparent px-3 py-1.5 text-sm shadow-xs cursor-text " \
              "focus-within:outline-none focus-within:border-ring focus-within:ring-[3px] focus-within:ring-ring/50"
    CHIP = "inline-flex items-center gap-1 rounded-md bg-secondary " \
                  "text-secondary-foreground px-2 py-0.5 text-xs font-medium"
    CHIP_LABEL = "tags-input-chip-label"
    REMOVE = "ml-0.5 rounded-xs opacity-60 transition-opacity hover:opacity-100 #{UI::Styles::FOCUS_RING}"
    FILTER = "min-w-[80px] flex-1 bg-transparent text-sm outline-none " \
                  "placeholder:text-muted-foreground"
    PANEL = "#{UI::Styles::POPOVER_PANEL} top-full left-0 mt-1 w-full overflow-hidden"
    LIST = "max-h-[200px] overflow-y-auto p-1"
    OPTION = "#{UI::Styles::MENU_ITEM} w-full cursor-pointer " \
                  "hover:bg-accent hover:text-accent-foreground"
    EMPTY = "py-4 text-center text-sm text-muted-foreground"

    def initialize(name:, options: [], values: [], placeholder: "Select...", **html_attrs)
      @name = name
      @options = options
      @values = Array(values).map(&:to_s)
      @placeholder = placeholder
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("relative", @extra_class),
        data: {
          controller: "tags-input",
          action: "click@document->tags-input#closeOnClickOutside"
        },
        **@html_attrs) do
        concat trigger
        concat chip_template
        concat dropdown
      end
    end

    private

    def trigger
      content_tag(:div,
        class: TRIGGER,
        data: {"tags-input-target": "trigger", action: "click->tags-input#focusInput"}) do
        concat safe_join(selected_options.map { |opt| chip(opt) })
        concat filter_input
      end
    end

    def chip(opt)
      content_tag(:span,
        class: CHIP,
        data: {"tags-input-target": "chip", "tags-input-value": opt[:value]}) do
        concat content_tag(:span, opt[:label], class: CHIP_LABEL)
        concat tag.input(type: "hidden", name: "#{@name}[]", value: opt[:value])
        concat remove_button(opt[:value])
      end
    end

    def chip_template
      content_tag(:template, data: {"tags-input-target": "chipTemplate"}) do
        chip(value: "", label: "")
      end
    end

    def remove_button(value)
      content_tag(:button,
        "×",
        type: "button",
        "aria-label": "Remove",
        class: REMOVE,
        data: {"tags-input-value": value, action: "click->tags-input#remove"})
    end

    def filter_input
      tag.input(
        type: "text",
        placeholder: selected_options.empty? ? @placeholder : nil,
        autocomplete: "off",
        class: FILTER,
        data: {
          "tags-input-target": "input",
          action: "focus->tags-input#open input->tags-input#filter keydown->tags-input#keydown"
        }
      )
    end

    def dropdown
      content_tag(:div,
        data: {"tags-input-target": "panel"},
        hidden: true,
        class: PANEL) do
        concat content_tag(:div, class: LIST) {
          concat options_list
          concat content_tag(:div, "No results.",
            class: EMPTY,
            data: {"tags-input-target": "empty"},
            hidden: true)
        }
      end
    end

    def options_list
      safe_join(normalized_options.map { |opt|
        content_tag(:button, opt[:label],
          type: "button",
          class: OPTION,
          hidden: @values.include?(opt[:value]),
          data: {
            "tags-input-target": "option",
            "tags-input-value": opt[:value],
            "tags-input-label": opt[:label],
            action: "click->tags-input#select"
          })
      })
    end

    def normalized_options
      @options.map { |o|
        case o
        when Hash then {value: o[:value].to_s, label: o[:label].to_s}
        when Array then {value: o[0].to_s, label: o[1].to_s}
        else {value: o.to_s, label: o.to_s}
        end
      }
    end

    def selected_options
      normalized_options.select { |o| @values.include?(o[:value]) }
    end
  end
end
