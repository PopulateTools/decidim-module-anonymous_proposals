# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    module CoauthorableOverrides
      extend ActiveSupport::Concern

      included do
        def add_coauthor(author, extra_attributes = {})
          return if author.blank? && persisted?

          author = anonymous_group if author.blank? && allow_anonymous_proposals?

          user_group = extra_attributes[:user_group]

          return if coauthorships.exists?(decidim_author_id: author.id, decidim_author_type: author.class.base_class.name) && user_group.blank?
          return if user_group && coauthorships.exists?(user_group: user_group)

          coauthorship_attributes = extra_attributes.merge(author: author)

          if persisted?
            coauthorships.create!(coauthorship_attributes)
          else
            coauthorships.build(coauthorship_attributes)
          end

          authors << author
        end

        private

        def allow_anonymous_proposals?
          component.settings.anonymous_proposals_enabled?
        end

        def anonymous_group
          Decidim::UserGroup.where(organization: organization).anonymous.first
        end
      end
    end
  end
end
