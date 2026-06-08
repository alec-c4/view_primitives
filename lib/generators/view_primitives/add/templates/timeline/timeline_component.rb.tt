# frozen_string_literal: true

module UI
  class TimelineComponent < ApplicationComponent
    # Vertical timeline of dated events.
    #
    # Usage:
    #   ui :timeline do |t|
    #     t.with_item(date: "Jan 2025", title: "Project started")
    #     t.with_item(date: "Feb 2025", title: "Milestone reached",
    #                 description: "Foundation phase complete", variant: :success)
    #     t.with_item(date: "Mar 2025", title: "Issue detected", variant: :destructive)
    #   end

    renders_many :items, "UI::TimelineComponent::ItemComponent"

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:ol,
        class: cn("relative ml-3 border-l border-border/60", @extra_class),
        data: { slot: "timeline" },
        **@html_attrs) do
        safe_join(items)
      end
    end

    class ItemComponent < ApplicationComponent
      # variant: :default | :success | :warning | :destructive | :muted
      VARIANTS = {
        default: "bg-primary",
        success: "bg-chart-2",
        warning: "bg-chart-4",
        destructive: "bg-destructive",
        muted: "bg-muted-foreground"
      }.freeze

      DOT_CLS = "absolute -left-[7px] mt-1.5 size-3 shrink-0 rounded-full border-2 border-background"
      DATE_CLS = "mb-1 text-xs text-muted-foreground"
      TITLE_CLS = "text-sm font-medium leading-snug text-foreground"
      DESC_CLS = "mt-1 text-sm text-muted-foreground"

      # date:        optional date/time string shown above the title
      # title:       event label (required)
      # description: optional supporting text
      # variant:     dot color — :default, :success, :warning, :destructive, :muted
      def initialize(title:, date: nil, description: nil, variant: :default, **html_attrs)
        @title = title
        @date = date
        @description = description
        @variant = variant.to_sym
        @extra_class = html_attrs.delete(:class)
        @html_attrs = html_attrs
      end

      def call
        content_tag(:li,
          class: cn("mb-10 ml-6 last:mb-0", @extra_class),
          data: { slot: "timeline-item" },
          **@html_attrs) do
          concat dot
          concat content_tag(:time, @date, class: DATE_CLS) if @date
          concat content_tag(:p, @title, class: TITLE_CLS)
          concat content_tag(:p, @description, class: DESC_CLS) if @description
          concat content if content?
        end
      end

      private

      def dot
        color = VARIANTS.fetch(@variant, VARIANTS[:default])
        content_tag(:span, nil, class: cn(DOT_CLS, color), "aria-hidden": "true")
      end
    end
  end
end
