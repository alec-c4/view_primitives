# frozen_string_literal: true

module ViewPrimitives
  module Generators
    module Detector
      TAILWIND_ENTRIES = [
        {path: "app/assets/tailwind/application.css", stylesheets: "app/assets/stylesheets"},
        {path: "app/assets/stylesheets/application.tailwind.css", stylesheets: "app/assets/stylesheets"},
        {path: "app/assets/builds/tailwind.css", stylesheets: "app/assets/stylesheets"},
        {path: "app/frontend/entrypoints/application.css", stylesheets: "app/frontend/stylesheets"},
        {path: "app/javascript/entrypoints/application.css", stylesheets: "app/javascript/stylesheets"},
        {path: "app/javascript/application.css", stylesheets: "app/javascript/stylesheets"}
      ].freeze

      JS_CONTROLLER_DIRS = %w[app/javascript/controllers app/frontend/controllers].freeze

      private

      def tailwind_entry
        @tailwind_entry ||= TAILWIND_ENTRIES.find do |entry|
          File.exist?(File.join(destination_root, entry[:path]))
        end
      end

      def tailwind_entry_path = tailwind_entry&.fetch(:path)
      def css_dest_dir = tailwind_entry&.fetch(:stylesheets) || "app/assets/stylesheets"
      def css_dest_path = "#{css_dest_dir}/view_primitives.css"

      def css_import_path
        return unless tailwind_entry_path

        Pathname.new("#{css_dest_dir}/view_primitives")
          .relative_path_from(Pathname.new(File.dirname(tailwind_entry_path))).to_s
      end

      def js_controllers_dir
        @js_controllers_dir ||= JS_CONTROLLER_DIRS.find do |dir|
          File.exist?(File.join(destination_root, dir))
        end
      end

      # Returns the exact line (including newline) that inject_into_file should anchor after,
      # or nil if no tailwindcss @import is present. Checks with and without semicolons so
      # the after: anchor always matches what the file actually contains.
      def tailwind_import_anchor(content)
        [
          "@import \"tailwindcss\";\n",
          "@import \"tailwindcss\"\n",
          "@import 'tailwindcss';\n",
          "@import 'tailwindcss'\n"
        ].find { |anchor| content.include?(anchor) }
      end
    end
  end
end
