# frozen_string_literal: true

require "test_helper"
require "fileutils"
require "stringio"
require "rails/generators"
require "generators/view_primitives/install/install_generator"
require "generators/view_primitives/update/update_generator"
require "generators/view_primitives/theme/theme_generator"

class TestGeneratorsIntegration < Minitest::Test
  def setup
    @root = Dir.mktmpdir("view_primitives_generator")
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def test_update_refreshes_css_bundle_and_ui_styles
    scaffold_app
    File.write(File.join(@root, "app/components/ui/button_component.rb"), "# installed")

    run_update_generator(skip_components: true)

    css = File.read(File.join(@root, "app/assets/stylesheets/view_primitives.css"))
    utilities = File.read(File.join(@root, "app/assets/stylesheets/view_primitives/utilities.css"))
    styles = File.read(File.join(@root, "app/components/ui/styles.rb"))

    assert_includes css, '@import "./view_primitives/tokens.css"'
    assert_includes utilities, "@utility vp-focus-ring"
    assert_includes styles, "module Styles"
    assert_includes styles, 'FOCUS_RING = "vp-focus-ring"'
  end

  def test_update_copies_only_requested_components
    scaffold_app
    File.write(File.join(@root, "app/components/ui/button_component.rb"), "# old button")
    File.write(File.join(@root, "app/components/ui/dialog_component.rb"), "# old dialog")

    run_update_generator(only: %w[button], skip_css: true, skip_styles: true)

    button = File.read(File.join(@root, "app/components/ui/button_component.rb"))
    dialog = File.read(File.join(@root, "app/components/ui/dialog_component.rb"))

    assert_includes button, "UI::Styles::FOCUS_RING"
    assert_includes dialog, "# old dialog"
  end

  def test_update_preserves_enabled_optional_theme_import
    scaffold_app
    File.write(
      File.join(@root, "app/assets/stylesheets/view_primitives.css"),
      <<~CSS
        @import "./view_primitives/tokens.css";
        /* @import "./view_primitives/themes/rose.css"; */
      CSS
    )

    run_update_generator(skip_components: true, skip_styles: true)

    css = File.read(File.join(@root, "app/assets/stylesheets/view_primitives.css"))

    assert_includes css, '@import "./view_primitives/themes/rose.css";'
  end

  def test_install_preserves_existing_styles_and_css_when_overwrite_declined
    scaffold_app
    FileUtils.mkdir_p(File.join(@root, "app/assets/stylesheets/view_primitives"))
    File.write(File.join(@root, "app/assets/stylesheets/view_primitives/utilities.css"), "/* custom utilities */")

    run_install_generator(force: false, overwrite: false)

    assert_equal "# old styles", File.read(File.join(@root, "app/components/ui/styles.rb"))
    assert_equal "/* old */", File.read(File.join(@root, "app/assets/stylesheets/view_primitives.css"))
    assert_equal "/* custom utilities */",
      File.read(File.join(@root, "app/assets/stylesheets/view_primitives/utilities.css"))
  end

  def test_theme_generator_copies_rose_and_enables_import
    FileUtils.mkdir_p(File.join(@root, "app/assets/stylesheets"))
    FileUtils.mkdir_p(File.join(@root, "app/assets/tailwind"))
    File.write(File.join(@root, "app/assets/tailwind/application.css"), '@import "tailwindcss";')
    File.write(
      File.join(@root, "app/assets/stylesheets/view_primitives.css"),
      <<~CSS
        @import "./view_primitives/tokens.css";
        /* @import "./view_primitives/themes/rose.css"; */
      CSS
    )

    run_theme_generator("rose")

    rose = File.read(File.join(@root, "app/assets/stylesheets/view_primitives/themes/rose.css"))
    css = File.read(File.join(@root, "app/assets/stylesheets/view_primitives.css"))

    assert_includes rose, '[data-theme="rose"]'
    assert_includes css, '@import "./view_primitives/themes/rose.css";'
  end

  private

  def scaffold_app
    FileUtils.mkdir_p(File.join(@root, "app/components/ui"))
    FileUtils.mkdir_p(File.join(@root, "app/assets/stylesheets"))
    FileUtils.mkdir_p(File.join(@root, "app/assets/tailwind"))
    FileUtils.mkdir_p(File.join(@root, "app/javascript/controllers"))
    File.write(File.join(@root, "app/assets/tailwind/application.css"), '@import "tailwindcss";')
    File.write(File.join(@root, "app/components/ui/styles.rb"), "# old styles")
    File.write(File.join(@root, "app/assets/stylesheets/view_primitives.css"), "/* old */")
  end

  def run_update_generator(**options)
    generator = ViewPrimitives::Generators::UpdateGenerator.new([], options.merge(force: true))
    configure_generator(generator)
    capture_stdout do
      generator.update_components unless options[:skip_components]
      generator.update_css_bundle unless options[:skip_css]
      generator.update_ui_styles unless options[:skip_styles]
    end
  end

  def run_install_generator(force:, overwrite:)
    generator = ViewPrimitives::Generators::InstallGenerator.new([], force: force)
    configure_generator(generator)
    generator.define_singleton_method(:yes?) { |*| overwrite }
    capture_stdout do
      generator.create_ui_styles
      generator.create_css_bundle
    end
  end

  def run_theme_generator(name)
    generator = ViewPrimitives::Generators::ThemeGenerator.new([name], force: true)
    configure_generator(generator)
    capture_stdout { generator.copy_theme_file }
  end

  def configure_generator(generator)
    generator.instance_variable_set(:@destination_stack, [@root])
  end

  def capture_stdout
    previous = $stdout
    $stdout = StringIO.new
    yield
  ensure
    $stdout = previous
  end
end
