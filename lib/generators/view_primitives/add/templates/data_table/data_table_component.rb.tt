# frozen_string_literal: true

module UI
  class DataTableComponent < ApplicationComponent
    # Sortable, filterable data table with client-side pagination.
    # Table cell styles follow shadcn/ui Table primitives.
    #
    # columns: array of { key:, label:, sortable: true }
    # rows:    array of hashes (keys must match column keys)
    # per_page: rows per page (default 10, 0 = no pagination)
    # caption:  optional <caption> text

    WRAPPER    = "w-full overflow-hidden rounded-md #{UI::Styles::BORDER} bg-background"
    TABLE_WRAP = "relative w-full overflow-x-auto"
    TOOLBAR    = "flex items-center gap-3 border-b border-border px-4 py-3"
    SEARCH_CLS = "flex h-9 w-full max-w-sm items-center gap-2 rounded-md border border-input bg-transparent px-3 " \
                 "text-sm shadow-xs transition-[color,box-shadow] " \
                 "focus-within:border-ring focus-within:ring-[3px] focus-within:ring-ring/50 " \
                 "dark:bg-input/30"
    SEARCH_INPUT = "w-full bg-transparent text-sm text-foreground outline-none placeholder:text-muted-foreground"
    TABLE_CLS  = "w-full caption-bottom text-sm"
    THEAD_CLS  = "[&_tr]:border-b [&_tr]:border-border"
    TH_CLS     = "h-10 px-2 text-left align-middle font-medium whitespace-nowrap text-foreground"
    TH_SORT    = "cursor-pointer select-none transition-colors hover:text-foreground/80"
    TBODY_CLS  = "[&_tr:last-child]:border-0"
    TR_CLS     = "border-b border-border transition-colors hover:bg-muted/50"
    TD_CLS     = "p-2 align-middle whitespace-nowrap"
    CAPTION_CLS = "mt-4 text-sm text-muted-foreground"
    FOOTER_CLS = "flex items-center justify-between gap-4 border-t border-border px-4 py-3 text-sm text-muted-foreground"
    PAGE_BTN   = "inline-flex size-8 shrink-0 items-center justify-center rounded-md border border-input bg-background " \
                 "text-sm font-medium shadow-xs transition-all outline-none " \
                 "hover:bg-accent hover:text-accent-foreground " \
                 "#{UI::Styles::FOCUS_RING} " \
                 "disabled:pointer-events-none disabled:opacity-50 " \
                 "dark:border-input dark:bg-input/30 dark:hover:bg-input/50"
    SORT_ASC   = "▲"
    SORT_DESC  = "▼"

    def initialize(columns:, rows:, per_page: 10, caption: nil, **html_attrs)
      @columns   = columns
      @rows      = rows
      @per_page  = per_page.to_i
      @caption   = caption
      @extra_class = html_attrs.delete(:class)
      @html_attrs  = html_attrs
    end

    def call
      content_tag(:div,
        class: cn(WRAPPER, @extra_class),
        data: {
          controller: "data-table",
          data_table_per_page_value: @per_page,
          data_table_total_value: @rows.size
        },
        **@html_attrs) do
        concat toolbar
        concat table_section
        concat footer if @per_page > 0
      end
    end

    private

    def toolbar
      content_tag(:div, class: TOOLBAR) do
        concat search_box
      end
    end

    def search_box
      content_tag(:label, class: SEARCH_CLS) do
        concat search_icon
        concat tag.input(
          type: "search", class: SEARCH_INPUT,
          placeholder: "Search…",
          data: {
            data_table_target: "search",
            action: "input->data-table#filter"
          })
      end
    end

    def table_section
      content_tag(:div, class: TABLE_WRAP) do
        content_tag(:table, class: TABLE_CLS) do
          concat thead
          concat tbody
          concat caption_element if @caption
        end
      end
    end

    def caption_element
      content_tag(:caption, @caption, class: CAPTION_CLS)
    end

    def thead
      content_tag(:thead, class: THEAD_CLS) do
        content_tag(:tr) do
          safe_join(@columns.map { |col| th_cell(col) })
        end
      end
    end

    def th_cell(col)
      key     = col[:key].to_s
      label   = col[:label] || key.humanize
      sortable = col.fetch(:sortable, false)

      content_tag(:th, class: cn(TH_CLS, sortable ? TH_SORT : nil),
        data: sortable ? {
          action: "click->data-table#sort",
          data_table_key_param: key,
          data_table_column_key: key
        } : {}) do
        content_tag(:span, class: "flex items-center gap-1") do
          concat label
          if sortable
            concat content_tag(:span, SORT_ASC,
              class: "text-xs opacity-0 data-[active=asc]:opacity-100",
              data: { data_table_target: "sortIndicator", data_table_sort_key: key, data_table_dir: "asc" })
            concat content_tag(:span, SORT_DESC,
              class: "text-xs opacity-0 data-[active=desc]:opacity-100",
              data: { data_table_target: "sortIndicator", data_table_sort_key: key, data_table_dir: "desc" })
          end
        end
      end
    end

    def tbody
      content_tag(:tbody, class: TBODY_CLS, data: { data_table_target: "body" }) do
        safe_join(@rows.map { |row| tr_row(row) })
      end
    end

    def tr_row(row)
      content_tag(:tr, class: TR_CLS, data: { data_table_row: true }) do
        safe_join(@columns.map { |col| td_cell(row, col[:key].to_s) })
      end
    end

    def td_cell(row, key)
      content_tag(:td, row[key.to_sym] || row[key], class: TD_CLS)
    end

    def footer
      content_tag(:div, class: FOOTER_CLS) do
        concat content_tag(:span, "",
          data: { data_table_target: "pageLabel" })
        concat(content_tag(:div, class: "flex shrink-0 items-center gap-1") {
          concat page_btn(prev_icon, "click->data-table#prevPage", "Previous page")
          concat page_btn(next_icon, "click->data-table#nextPage", "Next page")
        })
      end
    end

    def prev_icon
      chevron_svg("left")
    end

    def next_icon
      chevron_svg("right")
    end

    def chevron_svg(direction)
      path = direction == "left" ? "m15 18-6-6 6-6" : "m9 18 6-6-6-6"
      content_tag(:svg, content_tag(:path, nil, d: path),
        xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
        fill: "none", stroke: "currentColor", "stroke-width": "2",
        "stroke-linecap": "round", "stroke-linejoin": "round",
        class: "size-4", "aria-hidden": "true")
    end

    def page_btn(label, action, aria)
      content_tag(:button, label, type: "button",
        class: PAGE_BTN,
        "aria-label": aria,
        data: { action: action })
    end

    def search_icon
      content_tag(:svg,
        safe_join([
          content_tag(:circle, nil, cx: "11", cy: "11", r: "8"),
          content_tag(:path, nil, d: "m21 21-4.3-4.3")
        ]),
        xmlns: "http://www.w3.org/2000/svg", viewBox: "0 0 24 24",
        fill: "none", stroke: "currentColor", "stroke-width": "2",
        "stroke-linecap": "round", "stroke-linejoin": "round",
        class: "size-4 shrink-0 text-muted-foreground", "aria-hidden": "true")
    end
  end
end
