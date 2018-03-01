module Api
  module V1
    class ApiAidesController < Api::V1::ApiController

      before_action :authenticate_user

      def index
        if current_user
          p '- - - - - - - - - - - - - - current_user- - - - - - - - - - - - - - - -' 
          p current_user.inspect
          p params[:v_duree_d_inscription]
          p ''

        else
          p ' - - - - - - - -no current_user'
        end
      end

    end
  end
end
