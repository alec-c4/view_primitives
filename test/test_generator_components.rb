# frozen_string_literal: true

require "test_helper"

class TestGeneratorComponents < Minitest::Test
  PHASE1 = %w[button alert accordion].freeze
  PHASE2 = %w[
    badge avatar card separator label skeleton progress aspect_ratio
    spinner kbd rating rating_input indicator list_group banner button_group
  ].freeze
  PHASE3 = %w[input textarea checkbox radio_group select switch toggle toggle_group form_field
    file_input search_input number_input range floating_label].freeze
  PHASE4 = %w[breadcrumb pagination stepper bottom_nav footer tabs navbar navigation_menu mega_menu].freeze
  PHASE5 = %w[dialog alert_dialog sheet drawer popover tooltip hover_card].freeze
  PHASE6 = %w[dropdown_menu context_menu menubar command combobox].freeze
  PHASE7 = %w[collapsible scroll_area chat_bubble device_mockup qr_code].freeze
  PHASE9 = %w[image figure picture video audio iframe].freeze
  ALL_COMPONENTS = (PHASE1 + PHASE2 + PHASE3 + PHASE4 + PHASE5 + PHASE6 + PHASE7 + PHASE9).freeze

  TEMPLATE_ROOT = File.expand_path("../lib/generators/view_primitives/add/templates", __dir__)

  def supported_components
    @supported_components ||= ViewPrimitives::Generators::Components.supported
  end

  def test_all_components_are_in_supported_list
    ALL_COMPONENTS.each do |component|
      assert_includes supported_components, component,
        "#{component} missing from template directories"
    end
  end

  def test_supported_has_no_extra_directories
    extras = supported_components - ALL_COMPONENTS

    assert_empty extras, "Unexpected template directories: #{extras.join(", ")}"
  end

  # --- template directories and files --------------------------------------

  def test_all_components_have_a_template_directory
    ALL_COMPONENTS.each do |component|
      dir = File.join(TEMPLATE_ROOT, component)

      assert File.directory?(dir),
        "Template directory missing: #{dir}"
    end
  end

  def test_all_template_directories_contain_at_least_one_rb_tt_file
    ALL_COMPONENTS.each do |component|
      dir = File.join(TEMPLATE_ROOT, component)
      tt_files = Dir[File.join(dir, "*.rb.tt")]

      assert_operator tt_files.size, :>=, 1,
        "No .rb.tt template file found in #{dir}"
    end
  end

  # --- template syntax -----------------------------------------------------

  def test_all_rb_tt_templates_have_valid_ruby_syntax
    Dir[File.join(TEMPLATE_ROOT, "**", "*.rb.tt")].sort.each do |path|
      source = File.read(path)
      begin
        RubyVM::InstructionSequence.compile(source, path)
      rescue SyntaxError => e
        flunk "Syntax error in #{path.delete_prefix(TEMPLATE_ROOT + "/")}: #{e.message}"
      end
    end
  end

  # --- multi-file components -----------------------------------------------

  def test_accordion_copies_two_rb_tt_files
    files = Dir[File.join(TEMPLATE_ROOT, "accordion", "*.rb.tt")]

    assert_operator files.size, :>=, 2,
      "accordion should have accordion_component and accordion_item_component templates"
  end

  def test_card_copies_six_rb_tt_files
    files = Dir[File.join(TEMPLATE_ROOT, "card", "*.rb.tt")]

    assert_operator files.size, :>=, 6,
      "card should have component + header/title/description/content/footer templates"
  end

  def test_list_group_copies_two_rb_tt_files
    files = Dir[File.join(TEMPLATE_ROOT, "list_group", "*.rb.tt")]

    assert_operator files.size, :>=, 2,
      "list_group should have list_group_component and list_group_item_component templates"
  end

  def test_rating_input_has_js_controller
    js_file = File.join(TEMPLATE_ROOT, "rating_input", "rating_controller.js")

    assert_path_exists js_file, "rating_input should include rating_controller.js"
  end

  def test_tabs_copies_two_rb_tt_files
    files = Dir[File.join(TEMPLATE_ROOT, "tabs", "*.rb.tt")]

    assert_operator files.size, :>=, 2,
      "tabs should have tabs_component and tabs_item_component templates"
  end

  def test_tabs_has_html_erb_template
    assert_path_exists File.join(TEMPLATE_ROOT, "tabs", "tabs_component.html.erb"),
      "tabs should include tabs_component.html.erb"
  end

  def test_tabs_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "tabs", "tabs_controller.js"),
      "tabs should include tabs_controller.js"
  end

  def test_navbar_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "navbar", "navbar_controller.js"),
      "navbar should include navbar_controller.js"
  end

  def test_dialog_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "dialog", "dialog_controller.js"),
      "dialog should include dialog_controller.js"
  end

  def test_sheet_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "sheet", "sheet_controller.js"),
      "sheet should include sheet_controller.js"
  end

  def test_popover_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "popover", "popover_controller.js"),
      "popover should include popover_controller.js"
  end

  def test_dropdown_menu_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "dropdown_menu", "dropdown_controller.js"),
      "dropdown_menu should include dropdown_controller.js"
  end

  def test_context_menu_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "context_menu", "context_menu_controller.js"),
      "context_menu should include context_menu_controller.js"
  end

  def test_menubar_copies_two_rb_tt_files
    files = Dir[File.join(TEMPLATE_ROOT, "menubar", "*.rb.tt")]

    assert_operator files.size, :>=, 2,
      "menubar should have menubar_component and menubar_menu_component templates"
  end

  def test_menubar_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "menubar", "menubar_controller.js"),
      "menubar should include menubar_controller.js"
  end

  def test_command_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "command", "command_controller.js"),
      "command should include command_controller.js"
  end

  def test_combobox_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "combobox", "combobox_controller.js"),
      "combobox should include combobox_controller.js"
  end

  # --- Phase 9 — Media & semantic HTML ------------------------------------

  def test_picture_has_nested_source_template
    source = File.read(File.join(TEMPLATE_ROOT, "picture", "picture_component.rb.tt"))

    assert_includes source, "SourceComponent",
      "picture_component should define a nested SourceComponent"
  end

  def test_video_has_nested_source_and_track
    source = File.read(File.join(TEMPLATE_ROOT, "video", "video_component.rb.tt"))

    assert_includes source, "SourceComponent"
    assert_includes source, "TrackComponent"
  end

  def test_audio_has_nested_source_template
    source = File.read(File.join(TEMPLATE_ROOT, "audio", "audio_component.rb.tt"))

    assert_includes source, "SourceComponent",
      "audio_component should define a nested SourceComponent"
  end

  def test_image_enforces_lazy_loading_default
    source = File.read(File.join(TEMPLATE_ROOT, "image", "image_component.rb.tt"))

    assert_includes source, "loading: :lazy"
  end

  def test_iframe_requires_title
    source = File.read(File.join(TEMPLATE_ROOT, "iframe", "iframe_component.rb.tt"))

    assert_includes source, "title:"
  end

  # --- Phase 3 additions -----------------------------------------------------

  def test_file_input_accepts_multiple
    source = File.read(File.join(TEMPLATE_ROOT, "file_input", "file_input_component.rb.tt"))

    assert_includes source, "multiple"
  end

  def test_search_input_uses_type_search
    source = File.read(File.join(TEMPLATE_ROOT, "search_input", "search_input_component.rb.tt"))

    assert_includes source, 'type: "search"'
  end

  def test_number_input_hides_spin_buttons
    source = File.read(File.join(TEMPLATE_ROOT, "number_input", "number_input_component.rb.tt"))

    assert_includes source, "spin-button"
  end

  def test_range_styles_thumb
    source = File.read(File.join(TEMPLATE_ROOT, "range", "range_component.rb.tt"))

    assert_includes source, "slider-thumb"
  end

  def test_floating_label_has_peer_classes
    source = File.read(File.join(TEMPLATE_ROOT, "floating_label", "floating_label_component.rb.tt"))

    assert_includes source, "peer"
    assert_includes source, "label:"
  end

  # --- Phase 4 additions -----------------------------------------------------

  def test_navigation_menu_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "navigation_menu", "navigation_menu_controller.js"),
      "navigation_menu should include navigation_menu_controller.js"
  end

  def test_navigation_menu_has_nested_item_component
    source = File.read(File.join(TEMPLATE_ROOT, "navigation_menu", "navigation_menu_component.rb.tt"))

    assert_includes source, "ItemComponent"
  end

  def test_mega_menu_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "mega_menu", "mega_menu_controller.js"),
      "mega_menu should include mega_menu_controller.js"
  end

  def test_mega_menu_has_nested_column_component
    source = File.read(File.join(TEMPLATE_ROOT, "mega_menu", "mega_menu_component.rb.tt"))

    assert_includes source, "ColumnComponent"
  end

  # --- Phase 7 (no-JS) -------------------------------------------------------

  def test_collapsible_uses_details_element
    source = File.read(File.join(TEMPLATE_ROOT, "collapsible", "collapsible_component.rb.tt"))

    assert_includes source, ":details"
  end

  def test_scroll_area_has_scrollbar_classes
    source = File.read(File.join(TEMPLATE_ROOT, "scroll_area", "scroll_area_component.rb.tt"))

    assert_includes source, "scrollbar"
  end

  def test_chat_bubble_has_sent_and_received_variants
    source = File.read(File.join(TEMPLATE_ROOT, "chat_bubble", "chat_bubble_component.rb.tt"))

    assert_includes source, "sent"
    assert_includes source, "BUBBLE_RECV"
  end

  def test_device_mockup_has_phone_and_browser_variants
    source = File.read(File.join(TEMPLATE_ROOT, "device_mockup", "device_mockup_component.rb.tt"))

    assert_includes source, "phone"
    assert_includes source, "browser"
  end

  def test_qr_code_supports_src_and_block
    source = File.read(File.join(TEMPLATE_ROOT, "qr_code", "qr_code_component.rb.tt"))

    assert_includes source, "src:"
    assert_includes source, "content"
  end
end
