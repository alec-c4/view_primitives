# frozen_string_literal: true

require_relative "../detector"

module ViewPrimitives
  module Generators
    class AddGenerator < Rails::Generators::Base
      include Detector

      source_root File.expand_path("templates", __dir__)

      argument :components, type: :array

      SUPPORTED_COMPONENTS = %w[
        button alert accordion
        badge avatar card separator label skeleton progress aspect_ratio
        spinner kbd rating rating_input indicator list_group banner button_group
        input textarea checkbox radio_group select switch toggle toggle_group form_field
      ].freeze

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
        copy_js_controller "accordion/accordion_controller.js", "accordion"
      end

      def copy_rating_controller
        copy_js_controller "rating_input/rating_controller.js", "rating"
      end

      def copy_js_controller(source, name)
        dir = js_controllers_dir

        unless dir
          say "  Could not detect a JS controllers directory.", :yellow
          say "  Manually copy #{name}_controller.js to your controllers folder", :cyan
          say "  and register it: application.register('#{name}', #{name.capitalize}Controller)\n", :cyan
          return
        end

        copy_file source, "#{dir}/#{name}_controller.js"
      end

      def copy_badge
        template "badge/badge_component.rb.tt",
          "app/components/ui/badge_component.rb"
      end

      def copy_avatar
        template "avatar/avatar_component.rb.tt",
          "app/components/ui/avatar_component.rb"
      end

      def copy_card
        template "card/card_component.rb.tt",
          "app/components/ui/card_component.rb"
        template "card/card_header_component.rb.tt",
          "app/components/ui/card_header_component.rb"
        template "card/card_title_component.rb.tt",
          "app/components/ui/card_title_component.rb"
        template "card/card_description_component.rb.tt",
          "app/components/ui/card_description_component.rb"
        template "card/card_content_component.rb.tt",
          "app/components/ui/card_content_component.rb"
        template "card/card_footer_component.rb.tt",
          "app/components/ui/card_footer_component.rb"
      end

      def copy_separator
        template "separator/separator_component.rb.tt",
          "app/components/ui/separator_component.rb"
      end

      def copy_label
        template "label/label_component.rb.tt",
          "app/components/ui/label_component.rb"
      end

      def copy_skeleton
        template "skeleton/skeleton_component.rb.tt",
          "app/components/ui/skeleton_component.rb"
      end

      def copy_progress
        template "progress/progress_component.rb.tt",
          "app/components/ui/progress_component.rb"
      end

      def copy_aspect_ratio
        template "aspect_ratio/aspect_ratio_component.rb.tt",
          "app/components/ui/aspect_ratio_component.rb"
      end

      def copy_spinner
        template "spinner/spinner_component.rb.tt",
          "app/components/ui/spinner_component.rb"
      end

      def copy_kbd
        template "kbd/kbd_component.rb.tt",
          "app/components/ui/kbd_component.rb"
      end

      def copy_rating
        template "rating/rating_component.rb.tt",
          "app/components/ui/rating_component.rb"
      end

      def copy_rating_input
        template "rating_input/rating_input_component.rb.tt",
          "app/components/ui/rating_input_component.rb"
        copy_rating_controller
      end

      def copy_indicator
        template "indicator/indicator_component.rb.tt",
          "app/components/ui/indicator_component.rb"
      end

      def copy_list_group
        template "list_group/list_group_component.rb.tt",
          "app/components/ui/list_group_component.rb"
        template "list_group/list_group_item_component.rb.tt",
          "app/components/ui/list_group_item_component.rb"
      end

      def copy_banner
        template "banner/banner_component.rb.tt",
          "app/components/ui/banner_component.rb"
      end

      def copy_button_group
        template "button_group/button_group_component.rb.tt",
          "app/components/ui/button_group_component.rb"
      end

      def copy_input
        template "input/input_component.rb.tt",
          "app/components/ui/input_component.rb"
      end

      def copy_textarea
        template "textarea/textarea_component.rb.tt",
          "app/components/ui/textarea_component.rb"
      end

      def copy_checkbox
        template "checkbox/checkbox_component.rb.tt",
          "app/components/ui/checkbox_component.rb"
      end

      def copy_radio_group
        template "radio_group/radio_group_component.rb.tt",
          "app/components/ui/radio_group_component.rb"
      end

      def copy_select
        template "select/select_component.rb.tt",
          "app/components/ui/select_component.rb"
      end

      def copy_switch
        template "switch/switch_component.rb.tt",
          "app/components/ui/switch_component.rb"
      end

      def copy_toggle
        template "toggle/toggle_component.rb.tt",
          "app/components/ui/toggle_component.rb"
      end

      def copy_toggle_group
        template "toggle_group/toggle_group_component.rb.tt",
          "app/components/ui/toggle_group_component.rb"
      end

      def copy_form_field
        template "form_field/form_field_component.rb.tt",
          "app/components/ui/form_field_component.rb"
      end
    end
  end
end
