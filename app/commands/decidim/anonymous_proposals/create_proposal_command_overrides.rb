# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module CreateProposalCommandOverrides
      extend ActiveSupport::Concern

      include Decidim::AnonymousProposals::AnonymousBehaviorCommandsConcern

      def initialize(form, current_user, coauthorships = nil)
        @form = form
        @selected_user_group = Decidim::UserGroup.find_by(organization: organization, id: form.user_group_id)
        @is_anonymous = allow_anonymous_proposals? && (current_user.blank? || @selected_user_group == anonymous_group)

        set_current_user(current_user)
        @coauthorships = coauthorships
      end

      private

      def component
        @component ||= form.current_component
      end
    end
  end
end
