# frozen_string_literal: true

require_relative "lib/view_primitives/version"

Gem::Specification.new do |spec|
  spec.name = "view_primitives"
  spec.version = ViewPrimitives::VERSION
  spec.authors = ["Alexey Poimtsev"]
  spec.email = ["alexey.poimtsev@gmail.com"]

  spec.summary = "Primitive view components and helpers for Rails applications"
  spec.description = "Provides a set of primitive view components and helpers for building " \
                     "UI in Rails applications with minimal overhead."
  spec.homepage = "https://github.com/alec-c4/view_primitives"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alec-c4/view_primitives"
  spec.metadata["changelog_uri"] = "https://github.com/alec-c4/view_primitives/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.chdir(__dir__) do
    Dir["{lib}/**/*", "LICENSE.txt", "README.md", "CHANGELOG.md"].reject { |f| File.directory?(f) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "railties", ">= 7.0"
  spec.add_dependency "view_component"

  spec.add_development_dependency "rails", ">= 7.0"
  spec.add_development_dependency "simplecov", "~> 0.21"
  spec.add_development_dependency "appraisal"
  spec.add_development_dependency "lefthook"
end
