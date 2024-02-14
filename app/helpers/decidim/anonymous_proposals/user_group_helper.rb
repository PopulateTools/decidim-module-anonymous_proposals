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

        user_groups = Decidim::UserGroups::ManageableUserGroups.for(current_user).verified

        if allow_anonymous_proposals?
          anonymous_group_extension = anonymous_group.present? ? [[t("anonymous_user", scope: "decidim.proposals.proposals.new"), anonymous_group.id]] : []
          selected_group_id = (@form.user_group_id || options[:select_anonymous] && anonymous_group&.id).presence

          form.select(
            name,
            user_groups.map { |g| [g.name, g.id] } + anonymous_group_extension,
            selected: selected_group_id,
            include_blank: current_user.name,
            label: options.has_key?(:label) ? options[:label] : true
          )
        else
          return user_group_select_field(form, name, options) if current_organization.user_groups_enabled? && user_groups.any?
        end
      end
    end
  end
end
