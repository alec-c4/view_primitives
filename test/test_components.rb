# frozen_string_literal: true

require "test_helper"

# ---------------------------------------------------------------------------
# Minimal stubs — enough to load and instantiate components without Rails
# ---------------------------------------------------------------------------
module ViewComponent
  class Base
    include ViewPrimitives::ClassHelper

    def self.renders_many(name, *) = nil
    def self.renders_one(name, *) = nil
    def initialize(*args, **kwargs, &block) = nil
  end
end

class ApplicationComponent < ViewComponent::Base; end

TEMPLATE_ROOT = File.expand_path(
  "../lib/generators/view_primitives/add/templates", __dir__
)

def load_tt(*parts)
  eval File.read(File.join(TEMPLATE_ROOT, *parts)), TOPLEVEL_BINDING, File.join(*parts) # rubocop:disable Security/Eval
end

# Load Phase 1
load_tt "button/button_component.rb.tt"
load_tt "alert/alert_component.rb.tt"
load_tt "accordion/accordion_component.rb.tt"
load_tt "accordion/accordion_item_component.rb.tt"

# Load Phase 2 — original
load_tt "badge/badge_component.rb.tt"
load_tt "avatar/avatar_component.rb.tt"
load_tt "card/card_component.rb.tt"
load_tt "card/card_header_component.rb.tt"
load_tt "card/card_title_component.rb.tt"
load_tt "card/card_description_component.rb.tt"
load_tt "card/card_content_component.rb.tt"
load_tt "card/card_footer_component.rb.tt"
load_tt "separator/separator_component.rb.tt"
load_tt "label/label_component.rb.tt"
load_tt "skeleton/skeleton_component.rb.tt"
load_tt "progress/progress_component.rb.tt"
load_tt "aspect_ratio/aspect_ratio_component.rb.tt"

# Load Phase 2 — new
load_tt "spinner/spinner_component.rb.tt"
load_tt "kbd/kbd_component.rb.tt"
load_tt "rating/rating_component.rb.tt"
load_tt "indicator/indicator_component.rb.tt"
load_tt "list_group/list_group_component.rb.tt"
load_tt "list_group/list_group_item_component.rb.tt"
load_tt "banner/banner_component.rb.tt"
load_tt "button_group/button_group_component.rb.tt"

# ---------------------------------------------------------------------------

class TestButtonComponent < Minitest::Test
  def test_positional_label
    c = UI::ButtonComponent.new("Save")

    assert_equal "Save", c.instance_variable_get(:@label)
  end

  def test_keyword_label
    c = UI::ButtonComponent.new(label: "Save")

    assert_equal "Save", c.instance_variable_get(:@label)
  end

  def test_default_variant
    c = UI::ButtonComponent.new

    assert_equal :default, c.instance_variable_get(:@variant)
  end

  def test_variant_stored_as_symbol
    c = UI::ButtonComponent.new(variant: "destructive")

    assert_equal :destructive, c.instance_variable_get(:@variant)
  end

  def test_default_size
    c = UI::ButtonComponent.new

    assert_equal :default, c.instance_variable_get(:@size)
  end

  def test_href_sets_tag_to_a
    c = UI::ButtonComponent.new(href: "/path")

    assert_equal :a, c.instance_variable_get(:@tag)
    assert_equal "/path", c.instance_variable_get(:@html_attrs)[:href]
  end

  def test_class_extracted_from_html_attrs
    c = UI::ButtonComponent.new(class: "mt-2")

    assert_equal "mt-2", c.instance_variable_get(:@extra_class)
    refute c.instance_variable_get(:@html_attrs).key?(:class)
  end

  def test_arbitrary_html_attrs_forwarded
    c = UI::ButtonComponent.new(disabled: true)

    assert c.instance_variable_get(:@html_attrs)[:disabled]
  end

  def test_component_classes_default
    c = UI::ButtonComponent.new
    classes = c.send(:component_classes)

    assert_includes classes, "bg-primary"
    assert_includes classes, "h-9"
  end

  def test_component_classes_destructive_variant
    c = UI::ButtonComponent.new(variant: :destructive)

    assert_includes c.send(:component_classes), "bg-destructive"
  end

  def test_component_classes_small_size
    c = UI::ButtonComponent.new(size: :sm)

    assert_includes c.send(:component_classes), "h-8"
  end

  def test_extra_class_appended
    c = UI::ButtonComponent.new(class: "w-full")

    assert_includes c.send(:component_classes), "w-full"
  end
