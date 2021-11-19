# frozen_string_literal: true

require_relative "lib/active_campaign/version"

Gem::Specification.new do |spec|
  spec.name = "ractive_campaign"
  spec.version = ActiveCampaign::VERSION
  spec.authors = ["Wedson Lima"]
  spec.email = ["wedson.sousa.lima@gmail.com"]

  spec.summary = "Ruby API wrapper for ActiveCampaign API v3"
  spec.description = "Ruby API wrapper for ActiveCampaign API v3"
  spec.homepage = "https://github.com/wedsonlima/ractive_campaign"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata = {
    "homepage_uri"      => spec.homepage,
    "source_code_uri"   => "https://github.com/wedsonlima/ractive_campaign",
    "changelog_uri"     => "https://github.com/wedsonlima/ractive_campaign/blob/main/CHANGELOG.md",
    "documentation_uri" => "https://www.rubydoc.info/gems/ractive_campaign/#{ActiveCampaign::VERSION}",
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end

  spec.require_paths = ["lib"]

  spec.add_dependency "activemodel", "~> 6.1.4"
  spec.add_dependency "dry-configurable", "~> 0.12.1"
  spec.add_dependency "faraday", "~> 1.8.0"
  spec.add_dependency "faraday_middleware", "~> 1.2.0"
end
