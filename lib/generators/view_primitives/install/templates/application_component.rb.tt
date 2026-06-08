# frozen_string_literal: true

class ApplicationComponent < ViewComponent::Base
  include ViewPrimitives::ClassHelper

  private

  def extract_html_attrs(**html_attrs)
    @extra_class = html_attrs.delete(:class)
    @html_attrs = html_attrs
  end
end
