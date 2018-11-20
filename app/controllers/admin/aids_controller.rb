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
      of_aids = find_filters_params["ids"].map { |e| e.to_i  }
      p '- - - - - - - - - - - - - - find_filters- - - - - - - - - - - - - - - -' 
      pp of_aids
      p ''
      activated = ActivatedModelsService.instance
      selected_aids = activated.aids.select { |aid| of_aids.include?(aid["id"])  }

      render json: {
        status: "ok",
        aids_size: selected_aids.size
      }
    end

    def find_filters_params
      params.permit(:ids => []).to_h
    end

  end
end
