# frozen_string_literal: true

module ViewPrimitives
  class Railtie < Rails::Railtie
    initializer "view_primitives.inflections" do
      ActiveSupport::Inflector.inflections(:en) do |inflect|
        inflect.acronym "UI"
      end
    end

    generators do
      require "generators/view_primitives/install/install_generator"
      require "generators/view_primitives/add/add_generator"
    end

    initializer "view_primitives.component_helper" do
      ActiveSupport.on_load(:action_view) do
        include ViewPrimitives::ComponentHelper
      end
    end
  end
end
