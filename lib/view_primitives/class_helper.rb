# frozen_string_literal: true

module ViewPrimitives
  module ClassHelper
    private

    def cn(*classes)
      merged = classes.flatten.compact.reject(&:empty?).join(" ")
      return merged unless defined?(::TailwindMerge::Merger)

      ::TailwindMerge::Merger.new.merge(merged)
    end
  end
end
