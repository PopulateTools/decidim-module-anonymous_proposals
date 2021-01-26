# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module ProposalsControllerOverrides
      extend ActiveSupport::Concern

      private

      def proposal_draft
        return unless signed_in?

        Decidim::Proposals::Proposal.from_all_author_identities(current_user).not_hidden.only_amendables
                                    .where(component: current_component).find_by(published_at: nil)
      end
    end
  end
end
