# frozen_string_literal: true

module ViewPrimitives
  module ClassHelper
    private

    def cn(*classes)
      classes.flatten.compact.reject(&:empty?).join(" ")
    end
  end
end
