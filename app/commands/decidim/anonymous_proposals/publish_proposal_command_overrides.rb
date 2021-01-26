# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module PublishProposalCommandOverrides
      extend ActiveSupport::Concern

      def initialize(proposal, current_user)
        @proposal = proposal
        @current_user = current_user || Decidim::UserGroup.where(organization: proposal.organization).anonymous.first
      end
    end
  end
end
