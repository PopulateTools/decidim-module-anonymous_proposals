# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module PermissionsOverrides
      extend ActiveSupport::Concern

      def permissions
        return permission_action unless user_or_anonymous_action?(permission_action)

        # Delegate the admin permission checks to the admin permissions class
        return Decidim::Proposals::Admin::Permissions.new(user, permission_action, context).permissions if permission_action.scope == :admin
        return permission_action if permission_action.scope != :public

        case permission_action.subject
        when :proposal
          apply_proposal_permissions(permission_action)
        when :collaborative_draft
          apply_collaborative_draft_permissions(permission_action)
        else
          permission_action
        end

        permission_action
      end

      private

      def user_or_anonymous_action?(permission_action)
        user || [:create, :edit].include?(permission_action.action) && allow_anonymous_proposals?
      end

      def allow_anonymous_proposals?
        Decidim::UserGroup.where(organization: organization).anonymous.exists? && component_settings.anonymous_proposals_enabled?
      end

      def organization
        @organization ||= context.fetch(:organization, nil) || context.fetch(:current_organization, nil)
      end
    end
  end
end
