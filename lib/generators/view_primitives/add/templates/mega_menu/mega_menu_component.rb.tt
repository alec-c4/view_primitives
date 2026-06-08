# frozen_string_literal: true

module UI
  class MegaMenuComponent < ApplicationComponent
    # Full-width dropdown panel anchored to a trigger button.
    # Columns are rendered via with_column blocks.

    TRIGGER_CLS = "inline-flex h-9 w-max items-center justify-center gap-1.5 rounded-md bg-background " \
                  "px-4 py-2 text-sm font-medium transition-[color,box-shadow] outline-none " \
                  "hover:bg-accent hover:text-accent-foreground " \
                  "#{UI::Styles::FOCUS_RING} " \
                  "data-[state=open]:bg-accent/50 data-[state=open]:text-accent-foreground " \
                  "data-[state=open]:hover:bg-accent"

    PANEL_CLS = "#{UI::Styles::POPOVER_PANEL} left-0 top-full mt-2 w-full overflow-hidden"

    INNER_CLS = "container mx-auto grid gap-6 p-6"

    COLUMN_HEADING = "mb-2 text-xs font-semibold uppercase tracking-wide text-muted-foreground"

    ITEM_CLS = "group flex items-start gap-3 rounded-md p-2 text-sm transition-all outline-none " \
               "hover:bg-accent hover:text-accent-foreground " \
               "#{UI::Styles::FOCUS_RING}"

    ITEM_TITLE = "font-medium leading-none"
    ITEM_DESC  = "mt-1 text-xs leading-normal text-muted-foreground"

    CHEVRON_PATH = "m6 9 6 6 6-6"

    renders_many :columns, "UI::MegaMenuComponent::ColumnComponent"

    # label:   trigger button text
    # cols:    number of columns in the grid (default: auto based on column count)
    def initialize(label:, cols: nil, **html_attrs)
      @label = label
      @cols  = cols
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn("relative", @extra_class),
        data: {
          controller: "mega-menu",
          action: "click@document->mega-menu#closeOnClickOutside"
        },
        **@html_attrs) do
        concat trigger_btn
        concat panel
      end
    end

    private

    def trigger_btn
      content_tag(:button,
        type: "button",
        class: TRIGGER_CLS,
        "aria-expanded": "false",
        data: { mega_menu_target: "trigger", state: "closed",
                action: "click->mega-menu#toggle" }) do
        concat @label
        concat chevron
      end
    end

    def panel
      col_count = @cols || [columns.size, 1].max
      grid_cls  = "grid-cols-#{col_count}"

      content_tag(:div,
        hidden: true,
        class: PANEL_CLS,
        data: { mega_menu_target: "panel" }) do
        content_tag(:div, class: cn(INNER_CLS, grid_cls)) do
          safe_join(columns)
        end
      end
    end

    def chevron
      content_tag(:svg,
        content_tag(:path, nil, d: CHEVRON_PATH, "stroke-linecap": "round", "stroke-linejoin": "round"),
        xmlns: "http://www.w3.org/2000/svg",
        viewBox: "0 0 24 24",
        fill: "none",
        stroke: "currentColor",
        "stroke-width": "2",
        class: "size-4 shrink-0 transition-transform duration-200 group-data-[state=open]:rotate-180",
        "aria-hidden": "true",
        data: { mega_menu_target: "chevron" })
    end

    # A single column inside the mega menu panel.
    # heading: optional column title
    # items:   array of { title:, description:, href: } hashes
    class ColumnComponent < ApplicationComponent
      def initialize(heading: nil, items: [], **html_attrs)
        @heading    = heading
        @items      = items
        @html_attrs = html_attrs
      end

      def call
        content_tag(:div, **@html_attrs) do
          concat content_tag(:p, @heading, class: MegaMenuComponent::COLUMN_HEADING) if @heading
          concat(content_tag(:ul, class: "space-y-1") {
            safe_join(@items.map { |item| render_item(item) })
          })
        end
      end

      private

      def render_item(item)
        content_tag(:li) do
          content_tag(:a,
            href: item.fetch(:href, "#"),
            class: MegaMenuComponent::ITEM_CLS) do
            content_tag(:div) do
              concat content_tag(:p, item[:title], class: MegaMenuComponent::ITEM_TITLE)
              concat content_tag(:p, item[:description], class: MegaMenuComponent::ITEM_DESC) if item[:description]
            end
          end
        end
      end
    end
  end
end
