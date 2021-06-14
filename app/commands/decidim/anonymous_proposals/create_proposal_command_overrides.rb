# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module CreateProposalCommandOverrides
      extend ActiveSupport::Concern

      def initialize(form, current_user, coauthorships = nil)
        @form = form
        @current_user = current_user
        @current_user ||= anonymous_group if allow_anonymous_proposals?
        @coauthorships = coauthorships
      end

      private

      def anonymous_group
        Decidim::UserGroup.where(organization: organization).anonymous.first
      end

      def allow_anonymous_proposals?
        form.current_component.settings.anonymous_proposals_enabled?
      end

      def organization
        @organization ||= form.current_organization
      end
    end
  end
end
