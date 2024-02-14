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
        @editable = allow_anonymous_proposals? && proposal.authored_by?(anonymous_group) || proposal.editable_by?(current_user)
        @is_anonymous = allow_anonymous_proposals? && (current_user.blank? || (proposal.published? ? proposal.authored_by?(anonymous_group) : @selected_user_group == anonymous_group))
        set_current_user(current_user)
      end

      private

      def component
        @component ||= form.current_component
      end

      def invalid?
        !@editable || form.invalid? || proposal_limit_reached?
      end
    end
  end
end
