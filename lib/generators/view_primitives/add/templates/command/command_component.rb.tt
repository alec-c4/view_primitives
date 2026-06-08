# frozen_string_literal: true

module UI
  class CommandComponent < ApplicationComponent
    renders_one :trigger

    OVERLAY = UI::Styles::OVERLAY
    DIALOG  = "fixed top-[50%] left-[50%] z-50 grid w-full max-w-[calc(100%-2rem)] " \
              "translate-x-[-50%] translate-y-[-50%] overflow-hidden rounded-lg #{UI::Styles::BORDER} bg-background " \
              "p-0 shadow-lg duration-200 sm:max-w-lg"
    COMMAND = "flex h-full w-full flex-col overflow-hidden rounded-md bg-popover text-popover-foreground"
    SEARCH  = "flex h-9 items-center gap-2 border-b border-border px-3"
    LIST    = "max-h-[300px] scroll-py-1 overflow-x-hidden overflow-y-auto"
    EMPTY   = "py-6 text-center text-sm text-muted-foreground"

    # Wrap each group of items in a div with this class.
    GROUP_WRAPPER = "overflow-hidden p-1 text-foreground"
    # Apply to the heading element (p/span) inside a group wrapper.
    GROUP         = "px-2 py-1.5 text-xs font-medium text-muted-foreground"
    # Apply to each actionable item button/link.
    ITEM          = "#{UI::Styles::MENU_ITEM} w-full cursor-default data-[selected=true]:bg-accent " \
                    "data-[selected=true]:text-accent-foreground hover:bg-accent hover:text-accent-foreground " \
                    "[&_svg]:pointer-events-none [&_svg]:shrink-0 [&_svg:not([class*='size-'])]:size-4 " \
                    "[&_svg:not([class*='text-'])]:text-muted-foreground"
    # Place inside an ITEM as the last child to show a keyboard shortcut on the right.
    SHORTCUT      = "ml-auto text-xs tracking-widest text-muted-foreground"
    # Horizontal rule between groups (`<div role="separator">`).
    SEPARATOR     = UI::Styles::MENU_SEPARATOR

    def initialize(**html_attrs)
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div, data: { controller: "command" }, **@html_attrs) do
        concat content_tag(:span, trigger, data: { action: "click->command#open" }, class: "contents") if trigger
        concat panel
      end
    end

    private

    def panel
      content_tag(:div, data: { command_target: "panel" }, hidden: true) do
        concat content_tag(:div, nil,
          class: OVERLAY,
          data: { action: "click->command#close" },
          "aria-hidden": "true")
        concat content_tag(:div,
          class: cn(DIALOG, @extra_class),
          role: "dialog",
          "aria-modal": "true",
          data: { action: "keydown.escape@window->command#close" }) {
          concat content_tag(:div, class: COMMAND) {
            concat search_bar
            concat content_tag(:div, class: LIST, data: { command_target: "list" }) {
              concat content
            }
            concat content_tag(:div, "No results found.",
              class: EMPTY,
              data: { command_target: "empty" },
              hidden: true)
          }
        }
      end
    end

    def search_bar
      content_tag(:div, class: SEARCH) do
        concat search_icon
        concat tag.input(
          type: "text",
          placeholder: "Type a command or search...",
          class: "flex h-10 w-full rounded-md bg-transparent py-3 text-sm outline-hidden " \
                  "placeholder:text-muted-foreground disabled:cursor-not-allowed disabled:opacity-50",
          data: {
            command_target: "input",
            action: "input->command#filter"
          }
        )
      end
    end

    def search_icon
      raw('<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="size-4 shrink-0 opacity-50" aria-hidden="true"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.3-4.3"/></svg>')
    end
  end
end
