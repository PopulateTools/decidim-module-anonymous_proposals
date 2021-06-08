# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module PublishProposalCommandOverrides
      extend ActiveSupport::Concern

      def initialize(proposal, current_user)
        @proposal = proposal
        @current_user = current_user
        @current_user ||= anonymous_group if allow_anonymous_proposals?
      end

      private

      def anonymous_group
        Decidim::UserGroup.where(organization: @proposal.organization).anonymous.first
      end

      def allow_anonymous_proposals?
        @proposal.component.settings.anonymous_proposals_enabled?
      end
    end
  end
end
