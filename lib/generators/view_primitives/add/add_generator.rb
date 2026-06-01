# frozen_string_literal: true

require_relative "../components"
require_relative "../detector"

module ViewPrimitives
  module Generators
    class AddGenerator < Rails::Generators::Base
      include Detector

      source_root File.expand_path("templates", __dir__)

      argument :components, type: :array

      def copy_components
        @copied = []
        @unknown = []

        components.each do |name|
          if Components.supported.include?(name)
            copy_component(name)
            @copied << name
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
        abort
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
      end

      no_tasks do
        def template(source, *args, **options, &block)
          destination = args.first || options[:to]
          warn_overwrite(destination) if destination
          super
        end

        def copy_file(source, *args, **options)
          destination = args.first || options[:to]
          warn_overwrite(destination) if destination
          super
        end
      end

      private

      def copy_component(name)
        dir = File.join(self.class.source_root, name)
        Dir.each_child(dir).sort.each { |file| copy_template_file(name, file) }
        copy_extra_stimulus(name)
      end

      def copy_template_file(component, file)
        source = "#{component}/#{file}"

        case file
        when /\.rb\.tt\z/
          template source, "app/components/ui/#{file.delete_suffix(".tt")}"
        when /\.html\.erb\z/
          copy_file source, "app/components/ui/#{file}"
        when /_controller\.js\z/
          copy_js_controller source, file.delete_suffix("_controller.js")
        end
      end

      def copy_extra_stimulus(name)
        config = Components::EXTRA_STIMULUS[name]
        copy_js_controller(config[:source], config[:name]) if config
      end

      def copy_js_controller(source, stimulus_name)
        dir = js_controllers_dir
        unless dir
          say "  Could not detect a JS controllers directory.", :yellow
          say "  Copy #{source} manually and register Stimulus `#{stimulus_name}`.", :cyan
          return
        end

        dest = "#{dir}/#{stimulus_name}_controller.js"
        copy_file source, dest
        say "  Stimulus `#{stimulus_name}` → #{dest}", :green
      end

      def warn_overwrite(destination)
        return unless File.exist?(File.join(destination_root, destination))

        say "  #{destination} already exists — overwriting.", :yellow
      end
    end
  end
end
