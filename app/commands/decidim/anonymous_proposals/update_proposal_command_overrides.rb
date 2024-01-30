# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module UpdateProposalCommandOverrides
      extend ActiveSupport::Concern

      include Decidim::AnonymousProposals::AnonymousBehaviorCommandsConcern

      def initialize(form, current_user, proposal)
        @form = form
        @selected_user_group = Decidim::UserGroup.find_by(organization: organization, id: form.user_group_id)
        @proposal = proposal
        @attached_to = proposal
        @is_anonymous = allow_anonymous_proposals? && (current_user.blank? || proposal.authored_by?(anonymous_group))
        set_current_user(current_user)
      end

      private

      def component
        @component ||= form.current_component
      end
    end
  end
end
