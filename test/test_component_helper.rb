# frozen_string_literal: true

require "test_helper"

class TestComponentHelper < Minitest::Test
  include ViewPrimitives::ComponentHelper

  def render(component, &) = component

  def test_raises_with_class_name_when_component_not_found
    error = assert_raises(ViewPrimitives::ComponentNotFoundError) do
      component("nonexistent")
    end
    assert_match "NonexistentComponent", error.message
  end

  def test_raises_with_generator_hint_when_component_not_found
    error = assert_raises(ViewPrimitives::ComponentNotFoundError) do
      component("nonexistent")
    end
    assert_match "rails g view_primitives:add nonexistent", error.message
  end

  def test_namespaced_component_shows_full_class_name_in_error
    error = assert_raises(ViewPrimitives::ComponentNotFoundError) do
      component("ui/ghost_widget")
    end
    assert_match "UI::GhostWidgetComponent", error.message
  end

  def test_namespaced_component_shows_short_name_in_generator_hint
    error = assert_raises(ViewPrimitives::ComponentNotFoundError) do
      component("ui/ghost_widget")
    end
    assert_match "rails g view_primitives:add ghost_widget", error.message
  end

  def test_ui_shortcut_resolves_to_ui_namespace
    error = assert_raises(ViewPrimitives::ComponentNotFoundError) do
      ui("missing_thing")
    end
    assert_match "UI::MissingThingComponent", error.message
  end

  def test_component_not_found_error_is_a_view_primitives_error
    assert_operator ViewPrimitives::ComponentNotFoundError, :<, ViewPrimitives::Error
  end
end
