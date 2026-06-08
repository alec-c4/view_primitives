# frozen_string_literal: true

module UI
  class ToasterComponent < ApplicationComponent
    # Fixed-position toast stack (Sonner-style).
    # Place once in the application layout; trigger toasts server-side via
    # the renders_many slot or client-side via a `toaster:add` window event.
    #
    # Usage (layout):
    #   ui :toaster do |t|
    #     t.with_toast(message: "Profile saved", variant: :success)
    #   end
    #
    # Usage (JS dispatch from any controller):
    #   window.dispatchEvent(new CustomEvent("toaster:add", {
    #     detail: { message: "Done!", variant: "success", duration: 3000 }
    #   }))

    POSITIONS = {
      bottom_right: "fixed bottom-4 right-4",
      bottom_left: "fixed bottom-4 left-4",
      bottom_center: "fixed bottom-4 left-1/2 -translate-x-1/2",
      top_right: "fixed top-4 right-4",
      top_left: "fixed top-4 left-4",
      top_center: "fixed top-4 left-1/2 -translate-x-1/2"
    }.freeze

    CONTAINER_CLS = "toaster group z-50 flex w-80 flex-col gap-3 pointer-events-none"

    renders_many :toasts, "UI::ToasterComponent::ToastComponent"

    # position: corner to anchor the stack (default: :bottom_right)
    def initialize(position: :bottom_right, **html_attrs)
      @position = position.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      pos_cls = POSITIONS.fetch(@position, POSITIONS[:bottom_right])
      content_tag(:div,
        class: cn(CONTAINER_CLS, pos_cls, @extra_class),
        data: {
          controller: "toaster",
          action: "toaster:add@window->toaster#add"
        },
        **@html_attrs) do
        safe_join(toasts)
      end
    end

    class ToastComponent < ApplicationComponent
      VARIANTS = {
        default: {border: "border-border", icon: nil, icon_color: "text-foreground"},
        success: {
          border: "border-chart-2/40",
          icon: "M9 12l2 2 4-4m6 2a9 9 0 1 1-18 0 9 9 0 0 1 18 0z",
          icon_color: "text-chart-2"
        },
        warning: {
          border: "border-chart-4/40",
          icon: "M12 9v4m0 4h.01M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z",
          icon_color: "text-chart-4"
        },
        destructive: {
          border: "border-destructive/40",
          icon: "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 1 1-18 0 9 9 0 0 1 18 0z",
          icon_color: "text-destructive"
        },
        info: {
          border: "border-border",
          icon: "M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0z",
          icon_color: "text-muted-foreground"
        }
      }.freeze

      TOAST_CLS = "pointer-events-auto flex items-start gap-3 rounded-md #{UI::Styles::BORDER} " \
                  "bg-popover px-4 py-3 text-popover-foreground shadow-md outline-hidden " \
                  "transition-all duration-300 translate-y-2 opacity-0 " \
                  "data-[open=true]:translate-y-0 data-[open=true]:opacity-100"

      CLOSE_CLS = "ml-auto -mr-1 -mt-0.5 shrink-0 inline-flex size-6 items-center justify-center " \
                  "rounded-md text-muted-foreground hover:text-foreground hover:bg-accent " \
                  "#{UI::Styles::FOCUS_RING} outline-hidden transition"

      # message:  toast body (required)
      # title:    optional bold heading
      # variant:  :default | :success | :warning | :destructive | :info
      # duration: auto-dismiss in ms; 0 = no auto-dismiss (default: 4000)
      def initialize(message:, title: nil, variant: :default, duration: 4000, **html_attrs)
        @message = message
        @title = title
        @variant = variant.to_sym
        @duration = duration.to_i
        @extra_class = html_attrs.delete(:class)
        @html_attrs = html_attrs
      end

      def call
        v = VARIANTS.fetch(@variant, VARIANTS[:default])
        content_tag(:div,
          class: cn(TOAST_CLS, v[:border], @extra_class),
          role: "alert",
          "aria-live": "polite",
          "data-open": "false",
          data: {
            toaster_target: "toast",
            toaster_duration_param: @duration
          },
          **@html_attrs) do
          concat icon_svg(v[:icon], v[:icon_color]) if v[:icon]
          concat body
          concat close_btn
        end
      end

      private

      def body
        content_tag(:div, class: "flex-1 min-w-0") do
          concat content_tag(:p, @title, class: "text-sm font-semibold leading-tight") if @title
          concat content_tag(:p, @message,
            class: "text-sm leading-snug#{" text-muted-foreground mt-0.5" if @title}")
        end
      end

      def close_btn
        content_tag(:button, type: "button",
          class: CLOSE_CLS,
          "aria-label": "Dismiss",
          data: {action: "click->toaster#dismiss"}) do
          content_tag(:svg,
            content_tag(:path, nil, d: "M18 6 6 18M6 6l12 12",
              "stroke-linecap": "round", "stroke-linejoin": "round"),
            xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
            fill: "none", stroke: "currentColor", "stroke-width": "2",
            class: "size-3.5", "aria-hidden": "true")
        end
      end

      def icon_svg(path, color_cls)
        content_tag(:svg,
          content_tag(:path, nil, d: path,
            "stroke-linecap": "round", "stroke-linejoin": "round"),
          xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
          fill: "none", stroke: "currentColor", "stroke-width": "2",
          class: "mt-0.5 size-4 shrink-0 #{color_cls}",
          "aria-hidden": "true")
      end
    end
  end
end