end

class TestAlertComponent < Minitest::Test
  def test_default_variant
    c = UI::AlertComponent.new

    assert_equal :default, c.instance_variable_get(:@variant)
  end

  def test_title_kwarg_stored
    c = UI::AlertComponent.new(title: "Heads up")

    assert_equal "Heads up", c.instance_variable_get(:@title)
  end

  def test_description_kwarg_stored
    c = UI::AlertComponent.new(description: "Something happened.")

    assert_equal "Something happened.", c.instance_variable_get(:@description)
  end

  def test_destructive_variant
    c = UI::AlertComponent.new(variant: :destructive)

    assert_equal :destructive, c.instance_variable_get(:@variant)
  end
end

class TestAccordionComponent < Minitest::Test
  def test_exclusive_defaults_to_false
    c = UI::AccordionComponent.new

    refute c.instance_variable_get(:@exclusive)
  end

  def test_exclusive_true_stored
    c = UI::AccordionComponent.new(exclusive: true)

    assert c.instance_variable_get(:@exclusive)
  end

  def test_items_array_stored
    items = [{title: "Q", content: "A"}]
    c = UI::AccordionComponent.new(items: items)

    assert_equal items, c.instance_variable_get(:@items_data)
  end

  def test_items_nil_becomes_empty_array
    c = UI::AccordionComponent.new

    assert_equal [], c.instance_variable_get(:@items_data)
  end

  def test_wrapper_attrs_empty_when_not_exclusive
    c = UI::AccordionComponent.new

    assert_equal({}, c.send(:wrapper_attrs))
  end

  def test_wrapper_attrs_has_stimulus_data_when_exclusive
    c = UI::AccordionComponent.new(exclusive: true)
    attrs = c.send(:wrapper_attrs)

    assert_equal "accordion", attrs.dig(:data, :controller)
  end
end

class TestBadgeComponent < Minitest::Test
  def test_positional_label
    c = UI::BadgeComponent.new("New")

    assert_equal "New", c.instance_variable_get(:@label)
  end

  def test_default_variant
    c = UI::BadgeComponent.new

    assert_equal :default, c.instance_variable_get(:@variant)
  end

  def test_all_variants_exist
    %i[default secondary destructive outline].each do |variant|
      assert UI::BadgeComponent::VARIANTS.key?(variant), "Missing variant #{variant}"
    end
  end
end

class TestAvatarComponent < Minitest::Test
  def test_src_stored
    c = UI::AvatarComponent.new(src: "/avatar.jpg", alt: "Alice")

    assert_equal "/avatar.jpg", c.instance_variable_get(:@src)
    assert_equal "Alice", c.instance_variable_get(:@alt)
  end

  def test_fallback_stored
    c = UI::AvatarComponent.new(fallback: "Alice Smith")

    assert_equal "Alice Smith", c.instance_variable_get(:@fallback)
  end

  def test_default_size
    c = UI::AvatarComponent.new

    assert_equal :default, c.instance_variable_get(:@size)
  end

  def test_initials_two_words
    c = UI::AvatarComponent.new

    assert_equal "AB", c.send(:initials, "Alice Brown")
  end

  def test_initials_single_word
    c = UI::AvatarComponent.new

    assert_equal "A", c.send(:initials, "Alice")
  end

  def test_initials_more_than_two_words
    c = UI::AvatarComponent.new

    assert_equal "AB", c.send(:initials, "Alice Brown Clark")
  end

  def test_initials_empty_string
    c = UI::AvatarComponent.new

    assert_equal "", c.send(:initials, "")
  end

  def test_initials_nil
    c = UI::AvatarComponent.new

    assert_equal "", c.send(:initials, nil)
  end

  def test_initials_upcased
    c = UI::AvatarComponent.new

    assert_equal "AB", c.send(:initials, "alice brown")
  end
