# frozen_string_literal: true

require_relative "../components"
require_relative "../component_copier"
require_relative "../detector"

module ViewPrimitives
  module Generators
    class UpdateGenerator < Rails::Generators::Base
      include Detector
      include ComponentCopier

      source_root File.expand_path("../install/templates", __dir__)

      desc "Update installed ViewPrimitives components and CSS from the latest gem templates"

      class_option :only, type: :array, desc: "Update only these components (default: all installed)"
      class_option :skip_components, type: :boolean, default: false,
        desc: "Skip component Ruby/JS templates"
      class_option :skip_css, type: :boolean, default: false,
        desc: "Skip view_primitives CSS bundle"
      class_option :skip_styles, type: :boolean, default: false,
        desc: "Skip UI::Styles module"
      class_option :force, type: :boolean, default: false,
        desc: "Overwrite files without prompting"

      def update_components
        return if options[:skip_components]

        names = component_names_to_update
        if names.empty?
          say "  No installed components found. Run `rails g view_primitives:add <name>` first.", :yellow
          return
        end

        @updated = []
        @skipped = []

        names.each do |name|
          unless Components.supported.include?(name)
            @skipped << name
            say "  Unknown component: #{name}", :red
            next
          end

          if copy_component(name)
            @updated << name
          else
            @skipped << name
          end
        end

        report_component_summary
      end

      def update_css_bundle
        return if options[:skip_css]

        copy_file "view_primitives.css", css_dest_path
        directory "view_primitives", "#{css_dest_dir}/view_primitives"
        preserve_optional_theme_imports
        say "  CSS bundle → #{css_dest_dir}/view_primitives/", :green
      end

      def update_ui_styles
        return if options[:skip_styles]

        legacy = "app/components/ui/ui_styles.rb"
        remove_file legacy if File.exist?(File.join(destination_root, legacy))
        template "styles.rb.tt", "app/components/ui/styles.rb"
      end

      def report_usage
        say ""
        say "  Updated ViewPrimitives files from gem templates.", :green
        say "  Custom edits in generated files were overwritten.", :yellow
        say "  Rebuild CSS if Tailwind does not pick up changes automatically.", :cyan
        say ""
      end

      private

      def component_names_to_update
        requested = Array(options[:only]).map(&:to_s).reject(&:empty?)
        return requested if requested.any?

        Components.installed(destination_root)
      end

      def report_component_summary
        say "  Updated components: #{@updated.join(", ")}", :green if @updated&.any?
        say "  Skipped (unknown): #{@skipped.join(", ")}", :red if @skipped&.any?
      end

      def preserve_optional_theme_imports
        entry = File.join(destination_root, css_dest_path)
        return unless File.exist?(entry)

        content = File.read(entry)
        Components.optional_theme_imports.each do |theme|
          import_line = %(@import "./view_primitives/themes/#{theme}.css";)
          next if content.include?(import_line)

          optional = "/* @import \"./view_primitives/themes/#{theme}.css\"; */"
          next unless content.include?(optional)

          inject_into_file css_dest_path, "\n#{import_line}", after: optional
        end
      end
    end
  end
end
