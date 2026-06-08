# frozen_string_literal: true

require_relative "components"

module ViewPrimitives
  module Generators
    module ComponentCopier
      def self.included(base)
        base.no_tasks do
          define_method(:template) do |source, *args, **options, &blk|
            destination = args.first || options[:to]
            return unless destination.nil? || confirm_overwrite(destination)

            super(source, *args, **options, &blk)
          end

          define_method(:copy_file) do |source, *args, **options|
            destination = args.first || options[:to]
            return unless destination.nil? || confirm_overwrite(destination)

            super(source, *args, **options)
          end
        end
      end

      private

      def copy_component(name)
        dir = File.join(Components::TEMPLATE_ROOT, name)
        unless File.directory?(dir)
          say "  Missing templates for #{name}", :red
          return false
        end

        with_source_root(Components::TEMPLATE_ROOT) do
          Dir.each_child(dir).sort.each { |file| copy_template_file(name, file) }
        end
        copy_extra_stimulus(name)
        true
      end

      def copy_template_file(component, file)
        relative = File.join(component, file)

        case file
        when /\.rb\.tt\z/
          template relative, "app/components/ui/#{file.delete_suffix(".tt")}"
        when /\.html\.erb\z/
          copy_file relative, "app/components/ui/#{file}"
        when /_controller\.js\z/
          copy_js_controller("#{component}/#{file}", file.delete_suffix("_controller.js"))
        end
      end

      def copy_extra_stimulus(name)
        config = Components::EXTRA_STIMULUS[name]
        return unless config

        with_source_root(Components::TEMPLATE_ROOT) do
          copy_js_controller(config[:source], config[:name])
        end
      end

      def copy_js_controller(relative_source, stimulus_name)
        return if stimulus_name.empty?

        dir = js_controllers_dir
        unless dir
          say "  Could not detect a JS controllers directory.", :yellow
          say "  Copy #{relative_source} manually and register Stimulus `#{stimulus_name}`.", :cyan
          return
        end

        dest = "#{dir}/#{stimulus_name}_controller.js"
        copy_file relative_source, dest
        say "  Stimulus `#{stimulus_name}` → #{dest}", :green
      end

      def with_source_root(path)
        already_present = source_paths.include?(path)
        source_paths.unshift(path) unless already_present
        yield
      ensure
        source_paths.delete(path) unless already_present
      end

      def confirm_overwrite(destination)
        return true unless File.exist?(File.join(destination_root, destination))
        return true if options[:force]

        say "  #{destination} already exists.", :yellow
        yes?("  Overwrite? [y/N] ")
      end
    end
  end
end