end

class TestCardComponents < Minitest::Test
  def test_card_extracts_class
    c = UI::CardComponent.new(class: "mt-4")

    assert_equal "mt-4", c.instance_variable_get(:@extra_class)
  end

  def test_card_title_positional_text
    c = UI::CardTitleComponent.new("My Project")

    assert_equal "My Project", c.instance_variable_get(:@title)
  end

  def test_card_title_keyword_label
    c = UI::CardTitleComponent.new(label: "My Project")

    assert_equal "My Project", c.instance_variable_get(:@title)
  end

  def test_card_description_positional_text
    c = UI::CardDescriptionComponent.new("Deploy in one click.")

    assert_equal "Deploy in one click.", c.instance_variable_get(:@text)
  end

  def test_card_description_keyword_text
    c = UI::CardDescriptionComponent.new(text: "Deploy in one click.")

    assert_equal "Deploy in one click.", c.instance_variable_get(:@text)
  end
end

class TestSeparatorComponent < Minitest::Test
  def test_default_orientation
    c = UI::SeparatorComponent.new

    assert_equal :horizontal, c.instance_variable_get(:@orientation)
  end

  def test_vertical_orientation
    c = UI::SeparatorComponent.new(orientation: :vertical)

    assert_equal :vertical, c.instance_variable_get(:@orientation)
  end

  def test_decorative_defaults_to_true
    c = UI::SeparatorComponent.new

    assert c.instance_variable_get(:@decorative)
  end
end

class TestLabelComponent < Minitest::Test
  def test_positional_text
    c = UI::LabelComponent.new("Email")

    assert_equal "Email", c.instance_variable_get(:@text)
  end

  def test_for_attribute_stored
    c = UI::LabelComponent.new("Email", for: "email-input")

    assert_equal "email-input", c.instance_variable_get(:@for)
  end

  def test_for_not_in_html_attrs
    c = UI::LabelComponent.new("Email", for: "email-input")

    refute c.instance_variable_get(:@html_attrs).key?(:for)
  end
end

class TestProgressComponent < Minitest::Test
  def test_pct_at_50
    c = UI::ProgressComponent.new(value: 50, max: 100)

    assert_in_delta 50.0, c.instance_variable_get(:@pct)
  end

  def test_pct_clamped_above_100
    c = UI::ProgressComponent.new(value: 150, max: 100)

    assert_in_delta 100.0, c.instance_variable_get(:@pct)
  end

  def test_pct_clamped_below_0
    c = UI::ProgressComponent.new(value: -10, max: 100)

    assert_in_delta 0.0, c.instance_variable_get(:@pct)
  end

  def test_custom_max
    c = UI::ProgressComponent.new(value: 3, max: 10)

    assert_in_delta 30.0, c.instance_variable_get(:@pct)
  end
end

class TestSpinnerComponent < Minitest::Test
  def test_default_size
    c = UI::SpinnerComponent.new

    assert_equal :default, c.instance_variable_get(:@size)
  end

  def test_size_stored_as_symbol
    c = UI::SpinnerComponent.new(size: "lg")

    assert_equal :lg, c.instance_variable_get(:@size)
  end

  def test_all_sizes_defined
    %i[sm default lg].each do |size|
      assert UI::SpinnerComponent::SIZES.key?(size), "Missing size #{size}"
    end
  end
end

class TestKbdComponent < Minitest::Test
  def test_positional_key
    c = UI::KbdComponent.new("⌘")

    assert_equal "⌘", c.instance_variable_get(:@key)
  end

  def test_label_keyword
    c = UI::KbdComponent.new(label: "Enter")

    assert_equal "Enter", c.instance_variable_get(:@key)
  end
end

