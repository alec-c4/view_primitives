# frozen_string_literal: true

require "active_support/core_ext/string/inflections"

module ViewPrimitives
  module ComponentHelper
    # Renders any component by name, resolving the class from the name.
    #
    #   <%= component "button", variant: :outline do %>Click<% end %>
    #   <%= component "ui/button", variant: :outline do %>Click<% end %>
    #   <%= component "admin/stats_card", title: "Revenue" %>
    #
    def component(name, *, **, &)
      render(resolve_component(name).new(*, **), &)
    end

    # Shortcut for components in the Ui:: namespace.
    #
    #   <%= ui "button", variant: :default do %>Click<% end %>
    #   <%= ui "accordion_item", title: "FAQ" do %>Answer<% end %>
    #
    def ui(name, *, **, &)
      component("ui/#{name}", *, **, &)
    end

    private

    def resolve_component(name)
      class_name = "#{name.to_s.camelize}Component"
      class_name.constantize
    rescue NameError
      generator_name = name.to_s.split("/").last
      raise ViewPrimitives::ComponentNotFoundError,
        "Component `#{class_name}` not found. " \
        "Run `rails g view_primitives:add #{generator_name}` to generate it."
    end
  end
end
