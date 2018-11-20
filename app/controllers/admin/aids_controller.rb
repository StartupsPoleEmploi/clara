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
      p '- - - - - - - - - - - - - - selected_aids- - - - - - - - - - - - - - - -' 
      pp selected_aids
      p ''
      raw_aids = selected_aids.map{|aid| aid.select{|x| x == "id" || x.end_with?("filters")} }
      render json: {
        status: "ok",
        aids: raw_aids
      }
    end

    def find_filters_params
      params.permit(:ids => []).to_h
    end

  end
end
