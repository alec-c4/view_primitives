# frozen_string_literal: true

module UI
  class ComboboxComponent < ApplicationComponent
    INPUT  = UI::Styles::INPUT
    PANEL  = "#{UI::Styles::POPOVER_PANEL} top-full left-0 mt-1 w-full overflow-hidden"
    LIST   = "max-h-[200px] overflow-y-auto p-1"
    OPTION = "#{UI::Styles::MENU_ITEM} w-full cursor-pointer hover:bg-accent hover:text-accent-foreground"
    EMPTY  = "py-4 text-center text-sm text-muted-foreground"

    def initialize(name:, options: [], value: nil, placeholder: "Select...", **html_attrs)
      @name        = name
      @options     = options
      @value       = value&.to_s
      @placeholder = placeholder
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("relative", @extra_class),
        data: {
          controller: "combobox",
          action: "click@document->combobox#closeOnClickOutside"
        },
        **@html_attrs) do
        concat hidden_input
        concat text_input
        concat dropdown
      end
    end

    private

    def hidden_input
      tag.input(type: "hidden", name: @name, value: @value, data: { combobox_target: "hidden" })
    end

    def text_input
      selected_label = @options.find { |o| o[:value].to_s == @value }&.dig(:label)
      tag.input(
        type: "text",
        placeholder: @placeholder,
        value: selected_label,
        autocomplete: "off",
        class: INPUT,
        data: {
          combobox_target: "input",
          action: "focus->combobox#open input->combobox#filter"
        }
      )
    end

    def dropdown
      content_tag(:div,
        data: { combobox_target: "panel" },
        hidden: true,
        class: PANEL) do
        concat content_tag(:div, class: LIST) {
          concat options_list
          concat content_tag(:div, "No results.",
            class: EMPTY,
            data: { combobox_target: "empty" },
            hidden: true)
        }
      end
    end

    def options_list
      safe_join(@options.map { |opt|
        content_tag(:button, opt[:label],
          type: "button",
          class: OPTION,
          data: {
            combobox_target: "option",
            combobox_value: opt[:value],
            combobox_label: opt[:label],
            action: "click->combobox#select"
          })
      })
    end
  end
end
