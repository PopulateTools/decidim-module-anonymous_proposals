# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/anonymous_proposals/version"

Gem::Specification.new do |s|
  s.version = Decidim::AnonymousProposals.version
  s.authors = ["Eduardo Martínez"]
  s.email = ["entantoencuanto.rb@gmail.com"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/PopulateTools/decidim-module-anonymous_proposals"
  s.required_ruby_version = ">= 2.6"

  s.name = "decidim-anonymous_proposals"
  s.summary = "A decidim anonymous_proposals module"
  s.description = "Transform proposals component to allow not signed in users creation of proposals."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE-AGPLv3.txt", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::AnonymousProposals.decidim_version
end
