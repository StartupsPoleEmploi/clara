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
      # aids = JSON.parse(Aid.all.to_json(:only => [ :id, :name, :slug, :short_description, :rule_id, :contract_type_id, :ordre_affichage ], :include => {filters: {only:[:id, :slug]}, custom_filters: {only:[:id, :slug, :custom_parent_filter_id]}, need_filters: {only:[:id, :slug]}}))
      aids = ActivatedModelsService.instance.aids
      selected_aids = aids.select { |aid| of_aids.include?(aid["id"])  }
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
