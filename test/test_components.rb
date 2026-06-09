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

    def content = ""
  end
end

class ApplicationComponent < ViewComponent::Base
  private

  def extract_html_attrs(**html_attrs)
    @extra_class = html_attrs.delete(:class)
    @html_attrs = html_attrs
  end
end

module UI
  module Styles
    FOCUS_RING = "vp-focus-ring"
    PEER_FOCUS_RING = "vp-peer-focus-ring"
    BORDER = "vp-border"
    INPUT = "vp-input"
    TEXTAREA = "vp-textarea"
    OVERLAY = "vp-overlay"
    POPOVER_PANEL = "vp-popover-panel"
    MENU_ITEM = "vp-menu-item"
    MENU_SEPARATOR = "block -mx-1 my-1 h-px shrink-0 border-0 bg-border"
    SELECT = "vp-select"
    FIELD_PANEL = "rounded-md border border-input bg-background shadow-xs"
    PICKER_TRIGGER = "inline-flex h-9 shrink-0 cursor-pointer items-center justify-start gap-2 " \
                     "rounded-md border border-input bg-background px-4 py-2 text-left text-sm font-normal shadow-xs " \
                     "transition-all outline-none hover:bg-accent hover:text-accent-foreground " \
                     "#{FOCUS_RING} dark:bg-input/30 dark:hover:bg-input/50 " \
                     "aria-expanded:border-ring has-[>svg]:px-3"
  end
end

TEMPLATE_ROOT = File.expand_path(
  "../lib/generators/view_primitives/add/templates", __dir__
)

def load_tt(*parts)
  eval File.read(File.join(TEMPLATE_ROOT, *parts)), TOPLEVEL_BINDING, File.join(*parts) # rubocop:disable Security/Eval
end

Dir.glob(File.join(TEMPLATE_ROOT, "**", "*_component.rb.tt")).sort.each do |path|
  relative = Pathname.new(path).relative_path_from(Pathname.new(TEMPLATE_ROOT)).to_s
  load_tt(*relative.split("/"))
end

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

  def test_call_sets_type_button_by_default
    c = UI::ButtonComponent.new("Save")
    captured = {}

    c.define_singleton_method(:content_tag) do |_tag, _body, **attrs|
      captured.replace(attrs)
      ""
    end

    c.call

    assert_equal "button", captured[:type]
  end

  def test_call_preserves_explicit_type
    c = UI::ButtonComponent.new("Submit", type: "submit")
    captured = {}

    c.define_singleton_method(:content_tag) do |_tag, _body, **attrs|
      captured.replace(attrs)
      ""
    end

    c.call

    assert_equal "submit", captured[:type]
  end

  def test_call_does_not_set_type_on_link
    c = UI::ButtonComponent.new("Home", href: "/")
    captured = {}

    c.define_singleton_method(:content_tag) do |_tag, _body, **attrs|
      captured.replace(attrs)
      ""
    end

    c.call

    refute captured.key?(:type)
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

# ---------------------------------------------------------------------------
# Phase 5 — Overlays
# ---------------------------------------------------------------------------

class TestDialogComponent < Minitest::Test
  def test_title_stored
    c = UI::DialogComponent.new(title: "Edit Profile")

    assert_equal "Edit Profile", c.instance_variable_get(:@title)
  end

  def test_description_stored
    c = UI::DialogComponent.new(description: "Make changes here.")

    assert_equal "Make changes here.", c.instance_variable_get(:@description)
  end

  def test_nil_title_default
    c = UI::DialogComponent.new

    assert_nil c.instance_variable_get(:@title)
  end

  def test_nil_description_default
    c = UI::DialogComponent.new

    assert_nil c.instance_variable_get(:@description)
  end

  def test_class_extracted
    c = UI::DialogComponent.new(class: "max-w-sm")

    assert_equal "max-w-sm", c.instance_variable_get(:@extra_class)
  end
end

