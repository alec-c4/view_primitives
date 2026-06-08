# frozen_string_literal: true

module UI
  class SpeedDialComponent < ApplicationComponent
    # Floating action button that expands into a stack of sub-action buttons.
    #
    # Usage:
    #   ui :speed_dial, icon: :plus do |dial|
    #     dial.with_action(label: "New document", icon: :file, href: "/docs/new")
    #     dial.with_action(label: "Upload",        icon: :upload, data: { action: "..." })
    #   end

    FAB_CLS = "relative z-50 inline-flex size-12 items-center justify-center rounded-full " \
              "bg-primary text-primary-foreground shadow-xs transition-all outline-none " \
              "#{UI::Styles::FOCUS_RING} active:scale-95"

    PANEL_CLS = "absolute bottom-14 right-0 flex flex-col-reverse items-end gap-2"

    ACTION_CLS = "flex items-center gap-2 rounded-full border border-input bg-background px-4 py-2 text-sm font-medium " \
                 "whitespace-nowrap shadow-xs transition-all outline-none " \
                 "hover:bg-accent hover:text-accent-foreground " \
                 "#{UI::Styles::FOCUS_RING} " \
                 "dark:border-input dark:bg-input/30 dark:hover:bg-input/50"

    PLUS_PATH  = "M12 5v14M5 12h14"

    renders_many :actions, "UI::SpeedDialComponent::ActionComponent"

    # position: :bottom_right (default) | :bottom_left | :bottom_center
    def initialize(position: :bottom_right, **html_attrs)
      @position    = position.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      position_cls = {
        bottom_right:  "fixed bottom-6 right-6",
        bottom_left:   "fixed bottom-6 left-6",
        bottom_center: "fixed bottom-6 left-1/2 -translate-x-1/2"
      }.fetch(@position, "fixed bottom-6 right-6")

      content_tag(:div,
        class: cn("relative", position_cls, @extra_class),
        data: {
          controller: "speed-dial",
          action: "click@document->speed-dial#closeOnClickOutside"
        },
        **@html_attrs) do
        concat action_panel
        concat fab_button
      end
    end

    private

    def fab_button
      content_tag(:button,
        type: "button",
        class: FAB_CLS,
        "aria-expanded": "false",
        "aria-label": "Open actions",
        data: {
          speed_dial_target: "fab",
          action: "click->speed-dial#toggle"
        }) do
        plus_icon
      end
    end

    def action_panel
      content_tag(:div,
        class: PANEL_CLS,
        hidden: true,
        data: { speed_dial_target: "panel" }) do
        safe_join(actions)
      end
    end

    def plus_icon
      content_tag(:svg,
        content_tag(:path, nil, d: PLUS_PATH, "stroke-linecap": "round", "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        "stroke-width": "2",
        class: "size-6 transition-transform duration-200",
        "aria-hidden": "true",
        data: { speed_dial_target: "icon" })
    end

    class ActionComponent < ApplicationComponent
      def initialize(label:, href: nil, icon: nil, **html_attrs)
        @label      = label
        @href       = href
        @icon       = icon
        @html_attrs = html_attrs
      end

      def call
        tag_name = @href ? :a : :button
        attrs    = { class: SpeedDialComponent::ACTION_CLS, **@html_attrs }
        attrs[:href] = @href if @href
        attrs[:type] = "button" if tag_name == :button
        content_tag(tag_name, @label, **attrs)
      end
    end
  end
end
