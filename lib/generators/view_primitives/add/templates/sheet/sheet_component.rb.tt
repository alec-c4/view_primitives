# frozen_string_literal: true

module UI
  class SheetComponent < ApplicationComponent
    renders_one :trigger
    renders_one :footer

    OVERLAY = UI::Styles::OVERLAY

    SIDES = {
      right:  "inset-y-0 right-0 h-full w-3/4 border-l border-border sm:max-w-sm",
      left:   "inset-y-0 left-0 h-full w-3/4 border-r border-border sm:max-w-sm",
      top:    "inset-x-0 top-0 h-auto border-b border-border",
      bottom: "inset-x-0 bottom-0 h-auto border-t border-border"
    }.freeze

    PANEL_BASE = "fixed z-[51] flex flex-col gap-4 bg-background p-6 shadow-lg transition ease-in-out overflow-y-auto"

    CLOSE_BTN = "absolute top-4 right-4 z-10 rounded-xs opacity-70 ring-offset-background transition-opacity " \
                "hover:opacity-100 focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:outline-hidden " \
                "disabled:pointer-events-none"

    def initialize(title: nil, description: nil, side: :right, **html_attrs)
      @title       = title
      @description = description
      @side        = side.to_sym
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
          class: cn(PANEL_BASE, SIDES.fetch(@side, SIDES[:right]), @extra_class),
          role: "dialog",
          "aria-modal": "true",
          "aria-label": @title,
          data: { action: "keydown.escape@window->dialog#close" }) {
          concat close_button
          concat header_area
          concat content_tag(:div, content, class: "flex-1") unless content.blank?
          concat content_tag(:div, footer, class: "mt-auto flex flex-col gap-2") if footer
        }
      end
    end

    def header_area
      return "" if @title.nil? && @description.nil?

      content_tag(:div, class: "flex flex-col gap-1.5 pr-6") do
        concat content_tag(:h2, @title, class: "font-semibold text-foreground") if @title
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