class TestAlertDialogComponent < Minitest::Test
  def test_title_stored
    c = UI::AlertDialogComponent.new(title: "Are you sure?")

    assert_equal "Are you sure?", c.instance_variable_get(:@title)
  end

  def test_description_stored
    c = UI::AlertDialogComponent.new(description: "This cannot be undone.")

    assert_equal "This cannot be undone.", c.instance_variable_get(:@description)
  end

  def test_nil_defaults
    c = UI::AlertDialogComponent.new

    assert_nil c.instance_variable_get(:@title)
    assert_nil c.instance_variable_get(:@description)
  end
end

class TestSheetComponent < Minitest::Test
  def test_default_side
    c = UI::SheetComponent.new

    assert_equal :right, c.instance_variable_get(:@side)
  end

  def test_custom_side
    c = UI::SheetComponent.new(side: :left)

    assert_equal :left, c.instance_variable_get(:@side)
  end

  def test_string_side_coerced_to_symbol
    c = UI::SheetComponent.new(side: "bottom")

    assert_equal :bottom, c.instance_variable_get(:@side)
  end

  def test_all_sides_defined
    %i[right left top bottom].each do |side|
      assert UI::SheetComponent::SIDES.key?(side), "Missing side #{side}"
    end
  end

  def test_class_extracted
    c = UI::SheetComponent.new(class: "text-sm")

    assert_equal "text-sm", c.instance_variable_get(:@extra_class)
  end
end

class TestDrawerComponent < Minitest::Test
  def test_title_stored
    c = UI::DrawerComponent.new(title: "Move to project")

    assert_equal "Move to project", c.instance_variable_get(:@title)
  end

  def test_nil_title_default
    c = UI::DrawerComponent.new

    assert_nil c.instance_variable_get(:@title)
  end

  def test_class_extracted
    c = UI::DrawerComponent.new(class: "max-h-[80vh]")

    assert_equal "max-h-[80vh]", c.instance_variable_get(:@extra_class)
  end
end

class TestPopoverComponent < Minitest::Test
  def test_default_align
    c = UI::PopoverComponent.new

    assert_equal :start, c.instance_variable_get(:@align)
  end

  def test_default_side
    c = UI::PopoverComponent.new

    assert_equal :bottom, c.instance_variable_get(:@side)
  end

  def test_custom_align
    c = UI::PopoverComponent.new(align: :center)

    assert_equal :center, c.instance_variable_get(:@align)
  end

  def test_custom_side
    c = UI::PopoverComponent.new(side: :top)

    assert_equal :top, c.instance_variable_get(:@side)
  end

  def test_all_aligns_defined
    %i[start center end].each do |align|
      assert UI::PopoverComponent::ALIGN.key?(align), "Missing align #{align}"
    end
  end

  def test_all_sides_defined
    %i[bottom top left right].each do |side|
      assert UI::PopoverComponent::SIDE.key?(side), "Missing side #{side}"
    end
  end
end

class TestTooltipComponent < Minitest::Test
  def test_text_stored
    c = UI::TooltipComponent.new(text: "Save your work")

    assert_equal "Save your work", c.instance_variable_get(:@text)
  end

  def test_default_side
    c = UI::TooltipComponent.new(text: "Hello")

    assert_equal :top, c.instance_variable_get(:@side)
  end

  def test_custom_side
    c = UI::TooltipComponent.new(text: "Hello", side: :bottom)

    assert_equal :bottom, c.instance_variable_get(:@side)
  end

  def test_all_positions_defined
    %i[top bottom left right].each do |side|
      assert UI::TooltipComponent::POSITIONS.key?(side), "Missing position #{side}"
    end
  end
end

class TestHoverCardComponent < Minitest::Test
  def test_default_side
    c = UI::HoverCardComponent.new

    assert_equal :bottom, c.instance_variable_get(:@side)
  end

  def test_custom_side
    c = UI::HoverCardComponent.new(side: :top)

    assert_equal :top, c.instance_variable_get(:@side)
  end

  def test_all_positions_defined
    %i[bottom top left right].each do |side|
      assert UI::HoverCardComponent::POSITIONS.key?(side), "Missing position #{side}"
    end
  end

  def test_class_extracted
    c = UI::HoverCardComponent.new(class: "w-80")

    assert_equal "w-80", c.instance_variable_get(:@extra_class)
  end
