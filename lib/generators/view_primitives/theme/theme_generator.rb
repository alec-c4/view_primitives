# frozen_string_literal: true

require_relative "../detector"

module ViewPrimitives
  module Generators
    class ThemeGenerator < Rails::Generators::Base
      include Detector

      source_root File.expand_path("../install/templates", __dir__)

      desc "Install an optional ViewPrimitives color theme (CSS variables preset)"

      argument :name, type: :string, default: "rose", banner: "Theme name (e.g. rose)"

      def copy_theme_file
        source = "view_primitives/themes/#{theme_name}.css"
        dest = "#{css_dest_dir}/view_primitives/themes/#{theme_name}.css"

        unless theme_available?
          say "  Unknown theme: #{theme_name}. Available: #{available_themes.join(", ")}", :red
          abort
        end

        copy_file source, dest
        enable_theme_import
        print_usage
      end

      private

      def theme_name
        name.to_s.downcase
      end

      def theme_available?
        File.exist?(File.join(self.class.source_root, "view_primitives/themes/#{theme_name}.css"))
      end

      def available_themes
        Dir.children(File.join(self.class.source_root, "view_primitives/themes"))
          .grep(/\.css\z/)
          .map { |f| f.delete_suffix(".css") }
          .reject { |t| t == "default" }
          .sort
      end

      def enable_theme_import
        entry = css_dest_path
        import_line = %(@import "./view_primitives/themes/#{theme_name}.css";)
        optional = "/* @import \"./view_primitives/themes/#{theme_name}.css\"; */"

        unless File.exist?(File.join(destination_root, entry))
          say "  #{entry} not found. Run `rails g view_primitives:install` first.", :yellow
          return
        end

        content = File.read(File.join(destination_root, entry))
        return say "  Theme import already present in #{entry}", :yellow if content.include?(import_line)

        if content.include?(optional)
          gsub_file entry, optional, import_line
        else
          append_to_file entry, "\n#{import_line}\n"
        end

        say "  Enabled #{theme_name} theme in #{entry}", :green
      end

      def print_usage
        say ""
        say "  Apply the theme by setting data-theme on your layout root:", :cyan
        say '    <html lang="en" data-theme="' + theme_name + '">', :cyan
        say "  Dark mode still uses the .dark class alongside data-theme.", :cyan
        say ""
      end
    end
  end
end
