# frozen_string_literal: true

require "test_helper"

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
end