end

# ---------------------------------------------------------------------------
# Phase 6 — Menus
# ---------------------------------------------------------------------------

class TestDropdownMenuComponent < Minitest::Test
  def test_default_align
    c = UI::DropdownMenuComponent.new

    assert_equal :start, c.instance_variable_get(:@align)
  end

  def test_custom_align
    c = UI::DropdownMenuComponent.new(align: :end)

    assert_equal :end, c.instance_variable_get(:@align)
  end

  def test_item_constant_defined
    assert_kind_of String, UI::DropdownMenuComponent::ITEM
  end

  def test_separator_constant_defined
    assert_kind_of String, UI::DropdownMenuComponent::SEPARATOR
  end

  def test_class_extracted
    c = UI::DropdownMenuComponent.new(class: "w-48")

    assert_equal "w-48", c.instance_variable_get(:@extra_class)
  end
end

class TestContextMenuComponent < Minitest::Test
  def test_panel_constant_defined
    assert_includes UI::ContextMenuComponent::PANEL, "fixed"
  end

  def test_class_extracted
    c = UI::ContextMenuComponent.new(class: "h-40")

    assert_equal "h-40", c.instance_variable_get(:@extra_class)
  end
end

class TestMenubarComponent < Minitest::Test
  def test_bar_constant_defined
    assert_kind_of String, UI::MenubarComponent::BAR
  end

  def test_class_extracted
    c = UI::MenubarComponent.new(class: "w-full")

    assert_equal "w-full", c.instance_variable_get(:@extra_class)
  end
end

class TestMenubarMenuComponent < Minitest::Test
  def test_label_stored
    c = UI::MenubarMenuComponent.new(label: "File")

    assert_equal "File", c.instance_variable_get(:@label)
  end

  def test_trigger_constant_defined
    assert_kind_of String, UI::MenubarMenuComponent::TRIGGER
  end

  def test_panel_constant_defined
    assert_kind_of String, UI::MenubarMenuComponent::PANEL
  end
end

class TestCommandComponent < Minitest::Test
  def test_item_constant_defined
    assert_kind_of String, UI::CommandComponent::ITEM
  end

  def test_group_constant_defined
    assert_kind_of String, UI::CommandComponent::GROUP
  end

  def test_class_extracted
    c = UI::CommandComponent.new(class: "max-w-sm")

    assert_equal "max-w-sm", c.instance_variable_get(:@extra_class)
  end
end

class TestComboboxComponent < Minitest::Test
  def test_name_stored
    c = UI::ComboboxComponent.new(name: "country")

    assert_equal "country", c.instance_variable_get(:@name)
  end

  def test_default_placeholder
    c = UI::ComboboxComponent.new(name: "x")

    assert_equal "Select...", c.instance_variable_get(:@placeholder)
  end

  def test_custom_placeholder
    c = UI::ComboboxComponent.new(name: "x", placeholder: "Pick one...")

    assert_equal "Pick one...", c.instance_variable_get(:@placeholder)
  end

  def test_value_coerced_to_string
    c = UI::ComboboxComponent.new(name: "x", value: 42)

    assert_equal "42", c.instance_variable_get(:@value)
  end

  def test_nil_value_default
    c = UI::ComboboxComponent.new(name: "x")

    assert_nil c.instance_variable_get(:@value)
  end

  def test_options_stored
    opts = [{value: "a", label: "Alpha"}]
    c = UI::ComboboxComponent.new(name: "x", options: opts)

    assert_equal opts, c.instance_variable_get(:@options)
  end
end

