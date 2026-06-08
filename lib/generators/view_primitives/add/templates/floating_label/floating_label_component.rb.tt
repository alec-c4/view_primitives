# frozen_string_literal: true

module UI
  class FloatingLabelComponent < ApplicationComponent
    WRAPPER = "relative w-full"

    # The label floats via CSS peer — it sits inside the input border initially,
    # then rises above when the input is focused or has a value (:not(:placeholder-shown)).
    INPUT_BASE = "peer h-12 w-full min-w-0 rounded-md border border-input bg-transparent px-3 pb-1.5 pt-4 " \
                 "text-base shadow-xs transition-[color,box-shadow] outline-none placeholder:text-transparent " \
                 "#{UI::Styles::FOCUS_RING} " \
                 "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
                 "disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 " \
                 "md:text-sm dark:bg-input/30"

    LABEL_BASE = "pointer-events-none absolute left-3 top-3 origin-[0_0] text-sm text-muted-foreground " \
                 "transition-all duration-200 " \
                 "peer-focus:-translate-y-2 peer-focus:scale-75 peer-focus:text-foreground " \
                 "peer-[:not(:placeholder-shown)]:-translate-y-2 peer-[:not(:placeholder-shown)]:scale-75"

    # label:    visible label text (required)
    # type:     input type, default "text"
    # id:       ties label[for] to input; auto-generated from name if omitted
    def initialize(label:, type: "text", id: nil, **html_attrs)
      @label = label
      @type  = type
      name   = html_attrs[:name]
      @id    = id || html_attrs[:id] || (name ? name.to_s.gsub(/[\[\]]+/, "_") : nil)
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div, class: WRAPPER) do
        concat input_tag
        concat label_tag
      end
    end

    private

    def input_tag
      attrs = { type: @type, placeholder: @label, class: cn(INPUT_BASE, @extra_class) }
      attrs[:id] = @id if @id
      content_tag(:input, nil, **attrs, **@html_attrs)
    end

    def label_tag
      attrs = { class: LABEL_BASE }
      attrs[:for] = @id if @id
      content_tag(:label, @label, **attrs)
    end
  end
end
