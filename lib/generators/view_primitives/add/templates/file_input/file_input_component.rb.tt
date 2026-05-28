# frozen_string_literal: true

module UI
  class FileInputComponent < ApplicationComponent
    BASE = "h-9 w-full min-w-0 cursor-pointer rounded-md border border-input bg-transparent px-3 py-1 text-base shadow-xs " \
           "transition-[color,box-shadow] outline-none " \
           "file:mr-3 file:inline-flex file:h-7 file:cursor-pointer file:border-0 " \
           "file:bg-transparent file:text-sm file:font-medium file:text-foreground " \
           "placeholder:text-muted-foreground " \
           "focus-visible:border-ring focus-visible:ring-[3px] focus-visible:ring-ring/50 " \
           "aria-invalid:border-destructive aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 " \
           "disabled:pointer-events-none disabled:cursor-not-allowed disabled:opacity-50 " \
           "md:text-sm dark:bg-input/30"

    # accept:   MIME types or extensions, e.g. "image/*" or ".pdf,.docx"
    # multiple: allow selecting multiple files
    def initialize(accept: nil, multiple: false, **html_attrs)
      @accept   = accept
      @multiple = multiple
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      attrs = { type: "file", class: cn(BASE, @extra_class) }
      attrs[:accept]   = @accept if @accept
      attrs[:multiple] = true    if @multiple
      content_tag(:input, nil, **attrs, **@html_attrs)
    end
  end
end
