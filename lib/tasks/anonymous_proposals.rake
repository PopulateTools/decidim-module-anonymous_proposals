# frozen_string_literal: true

namespace :decidim_anonymous_proposals do
  desc "Create anonymous groups for organizations"
  task :generate_anonymous_group, [:name, :nickname, :email, :organization_id] => :environment do |_, args|
    organizations = args.organization_id.present? ? Decidim::Organization.where(id: args.organization_id) : Decidim::Organization.all

    organizations.each do |organization|
      if Decidim::UserGroup.where(organization: organization).anonymous.exists? && (update_args = args.to_h.slice(:name, :nickname, :email)).present?
        Decidim::UserGroup.where(organization: organization).anonymous.first.update(update_args)
      else
        Decidim::UserGroup.where(organization: organization).create(
          name: args.name || "Anonymous",
          nickname: args.nickname || "anonymous",
          email: args.email || "anonymous@example.org",
          extended_data: { anonymous: true }
        )
      end
    end
  end
end
