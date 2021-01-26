# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module UpdateProposalCommandOverrides
      extend ActiveSupport::Concern

      def initialize(form, current_user, proposal)
        @form = form
        @current_user = current_user || Decidim::UserGroup.where(organization: organization).anonymous.first
        @proposal = proposal
        @attached_to = proposal
      end

      private

      def organization
        @organization ||= form.current_organization
      end
    end
  end
end