class TestRatingComponent < Minitest::Test
  def test_filled_count_at_3
    c = UI::RatingComponent.new(value: 3)

    assert_equal 3, c.instance_variable_get(:@filled_count)
  end

  def test_filled_count_rounds_up
    c = UI::RatingComponent.new(value: 3.7)

    assert_equal 4, c.instance_variable_get(:@filled_count)
  end

  def test_value_clamped_above_max
    c = UI::RatingComponent.new(value: 10, max: 5)

    assert_in_delta 5.0, c.instance_variable_get(:@value)
  end

  def test_value_clamped_below_zero
    c = UI::RatingComponent.new(value: -1)

    assert_in_delta 0.0, c.instance_variable_get(:@value)
  end

  def test_default_max
    c = UI::RatingComponent.new

    assert_equal 5, c.instance_variable_get(:@max)
  end

  def test_custom_max
    c = UI::RatingComponent.new(value: 7, max: 10)

    assert_equal 10, c.instance_variable_get(:@max)
    assert_equal 7, c.instance_variable_get(:@filled_count)
  end
end

class TestIndicatorComponent < Minitest::Test
  def test_default_variant
    c = UI::IndicatorComponent.new

    assert_equal :default, c.instance_variable_get(:@variant)
  end

  def test_default_position
    c = UI::IndicatorComponent.new

    assert_equal :top_right, c.instance_variable_get(:@position)
  end

  def test_count_stored
    c = UI::IndicatorComponent.new(count: 9)

    assert_equal 9, c.instance_variable_get(:@count)
  end

  def test_nil_count_by_default
    c = UI::IndicatorComponent.new

    assert_nil c.instance_variable_get(:@count)
  end

  def test_all_variants_defined
    %i[default destructive success warning].each do |v|
      assert UI::IndicatorComponent::VARIANTS.key?(v), "Missing variant #{v}"
    end
  end

  def test_all_positions_defined
    %i[top_right top_left bottom_right bottom_left].each do |p|
      assert UI::IndicatorComponent::POSITIONS.key?(p), "Missing position #{p}"
    end
  end
end

class TestListGroupComponents < Minitest::Test
  def test_list_group_item_positional_label
    c = UI::ListGroupItemComponent.new("Dashboard")

    assert_equal "Dashboard", c.instance_variable_get(:@label)
  end

  def test_list_group_item_href_stored
    c = UI::ListGroupItemComponent.new("Home", href: "/")

    assert_equal "/", c.instance_variable_get(:@href)
  end

  def test_list_group_item_active_flag
    c = UI::ListGroupItemComponent.new("Active", active: true)

    assert_equal :active, c.instance_variable_get(:@variant)
  end

  def test_list_group_item_default_variant
    c = UI::ListGroupItemComponent.new("Item")

    assert_equal :default, c.instance_variable_get(:@variant)
  end

  def test_list_group_item_muted_variant
    c = UI::ListGroupItemComponent.new("Help", variant: :muted)

    assert_equal :muted, c.instance_variable_get(:@variant)
  end
end

class TestBannerComponent < Minitest::Test
  def test_positional_message
    c = UI::BannerComponent.new("We launched!")

    assert_equal "We launched!", c.instance_variable_get(:@message)
  end

  def test_message_keyword
    c = UI::BannerComponent.new(message: "We launched!")

    assert_equal "We launched!", c.instance_variable_get(:@message)
  end

  def test_default_variant
    c = UI::BannerComponent.new

    assert_equal :default, c.instance_variable_get(:@variant)
  end

  def test_all_variants_defined
    %i[default info warning destructive success].each do |v|
      assert UI::BannerComponent::VARIANTS.key?(v), "Missing variant #{v}"
    end
  end
end

class TestButtonGroupComponent < Minitest::Test
  def test_class_extracted
    c = UI::ButtonGroupComponent.new(class: "mt-4")

    assert_equal "mt-4", c.instance_variable_get(:@extra_class)
  end

  def test_html_attrs_forwarded
    c = UI::ButtonGroupComponent.new("aria-label": "Actions")

    assert_equal "Actions", c.instance_variable_get(:@html_attrs)[:"aria-label"]
  end
end
