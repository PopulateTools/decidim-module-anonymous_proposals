# frozen_string_literal: true

module Decidim
  module AnonymousProposals
    # This is the engine that runs on the public interface of `AnonymousProposals`.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::AnonymousProposals::Admin

      paths["db/migrate"] = nil
      paths["lib/tasks"] = nil

      routes do
        # Add admin engine routes here
        # resources :anonymous_proposals do
        #   collection do
        #     resources :exports, only: [:create]
        #   end
        # end
        # root to: "anonymous_proposals#index"
      end

      def load_seed
        nil
      end
    end
  end
end
