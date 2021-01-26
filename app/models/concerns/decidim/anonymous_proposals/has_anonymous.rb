# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    module HasAnonymous
      extend ActiveSupport::Concern

      included do
        scope :anonymous, -> { where.not("extended_data->>'anonymous' IS ?", nil) }
      end
    end
  end
end
