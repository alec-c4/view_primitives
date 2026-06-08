# frozen_string_literal: true

module UI
  class AccordionItemComponent < ApplicationComponent
    ITEM_CLASSES = "border-b border-border last:border-b-0 group"

    SUMMARY_CLASSES = "flex flex-1 cursor-pointer list-none items-start justify-between gap-4 rounded-md py-4 " \
                      "text-left text-sm font-medium transition-all outline-none hover:underline " \
                      "[&::-webkit-details-marker]:hidden #{UI::Styles::FOCUS_RING} " \
                      "disabled:pointer-events-none disabled:opacity-50"

    TITLE_CLASSES = "flex-1 text-left font-medium leading-none"

    CONTENT_CLASSES = "overflow-hidden pb-4 pt-0 text-sm"

    CHEVRON_CLASSES = "pointer-events-none size-4 shrink-0 translate-y-0.5 text-muted-foreground " \
                      "transition-transform duration-200 group-open:rotate-180"

    def initialize(title:, open: false, **html_attrs)
      @title = title
      @open = open
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:details, details_content, **details_attrs)
    end

    private

    def details_attrs
      attrs = @html_attrs.merge(class: cn(ITEM_CLASSES, @extra_class))
      attrs[:open] = true if @open
      attrs
    end

    def details_content
      safe_join([
        content_tag(:summary, summary_content, class: SUMMARY_CLASSES),
        content_tag(:div, content, class: CONTENT_CLASSES)
      ])
    end

    def summary_content
      safe_join([
        content_tag(:span, @title, class: TITLE_CLASSES),
        chevron_icon
      ])
    end

    def chevron_icon
      content_tag(:svg,
        content_tag(:path, nil, d: "m6 9 6 6 6-6"),
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        "stroke-width": "2",
        "stroke-linecap": "round",
        "stroke-linejoin": "round",
        class: CHEVRON_CLASSES,
        "aria-hidden": "true")
    end
  end
end
