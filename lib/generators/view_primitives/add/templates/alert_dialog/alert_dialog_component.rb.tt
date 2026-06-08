# frozen_string_literal: true

module UI
  class AlertDialogComponent < ApplicationComponent
    renders_one :trigger
    renders_one :footer

    OVERLAY = UI::Styles::OVERLAY
    PANEL   = "fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] " \
              "translate-x-[-50%] translate-y-[-50%] gap-4 " \
              "rounded-lg #{UI::Styles::BORDER} bg-background p-6 shadow-lg duration-200 sm:max-w-lg"

    def initialize(title: nil, description: nil, **html_attrs)
      @title       = title
      @description = description
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div, data: { controller: "dialog" }, **@html_attrs) do
        concat content_tag(:span, trigger, data: { action: "click->dialog#open" }, class: "contents") if trigger
        concat panel
      end
    end

    private

    def panel
      content_tag(:div, data: { dialog_target: "panel" }, hidden: true) do
        concat content_tag(:div, nil,
          class: OVERLAY,
          "aria-hidden": "true")
        concat content_tag(:div,
          class: cn(PANEL, @extra_class),
          role: "alertdialog",
          "aria-modal": "true",
          "aria-label": @title) {
          concat header_area
          concat content_tag(:div, content, class: "text-sm text-muted-foreground") unless content.blank?
          concat content_tag(:div, footer, class: "flex flex-col-reverse gap-2 sm:flex-row sm:justify-end") if footer
        }
      end
    end

    def header_area
      return "" if @title.nil? && @description.nil?

      content_tag(:div, class: "flex flex-col gap-2 text-center sm:text-left") do
        concat content_tag(:h2, @title, class: "text-lg leading-none font-semibold") if @title
        concat content_tag(:p, @description, class: "text-sm text-muted-foreground") if @description
      end
    end
  end
end
