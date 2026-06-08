# frozen_string_literal: true

module UI
  class CollapsibleComponent < ApplicationComponent
    # CSS-only collapse via native <details>/<summary>.
    # trigger slot: content for the summary row (button, icon, label, etc.)
    # open:         render pre-expanded (default: false)

    SUMMARY_CLS = "flex cursor-pointer list-none items-center justify-between gap-4 rounded-md py-2 " \
                  "text-left text-sm font-medium transition-all outline-none " \
                  "hover:underline " \
                  "#{UI::Styles::FOCUS_RING} " \
                  "[&::-webkit-details-marker]:hidden"
    CONTENT_CLS = "pb-2 pt-0 text-sm text-muted-foreground"

    renders_one :trigger

    def initialize(open: false, **html_attrs)
      @open = open
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { class: cn("group", @extra_class), data: { slot: "collapsible" }, **@html_attrs }
      attrs[:open] = true if @open

      content_tag(:details, **attrs) do
        concat content_tag(:summary, trigger,
          class: SUMMARY_CLS,
          data: { slot: "collapsible-trigger" })
        concat content_tag(:div, content,
          class: CONTENT_CLS,
          data: { slot: "collapsible-content" })
      end
    end
  end
end
