# frozen_string_literal: true

require_relative "view_primitives/version"
require_relative "view_primitives/class_helper"
require_relative "view_primitives/component_helper"

module ViewPrimitives
  class Error < StandardError; end
  class ComponentNotFoundError < Error; end
end

require_relative "view_primitives/railtie" if defined?(Rails::Railtie)
