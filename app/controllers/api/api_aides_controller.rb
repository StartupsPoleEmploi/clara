module Api
  class ApiAidesController < Api::ApiController

    before_action :authenticate_user

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
