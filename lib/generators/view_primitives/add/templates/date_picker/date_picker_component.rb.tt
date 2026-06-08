# frozen_string_literal: true

module UI
  class DatePickerComponent < ApplicationComponent
    # Date picker — text input that opens a calendar popover on focus/click.
    #
    # value:       Date or nil — initial selected date
    # name:        form field name for the hidden input
    # placeholder: displayed when no date is selected (default: "Pick a date")
    # min/max:     Date bounds passed to the calendar

    WRAPPER  = "relative inline-block"
    TRIGGER  = "#{UI::Styles::PICKER_TRIGGER} w-48"
    ICON_CLS = "size-4 shrink-0 text-muted-foreground pointer-events-none"
    LABEL_PLACEHOLDER = "text-muted-foreground"
    # Positioning shell only — visual chrome comes from CalendarComponent::CONTAINER
    POPOVER  = "absolute left-0 top-full z-50 mt-2 hidden w-max data-[open=true]:block"

    def initialize(value: nil, name: nil, placeholder: "Pick a date", min: nil, max: nil, **html_attrs)
      @value       = value
      @name        = name
      @placeholder = placeholder
      @min         = min
      @max         = max
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn(WRAPPER, @extra_class),
        data: { controller: "date-picker" },
        **@html_attrs) do
        concat hidden_input if @name
        concat trigger_button
        concat calendar_popover
      end
    end

    private

    def hidden_input
      tag.input(type: "hidden", name: @name,
        value: @value&.iso8601,
        data: { date_picker_target: "hidden" })
    end

    def trigger_button
      label_text = @value ? @value.strftime("%B %-d, %Y") : @placeholder
      content_tag(:button, type: "button",
        class: TRIGGER,
        "aria-expanded": "false",
        "aria-haspopup": "dialog",
        data: {
          date_picker_target: "trigger",
          action: "click->date-picker#toggle"
        }) do
        concat calendar_icon
        concat content_tag(:span, label_text,
          class: (@value ? nil : LABEL_PLACEHOLDER),
          data: { date_picker_target: "label" })
      end
    end

    def calendar_popover
      content_tag(:div,
        class: POPOVER,
        role: "dialog",
        "aria-modal": "true",
        data: {
          date_picker_target: "popover",
          action: "calendar:change->date-picker#dateSelected"
        }) do
        render UI::CalendarComponent.new(
          selected: @value,
          min: @min,
          max: @max
        )
      end
    end

    def calendar_icon
      content_tag(:svg,
        content_tag(:path, nil,
          d: "M8 2v3m8-3v3M3.5 8h17M5 4h14a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2z",
          "stroke-linecap": "round", "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
        fill: "none", stroke: "currentColor", "stroke-width": "2",
        class: ICON_CLS, "aria-hidden": "true")
    end
  end
end
