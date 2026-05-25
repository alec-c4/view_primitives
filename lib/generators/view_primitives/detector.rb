# frozen_string_literal: true

module ViewPrimitives
  module Generators
    module Detector
      TAILWIND_ENTRY_CANDIDATES = [
        {path: "app/assets/tailwind/application.css", type: :tailwindcss_rails},
        {path: "app/frontend/entrypoints/application.css", type: :vite_frontend},
        {path: "app/javascript/entrypoints/application.css", type: :vite_javascript},
        {path: "app/javascript/application.css", type: :esbuild}
      ].freeze

      JS_CONTROLLER_CANDIDATES = %w[
        app/javascript/controllers
        app/frontend/controllers
      ].freeze

      private

      def tailwind_entry
        @tailwind_entry ||= TAILWIND_ENTRY_CANDIDATES.find do |c|
          File.exist?(File.join(destination_root, c[:path]))
        end
      end

      def tailwind_entry_path = tailwind_entry&.fetch(:path)
      def tailwind_entry_type = tailwind_entry&.fetch(:type)

      def css_dest_dir
        case tailwind_entry_type
        when :tailwindcss_rails then "app/assets/stylesheets"
        when :vite_frontend then "app/frontend/stylesheets"
        when :vite_javascript,
             :esbuild then "app/javascript/stylesheets"
        else "app/assets/stylesheets"
        end
      end

      def css_dest_path
        "#{css_dest_dir}/view_primitives.css"
      end

      def css_import_path
        return nil unless tailwind_entry_path

        from_dir = Pathname.new(tailwind_entry_path).dirname
        to = Pathname.new("#{css_dest_dir}/view_primitives")
        to.relative_path_from(from_dir).to_s
      end

      def js_controllers_dir
        @js_controllers_dir ||= JS_CONTROLLER_CANDIDATES.find do |dir|
          File.exist?(File.join(destination_root, dir))
        end
      end
    end
  end
end
