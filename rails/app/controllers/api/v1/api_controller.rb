module Api
  module V1
    class ApiController < ActionController::API
      include Knock::Authenticable

      def authenticate_v1_user
        authenticate_for ApiUser
      end

    end
  end
end
