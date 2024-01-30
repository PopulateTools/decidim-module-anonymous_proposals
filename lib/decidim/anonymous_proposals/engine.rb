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

      initializer "decidim_anonymous_proposals.proposal_component_settings" do
        component = Decidim.find_component_manifest(:proposals)
        component.settings(:global) do |settings|
          settings.attribute :anonymous_proposals_enabled, type: :boolean, default: false
        end
      end

      initializer "decidim_anonymous_proposals.proposals_additions" do
        config.to_prepare do
          Decidim::UserGroup.class_eval do
            include Decidim::AnonymousProposals::HasAnonymous
          end

          Decidim::Proposals::Permissions.class_eval do
            prepend Decidim::AnonymousProposals::PermissionsOverrides
          end

          Decidim::Proposals::ProposalsHelper.class_eval do
            include Decidim::AnonymousProposals::UserGroupHelper
          end

          Decidim::Proposals::ProposalsController.class_eval do
            prepend Decidim::AnonymousProposals::ProposalsControllerOverrides
            include Decidim::AnonymousProposals::ProposalsControllerAdditions
          end

          Decidim::UserGroups::ManageableUserGroups.class_eval do
            prepend Decidim::AnonymousProposals::ManageableUserGroupsOverrides
          end

          Decidim::Proposals::CreateProposal.class_eval do
            prepend Decidim::AnonymousProposals::CreateProposalCommandOverrides
          end

          Decidim::Proposals::UpdateProposal.class_eval do
            prepend Decidim::AnonymousProposals::UpdateProposalCommandOverrides
          end

          Decidim::Proposals::PublishProposal.class_eval do
            prepend Decidim::AnonymousProposals::PublishProposalCommandOverrides
          end
        end
      end
    end
  end
end