class TestTagsInputComponent < Minitest::Test
  def test_name_stored
    c = UI::TagsInputComponent.new(name: "colors")

    assert_equal "colors", c.instance_variable_get(:@name)
  end

  def test_default_placeholder
    c = UI::TagsInputComponent.new(name: "x")

    assert_equal "Select...", c.instance_variable_get(:@placeholder)
  end

  def test_custom_placeholder
    c = UI::TagsInputComponent.new(name: "x", placeholder: "Add tags...")

    assert_equal "Add tags...", c.instance_variable_get(:@placeholder)
  end

  def test_values_coerced_to_strings
    c = UI::TagsInputComponent.new(name: "x", values: [1, 2])

    assert_equal %w[1 2], c.instance_variable_get(:@values)
  end

  def test_empty_values_default
    c = UI::TagsInputComponent.new(name: "x")

    assert_equal [], c.instance_variable_get(:@values)
  end

  def test_options_stored
    opts = [{value: "red", label: "Red"}]
    c = UI::TagsInputComponent.new(name: "x", options: opts)

    assert_equal opts, c.instance_variable_get(:@options)
  end
end

# ---------------------------------------------------------------------------
# Phase 9 — Media & semantic HTML
# ---------------------------------------------------------------------------

class TestImageComponent < Minitest::Test
  def test_base_class_present
    assert_includes UI::ImageComponent::BASE, "max-w-full"
  end

  def test_required_src_and_alt
    c = UI::ImageComponent.new(src: "photo.jpg", alt: "A photo")

    assert_equal "photo.jpg", c.instance_variable_get(:@src)
    assert_equal "A photo", c.instance_variable_get(:@alt)
  end

  def test_default_lazy_loading
    c = UI::ImageComponent.new(src: "photo.jpg", alt: "Photo")

    assert_equal :lazy, c.instance_variable_get(:@loading)
  end

  def test_eager_loading_accepted
    c = UI::ImageComponent.new(src: "photo.jpg", alt: "Photo", loading: :eager)

    assert_equal :eager, c.instance_variable_get(:@loading)
  end

  def test_invalid_loading_falls_back_to_lazy
    c = UI::ImageComponent.new(src: "photo.jpg", alt: "Photo", loading: :instant)

    assert_equal :lazy, c.instance_variable_get(:@loading)
  end

  def test_optional_srcset_stored
    c = UI::ImageComponent.new(src: "photo.jpg", alt: "Photo", srcset: "photo-2x.jpg 2x")

    assert_equal "photo-2x.jpg 2x", c.instance_variable_get(:@srcset)
  end

  def test_nil_srcset_by_default
    c = UI::ImageComponent.new(src: "photo.jpg", alt: "Photo")

    assert_nil c.instance_variable_get(:@srcset)
  end
end

class TestFigureComponent < Minitest::Test
  def test_caption_class_constant
    assert_includes UI::FigureComponent::CAPTION, "text-muted-foreground"
  end

  def test_caption_stored
    c = UI::FigureComponent.new(caption: "A sunset")

    assert_equal "A sunset", c.instance_variable_get(:@caption)
  end

  def test_nil_caption_by_default
    c = UI::FigureComponent.new

    assert_nil c.instance_variable_get(:@caption)
  end
end

class TestPictureComponent < Minitest::Test
  def test_required_src_and_alt
    c = UI::PictureComponent.new(src: "fallback.jpg", alt: "Photo")

    assert_equal "fallback.jpg", c.instance_variable_get(:@src)
    assert_equal "Photo", c.instance_variable_get(:@alt)
  end

  def test_default_lazy_loading
    c = UI::PictureComponent.new(src: "f.jpg", alt: "Photo")

    assert_equal :lazy, c.instance_variable_get(:@loading)
  end

  def test_source_component_stores_srcset
    s = UI::PictureComponent::SourceComponent.new(srcset: "photo.avif", type: "image/avif")

    assert_equal "photo.avif", s.instance_variable_get(:@srcset)
    assert_equal "image/avif", s.instance_variable_get(:@type)
  end

  def test_source_optional_media
    s = UI::PictureComponent::SourceComponent.new(srcset: "wide.jpg", media: "(min-width: 800px)")

    assert_equal "(min-width: 800px)", s.instance_variable_get(:@media)
  end
end

