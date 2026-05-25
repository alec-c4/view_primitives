# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "view_primitives"

require "active_support/inflector"
ActiveSupport::Inflector.inflections(:en) { |i| i.acronym "UI" }

require "minitest/autorun"
