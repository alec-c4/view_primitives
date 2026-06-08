# frozen_string_literal: true

require_relative "../components"
require_relative "../component_copier"
require_relative "../detector"

module ViewPrimitives
  module Generators
    class AddGenerator < Rails::Generators::Base
      include Detector
      include ComponentCopier

      source_root File.expand_path("templates", __dir__)

      argument :components, type: :array

      class_option :force, type: :boolean, default: false,
        desc: "Overwrite existing files without prompting"

      def copy_components
        @copied = []
        @unknown = []

        components.each do |name|
          if Components.supported.include?(name)
            @copied << name if copy_component(name)
          else
            @unknown << name
            say "  Unknown component: #{name}. Supported: #{Components.supported.join(", ")}", :red
          end
        end
      end

      def report_summary
        say "" if @copied&.any? || @unknown&.any?
        say "  Copied: #{@copied.join(", ")}", :green if @copied&.any?
        return if @unknown.blank?

        say "  Failed: #{@unknown.join(", ")} (unknown)", :red
        say "  Run `rails g view_primitives:list` to see all available components.", :cyan
        @abort_after_notes = true
      end

      def report_setup_notes
        @copied&.each do |name|
          note = Components::SETUP_NOTES[name]
          next unless note

          say ""
          say "  ── Setup required for #{name} ──────────────────────────", :yellow
          note.each_line { |line| say "  #{line.chomp}", :cyan }
          say ""
        end
        abort if @abort_after_notes
      end
    end
  end
end