class TestVideoComponent < Minitest::Test
  def test_base_class_present
    assert_includes UI::VideoComponent::BASE, "max-w-full"
  end

  def test_controls_on_by_default
    c = UI::VideoComponent.new

    assert c.instance_variable_get(:@controls)
  end

  def test_playsinline_on_by_default
    c = UI::VideoComponent.new

    assert c.instance_variable_get(:@playsinline)
  end

  def test_autoplay_false_by_default
    c = UI::VideoComponent.new

    refute c.instance_variable_get(:@autoplay)
  end

  def test_source_component_stores_src_and_type
    s = UI::VideoComponent::SourceComponent.new(src: "video.mp4", type: "video/mp4")

    assert_equal "video.mp4", s.instance_variable_get(:@src)
    assert_equal "video/mp4", s.instance_variable_get(:@type)
  end

  def test_track_component_defaults_to_subtitles
    t = UI::VideoComponent::TrackComponent.new(src: "subs.vtt")

    assert_equal :subtitles, t.instance_variable_get(:@kind)
  end

  def test_track_component_stores_label_and_srclang
    t = UI::VideoComponent::TrackComponent.new(src: "subs.vtt", label: "English", srclang: "en")

    assert_equal "English", t.instance_variable_get(:@label)
    assert_equal "en", t.instance_variable_get(:@srclang)
  end

  def test_track_invalid_kind_falls_back_to_subtitles
    t = UI::VideoComponent::TrackComponent.new(src: "subs.vtt", kind: :bogus)

    assert_equal :subtitles, t.instance_variable_get(:@kind)
  end
end

class TestAudioComponent < Minitest::Test
  def test_controls_on_by_default
    c = UI::AudioComponent.new

    assert c.instance_variable_get(:@controls)
  end

  def test_autoplay_false_by_default
    c = UI::AudioComponent.new

    refute c.instance_variable_get(:@autoplay)
  end

  def test_source_component_stores_src_and_type
    s = UI::AudioComponent::SourceComponent.new(src: "audio.mp3", type: "audio/mpeg")

    assert_equal "audio.mp3", s.instance_variable_get(:@src)
    assert_equal "audio/mpeg", s.instance_variable_get(:@type)
  end
end

class TestIframeComponent < Minitest::Test
  def test_base_class_present
    assert_includes UI::IframeComponent::BASE, "w-full"
  end

  def test_required_src_and_title
    c = UI::IframeComponent.new(src: "https://example.com", title: "Example")

    assert_equal "https://example.com", c.instance_variable_get(:@src)
    assert_equal "Example", c.instance_variable_get(:@title)
  end

  def test_default_lazy_loading
    c = UI::IframeComponent.new(src: "https://example.com", title: "Example")

    assert_equal :lazy, c.instance_variable_get(:@loading)
  end

  def test_sandbox_true_by_default
    c = UI::IframeComponent.new(src: "https://example.com", title: "Example")

    assert c.instance_variable_get(:@sandbox)
  end

  def test_nil_aspect_by_default
    c = UI::IframeComponent.new(src: "https://example.com", title: "Example")

    assert_nil c.instance_variable_get(:@aspect)
  end

  def test_aspect_ratio_stored
    c = UI::IframeComponent.new(src: "https://example.com", title: "Example", aspect: "16/9")

    assert_equal "16/9", c.instance_variable_get(:@aspect)
  end
end

class TestFileInputComponent < Minitest::Test
  def test_accept_nil_by_default
    c = UI::FileInputComponent.new

    assert_nil c.instance_variable_get(:@accept)
  end

  def test_accept_stored
    c = UI::FileInputComponent.new(accept: "image/*")

    assert_equal "image/*", c.instance_variable_get(:@accept)
  end

  def test_multiple_false_by_default
    c = UI::FileInputComponent.new

    refute c.instance_variable_get(:@multiple)
  end

  def test_multiple_stored
    c = UI::FileInputComponent.new(multiple: true)

    assert c.instance_variable_get(:@multiple)
  end
end

class TestSearchInputComponent < Minitest::Test
  def test_default_placeholder
    c = UI::SearchInputComponent.new

    assert_equal "Search…", c.instance_variable_get(:@placeholder)
  end

  def test_custom_placeholder
    c = UI::SearchInputComponent.new(placeholder: "Find something")

    assert_equal "Find something", c.instance_variable_get(:@placeholder)
  end
end

