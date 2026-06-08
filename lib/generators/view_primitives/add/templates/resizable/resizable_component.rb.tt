# frozen_string_literal: true

module UI
  class ResizableComponent < ApplicationComponent
    # Drag-to-resize panel layout — two panels separated by a draggable handle.
    #
    # Usage:
    #   ui :resizable, direction: :horizontal do |r|
    #     r.with_panel(min: 20, default: 30) { left_content }
    #     r.with_panel { right_content }
    #   end

    WRAPPER_CLS = "group flex w-full overflow-hidden rounded-md #{UI::Styles::BORDER} shadow-xs"

    PANEL_CLS = "h-full w-full min-h-0 min-w-0 overflow-auto"

    HANDLE_GRIP_BASE = "z-10 flex shrink-0 items-center justify-center rounded-xs #{UI::Styles::BORDER} bg-border"

    HANDLE_GRIP_HORIZONTAL = "h-4 w-3"
    HANDLE_GRIP_VERTICAL   = "h-3 w-4"

    HANDLE_HORIZONTAL = "relative flex w-px shrink-0 items-center justify-center bg-border " \
                        "after:absolute after:inset-y-0 after:left-1/2 after:w-1 after:-translate-x-1/2 " \
                        "cursor-col-resize focus-visible:ring-1 focus-visible:ring-ring " \
                        "focus-visible:ring-offset-1 focus-visible:outline-hidden"

    HANDLE_VERTICAL = "relative flex h-px w-full shrink-0 items-center justify-center bg-border " \
                      "after:absolute after:inset-x-0 after:top-1/2 after:h-1 after:w-full after:-translate-y-1/2 " \
                      "cursor-row-resize focus-visible:ring-1 focus-visible:ring-ring " \
                      "focus-visible:ring-offset-1 focus-visible:outline-hidden"

    renders_many :panels, "UI::ResizableComponent::PanelComponent"

    def initialize(direction: :horizontal, **html_attrs)
      @direction   = direction.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      is_row = @direction == :horizontal
      flex_dir = is_row ? "flex-row" : "flex-col"

      content_tag(:div,
        class: cn(WRAPPER_CLS, flex_dir, @extra_class),
        "data-slot": "resizable-panel-group",
        "data-direction": @direction,
        "aria-orientation": @direction == :horizontal ? "horizontal" : "vertical",
        data: {
          controller: "resizable",
          resizable_direction_value: @direction
        },
        **@html_attrs) do
        panels.each_with_index do |panel, i|
          concat panel
          concat handle unless i == panels.size - 1
        end
      end
    end

    private

    def handle
      grip_cls = @direction == :vertical ? HANDLE_GRIP_VERTICAL : HANDLE_GRIP_HORIZONTAL
      handle_cls = @direction == :vertical ? HANDLE_VERTICAL : HANDLE_HORIZONTAL

      content_tag(:div,
        content_tag(:div, nil, class: cn(HANDLE_GRIP_BASE, grip_cls)),
        class: handle_cls,
        "data-slot": "resizable-handle",
        tabindex: "0",
        role: "separator",
        "aria-orientation": @direction == :horizontal ? "vertical" : "horizontal",
        data: {
          resizable_target: "handle",
          action: "mousedown->resizable#startDrag touchstart->resizable#startDrag"
        })
    end

    class PanelComponent < ApplicationComponent
      def initialize(min: 10, max: 90, default: nil, **html_attrs)
        @min     = min
        @max     = max
        @default = default
        @html_attrs = html_attrs
      end

      def call
        style = @default ? "flex: 0 0 #{@default}%" : "flex: 1 1 0%"
        content_tag(:div, content,
          class: ResizableComponent::PANEL_CLS,
          "data-slot": "resizable-panel",
          style: style,
          data: {
            resizable_target: "panel",
            resizable_min_param: @min,
            resizable_max_param: @max
          },
          **@html_attrs)
      end
    end
  end
end
