module Api
  module V1
    class ApiController < ActionController::API
      include Knock::Authenticable
    end
  end
end
