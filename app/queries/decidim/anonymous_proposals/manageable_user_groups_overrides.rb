# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Additions to disable filters
    module ManageableUserGroupsOverrides
      extend ActiveSupport::Concern

      def query
        return Decidim::UserGroup.none if user.blank?

        user
          .user_groups
          .includes(:memberships)
          .where(decidim_user_group_memberships: { role: %w(admin creator) })
      end
    end
  end
end
