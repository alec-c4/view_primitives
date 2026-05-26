# frozen_string_literal: true

module UI
  class TabsComponent < ApplicationComponent
    renders_many :tabs, "UI::TabsItemComponent"

    # items:         array shorthand — [{ title:, content: }]
    # default_index: which tab is open on load (0-based)
    def initialize(items: nil, default_index: 0, **html_attrs)
      @items_data    = Array(items)
      @default_index = default_index.to_i
      @extra_class   = html_attrs.delete(:class)
      @html_attrs    = html_attrs
    end
  end
end
