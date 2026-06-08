# frozen_string_literal: true

module UI
  class DrawerComponent < ApplicationComponent
    renders_one :trigger
    renders_one :footer

    OVERLAY = UI::Styles::OVERLAY
    PANEL   = "fixed inset-x-0 bottom-0 z-50 flex h-auto max-h-[80vh] flex-col " \
              "rounded-t-lg border-t border-border bg-background shadow-lg overflow-y-auto"

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
          concat drag_handle
          concat header_area
          concat content_tag(:div, content, class: "px-4 pb-6 text-sm")
          concat content_tag(:div, footer, class: "px-4 pb-6 flex justify-end gap-2") if footer
        }
      end
    end

    def drag_handle
      content_tag(:div, class: "flex justify-center pt-3 pb-2") {
        content_tag(:div, nil, class: "h-1.5 w-12 rounded-full bg-muted")
      }
    end

    def header_area
      return "" if @title.nil? && @description.nil?

      content_tag(:div, class: "px-4 pb-4") do
        concat content_tag(:h2, @title, class: "text-lg font-semibold text-foreground") if @title
        concat content_tag(:p, @description, class: "mt-1 text-sm text-muted-foreground") if @description
      end
    end
  end
end