class TestNumberInputComponent < Minitest::Test
  def test_min_max_step_defaults
    c = UI::NumberInputComponent.new

    assert_nil c.instance_variable_get(:@min)
    assert_nil c.instance_variable_get(:@max)
    assert_nil c.instance_variable_get(:@step)
  end

  def test_min_max_step_stored
    c = UI::NumberInputComponent.new(min: 0, max: 100, step: 5)

    assert_equal 0, c.instance_variable_get(:@min)
    assert_equal 100, c.instance_variable_get(:@max)
    assert_equal 5, c.instance_variable_get(:@step)
  end

  def test_value_nil_by_default
    c = UI::NumberInputComponent.new

    assert_nil c.instance_variable_get(:@value)
  end
end

class TestRangeComponent < Minitest::Test
  def test_defaults
    c = UI::RangeComponent.new

    assert_equal 0, c.instance_variable_get(:@min)
    assert_equal 100, c.instance_variable_get(:@max)
    assert_equal 1, c.instance_variable_get(:@step)
    assert_nil c.instance_variable_get(:@value)
  end

  def test_custom_values_stored
    c = UI::RangeComponent.new(min: 10, max: 50, step: 2, value: 30)

    assert_equal 10, c.instance_variable_get(:@min)
    assert_equal 50, c.instance_variable_get(:@max)
    assert_equal 2, c.instance_variable_get(:@step)
    assert_equal 30, c.instance_variable_get(:@value)
  end
end

class TestFloatingLabelComponent < Minitest::Test
  def test_label_stored
    c = UI::FloatingLabelComponent.new(label: "Email")

    assert_equal "Email", c.instance_variable_get(:@label)
  end

  def test_type_defaults_to_text
    c = UI::FloatingLabelComponent.new(label: "Name")

    assert_equal "text", c.instance_variable_get(:@type)
  end

  def test_id_derived_from_name
    c = UI::FloatingLabelComponent.new(label: "Email", name: "user[email]")

    assert_equal "user_email_", c.instance_variable_get(:@id)
  end

  def test_explicit_id_takes_precedence
    c = UI::FloatingLabelComponent.new(label: "Email", id: "my-email", name: "email")

    assert_equal "my-email", c.instance_variable_get(:@id)
  end
end

class TestNavigationMenuComponent < Minitest::Test
  def test_item_stores_label_and_href
    item = UI::NavigationMenuComponent::ItemComponent.new(label: "Docs", href: "/docs")

    assert_equal "Docs", item.instance_variable_get(:@label)
    assert_equal "/docs", item.instance_variable_get(:@href)
  end

  def test_item_active_defaults_to_false
    item = UI::NavigationMenuComponent::ItemComponent.new(label: "Home")

    refute item.instance_variable_get(:@active)
  end

  def test_item_without_href_has_nil_href
    item = UI::NavigationMenuComponent::ItemComponent.new(label: "Products")

    assert_nil item.instance_variable_get(:@href)
  end
end

class TestMegaMenuComponent < Minitest::Test
  def test_label_stored
    c = UI::MegaMenuComponent.new(label: "Solutions")

    assert_equal "Solutions", c.instance_variable_get(:@label)
  end

  def test_cols_nil_by_default
    c = UI::MegaMenuComponent.new(label: "Menu")

    assert_nil c.instance_variable_get(:@cols)
  end

  def test_cols_stored
    c = UI::MegaMenuComponent.new(label: "Menu", cols: 3)

    assert_equal 3, c.instance_variable_get(:@cols)
  end

  def test_column_heading_and_items
    col = UI::MegaMenuComponent::ColumnComponent.new(
      heading: "Products",
      items: [{title: "Analytics", href: "/analytics"}]
    )

    assert_equal "Products", col.instance_variable_get(:@heading)
    assert_equal 1, col.instance_variable_get(:@items).size
  end
end

class TestCollapsibleComponent < Minitest::Test
  def test_open_defaults_to_false
    c = UI::CollapsibleComponent.new

    refute c.instance_variable_get(:@open)
  end

  def test_open_stored
    c = UI::CollapsibleComponent.new(open: true)

    assert c.instance_variable_get(:@open)
  end
