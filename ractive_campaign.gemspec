# frozen_string_literal: true

require_relative "lib/ractive_campaign/version"

Gem::Specification.new do |spec|
  spec.name = "ractive_campaign"
  spec.version = RactiveCampaign::VERSION
  spec.authors = ["Wedson Lima"]
  spec.email = ["wedson.sousa.lima@gmail.com"]

  spec.summary = "TODO: Write a short summary, because RubyGems requires one."
  spec.description = "TODO: Write a longer description or delete this line."
  spec.homepage = "TODO: Put your gem's website or public repo URL here."
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["homepage_uri"] = spec.homepage
  # spec.metadata["source_code_uri"] = "TODO: Put your gem's public repo URL here."
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "dry-configurable", "~> 0.7.0"
  spec.add_dependency "faraday", "~> 1.4"
  spec.add_dependency "faraday_middleware", "~> 1.0"
  spec.add_dependency "her", "~> 1.1"
end
