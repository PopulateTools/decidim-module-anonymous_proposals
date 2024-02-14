module Decidim
  module AnonymousProposals
    module AnonymousBehaviorCommandsConcern
      private

      def is_anonymous?
        @is_anonymous
      end

      def anonymous_group
        Decidim::UserGroup.where(organization: organization).anonymous.first
      end

      def set_current_user(user)
        @current_user = is_anonymous? ? anonymous_group : user
      end

      def user_group
        return if is_anonymous?

        @selected_user_group
      end

      def allow_anonymous_proposals?
        component.settings.anonymous_proposals_enabled?
      end

      def organization
        @organization ||= component.organization
      end
    end
  end
end
