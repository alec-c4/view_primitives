# frozen_string_literal: true

module UI
  class ChartComponent < ApplicationComponent
    # Chart wrapper — renders a <canvas> wired to chart_controller.js.
    # chart_controller.js is an adapter for Chart.js; the library itself is
    # NOT bundled — add it to your importmap before use:
    #
    #   # config/importmap.rb
    #   pin "chart.js", to: "https://esm.sh/chart.js@4"
    #
    # Usage:
    #   ui :chart, type: :bar, labels: ["Jan", "Feb", "Mar"],
    #     datasets: [
    #       { label: "Revenue", data: [100, 200, 150] },
    #       { label: "Costs",   data: [80,  140, 110], background_color: "#ef4444" }
    #     ]
    #
    # Options:
    #   type:     :bar | :line | :pie | :doughnut | :radar | :polarArea (default: :bar)
    #   labels:   array of x-axis labels
    #   datasets: array of dataset hashes; snake_case keys are camelized for Chart.js
    #             (e.g. background_color: → backgroundColor:)
    #   options:  hash merged into Chart.js `options` (e.g. { responsive: false })
    #   colors:   optional array overriding default --chart-1…5 palette for datasets

    TYPES = %w[bar line pie doughnut radar polarArea].freeze

    WRAPPER_CLS = "flex aspect-video w-full justify-center text-xs"

    def initialize(type: :bar, labels: [], datasets: [], options: {}, colors: nil, **html_attrs)
      @type = TYPES.include?(type.to_s) ? type.to_s : "bar"
      @labels = labels
      @datasets = datasets
      @chart_options = options
      @colors = colors
      @extra_class = html_attrs.delete(:class)
      @html_attrs = html_attrs
    end

    def call
      content_tag(:div,
        class: cn(WRAPPER_CLS, @extra_class),
        data: { slot: "chart" }) do
        tag.canvas(
          data: {
            controller: "chart",
            chart_type_value: @type,
            chart_config_value: config_json
          },
          **@html_attrs
        )
      end
    end

    private

    def config_json
      ds = @datasets.map { |d| camelize_keys(d).compact }
      payload = {labels: @labels, datasets: ds, options: @chart_options}
      payload[:colors] = @colors if @colors
      payload.to_json
    end

    def camelize_keys(hash)
      hash.transform_keys { |k| k.to_s.camelize(:lower) }
    end
  end
end
