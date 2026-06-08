# frozen_string_literal: true

require_relative "../components"

module ViewPrimitives
  module Generators
    class ListGenerator < Rails::Generators::Base
      desc "List available ViewPrimitives components and whether they are installed"

      def list_components
        say "\nViewPrimitives components:\n\n", :bold
        say "COMPONENT          STATUS"
        say "-" * 32

        Components.supported.each do |component|
          status = Components.installed?(component, destination_root) ? "installed" : "—"
          color = (status == "installed") ? :green : :cyan
          say format("%-18s %s", component, status), color
        end

        say "\nInstall:  rails g view_primitives:add <name>", :cyan
        say "Update:   rails g view_primitives:update", :cyan
        say "Themes:   rails g view_primitives:theme rose\n", :cyan
      end
    end
  end
end
