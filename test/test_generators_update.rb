# frozen_string_literal: true

require "test_helper"

class TestGeneratorsUpdate < Minitest::Test
  INSTALL_TEMPLATE_ROOT = File.expand_path(
    "../lib/generators/view_primitives/install/templates", __dir__
  )

  def test_css_bundle_files_exist
    assert_path_exists File.join(INSTALL_TEMPLATE_ROOT, "view_primitives.css")
    assert_path_exists File.join(INSTALL_TEMPLATE_ROOT, "view_primitives/tokens.css")
    assert_path_exists File.join(INSTALL_TEMPLATE_ROOT, "view_primitives/utilities.css")
    assert_path_exists File.join(INSTALL_TEMPLATE_ROOT, "view_primitives/themes/default.css")
    assert_path_exists File.join(INSTALL_TEMPLATE_ROOT, "view_primitives/themes/rose.css")
  end

  def test_ui_styles_template_defines_primitives
    source = File.read(File.join(INSTALL_TEMPLATE_ROOT, "styles.rb.tt"))

    assert_includes source, "module UI"
    assert_includes source, "module Styles"
    assert_includes source, "FOCUS_RING"
    assert_includes source, "INPUT"
    assert_includes source, "vp-input"
  end

  def test_utilities_css_defines_vp_classes
    css = File.read(File.join(INSTALL_TEMPLATE_ROOT, "view_primitives/utilities.css"))

    assert_includes css, "@utility vp-focus-ring"
    assert_includes css, "@utility vp-input"
    assert_includes css, "@utility vp-overlay"
    assert_includes css, "@utility vp-peer-focus-ring"
  end

  def test_components_installed_lists_existing_primary_paths
    root = Dir.mktmpdir
    FileUtils.mkdir_p(File.join(root, "app/components/ui"))
    File.write(File.join(root, "app/components/ui/button_component.rb"), "")

    installed = ViewPrimitives::Generators::Components.installed(root)

    assert_includes installed, "button"
    refute_includes installed, "dialog"
  ensure
    FileUtils.remove_entry(root)
  end

  def test_optional_themes_include_rose
    themes = ViewPrimitives::Generators::Components.optional_theme_imports

    assert_includes themes, "rose"
  end

  def test_update_and_theme_generator_files_exist
    gen_root = File.expand_path("../lib/generators/view_primitives", __dir__)

    assert_path_exists File.join(gen_root, "update/update_generator.rb")
    assert_path_exists File.join(gen_root, "theme/theme_generator.rb")
    assert_path_exists File.join(gen_root, "component_copier.rb")
  end
end
