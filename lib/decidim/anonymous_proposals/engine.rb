# frozen_string_literal: true

require "rails"
require "decidim/core"
require "deface"

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

      initializer "decidim_anonymous_proposals.proposals_additions" do
        Decidim::UserGroup.class_eval do
          include Decidim::AnonymousProposals::HasAnonymous
        end

        Decidim::Proposals::Permissions.class_eval do
          prepend Decidim::AnonymousProposals::PermissionsOverrides
        end

        Decidim::Proposals::ProposalsController.class_eval do
          prepend Decidim::AnonymousProposals::ProposalsControllerOverrides
          include Decidim::AnonymousProposals::ProposalsControllerAdditions
        end
      end
    end
  end
end
