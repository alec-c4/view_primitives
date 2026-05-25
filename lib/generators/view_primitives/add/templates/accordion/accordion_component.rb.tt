# frozen_string_literal: true

module UI
  class AccordionComponent < ApplicationComponent
    renders_many :items, "UI::AccordionItemComponent"

    # items:     array shorthand — each entry: { title:, content:, open: (optional) }
    # exclusive: when true, opening one item closes all others via Stimulus
    def initialize(items: nil, exclusive: false)
      @items_data = Array(items)
      @exclusive = exclusive
    end

    private

    def wrapper_attrs
      return {} unless @exclusive

      { data: { controller: "accordion", action: "click->accordion#toggle" } }
    end
  end
end
