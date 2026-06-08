# frozen_string_literal: true

module ViewPrimitives
  class Railtie < Rails::Railtie
    initializer "view_primitives.inflections" do
      ActiveSupport::Inflector.inflections(:en) { |inflect| inflect.acronym "UI" }
    end

    generators do
      %w[install add list update theme].each do |gen|
        require "generators/view_primitives/#{gen}/#{gen}_generator"
      end
    end

    initializer "view_primitives.component_helper" do
      %i[action_view action_mailer].each do |hook|
        ActiveSupport.on_load(hook) { include ViewPrimitives::ComponentHelper }
      end
    end
  end
end
