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

# Load Phase 3
load_tt "input/input_component.rb.tt"
load_tt "textarea/textarea_component.rb.tt"
load_tt "checkbox/checkbox_component.rb.tt"
load_tt "radio_group/radio_group_component.rb.tt"
load_tt "select/select_component.rb.tt"
load_tt "switch/switch_component.rb.tt"
load_tt "toggle/toggle_component.rb.tt"
load_tt "toggle_group/toggle_group_component.rb.tt"
load_tt "form_field/form_field_component.rb.tt"

# Load Phase 4
load_tt "breadcrumb/breadcrumb_component.rb.tt"
load_tt "pagination/pagination_component.rb.tt"
load_tt "stepper/stepper_component.rb.tt"
load_tt "bottom_nav/bottom_nav_component.rb.tt"
load_tt "footer/footer_component.rb.tt"
load_tt "tabs/tabs_component.rb.tt"
load_tt "tabs/tabs_item_component.rb.tt"
load_tt "navbar/navbar_component.rb.tt"

# Load Phase 2 — new
load_tt "rating_input/rating_input_component.rb.tt"
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

class TestInputComponent < Minitest::Test
  def test_default_type
    c = UI::InputComponent.new

    assert_equal "text", c.instance_variable_get(:@type)
  end

  def test_custom_type
    c = UI::InputComponent.new(type: "email")

    assert_equal "email", c.instance_variable_get(:@type)
  end

  def test_class_extracted
    c = UI::InputComponent.new(class: "w-full")

    assert_equal "w-full", c.instance_variable_get(:@extra_class)
    refute c.instance_variable_get(:@html_attrs).key?(:class)
  end

  def test_html_attrs_forwarded
    c = UI::InputComponent.new(placeholder: "Email", disabled: true)

    assert_equal "Email", c.instance_variable_get(:@html_attrs)[:placeholder]
    assert c.instance_variable_get(:@html_attrs)[:disabled]
  end
end

class TestTextareaComponent < Minitest::Test
  def test_class_extracted
    c = UI::TextareaComponent.new(class: "min-h-[160px]")

    assert_equal "min-h-[160px]", c.instance_variable_get(:@extra_class)
  end

  def test_html_attrs_forwarded
    c = UI::TextareaComponent.new(placeholder: "Write...", rows: 5)

    assert_equal "Write...", c.instance_variable_get(:@html_attrs)[:placeholder]
    assert_equal 5, c.instance_variable_get(:@html_attrs)[:rows]
  end
end

class TestCheckboxComponent < Minitest::Test
  def test_label_stored
    c = UI::CheckboxComponent.new(label: "Accept terms")

    assert_equal "Accept terms", c.instance_variable_get(:@label)
  end

  def test_checked_defaults_to_false
    c = UI::CheckboxComponent.new

    refute c.instance_variable_get(:@checked)
  end

  def test_checked_stored
    c = UI::CheckboxComponent.new(checked: true)

    assert c.instance_variable_get(:@checked)
  end

  def test_id_derived_from_name
    c = UI::CheckboxComponent.new(name: "user[terms]")

    assert_equal "user_terms_", c.instance_variable_get(:@id)
  end

  def test_explicit_id_takes_precedence
    c = UI::CheckboxComponent.new(id: "my-checkbox", name: "terms")

    assert_equal "my-checkbox", c.instance_variable_get(:@id)
  end
end

class TestRadioGroupComponent < Minitest::Test
  def test_name_stored
    c = UI::RadioGroupComponent.new(name: "plan")

    assert_equal "plan", c.instance_variable_get(:@name)
  end

  def test_items_stored
    items = [{value: "free", label: "Free"}, {value: "pro", label: "Pro"}]
    c = UI::RadioGroupComponent.new(name: "plan", items: items)

    assert_equal items, c.instance_variable_get(:@items)
  end

  def test_items_defaults_to_empty_array
    c = UI::RadioGroupComponent.new(name: "plan")

    assert_equal [], c.instance_variable_get(:@items)
  end
end

