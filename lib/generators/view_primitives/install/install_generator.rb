# frozen_string_literal: true

require_relative "../detector"
require_relative "../component_copier"

module ViewPrimitives
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Detector
      include ComponentCopier

      source_root File.expand_path("templates", __dir__)

      class_option :force, type: :boolean, default: false,
        desc: "Overwrite existing ApplicationComponent, UI styles, and CSS files"

      def verify_ui_inflection
        return if "ui/button_component".camelize == "UI::ButtonComponent"

        say "\n  Warning: ActiveSupport inflection for `UI` is not configured.", :yellow
        say "  ViewPrimitives expects `ui/button` to resolve to `UI::ButtonComponent`.", :yellow
        say "  The gem registers this automatically — restart the Rails server if you just installed.\n", :yellow
      end

      def create_application_component
        target = "app/components/application_component.rb"
        exists = File.exist?(File.join(destination_root, target))

        if exists && !options[:force]
          say "  ApplicationComponent already exists. Add `include ViewPrimitives::ClassHelper` and " \
              "`extract_html_attrs` manually, or re-run with --force.", :yellow
        else
          template "application_component.rb.tt", target
        end
      end

      def create_ui_styles
        template "styles.rb.tt", "app/components/ui/styles.rb"
      end

      def create_css_bundle
        copy_file "view_primitives.css", css_dest_path
        directory "view_primitives", "#{css_dest_dir}/view_primitives"
      end

      def inject_css_import
        entry = tailwind_entry_path

        unless entry
          say "\n  Could not detect a Tailwind CSS entry point.", :yellow
          say "  Add this line to your main CSS file:\n"
          say "    @import \"./view_primitives\";\n"
          say "  Common locations: app/assets/tailwind/application.css, " \
              "app/assets/stylesheets/application.tailwind.css, app/javascript/application.css\n", :cyan
          return
        end

        entry_content = File.read(File.join(destination_root, entry))

        if entry_content.include?("view_primitives")
          say "  #{entry} already imports view_primitives — skipping.", :yellow
          return
        end

        import_line = "@import \"#{css_import_path}\";\n"

        anchor = tailwind_import_anchor(entry_content)
        if anchor
          inject_into_file entry, import_line, after: anchor
        else
          append_to_file entry, "\n#{import_line}"
        end
      end
    end
  end
end
