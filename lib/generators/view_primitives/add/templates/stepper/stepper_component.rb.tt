# frozen_string_literal: true

module UI
  class StepperComponent < ApplicationComponent
    # steps: [{ label:, description: (optional), status: :complete | :current | :pending }]
    def initialize(steps:, orientation: :horizontal, **html_attrs)
      @steps = steps
      @orientation = orientation.to_sym
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      wrapper_class = @orientation == :vertical \
        ? "flex flex-col gap-0" \
        : "flex items-start gap-0"

      content_tag(:ol,
        class: cn(wrapper_class, @extra_class),
        "aria-label": "Progress",
        data: { slot: "stepper" },
        **@html_attrs) do
        safe_join(@steps.each_with_index.map { |step, i| step_item(step, i) })
      end
    end

    private

    def step_item(step, index)
      is_last = index == @steps.size - 1
      status  = step.fetch(:status, :pending).to_sym

      if @orientation == :vertical
        vertical_item(step, status, is_last, index)
      else
        horizontal_item(step, status, is_last, index)
      end
    end

    def horizontal_item(step, status, is_last, index)
      content_tag(:li, class: "flex items-center #{is_last ? '' : 'flex-1'}") do
        concat step_circle(status, index + 1)
        concat content_tag(:p, step[:label], class: cn("ml-3 text-sm font-medium whitespace-nowrap", label_color(status))) unless step[:label].nil?
        concat connector(:horizontal, status) unless is_last
      end
    end

    def vertical_item(step, status, is_last, index)
      content_tag(:li, class: "relative flex gap-4") do
        concat content_tag(:div, class: "flex flex-col items-center") {
          concat step_circle(status, index + 1)
          concat connector(:vertical, status) unless is_last
        }
        concat content_tag(:div, class: "min-w-0 pb-8 pt-0.5") {
          concat content_tag(:p, step[:label], class: cn("text-sm font-medium", label_color(status)))
          concat content_tag(:p, step[:description], class: "mt-0.5 text-xs text-muted-foreground") if step[:description]
        }
      end
    end

    def step_circle(status, number)
      base = "flex size-8 shrink-0 items-center justify-center rounded-full border-2 text-xs font-medium transition-colors"
      case status
      when :complete
        content_tag(:span, check_svg,
          class: cn(base, "border-primary bg-primary text-primary-foreground"),
          "aria-label": "Completed")
      when :current
        content_tag(:span, number.to_s,
          class: cn(base, "border-primary bg-background text-primary ring-[3px] ring-ring/50"),
          "aria-current": "step")
      else
        content_tag(:span, number.to_s,
          class: cn(base, "border-border bg-muted text-muted-foreground"),
          "aria-label": "Pending")
      end
    end

    def connector(direction, status)
      filled = status == :complete
      if direction == :horizontal
        content_tag(:div, nil, class: cn("mx-3 h-0.5 min-w-8 flex-1", filled ? "bg-primary" : "bg-border"))
      else
        content_tag(:div, nil, class: cn("my-1 w-0.5 flex-1", filled ? "bg-primary" : "bg-border"))
      end
    end

    def label_color(status)
      case status
      when :complete then "text-foreground"
      when :current  then "text-primary"
      else "text-muted-foreground"
      end
    end

    def check_svg
      raw('<svg xmlns="http://www.w3.org/2000/svg" width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="3" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><polyline points="20 6 9 17 4 12"/></svg>')
    end
  end
end
