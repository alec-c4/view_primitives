# frozen_string_literal: true

require_relative "../detector"

module ViewPrimitives
  module Generators
    class AddGenerator < Rails::Generators::Base
      include Detector

      source_root File.expand_path("templates", __dir__)

      argument :components, type: :array

      SUPPORTED_COMPONENTS = %w[button alert accordion].freeze

      def copy_components
        components.each do |component|
          if SUPPORTED_COMPONENTS.include?(component)
            send(:"copy_#{component}")
          else
            say "  Unknown component: #{component}. Supported: #{SUPPORTED_COMPONENTS.join(", ")}", :red
          end
        end
      end

      private

      def copy_button
        template "button/button_component.rb.tt",
          "app/components/ui/button_component.rb"
      end

      def copy_alert
        template "alert/alert_component.rb.tt",
          "app/components/ui/alert_component.rb"
      end

      def copy_accordion
        template "accordion/accordion_component.rb.tt",
          "app/components/ui/accordion_component.rb"
        template "accordion/accordion_item_component.rb.tt",
          "app/components/ui/accordion_item_component.rb"
        copy_file "accordion/accordion_component.html.erb",
          "app/components/ui/accordion_component.html.erb"
        copy_accordion_controller
      end

      def copy_accordion_controller
        dir = js_controllers_dir

        unless dir
          say "  Could not detect a JS controllers directory.", :yellow
          say "  Manually copy accordion_controller.js to your controllers folder", :cyan
          say "  and register it: application.register('accordion', AccordionController)\n", :cyan
          return
        end

        copy_file "accordion/accordion_controller.js", "#{dir}/accordion_controller.js"
      end
    end
  end
end
