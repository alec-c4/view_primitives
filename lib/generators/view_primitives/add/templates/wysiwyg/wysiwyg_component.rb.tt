# frozen_string_literal: true

module UI
  class WysiwygComponent < ApplicationComponent
    # Rich-text editor wrapper — picks between Trix and Quill via adapter:.
    #
    # Usage:
    #   ui :wysiwyg, name: "body"                            # Trix (default)
    #   ui :wysiwyg, name: "body", adapter: :quill
    #   ui :wysiwyg, name: "body", adapter: :quill,
    #     placeholder: "Write something...", height: 400
    #
    # Trix setup (ActionText):
    #   bundle add actiontext
    #   rails action_text:install
    #
    # Quill setup:
    #   # config/importmap.rb
    #   pin "quill", to: "https://esm.sh/quill@2"
    #   # In your CSS entry point:
    #   @import url("https://esm.sh/quill@2/dist/quill.snow.css");
    #
    # Options:
    #   name:        form field name (required)
    #   adapter:     :trix (default) | :quill
    #   value:       initial HTML content
    #   placeholder: placeholder text
    #   toolbar:     show editor toolbar (default: true)
    #   height:      editor content area height in px (default: 200; Quill only)

    ADAPTERS = %w[trix quill].freeze

    WRAPPER_CLS = "rounded-md border border-input bg-transparent shadow-xs dark:bg-input/30"
    TRIX_CLS    = "trix-content min-h-[200px] px-3 py-2 text-sm outline-none " \
                  "selection:bg-primary selection:text-primary-foreground " \
                  "#{UI::Styles::FOCUS_RING}"

    def initialize(name:, adapter: :trix, value: nil, placeholder: nil,
                   toolbar: true, height: 200, **html_attrs)
      @name        = name
      @adapter     = ADAPTERS.include?(adapter.to_s) ? adapter.to_s : "trix"
      @value       = value
      @placeholder = placeholder
      @toolbar     = toolbar
      @height      = height
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
      @input_id    = "wysiwyg-#{SecureRandom.hex(4)}"
    end

    def call
      content_tag(:div,
        class: cn(WRAPPER_CLS, @extra_class),
        data: { slot: "wysiwyg" },
        **@html_attrs) do
        @adapter == "quill" ? quill_markup : trix_markup
      end
    end

    private

    def trix_markup
      safe_join([
        tag.input(type: "hidden", id: @input_id, name: @name, value: @value),
        tag.send(:"trix-editor",
          input: @input_id,
          placeholder: @placeholder,
          class: TRIX_CLS)
      ])
    end

    def quill_markup
      content_tag(:div,
        data: {
          controller: "wysiwyg",
          wysiwyg_adapter_value:      "quill",
          wysiwyg_placeholder_value:  @placeholder.to_s,
          wysiwyg_height_value:       @height,
          wysiwyg_toolbar_value:      @toolbar
        }) do
        safe_join([
          tag.div(
            data: { wysiwyg_target: "editor" },
            style: "height: #{@height}px"),
          tag.input(
            type: "hidden",
            name: @name,
            value: @value,
            data: { wysiwyg_target: "input" })
        ])
      end
    end
  end
end