class TestSelectComponent < Minitest::Test
  def test_options_stored
    c = UI::SelectComponent.new(options: %w[a b c])

    assert_equal %w[a b c], c.instance_variable_get(:@options)
  end

  def test_selected_stored
    c = UI::SelectComponent.new(selected: "b")

    assert_equal "b", c.instance_variable_get(:@selected)
  end

  def test_include_blank_defaults_to_false
    c = UI::SelectComponent.new

    refute c.instance_variable_get(:@include_blank)
  end

  def test_normalized_options_from_strings
    c = UI::SelectComponent.new(options: %w[Apple Banana])
    normalized = c.send(:normalized_options)

    assert_equal [["Apple", "Apple"], ["Banana", "Banana"]], normalized
  end

  def test_normalized_options_from_pairs
    c = UI::SelectComponent.new(options: [["us", "United States"], ["gb", "United Kingdom"]])
    normalized = c.send(:normalized_options)

    assert_equal [["us", "United States"], ["gb", "United Kingdom"]], normalized
  end

  def test_normalized_options_from_hash
    c = UI::SelectComponent.new(options: {us: "United States", gb: "United Kingdom"})
    normalized = c.send(:normalized_options)

    assert_equal 2, normalized.size
  end
end

class TestSwitchComponent < Minitest::Test
  def test_label_stored
    c = UI::SwitchComponent.new(label: "Dark mode")

    assert_equal "Dark mode", c.instance_variable_get(:@label)
  end

  def test_checked_defaults_to_false
    c = UI::SwitchComponent.new

    refute c.instance_variable_get(:@checked)
  end

  def test_id_derived_from_name
    c = UI::SwitchComponent.new(name: "dark_mode")

    assert_equal "dark_mode", c.instance_variable_get(:@id)
  end
end

class TestToggleComponent < Minitest::Test
  def test_positional_label
    c = UI::ToggleComponent.new("Bold")

    assert_equal "Bold", c.instance_variable_get(:@label)
  end

  def test_pressed_defaults_to_false
    c = UI::ToggleComponent.new

    refute c.instance_variable_get(:@pressed)
  end

  def test_pressed_stored
    c = UI::ToggleComponent.new(pressed: true)

    assert c.instance_variable_get(:@pressed)
  end

  def test_default_size
    c = UI::ToggleComponent.new

    assert_equal :default, c.instance_variable_get(:@size)
  end

  def test_all_sizes_defined
    %i[default sm lg].each do |size|
      assert UI::ToggleComponent::SIZES.key?(size), "Missing size #{size}"
    end
  end

  def test_value_stored
    c = UI::ToggleComponent.new(value: "bold")

    assert_equal "bold", c.instance_variable_get(:@value)
  end
end

class TestToggleGroupComponent < Minitest::Test
  def test_default_type
    c = UI::ToggleGroupComponent.new

    assert_equal :single, c.instance_variable_get(:@type)
  end

  def test_type_stored_as_symbol
    c = UI::ToggleGroupComponent.new(type: "multiple")

    assert_equal :multiple, c.instance_variable_get(:@type)
  end

  def test_single_value_normalized_to_array
    c = UI::ToggleGroupComponent.new(value: "bold")

    assert_equal ["bold"], c.instance_variable_get(:@value)
  end

  def test_array_value_stored
    c = UI::ToggleGroupComponent.new(value: %w[bold underline])

    assert_equal %w[bold underline], c.instance_variable_get(:@value)
  end

  def test_nil_value_becomes_empty_array
    c = UI::ToggleGroupComponent.new

    assert_equal [], c.instance_variable_get(:@value)
  end

  def test_item_pressed_true_when_in_value
    c = UI::ToggleGroupComponent.new(value: "bold")

    assert c.item_pressed?("bold")
  end

  def test_item_pressed_false_when_not_in_value
    c = UI::ToggleGroupComponent.new(value: "bold")

    refute c.item_pressed?("italic")
  end
end

class TestFormFieldComponent < Minitest::Test
  def test_label_stored
    c = UI::FormFieldComponent.new(label: "Email")

    assert_equal "Email", c.instance_variable_get(:@label)
  end

  def test_hint_stored
    c = UI::FormFieldComponent.new(hint: "Letters only")

    assert_equal "Letters only", c.instance_variable_get(:@hint)
  end

  def test_error_stored
    c = UI::FormFieldComponent.new(error: "is required")

    assert_equal "is required", c.instance_variable_get(:@error)
  end

  def test_required_defaults_to_false
    c = UI::FormFieldComponent.new

    refute c.instance_variable_get(:@required)
  end

  def test_required_stored
    c = UI::FormFieldComponent.new(required: true)

    assert c.instance_variable_get(:@required)
  end
end

