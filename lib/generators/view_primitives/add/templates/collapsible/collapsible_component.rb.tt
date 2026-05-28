# frozen_string_literal: true

module UI
  class CollapsibleComponent < ApplicationComponent
    # CSS-only collapse via native <details>/<summary>.
    # trigger slot: content for the summary row (button, icon, label, etc.)
    # open:         render pre-expanded (default: false)

    SUMMARY_CLS = "flex cursor-pointer list-none items-center justify-between gap-2 " \
                  "[&::-webkit-details-marker]:hidden"
    CONTENT_CLS = "mt-2"

    renders_one :trigger

    def initialize(open: false, **html_attrs)
      @open = open
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { class: cn(@extra_class), **@html_attrs }
      attrs[:open] = true if @open

      content_tag(:details, **attrs) do
        concat content_tag(:summary, trigger, class: SUMMARY_CLS)
        concat content_tag(:div, content, class: CONTENT_CLS)
      end
    end
  end
end
