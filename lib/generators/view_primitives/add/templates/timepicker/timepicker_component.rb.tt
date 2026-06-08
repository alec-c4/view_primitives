# frozen_string_literal: true

module UI
  class TimepickerComponent < ApplicationComponent
    # Time picker — trigger button opens a clock popover with hour/minute spinners.
    #
    # value:    "HH:MM" string or nil
    # name:     form field name for the hidden input
    # format:   :h24 (default) | :h12
    # step:     minute step increment (default 1, common: 5, 15, 30)

    WRAPPER  = "relative inline-block"
    TRIGGER  = "#{UI::Styles::PICKER_TRIGGER} w-36"
    ICON_CLS = "size-4 shrink-0 text-muted-foreground pointer-events-none"
    LABEL_PLACEHOLDER = "text-muted-foreground"
    POPOVER  = "absolute left-0 top-full z-50 mt-2 hidden w-max p-3 #{UI::Styles::FIELD_PANEL} data-[open=true]:block"
    SPINNER_WRAP = "flex items-center justify-center gap-1"
    COL_CLS  = "flex flex-col items-center gap-1"
    SPIN_BTN = "inline-flex size-7 items-center justify-center rounded-md text-muted-foreground " \
               "transition-colors outline-none " \
               "hover:bg-accent hover:text-accent-foreground " \
               "#{UI::Styles::FOCUS_RING} " \
               "dark:hover:bg-accent/50"
    NUM_CLS  = "h-9 w-10 rounded-md border border-input bg-transparent px-1 py-1 text-center text-sm shadow-xs " \
               "transition-[color,box-shadow] outline-none " \
               "#{UI::Styles::FOCUS_RING} " \
               "dark:bg-input/30"
    AMPM_CLS = NUM_CLS + " cursor-pointer select-none"
    SEP_CLS  = "pb-1 text-lg font-medium text-foreground"

    def initialize(value: nil, name: nil, format: :h24, step: 1, **html_attrs)
      @value       = value
      @name        = name
      @format      = format.to_sym
      @step        = step.to_i.clamp(1, 60)
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn(WRAPPER, @extra_class),
        data: {
          controller: "timepicker",
          timepicker_format_value: @format,
          timepicker_step_value: @step
        },
        **@html_attrs) do
        concat hidden_input if @name
        concat trigger_button
        concat clock_popover
      end
    end

    private

    def hidden_input
      tag.input(type: "hidden", name: @name,
        value: @value,
        data: { timepicker_target: "hidden" })
    end

    def trigger_button
      content_tag(:button, type: "button",
        class: TRIGGER,
        "aria-expanded": "false",
        "aria-haspopup": "dialog",
        data: {
          timepicker_target: "trigger",
          action: "click->timepicker#toggle"
        }) do
        concat clock_icon
        concat content_tag(:span, @value || "Pick time",
          class: (@value ? nil : LABEL_PLACEHOLDER),
          data: { timepicker_target: "label" })
      end
    end

    def clock_popover
      hour_val, min_val = (@value || "00:00").split(":").map(&:to_i)

      content_tag(:div,
        class: POPOVER,
        role: "dialog",
        "aria-modal": "true",
        data: { timepicker_target: "popover" }) do
        content_tag(:div, class: SPINNER_WRAP) do
          concat hour_column(hour_val)
          concat content_tag(:span, ":", class: SEP_CLS)
          concat minute_column(min_val)
          concat ampm_column if @format == :h12
        end
      end
    end

    def hour_column(val)
      content_tag(:div, class: COL_CLS) do
        concat spin_btn("▲", "click->timepicker#hourUp")
        concat tag.input(type: "text", inputmode: "numeric", class: NUM_CLS,
          value: val.to_s.rjust(2, "0"), maxlength: "2",
          data: { timepicker_target: "hour", action: "change->timepicker#hourChanged" })
        concat spin_btn("▼", "click->timepicker#hourDown")
      end
    end

    def minute_column(val)
      content_tag(:div, class: COL_CLS) do
        concat spin_btn("▲", "click->timepicker#minuteUp")
        concat tag.input(type: "text", inputmode: "numeric", class: NUM_CLS,
          value: val.to_s.rjust(2, "0"), maxlength: "2",
          data: { timepicker_target: "minute", action: "change->timepicker#minuteChanged" })
        concat spin_btn("▼", "click->timepicker#minuteDown")
      end
    end

    def ampm_column
      content_tag(:div, class: COL_CLS) do
        concat spin_btn("▲", "click->timepicker#toggleAmPm")
        concat content_tag(:span, "AM",
          class: AMPM_CLS,
          data: { timepicker_target: "ampm", action: "click->timepicker#toggleAmPm" })
        concat spin_btn("▼", "click->timepicker#toggleAmPm")
      end
    end

    def spin_btn(label, action)
      content_tag(:button, label, type: "button",
        class: SPIN_BTN, "aria-hidden": "true",
        tabindex: "-1", data: { action: action })
    end

    def clock_icon
      content_tag(:svg,
        safe_join([
          content_tag(:circle, nil, cx: "12", cy: "12", r: "10"),
          content_tag(:polyline, nil, points: "12 6 12 12 16 14")
        ]),
        xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
        fill: "none", stroke: "currentColor", "stroke-width": "2",
        "stroke-linecap": "round", "stroke-linejoin": "round",
        class: ICON_CLS, "aria-hidden": "true")
    end
  end
end
