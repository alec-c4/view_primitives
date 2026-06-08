# frozen_string_literal: true

module UI
  class AlertComponent < ApplicationComponent
    OUTER_CLASSES = "relative grid w-full grid-cols-[0_1fr] items-start gap-y-0.5 rounded-lg #{UI::Styles::BORDER} " \
                    "px-4 py-3 text-sm has-[>svg]:grid-cols-[calc(var(--spacing)*4)_1fr] " \
                    "has-[>svg]:gap-x-3 [&>svg]:size-4 [&>svg]:translate-y-0.5 [&>svg]:text-current"

    VARIANTS = {
      default: "bg-card text-card-foreground",
      destructive: "bg-card text-destructive [&>svg]:text-current *:data-[slot=alert-description]:text-destructive/90"
    }.freeze

    renders_one :alert_title, "UI::AlertComponent::TitleComponent"
    renders_one :alert_description, "UI::AlertComponent::DescriptionComponent"

    # title: and description: are kwargs shorthands for plain-text content.
    # Use slots (with_alert_title / with_alert_description) for rich HTML content.
    # Slots take precedence over kwargs when both are provided.
    def initialize(variant: :default, title: nil, description: nil)
      @variant = variant.to_sym
      @title = title
      @description = description
    end

    def call
      content_tag(:div, safe_join([resolved_title, resolved_description].compact),
        role: "alert",
        class: cn(OUTER_CLASSES, VARIANTS.fetch(@variant, VARIANTS[:default])))
    end

    class TitleComponent < ApplicationComponent
      CLASSES = "col-start-2 line-clamp-1 min-h-4 font-medium tracking-tight"

      def call
        content_tag(:h5, content, class: CLASSES)
      end
    end

    class DescriptionComponent < ApplicationComponent
      CLASSES = "col-start-2 grid justify-items-start gap-1 text-sm text-muted-foreground [&_p]:leading-relaxed"

      def call
        content_tag(:div, content, class: CLASSES, data: { slot: "alert-description" })
      end
    end

    private

    def resolved_title
      alert_title || (@title && content_tag(:h5, @title, class: TitleComponent::CLASSES))
    end

    def resolved_description
      return alert_description if alert_description

      @description && content_tag(:div, @description,
        class: DescriptionComponent::CLASSES,
        data: { slot: "alert-description" })
    end
  end
end