class TestRatingInputComponent < Minitest::Test
  def test_value_stored
    c = UI::RatingInputComponent.new(value: 3)

    assert_equal 3, c.instance_variable_get(:@value)
  end

  def test_value_clamped_above_max
    c = UI::RatingInputComponent.new(value: 10, max: 5)

    assert_equal 5, c.instance_variable_get(:@value)
  end

  def test_value_clamped_below_zero
    c = UI::RatingInputComponent.new(value: -1)

    assert_equal 0, c.instance_variable_get(:@value)
  end

  def test_value_is_integer
    c = UI::RatingInputComponent.new(value: 3.9)

    assert_equal 3, c.instance_variable_get(:@value)
  end

  def test_default_max
    c = UI::RatingInputComponent.new

    assert_equal 5, c.instance_variable_get(:@max)
  end

  def test_name_stored
    c = UI::RatingInputComponent.new(name: "review[rating]")

    assert_equal "review[rating]", c.instance_variable_get(:@name)
  end

  def test_name_nil_by_default
    c = UI::RatingInputComponent.new

    assert_nil c.instance_variable_get(:@name)
  end

  def test_url_stored
    c = UI::RatingInputComponent.new(url: "/posts/1/rate")

    assert_equal "/posts/1/rate", c.instance_variable_get(:@url)
  end

  def test_url_nil_by_default
    c = UI::RatingInputComponent.new

    assert_nil c.instance_variable_get(:@url)
  end

  def test_controller_data_always_includes_value
    c = UI::RatingInputComponent.new(value: 4)
    data = c.send(:controller_data)

    assert_equal "rating", data[:controller]
    assert_equal 4, data[:rating_value_value]
  end

  def test_controller_data_excludes_url_when_nil
    c = UI::RatingInputComponent.new
    data = c.send(:controller_data)

    refute data.key?(:rating_url_value)
  end

  def test_controller_data_includes_url_when_set
    c = UI::RatingInputComponent.new(url: "/rate")
    data = c.send(:controller_data)

    assert_equal "/rate", data[:rating_url_value]
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

# ---------------------------------------------------------------------------
# Phase 4 — Navigation
# ---------------------------------------------------------------------------

class TestBreadcrumbComponent < Minitest::Test
  def test_default_separator
    c = UI::BreadcrumbComponent.new

    assert_equal "/", c.instance_variable_get(:@separator)
  end

  def test_custom_separator
    c = UI::BreadcrumbComponent.new(separator: "›")

    assert_equal "›", c.instance_variable_get(:@separator)
  end

  def test_items_stored
    items = [{label: "Home", href: "/"}, {label: "Products"}]
    c = UI::BreadcrumbComponent.new(items: items)

    assert_equal 2, c.instance_variable_get(:@items).size
  end

  def test_empty_items_default
    c = UI::BreadcrumbComponent.new

    assert_equal [], c.instance_variable_get(:@items)
  end

  def test_class_extracted
    c = UI::BreadcrumbComponent.new(class: "mt-2")

    assert_equal "mt-2", c.instance_variable_get(:@extra_class)
  end
end

class TestPaginationComponent < Minitest::Test
  def test_stores_current_page
    c = UI::PaginationComponent.new(current_page: 3, total_pages: 10, url: ->(p) { "/posts?page=#{p}" })

    assert_equal 3, c.instance_variable_get(:@current)
  end

  def test_stores_total_pages
    c = UI::PaginationComponent.new(current_page: 1, total_pages: 5, url: ->(p) { p.to_s })

    assert_equal 5, c.instance_variable_get(:@total)
  end

  def test_default_window
    c = UI::PaginationComponent.new(current_page: 1, total_pages: 10, url: ->(p) { p.to_s })

    assert_equal 2, c.instance_variable_get(:@window)
  end

  def test_custom_window
    c = UI::PaginationComponent.new(current_page: 1, total_pages: 10, url: ->(p) { p.to_s }, window: 3)

    assert_equal 3, c.instance_variable_get(:@window)
  end

  def test_pages_all_when_small_range
    c = UI::PaginationComponent.new(current_page: 3, total_pages: 5, url: ->(p) { p.to_s })
    pages = c.send(:pages)

    assert_equal [1, 2, 3, 4, 5], pages
  end

  def test_pages_includes_ellipsis_when_large_range
    c = UI::PaginationComponent.new(current_page: 6, total_pages: 20, url: ->(p) { p.to_s })
    pages = c.send(:pages)

    assert_includes pages, :ellipsis
  end

  def test_pages_always_includes_first_and_last
    c = UI::PaginationComponent.new(current_page: 10, total_pages: 20, url: ->(p) { p.to_s })
    pages = c.send(:pages)

    assert_equal 1, pages.first
    assert_equal 20, pages.last
  end
end

