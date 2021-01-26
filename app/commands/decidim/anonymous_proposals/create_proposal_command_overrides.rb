# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Method overrides to avoid errors when current_user is not present
    module CreateProposalCommandOverrides
      extend ActiveSupport::Concern

      def initialize(form, current_user, coauthorships = nil)
        @form = form
        @current_user = current_user || Decidim::UserGroup.where(organization: organization).anonymous.first
        @coauthorships = coauthorships
      end

      private

      def organization
        @organization ||= form.current_organization
      end
    end
  end
end
