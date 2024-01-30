# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # Custom helpers, scoped to the anonymous_proposals engine.
    #
    module UserGroupHelper
      # Renders a user_group select field in a form including the anonymous
      # option if enabled
      # form - FormBuilder object
      # name - attribute user_group_id
      # options - A hash used to modify the behavior of the select field.
      #
      # Returns nothing.
      def user_group_with_anonymous_select_field(form, name, options = {})
        return unless user_signed_in?
        return user_group_select_field(form, name, options) unless allow_anonymous_proposals?

        user_groups = Decidim::UserGroups::ManageableUserGroups.for(current_user).verified
        anonymous_group_extension = anonymous_group.present? ? [[t("anonymous_user", scope: "decidim.proposals.proposals.new"), anonymous_group.id]] : []

        form.select(
          name,
          user_groups.map { |g| [g.name, g.id] } + anonymous_group_extension,
          selected: @form.user_group_id.presence,
          include_blank: current_user.name,
          label: options.has_key?(:label) ? options[:label] : true
        )
      end
    end
  end
end
