# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Additions to disable filters
    module ProposalsControllerAdditions
      extend ActiveSupport::Concern

      included do
        helper_method :allow_anonymous_proposals?, :is_anonymous?, :anonymous_group

        skip_before_action :authenticate_user!, if: :allow_anonymous_proposals?
      end

      private

      def allow_anonymous_proposals?
        anonymous_group.present? && component_settings.anonymous_proposals_enabled?
      end

      def is_anonymous?
        allow_anonymous_proposals? && (current_user.blank? || @proposal&.authored_by?(anonymous_group))
      end

      def anonymous_group
        @anonymous_group ||= Decidim::UserGroup.where(organization: current_organization).anonymous.first
      end

      def anonymous_group_present?
        Decidim::UserGroup.where(organization: current_organization).anonymous.exists?
      end
    end
  end
end
