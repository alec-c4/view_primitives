# frozen_string_literal: true

require "test_helper"

class TestGeneratorComponents < Minitest::Test
  PHASE1 = %w[button alert accordion].freeze
  PHASE2 = %w[
    badge avatar card separator label skeleton progress aspect_ratio
    spinner kbd rating rating_input indicator list_group banner button_group
  ].freeze
  PHASE3 = %w[input textarea checkbox radio_group select switch toggle toggle_group form_field].freeze
  PHASE4 = %w[breadcrumb pagination stepper bottom_nav footer tabs navbar].freeze
  ALL_COMPONENTS = (PHASE1 + PHASE2 + PHASE3 + PHASE4).freeze

  TEMPLATE_ROOT = File.expand_path("../lib/generators/view_primitives/add/templates", __dir__)

  def generator_source
    @generator_source ||= File.read(
      File.expand_path("../lib/generators/view_primitives/add/add_generator.rb", __dir__)
    )
  end

  # --- SUPPORTED_COMPONENTS list -----------------------------------------

  def test_all_components_are_in_supported_list
    ALL_COMPONENTS.each do |component|
      assert_match(/\b#{Regexp.escape(component)}\b/, generator_source,
        "#{component} missing from SUPPORTED_COMPONENTS")
    end
  end

  # --- copy_* methods -------------------------------------------------------

  def test_all_components_have_a_copy_method
    ALL_COMPONENTS.each do |component|
      assert_match(/def copy_#{Regexp.escape(component)}\b/, generator_source,
        "copy_#{component} method missing from AddGenerator")
    end
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
end
