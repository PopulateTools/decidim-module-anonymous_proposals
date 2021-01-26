# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Additions to disable filters
    module ProposalsControllerAdditions
      extend ActiveSupport::Concern

      included do
        skip_before_action :authenticate_user!, if: :anonymous_group_present?
      end

      private

      def anonymous_group_present?
        Decidim::UserGroup.where(organization: current_organization).anonymous.exists?
      end
    end
  end
end
