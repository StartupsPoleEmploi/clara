module Api
  module V1
    class ApiController < ActionController::API
      include Knock::Authenticable

      def authenticate_api_user
        unauthorized_entity('ApiUser') unless authenticate_entity('ApiUser')
      end

    end
  end
end
