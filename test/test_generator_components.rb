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
  PHASE7 = %w[
    collapsible scroll_area chat_bubble device_mockup qr_code
    speed_dial gallery carousel input_otp sidebar resizable calendar
    date_picker timepicker data_table
  ].freeze
  PHASE8 = %w[timeline toaster chart wysiwyg].freeze
  PHASE9 = %w[image figure picture video audio iframe map_area embed].freeze
  ALL_COMPONENTS = (PHASE1 + PHASE2 + PHASE3 + PHASE4 + PHASE5 + PHASE6 + PHASE7 + PHASE8 + PHASE9).freeze

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

    source = File.read(File.join(TEMPLATE_ROOT, "accordion", "accordion_item_component.rb.tt"))

    assert_includes source, "border-b border-border"
    assert_includes source, "[&::-webkit-details-marker]:hidden"
    assert_includes source, '"stroke-width": "2"'
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

    source = File.read(File.join(TEMPLATE_ROOT, "list_group", "list_group_component.rb.tt"))

    assert_includes source, "divide-border"
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

  def test_dialog_controller_traps_focus
    source = File.read(File.join(TEMPLATE_ROOT, "dialog", "dialog_controller.js"))

    assert_includes source, "#trapFocus"
    assert_includes source, "[role=dialog], [role=alertdialog]"
    assert_includes source, "_previouslyFocused"
  end

  def test_command_controller_traps_focus
    source = File.read(File.join(TEMPLATE_ROOT, "command", "command_controller.js"))

    assert_includes source, "#trapFocus"
    assert_includes source, "_previouslyFocused"
  end

  def test_navbar_renders_mobile_menu_target
    source = File.read(File.join(TEMPLATE_ROOT, "navbar", "navbar_component.rb.tt"))

    assert_includes source, 'navbar_target: "menu"'
    assert_includes source, "mobile_menu"
    assert_includes source, "border-b border-border"
  end

  def test_navbar_controller_toggles_menu_target
    source = File.read(File.join(TEMPLATE_ROOT, "navbar", "navbar_controller.js"))

    assert_includes source, "menuTarget"
    assert_includes source, "aria-expanded"
  end

  def test_sheet_reuses_dialog_stimulus_controller
    config = ViewPrimitives::Generators::Components::EXTRA_STIMULUS["sheet"]

    assert_equal "dialog/dialog_controller.js", config[:source]
    assert_equal "dialog", config[:name]
  end

  def test_drawer_reuses_dialog_stimulus_controller
    config = ViewPrimitives::Generators::Components::EXTRA_STIMULUS["drawer"]

    assert_equal "dialog/dialog_controller.js", config[:source]
    assert_equal "dialog", config[:name]
  end

  def test_sheet_template_wires_dialog_stimulus_actions
    source = File.read(File.join(TEMPLATE_ROOT, "sheet", "sheet_component.rb.tt"))

    assert_includes source, 'controller: "dialog"'
    assert_includes source, "click->dialog#open"
    assert_includes source, "click->dialog#close"
    assert_includes source, 'dialog_target: "panel"'
    assert_includes source, "z-10"
    refute_match(/sheet#/, source)
    refute_match(/sheet_target/, source)
  end

  def test_drawer_template_wires_dialog_stimulus_actions
    source = File.read(File.join(TEMPLATE_ROOT, "drawer", "drawer_component.rb.tt"))

    assert_includes source, 'controller: "dialog"'
    assert_includes source, "click->dialog#open"
    assert_includes source, "click->dialog#close"
    assert_includes source, 'dialog_target: "panel"'
    refute_match(/drawer#/, source)
    refute_match(/drawer_target/, source)
  end

  def test_popover_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "popover", "popover_controller.js"),
      "popover should include popover_controller.js"
  end

  def test_dropdown_menu_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "dropdown_menu", "dropdown_controller.js"),
      "dropdown_menu should include dropdown_controller.js"

    source = File.read(File.join(TEMPLATE_ROOT, "dropdown_menu", "dropdown_menu_component.rb.tt"))

    assert_includes source, "UI::Styles::MENU_SEPARATOR"
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

    source = File.read(File.join(TEMPLATE_ROOT, "menubar", "menubar_component.rb.tt"))

    assert_includes source, "UI::Styles::MENU_SEPARATOR"
    assert_includes source, "whitespace-nowrap"

    menu_source = File.read(File.join(TEMPLATE_ROOT, "menubar", "menubar_menu_component.rb.tt"))

    assert_includes menu_source, "w-max min-w-[12rem]"
  end

  def test_command_has_js_controller
    assert_path_exists File.join(TEMPLATE_ROOT, "command", "command_controller.js"),
      "command should include command_controller.js"

    source = File.read(File.join(TEMPLATE_ROOT, "command", "command_component.rb.tt"))

    assert_includes source, "border-b border-border"
    assert_includes source, "UI::Styles::MENU_SEPARATOR"
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
    assert_includes source, "tablet"
    assert_includes source, "aspect-[393/852]"
    assert_includes source, "aspect-[3/2]"
    assert_includes source, "DYNAMIC_ISLAND"
    assert_includes source, "HOME_INDICATOR"
    assert_includes source, "PHONE_SHELL"
    assert_includes source, "TABLET_SHELL"
    assert_includes source, "SCREEN_CONTENT"
    assert_includes source, "w-full max-w-[280px]"
    assert_includes source, "#FF5F57"
  end

  def test_qr_code_supports_src_and_block
    source = File.read(File.join(TEMPLATE_ROOT, "qr_code", "qr_code_component.rb.tt"))

    assert_includes source, "src:"
    assert_includes source, "content"
  end

  # --- Phase 7 (JS) ----------------------------------------------------------

  def test_speed_dial_has_actions_slot_and_controller
    source = File.read(File.join(TEMPLATE_ROOT, "speed_dial", "speed_dial_component.rb.tt"))

    assert_includes source, "renders_many :actions"
    assert_includes source, "speed-dial"
  end

  def test_speed_dial_controller_has_toggle
    js = File.read(File.join(TEMPLATE_ROOT, "speed_dial", "speed_dial_controller.js"))

    assert_includes js, "toggle()"
  end

  def test_gallery_has_lightbox_and_controller
    source = File.read(File.join(TEMPLATE_ROOT, "gallery", "gallery_component.rb.tt"))

    assert_includes source, "gallery"
  end

  def test_gallery_controller_has_open_close
    js = File.read(File.join(TEMPLATE_ROOT, "gallery", "gallery_controller.js"))

    assert_includes js, "open("
    assert_includes js, "close("
  end

  def test_carousel_has_slides_and_controller
    source = File.read(File.join(TEMPLATE_ROOT, "carousel", "carousel_component.rb.tt"))

    assert_includes source, "renders_many :slides"
    assert_includes source, "carousel"
  end

  def test_carousel_controller_has_prev_next
    js = File.read(File.join(TEMPLATE_ROOT, "carousel", "carousel_controller.js"))

    assert_includes js, "prev("
    assert_includes js, "next("
  end

  def test_input_otp_accepts_length
    source = File.read(File.join(TEMPLATE_ROOT, "input_otp", "input_otp_component.rb.tt"))

    assert_includes source, "length:"
    assert_includes source, "input_otp"
  end

  def test_input_otp_controller_auto_advances
    js = File.read(File.join(TEMPLATE_ROOT, "input_otp", "input_otp_controller.js"))

    assert_includes js, "focus"
  end

  def test_sidebar_has_group_and_item_components
    source = File.read(File.join(TEMPLATE_ROOT, "sidebar", "sidebar_component.rb.tt"))

    assert_includes source, "GroupComponent"
    assert_includes source, "ItemComponent"
    assert_includes source, "collapsed"
    assert_includes source, "group-data-[collapsed=true]:hidden"
    refute_includes source, "-mt-8"
  end

  def test_sidebar_controller_has_toggle
    js = File.read(File.join(TEMPLATE_ROOT, "sidebar", "sidebar_controller.js"))

    assert_includes js, "toggle()"
  end

  def test_resizable_has_panel_component
    source = File.read(File.join(TEMPLATE_ROOT, "resizable", "resizable_component.rb.tt"))

    assert_includes source, "PanelComponent"
    assert_includes source, "renders_many :panels"
    assert_includes source, "HANDLE_VERTICAL"
    assert_includes source, "HANDLE_GRIP_VERTICAL"
    assert_includes source, "min-h-0"
  end

  def test_resizable_controller_handles_drag
    js = File.read(File.join(TEMPLATE_ROOT, "resizable", "resizable_controller.js"))

    assert_includes js, "startDrag"
    assert_includes js, "mousemove"
  end

  def test_calendar_renders_month_grid
    source = File.read(File.join(TEMPLATE_ROOT, "calendar", "calendar_component.rb.tt"))

    assert_includes source, "beginning_of_month"
    assert_includes source, "DAYS_OF_WEEK"
    assert_includes source, "calendar"
  end

  def test_calendar_controller_has_select_and_nav
    js = File.read(File.join(TEMPLATE_ROOT, "calendar", "calendar_controller.js"))

    assert_includes js, "selectDay"
    assert_includes js, "prevMonth"
    assert_includes js, "nextMonth"
  end

  def test_date_picker_embeds_calendar
    source = File.read(File.join(TEMPLATE_ROOT, "date_picker", "date_picker_component.rb.tt"))

    assert_includes source, "CalendarComponent"
    assert_includes source, "date-picker"
    assert_includes source, "UI::Styles::PICKER_TRIGGER"
    refute_includes source, "POPOVER_PANEL"
  end

  def test_date_picker_controller_opens_closes
    js = File.read(File.join(TEMPLATE_ROOT, "date_picker", "date_picker_controller.js"))

    assert_includes js, "open()"
    assert_includes js, "close()"
    assert_includes js, "dateSelected"
  end

  def test_timepicker_uses_picker_trigger_and_field_panel
    source = File.read(File.join(TEMPLATE_ROOT, "timepicker", "timepicker_component.rb.tt"))

    assert_includes source, "UI::Styles::PICKER_TRIGGER"
    assert_includes source, "UI::Styles::FIELD_PANEL"
    refute_includes source, "POPOVER_PANEL"
  end

  def test_utilities_define_vp_border
    css = File.read(File.expand_path("../lib/generators/view_primitives/install/templates/view_primitives/utilities.css", __dir__))

    assert_includes css, "@utility vp-border"
    assert_includes css, "border-border"
  end

  def test_styles_module_exports_border_and_picker_constants
    source = File.read(File.expand_path("../lib/generators/view_primitives/install/templates/styles.rb.tt", __dir__))

    assert_includes source, "BORDER = \"vp-border\""
    assert_includes source, "FIELD_PANEL"
    assert_includes source, "PICKER_TRIGGER"
  end

  def test_timepicker_supports_h12_and_h24
    source = File.read(File.join(TEMPLATE_ROOT, "timepicker", "timepicker_component.rb.tt"))

    assert_includes source, ":h12"
    assert_includes source, ":h24"
    assert_includes source, "timepicker"
  end

  def test_timepicker_controller_commits_time
    js = File.read(File.join(TEMPLATE_ROOT, "timepicker", "timepicker_controller.js"))

    assert_includes js, "timepicker:change"
  end

  def test_data_table_accepts_columns_and_rows
    source = File.read(File.join(TEMPLATE_ROOT, "data_table", "data_table_component.rb.tt"))

    assert_includes source, "columns:"
    assert_includes source, "rows:"
    assert_includes source, "data-table"
    assert_includes source, "caption-bottom"
    assert_includes source, "content_tag(:caption"
    assert_includes source, "[&_tr]:border-b"
    assert_includes source, "p-2 align-middle"
    refute_includes source, "caption_bar"
    refute_includes source, "bg-muted/40"
  end

  def test_data_table_controller_supports_sort_and_filter
    js = File.read(File.join(TEMPLATE_ROOT, "data_table", "data_table_controller.js"))

    assert_includes js, "filter()"
    assert_includes js, "sort("
  end

  def test_timeline_has_items_slot_and_variants
    source = File.read(File.join(TEMPLATE_ROOT, "timeline", "timeline_component.rb.tt"))

    assert_includes source, "renders_many :items"
    assert_includes source, "VARIANTS"
    assert_includes source, ":success"
    assert_includes source, ":destructive"
    assert_includes source, ":warning"
  end

  def test_timeline_item_accepts_date_title_description
    source = File.read(File.join(TEMPLATE_ROOT, "timeline", "timeline_component.rb.tt"))

    assert_includes source, "title:"
    assert_includes source, "date:"
    assert_includes source, "description:"
  end

  def test_toaster_has_toasts_slot_and_variants
    source = File.read(File.join(TEMPLATE_ROOT, "toaster", "toaster_component.rb.tt"))

    assert_includes source, "renders_many :toasts"
    assert_includes source, ":success"
    assert_includes source, ":destructive"
    assert_includes source, ":warning"
    assert_includes source, ":info"
  end

  def test_toaster_item_accepts_message_title_duration
    source = File.read(File.join(TEMPLATE_ROOT, "toaster", "toaster_component.rb.tt"))

    assert_includes source, "message:"
    assert_includes source, "title:"
    assert_includes source, "duration:"
  end

  def test_toaster_controller_handles_add_and_dismiss
    js = File.read(File.join(TEMPLATE_ROOT, "toaster", "toaster_controller.js"))

    assert_includes js, "add("
    assert_includes js, "dismiss("
    assert_includes js, "toaster:add"
  end

  def test_chart_renders_canvas_with_type_and_config
    source = File.read(File.join(TEMPLATE_ROOT, "chart", "chart_component.rb.tt"))

    assert_includes source, "datasets:"
    assert_includes source, "chart_type_value"
    assert_includes source, "chart_config_value"
    assert_includes source, "tag.canvas"
  end

  def test_chart_validates_type
    source = File.read(File.join(TEMPLATE_ROOT, "chart", "chart_component.rb.tt"))

    assert_includes source, "TYPES"
    assert_includes source, "bar"
    assert_includes source, "line"
    assert_includes source, "pie"
  end

  def test_chart_controller_uses_chartjs_adapter
    js = File.read(File.join(TEMPLATE_ROOT, "chart", "chart_controller.js"))

    assert_includes js, "import { Chart"
    assert_includes js, "connect("
    assert_includes js, "disconnect("
    assert_includes js, "destroy"
  end

  def test_chart_has_setup_note
    components_rb = File.read(File.expand_path("../lib/generators/view_primitives/components.rb", __dir__))

    assert_includes components_rb, "SETUP_NOTES"
    assert_includes components_rb, '"chart"'
    assert_includes components_rb, "chart.js"
    assert_includes components_rb, "importmap"
  end

  def test_wysiwyg_supports_trix_and_quill_adapters
    source = File.read(File.join(TEMPLATE_ROOT, "wysiwyg", "wysiwyg_component.rb.tt"))

    assert_includes source, "ADAPTERS"
    assert_includes source, "trix"
    assert_includes source, "quill"
  end

  def test_wysiwyg_defaults_to_trix
    source = File.read(File.join(TEMPLATE_ROOT, "wysiwyg", "wysiwyg_component.rb.tt"))

    assert_includes source, "adapter: :trix"
  end

  def test_wysiwyg_trix_renders_trix_editor_element
    source = File.read(File.join(TEMPLATE_ROOT, "wysiwyg", "wysiwyg_component.rb.tt"))

    assert_includes source, "trix-editor"
    assert_includes source, "type: \"hidden\""
  end

  def test_wysiwyg_quill_wires_stimulus_controller
    source = File.read(File.join(TEMPLATE_ROOT, "wysiwyg", "wysiwyg_component.rb.tt"))

    assert_includes source, "controller: \"wysiwyg\""
    assert_includes source, "wysiwyg_target: \"editor\""
    assert_includes source, "wysiwyg_target: \"input\""
  end

  def test_wysiwyg_controller_imports_quill_dynamically
    js = File.read(File.join(TEMPLATE_ROOT, "wysiwyg", "wysiwyg_controller.js"))

    assert_includes js, "import(\"quill\")"
    assert_includes js, "connect("
    assert_includes js, "disconnect("
  end

  def test_wysiwyg_has_setup_note
    components_rb = File.read(File.expand_path("../lib/generators/view_primitives/components.rb", __dir__))

    assert_includes components_rb, '"wysiwyg"'
    assert_includes components_rb, "actiontext"
    assert_includes components_rb, "esm.sh/quill"
  end

  def test_map_area_renders_img_and_map_elements
    source = File.read(File.join(TEMPLATE_ROOT, "map_area", "map_area_component.rb.tt"))

    assert_includes source, "usemap:"
    assert_includes source, "tag.img"
    assert_includes source, "content_tag(:map"
    assert_includes source, "tag.area"
  end

  def test_map_area_accepts_areas_array
    source = File.read(File.join(TEMPLATE_ROOT, "map_area", "map_area_component.rb.tt"))

    assert_includes source, "areas:"
    assert_includes source, ":rect"
    assert_includes source, ":circle"
    assert_includes source, ":poly"
  end

  def test_map_area_auto_generates_map_name
    source = File.read(File.join(TEMPLATE_ROOT, "map_area", "map_area_component.rb.tt"))

    assert_includes source, "SecureRandom.hex"
  end

  def test_embed_supports_all_providers
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    %w[youtube vimeo spotify google_maps yandex_maps loom soundcloud x telegram facebook].each do |provider|
      assert_includes source, ":#{provider}", "missing provider :#{provider}"
    end
  end

  def test_embed_has_no_explicit_type_param
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "def initialize(url: nil, query: nil"
    refute_includes source, "type: nil"
    refute_includes source, "id: nil"
  end

  def test_embed_auto_detects_provider_from_url
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "detect_provider"
    assert_includes source, "DOMAIN_MAP"
  end

  def test_embed_builds_youtube_url
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "youtube.com/embed"
    assert_includes source, "extract_youtube_id"
  end

  def test_embed_builds_vimeo_url
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "player.vimeo.com/video"
  end

  def test_embed_builds_spotify_url
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "open.spotify.com/embed"
    assert_includes source, "extract_spotify_path"
  end

  def test_embed_builds_google_maps_url
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "maps.google.com/maps"
    assert_includes source, "CGI.escape"
  end

  def test_embed_builds_yandex_maps_url
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "map-widget/v1"
    assert_includes source, "yandex_maps_url"
  end

  def test_embed_has_sandbox_per_provider
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "PROVIDERS"
    assert_includes source, "sandbox:"
  end

  def test_embed_uses_aspect_ratio_for_video_providers
    source = File.read(File.join(TEMPLATE_ROOT, "embed", "embed_component.rb.tt"))

    assert_includes source, "aspect-ratio"
    assert_includes source, '"16/9"'
  end
end
