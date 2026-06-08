# frozen_string_literal: true

module UI
  class DialogComponent < ApplicationComponent
    renders_one :trigger
    renders_one :footer

    OVERLAY = UI::Styles::OVERLAY
    PANEL   = "fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] " \
              "translate-x-[-50%] translate-y-[-50%] gap-4 " \
              "rounded-lg #{UI::Styles::BORDER} bg-background p-6 shadow-lg duration-200 outline-none sm:max-w-lg"
    CLOSE_BTN = "absolute top-4 right-4 z-10 rounded-xs opacity-70 ring-offset-background transition-opacity " \
                "hover:opacity-100 focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:outline-hidden " \
                "disabled:pointer-events-none"

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
          data: { action: "click->dialog#close" },
          "aria-hidden": "true")
        concat content_tag(:div,
          class: cn(PANEL, @extra_class),
          role: "dialog",
          "aria-modal": "true",
          "aria-label": @title,
          data: { action: "keydown.escape@window->dialog#close" }) {
          concat close_button
          concat header_area
          concat content_tag(:div, content) unless content.blank?
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

    def close_button
      content_tag(:button,
        close_svg,
        type: "button",
        class: CLOSE_BTN,
        data: { action: "click->dialog#close" },
        "aria-label": "Close")
    end

    def close_svg
      raw('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-4" aria-hidden="true"><path d="M18 6 6 18"/><path d="m6 6 12 12"/></svg>')
    end
  end
end
