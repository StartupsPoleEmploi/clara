module Admin
  class AidsController < Admin::ApplicationController
    def find_resource(param)
      Aid.find_by!(slug: param)
    end

    def show 
      @asker = Asker.new
      super
    end
    
    def find_filters 
      p '- - - - - - - - - - - - - - find_filters- - - - - - - - - - - - - - - -' 
      pp find_filters_params.to_h
      p ''
      of_aids = find_filters_params
      

      render json: {
        status: "ok"
      }
    end

    def find_filters_params
      params.permit(:ids => []).to_h
    end

  end
end
