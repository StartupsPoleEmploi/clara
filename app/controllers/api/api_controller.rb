module Api
  class ApiController < ActionController::API
    include Knock::Authenticable
  end
end
