# frozen_string_literal: true

require "test_helper"

begin
  require "tailwind_merge"
rescue LoadError
  # optional — cn merge test skips when gem is absent
end

class ClassHelperConsumer
  include ViewPrimitives::ClassHelper

  def call_cn(*args)
    cn(*args)
  end
end

class TestClassHelper < Minitest::Test
  def setup
    @subject = ClassHelperConsumer.new
  end

  def test_joins_two_plain_strings
    assert_equal "foo bar", @subject.call_cn("foo", "bar")
  end

  def test_skips_nil_values
    assert_equal "foo bar", @subject.call_cn("foo", nil, "bar")
  end

  def test_flattens_nested_arrays
    assert_equal "foo bar baz", @subject.call_cn(["foo", "bar"], "baz")
  end

  def test_skips_empty_strings
    assert_equal "foo bar", @subject.call_cn("foo", "", "bar")
  end

  def test_returns_empty_string_when_all_inputs_are_blank
    assert_equal "", @subject.call_cn(nil, "", nil)
  end

  def test_handles_single_class
    assert_equal "foo", @subject.call_cn("foo")
  end

  def test_merges_conflicting_tailwind_utilities_when_gem_loaded
    skip "tailwind_merge gem not installed" unless defined?(::TailwindMerge::Merger)

    result = @subject.call_cn("px-2 py-1", "px-4")

    assert_equal "py-1 px-4", result
  end
end
