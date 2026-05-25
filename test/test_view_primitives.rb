# frozen_string_literal: true

require "test_helper"

class TestViewPrimitives < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ViewPrimitives::VERSION
  end

  def test_error_class_inherits_from_standard_error
    assert_kind_of StandardError, ViewPrimitives::Error.new
  end
end