end

class TestScrollAreaComponent < Minitest::Test
  def test_orientation_defaults_to_vertical
    c = UI::ScrollAreaComponent.new

    assert_equal :vertical, c.instance_variable_get(:@orientation)
  end

  def test_max_h_default
    c = UI::ScrollAreaComponent.new

    assert_equal "max-h-72", c.instance_variable_get(:@max_h)
  end

  def test_orientation_stored
    c = UI::ScrollAreaComponent.new(orientation: :horizontal)

    assert_equal :horizontal, c.instance_variable_get(:@orientation)
  end
end

class TestChatBubbleComponent < Minitest::Test
  def test_sent_defaults_to_false
    c = UI::ChatBubbleComponent.new

    refute c.instance_variable_get(:@sent)
  end

  def test_sent_stored
    c = UI::ChatBubbleComponent.new(sent: true)

    assert c.instance_variable_get(:@sent)
  end

  def test_timestamp_nil_by_default
    c = UI::ChatBubbleComponent.new

    assert_nil c.instance_variable_get(:@timestamp)
  end

  def test_timestamp_stored
    c = UI::ChatBubbleComponent.new(timestamp: "12:34")

    assert_equal "12:34", c.instance_variable_get(:@timestamp)
  end
end

class TestDeviceMockupComponent < Minitest::Test
  def test_variant_defaults_to_phone
    c = UI::DeviceMockupComponent.new

    assert_equal :phone, c.instance_variable_get(:@variant)
  end

  def test_variant_stored
    c = UI::DeviceMockupComponent.new(variant: :browser)

    assert_equal :browser, c.instance_variable_get(:@variant)
  end

  def test_url_nil_by_default
    c = UI::DeviceMockupComponent.new

    assert_nil c.instance_variable_get(:@url)
  end
end

class TestQrCodeComponent < Minitest::Test
  def test_src_nil_by_default
    c = UI::QrCodeComponent.new

    assert_nil c.instance_variable_get(:@src)
  end

  def test_src_stored
    c = UI::QrCodeComponent.new(src: "https://example.com/qr.png")

    assert_equal "https://example.com/qr.png", c.instance_variable_get(:@src)
  end

  def test_size_default
    c = UI::QrCodeComponent.new

    assert_equal 200, c.instance_variable_get(:@size)
  end

  def test_alt_default
    c = UI::QrCodeComponent.new

    assert_equal "QR code", c.instance_variable_get(:@alt)
  end
end

class TestSpeedDialComponent < Minitest::Test
  def test_position_defaults_to_bottom_right
    c = UI::SpeedDialComponent.new

    assert_equal :bottom_right, c.instance_variable_get(:@position)
  end

  def test_position_stored
    c = UI::SpeedDialComponent.new(position: :bottom_left)

    assert_equal :bottom_left, c.instance_variable_get(:@position)
  end
end

class TestGalleryComponent < Minitest::Test
  def test_cols_default
    c = UI::GalleryComponent.new

    assert_equal 3, c.instance_variable_get(:@cols)
  end

  def test_cols_stored
    c = UI::GalleryComponent.new(cols: 4)

    assert_equal 4, c.instance_variable_get(:@cols)
  end
end

class TestCarouselComponent < Minitest::Test
  def test_loop_defaults_to_true
    c = UI::CarouselComponent.new

    assert c.instance_variable_get(:@loop)
  end

  def test_autoplay_defaults_to_zero
    c = UI::CarouselComponent.new

    assert_equal 0, c.instance_variable_get(:@autoplay)
  end

  def test_autoplay_stored
    c = UI::CarouselComponent.new(autoplay: 3000)

    assert_equal 3000, c.instance_variable_get(:@autoplay)
  end
end

class TestInputOtpComponent < Minitest::Test
  def test_length_defaults_to_6
    c = UI::InputOtpComponent.new

    assert_equal 6, c.instance_variable_get(:@length)
  end

  def test_length_stored
    c = UI::InputOtpComponent.new(length: 4)

    assert_equal 4, c.instance_variable_get(:@length)
  end

  def test_name_defaults_to_otp
    c = UI::InputOtpComponent.new

    assert_equal "otp", c.instance_variable_get(:@name)
  end
