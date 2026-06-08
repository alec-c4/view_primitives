# frozen_string_literal: true

module UI
  class CarouselComponent < ApplicationComponent
    # Scrollable carousel with prev/next controls and optional dot indicators.
    #
    # Usage:
    #   ui :carousel do |c|
    #     c.with_slide { image_tag "slide1.jpg" }
    #     c.with_slide { image_tag "slide2.jpg" }
    #   end

    CONTENT_CLS = "overflow-hidden"
    TRACK_CLS   = "flex transition-transform duration-300 ease-in-out"
    SLIDE_CLS   = "min-w-0 shrink-0 grow-0 basis-full"

    BTN_BASE    = "absolute top-1/2 z-10 -translate-y-1/2 inline-flex size-8 shrink-0 items-center " \
                  "justify-center rounded-full border border-input bg-background text-sm font-medium shadow-xs " \
                  "transition-all outline-none " \
                  "hover:bg-accent hover:text-accent-foreground " \
                  "#{UI::Styles::FOCUS_RING} " \
                  "disabled:pointer-events-none disabled:opacity-50 " \
                  "dark:border-input dark:bg-input/30 dark:hover:bg-input/50"
    BTN_PREV    = "left-2"
    BTN_NEXT    = "right-2"

    DOTS_CLS    = "mt-4 flex justify-center gap-1.5"
    DOT_CLS     = "size-2 rounded-full bg-muted transition-colors " \
                  "data-[active=true]:bg-primary data-[active=true]:w-4"

    CHEVRON_L   = "m15 18-6-6 6-6"
    CHEVRON_R   = "m9 18 6-6-6-6"

    renders_many :slides

    # loop:        wrap around at the ends (default: true)
    # indicators:  show dot indicators (default: true)
    # autoplay:    interval in ms, 0 to disable (default: 0)
    def initialize(loop: true, indicators: true, autoplay: 0, **html_attrs)
      @loop        = loop
      @indicators  = indicators
      @autoplay    = autoplay.to_i
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("relative", @extra_class),
        role: "region",
        "aria-roledescription": "carousel",
        data: {
          slot: "carousel",
          controller: "carousel",
          carousel_loop_value: @loop,
          carousel_autoplay_value: @autoplay
        },
        **@html_attrs) do
        concat content_tag(:div, track, class: CONTENT_CLS, data: { slot: "carousel-content" })
        concat prev_btn
        concat next_btn
        concat dots if @indicators && slides.size > 1
      end
    end

    private

    def track
      content_tag(:div, class: TRACK_CLS, data: { carousel_target: "track" }) do
        safe_join(slides.map { |s|
          content_tag(:div, s,
            class: SLIDE_CLS,
            role: "group",
            "aria-roledescription": "slide",
            data: { slot: "carousel-item" })
        })
      end
    end

    def prev_btn
      content_tag(:button, type: "button",
        class: cn(BTN_BASE, BTN_PREV),
        "aria-label": "Previous slide",
        data: { slot: "carousel-previous", action: "click->carousel#prev" }) { chevron(CHEVRON_L) }
    end

    def next_btn
      content_tag(:button, type: "button",
        class: cn(BTN_BASE, BTN_NEXT),
        "aria-label": "Next slide",
        data: { slot: "carousel-next", action: "click->carousel#next" }) { chevron(CHEVRON_R) }
    end

    def dots
      content_tag(:div, class: DOTS_CLS, data: { carousel_target: "dots" }) do
        safe_join(slides.each_with_index.map { |_, i|
          content_tag(:button, nil,
            type: "button",
            class: DOT_CLS,
            "aria-label": "Go to slide #{i + 1}",
            "data-active": i.zero?.to_s,
            data: { action: "click->carousel#goTo", carousel_index_param: i })
        })
      end
    end

    def chevron(path)
      content_tag(:svg,
        content_tag(:path, nil, d: path, "stroke-linecap": "round", "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
        fill: "none", stroke: "currentColor", "stroke-width": "2",
        class: "size-4", "aria-hidden": "true")
    end
  end
end
