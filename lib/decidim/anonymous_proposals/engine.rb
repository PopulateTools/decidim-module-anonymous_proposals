# frozen_string_literal: true

require "rails"
require "decidim/core"

module Decidim
  module AnonymousProposals
    # This is the engine that runs on the public interface of anonymous_proposals.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::AnonymousProposals

      routes do
        # Add engine routes here
        # resources :anonymous_proposals
        # root to: "anonymous_proposals#index"
      end

      initializer "decidim_anonymous_proposals.assets" do |app|
        app.config.assets.precompile += %w(decidim_anonymous_proposals_manifest.js decidim_anonymous_proposals_manifest.css)
      end
    end
  end
end