end

class TestSidebarComponent < Minitest::Test
  def test_collapsed_defaults_to_false
    c = UI::SidebarComponent.new

    refute c.instance_variable_get(:@collapsed)
  end

  def test_brand_nil_by_default
    c = UI::SidebarComponent.new

    assert_nil c.instance_variable_get(:@brand)
  end

  def test_brand_stored
    c = UI::SidebarComponent.new(brand: "Acme")

    assert_equal "Acme", c.instance_variable_get(:@brand)
  end
end

class TestResizableComponent < Minitest::Test
  def test_direction_defaults_to_horizontal
    c = UI::ResizableComponent.new

    assert_equal :horizontal, c.instance_variable_get(:@direction)
  end

  def test_direction_stored
    c = UI::ResizableComponent.new(direction: :vertical)

    assert_equal :vertical, c.instance_variable_get(:@direction)
  end
end

class TestCalendarComponent < Minitest::Test
  def test_selected_nil_by_default
    c = UI::CalendarComponent.new

    assert_nil c.instance_variable_get(:@selected)
  end

  def test_selected_stored
    d = Date.new(2025, 6, 15)
    c = UI::CalendarComponent.new(selected: d)

    assert_equal d, c.instance_variable_get(:@selected)
  end

  def test_month_defaults_to_beginning_of_current_month
    c = UI::CalendarComponent.new

    assert_equal Date.today.beginning_of_month, c.instance_variable_get(:@month)
  end

  def test_name_nil_by_default
    c = UI::CalendarComponent.new

    assert_nil c.instance_variable_get(:@name)
  end
end

class TestDatePickerComponent < Minitest::Test
  def test_value_nil_by_default
    c = UI::DatePickerComponent.new

    assert_nil c.instance_variable_get(:@value)
  end

  def test_value_stored
    d = Date.new(2025, 1, 1)
    c = UI::DatePickerComponent.new(value: d)

    assert_equal d, c.instance_variable_get(:@value)
  end

  def test_placeholder_default
    c = UI::DatePickerComponent.new

    assert_equal "Pick a date", c.instance_variable_get(:@placeholder)
  end

  def test_name_nil_by_default
    c = UI::DatePickerComponent.new

    assert_nil c.instance_variable_get(:@name)
  end
end

class TestTimepickerComponent < Minitest::Test
  def test_format_defaults_to_h24
    c = UI::TimepickerComponent.new

    assert_equal :h24, c.instance_variable_get(:@format)
  end

  def test_format_stored
    c = UI::TimepickerComponent.new(format: :h12)

    assert_equal :h12, c.instance_variable_get(:@format)
  end

  def test_step_defaults_to_1
    c = UI::TimepickerComponent.new

    assert_equal 1, c.instance_variable_get(:@step)
  end

  def test_step_clamped_to_60
    c = UI::TimepickerComponent.new(step: 999)

    assert_equal 60, c.instance_variable_get(:@step)
  end

  def test_value_nil_by_default
    c = UI::TimepickerComponent.new

    assert_nil c.instance_variable_get(:@value)
  end
end

class TestDataTableComponent < Minitest::Test
  def test_columns_and_rows_stored
    cols = [{key: :name, label: "Name"}]
    rows = [{name: "Alice"}]
    c = UI::DataTableComponent.new(columns: cols, rows: rows)

    assert_equal cols, c.instance_variable_get(:@columns)
    assert_equal rows, c.instance_variable_get(:@rows)
  end

  def test_per_page_defaults_to_10
    c = UI::DataTableComponent.new(columns: [], rows: [])

    assert_equal 10, c.instance_variable_get(:@per_page)
  end

  def test_per_page_stored
    c = UI::DataTableComponent.new(columns: [], rows: [], per_page: 25)

    assert_equal 25, c.instance_variable_get(:@per_page)
  end

  def test_caption_nil_by_default
    c = UI::DataTableComponent.new(columns: [], rows: [])

    assert_nil c.instance_variable_get(:@caption)
  end
end