class TestStepperComponent < Minitest::Test
  def test_default_orientation_is_horizontal
    c = UI::StepperComponent.new(steps: [])

    assert_equal :horizontal, c.instance_variable_get(:@orientation)
  end

  def test_vertical_orientation
    c = UI::StepperComponent.new(steps: [], orientation: :vertical)

    assert_equal :vertical, c.instance_variable_get(:@orientation)
  end

  def test_string_orientation_coerced_to_symbol
    c = UI::StepperComponent.new(steps: [], orientation: "vertical")

    assert_equal :vertical, c.instance_variable_get(:@orientation)
  end

  def test_steps_stored
    steps = [{label: "One", status: :complete}, {label: "Two", status: :current}]
    c = UI::StepperComponent.new(steps: steps)

    assert_equal 2, c.instance_variable_get(:@steps).size
  end

  def test_class_extracted
    c = UI::StepperComponent.new(steps: [], class: "my-8")

    assert_equal "my-8", c.instance_variable_get(:@extra_class)
  end
end

class TestBottomNavComponent < Minitest::Test
  def test_items_stored
    items = [{label: "Home", href: "/"}, {label: "Search", href: "/search"}]
    c = UI::BottomNavComponent.new(items: items)

    assert_equal 2, c.instance_variable_get(:@items).size
  end

  def test_empty_items_default
    c = UI::BottomNavComponent.new

    assert_equal [], c.instance_variable_get(:@items)
  end

  def test_class_extracted
    c = UI::BottomNavComponent.new(class: "shadow-lg")

    assert_equal "shadow-lg", c.instance_variable_get(:@extra_class)
  end
end

class TestFooterComponent < Minitest::Test
  def test_copyright_stored
    c = UI::FooterComponent.new(copyright: "© 2026 Acme")

    assert_equal "© 2026 Acme", c.instance_variable_get(:@copyright)
  end

  def test_copyright_nil_by_default
    c = UI::FooterComponent.new

    assert_nil c.instance_variable_get(:@copyright)
  end

  def test_columns_stored
    cols = [{title: "Product", links: []}]
    c = UI::FooterComponent.new(columns: cols)

    assert_equal 1, c.instance_variable_get(:@columns).size
  end

  def test_empty_columns_default
    c = UI::FooterComponent.new

    assert_equal [], c.instance_variable_get(:@columns)
  end

  def test_class_extracted
    c = UI::FooterComponent.new(class: "bg-muted")

    assert_equal "bg-muted", c.instance_variable_get(:@extra_class)
  end
end

class TestTabsComponent < Minitest::Test
  def test_items_data_from_array
    c = UI::TabsComponent.new(items: [{title: "A", content: "a"}])

    assert_equal 1, c.instance_variable_get(:@items_data).size
  end

  def test_nil_items_becomes_empty_array
    c = UI::TabsComponent.new

    assert_equal [], c.instance_variable_get(:@items_data)
  end

  def test_default_index
    c = UI::TabsComponent.new

    assert_equal 0, c.instance_variable_get(:@default_index)
  end

  def test_custom_default_index
    c = UI::TabsComponent.new(default_index: 2)

    assert_equal 2, c.instance_variable_get(:@default_index)
  end

  def test_string_index_coerced_to_int
    c = UI::TabsComponent.new(default_index: "1")

    assert_equal 1, c.instance_variable_get(:@default_index)
  end

  def test_class_extracted
    c = UI::TabsComponent.new(class: "rounded-lg")

    assert_equal "rounded-lg", c.instance_variable_get(:@extra_class)
  end
end

class TestTabsItemComponent < Minitest::Test
  def test_title_stored_and_accessible
    c = UI::TabsItemComponent.new(title: "Settings")

    assert_equal "Settings", c.title
  end
end

class TestNavbarComponent < Minitest::Test
  def test_brand_stored
    c = UI::NavbarComponent.new(brand: "Acme")

    assert_equal "Acme", c.instance_variable_get(:@brand)
  end

  def test_default_brand_href
    c = UI::NavbarComponent.new

    assert_equal "/", c.instance_variable_get(:@brand_href)
  end

  def test_custom_brand_href
    c = UI::NavbarComponent.new(brand_href: "/home")

    assert_equal "/home", c.instance_variable_get(:@brand_href)
  end

  def test_items_stored
    items = [{label: "Home", href: "/"}]
    c = UI::NavbarComponent.new(items: items)

    assert_equal 1, c.instance_variable_get(:@items).size
  end

  def test_empty_items_default
    c = UI::NavbarComponent.new

    assert_equal [], c.instance_variable_get(:@items)
  end

  def test_class_extracted
    c = UI::NavbarComponent.new(class: "border-none")

    assert_equal "border-none", c.instance_variable_get(:@extra_class)
  end

  def test_html_attrs_forwarded
    c = UI::NavbarComponent.new("data-testid": "main-nav")

    assert_equal "main-nav", c.instance_variable_get(:@html_attrs)[:"data-testid"]
  end
end
