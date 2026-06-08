# frozen_string_literal: true

module UI
  class DeviceMockupComponent < ApplicationComponent
    # Shell holds aspect ratio and hardware controls; bezel clips the screen inset.
    PHONE_SHELL = "relative mx-auto w-full max-w-[280px] aspect-[393/852]"

    PHONE_BEZEL = "absolute inset-0 overflow-hidden rounded-[3rem] bg-gradient-to-b from-zinc-600 via-zinc-800 to-zinc-900 " \
                 "shadow-[0_25px_50px_-12px_rgba(0,0,0,0.5)] ring-1 ring-inset ring-white/15"

    PHONE_SCREEN = "absolute inset-[10px] flex flex-col overflow-hidden rounded-[2.45rem] bg-black"

    DYNAMIC_ISLAND = "pointer-events-none absolute left-1/2 top-[10px] z-20 h-[26px] w-[92px] " \
                     "-translate-x-1/2 rounded-full bg-zinc-950 " \
                     "shadow-[0_0_0_1px_rgba(255,255,255,0.14),inset_0_1px_0_rgba(255,255,255,0.08)]"

    HOME_INDICATOR = "pointer-events-none absolute bottom-[7px] left-1/2 z-20 h-1 w-[112px] " \
                     "-translate-x-1/2 rounded-full bg-white/40"

    PHONE_BUTTONS = [
      "pointer-events-none absolute -left-px top-[24%] z-30 h-7 w-[3px] rounded-l-sm bg-zinc-500/90",
      "pointer-events-none absolute -left-px top-[31%] z-30 h-11 w-[3px] rounded-l-sm bg-zinc-500/90",
      "pointer-events-none absolute -left-px top-[40%] z-30 h-11 w-[3px] rounded-l-sm bg-zinc-500/90",
      "pointer-events-none absolute -right-px top-[33%] z-30 h-14 w-[3px] rounded-r-sm bg-zinc-500/90"
    ].freeze

    TABLET_SHELL = "relative mx-auto w-full max-w-[640px] aspect-[3/2]"

    TABLET_BEZEL = "absolute inset-0 overflow-hidden rounded-[1.5rem] bg-gradient-to-b from-zinc-600 via-zinc-800 to-zinc-900 " \
                 "shadow-[0_25px_50px_-12px_rgba(0,0,0,0.5)] ring-1 ring-inset ring-white/15"

    TABLET_SCREEN = "absolute inset-3 flex flex-col overflow-hidden rounded-[0.85rem] bg-black"

    TABLET_CAMERA = "pointer-events-none absolute left-1/2 top-[6px] z-30 size-[7px] " \
                    "-translate-x-1/2 rounded-full bg-zinc-950 " \
                    "shadow-[0_0_0_1px_rgba(255,255,255,0.1),inset_0_0_2px_rgba(0,0,0,0.9)]"

    SCREEN_CONTENT = "relative flex min-h-0 flex-1 flex-col"

    VARIANTS = {
      phone: {
        shell:         PHONE_SHELL,
        bezel:         PHONE_BEZEL,
        screen:        PHONE_SCREEN,
        side_controls: PHONE_BUTTONS,
        overlays:      [DYNAMIC_ISLAND, HOME_INDICATOR]
      },
      browser: {
        outer:  "relative mx-auto flex w-full max-w-3xl flex-col overflow-hidden rounded-lg " \
                "#{UI::Styles::BORDER} bg-background shadow-md",
        bar:    "flex h-10 shrink-0 items-center gap-2 border-b border-border bg-muted/50 px-4",
        dots:   "flex gap-1.5",
        screen: "relative w-full min-h-48 overflow-hidden bg-background"
      },
      tablet: {
        shell:          TABLET_SHELL,
        bezel:          TABLET_BEZEL,
        screen:         TABLET_SCREEN,
        bezel_overlays: [TABLET_CAMERA],
        overlays:       [HOME_INDICATOR]
      }
    }.freeze

    # variant: :phone (default) | :browser | :tablet
    # url:     address bar text for :browser variant
    def initialize(variant: :phone, url: nil, **html_attrs)
      @variant = variant.to_sym
      @url     = url
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      cfg = VARIANTS.fetch(@variant, VARIANTS[:phone])

      if @variant == :browser
        browser_mockup(cfg)
      else
        device_mockup(cfg)
      end
    end

    private

    def device_mockup(cfg)
      content_tag(:div, class: cn(cfg[:shell], @extra_class), **@html_attrs) do
        render_side_controls(cfg)
        concat(content_tag(:div, class: cfg[:bezel]) do
          render_bezel_overlays(cfg)
          concat device_screen(cfg)
        end)
      end
    end

    def browser_mockup(cfg)
      content_tag(:div, class: cn(cfg[:outer], @extra_class), **@html_attrs) do
        concat browser_bar(cfg)
        concat content_tag(:div, content, class: cfg[:screen])
      end
    end

    def render_side_controls(cfg)
      Array(cfg[:side_controls]).each do |cls|
        concat content_tag(:div, nil, class: cls, role: "presentation")
      end
    end

    def render_bezel_overlays(cfg)
      Array(cfg[:bezel_overlays]).each do |cls|
        concat content_tag(:div, nil, class: cls, role: "presentation")
      end
    end

    def device_screen(cfg)
      content_tag(:div, class: cfg[:screen]) do
        Array(cfg[:overlays]).each do |cls|
          concat content_tag(:div, nil, class: cls, role: "presentation")
        end
        concat content_tag(:div, class: SCREEN_CONTENT) { concat content }
      end
    end

    def browser_bar(cfg)
      content_tag(:div, class: cfg[:bar]) do
        concat(content_tag(:div, class: cfg[:dots]) {
          %w[bg-[#FF5F57] bg-[#FFBD2E] bg-[#28CA42]].each do |color|
            concat content_tag(:div, nil, class: "size-3 rounded-full #{color}")
          end
        })
        if @url
          concat content_tag(:div, @url,
            class: "ml-4 flex-1 truncate rounded-md border border-input bg-transparent px-3 py-1 " \
                   "text-xs text-muted-foreground shadow-xs dark:bg-input/30")
        end
      end
    end
  end
end
