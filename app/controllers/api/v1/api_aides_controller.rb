module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user
      respond_to :json
      swagger_controller :posts, 'Posts'

      swagger_api :index do
        summary 'Returns all posts'
        notes 'Notes...'
      end

      def index
        if current_user
          p '- - - - - - - - - - - - - - current_user- - - - - - - - - - - - - - - -' 
          p current_user.inspect
          p ''

        else
          p ' - - - - - - - -no current_user'
        end
      end

    end
  end
end
