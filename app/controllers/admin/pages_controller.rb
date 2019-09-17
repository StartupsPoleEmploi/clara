require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

    def rule_creation

      aid = Aid.find_by(slug: params[:aid])

      gon.global_state = {
        explicitations: _all_explicitations,
        operator_kinds: _all_operator_kinds,        
        variables: _all_variables,        
      }

      gon.initial_scope = ExtractScopeForAid.new.call(aid)
      
      render locals: {
        aid: aid ? aid.attributes.with_indifferent_access : nil
      }
    end
    def post_rule_creation
      aid_slug = params["aid"]
      trundle = JSON.parse(params["trundle"], symbolize_names: true)
      geo_town = params["geo_town"]
      geo_dep = params["geo_dep"]
      geo_region = params["geo_region"]
      # geo_dep = JSON.parse(params["geo_dep"], symbolize_names: true)
      # geo_region = JSON.parse(params["geo_region"], symbolize_names: true)

      ap geo_town
      ap geo_dep
      ap geo_region

      url = admin_aid_path(aid_slug)
      aid = Aid.find_by(slug: aid_slug)

      fail 'Stop here please'

      CreateScopeForAid.new.call(scope: {trundle: trundle}, aid: aid)

      flash[:notice] = "Mise à jour du champ d'application effectué."
      flash.keep(:notice)
      render js: "document.location = '#{url}'"
    end



    def _all_explicitations 
      JSON.parse(Explicitation.all.to_json(:only => [ :id, :value_eligible, :operator_kind, :template ], :include => {variable: {only:[:name]}})).map{|e| e["variable_name"] = e["variable"]["name"];e.delete("variable");e}
    end
    def _all_operator_kinds
      ListOperatorKind.new.call
    end
    def _all_variables
      JSON.parse(Variable.all.to_json(:only => [ :id, :name, :variable_kind, :elements, :elements_translation, :is_visible, :name_translation ]))
    end


    def get_delete_trace
    end
    def post_delete_trace
      Trace.destroy_all
    end

    # load zrr
    def get_zrr
    end
    def post_zrr
      deleted_zrrs_cache = Rails.cache.delete("zrrs")
      Zrr.create unless Zrr.first
      z = Zrr.first
      z.value = _csv_data
      z.save
      render json: {
        deleted_zrrs_cache: deleted_zrrs_cache,
        status: "ok"
      }
    end

    # cache
    def get_cache
    end
    def post_cache
      ExpireCache.new.call
      render json: {
        status: "ok"
      }
    end

    # refdata
    def get_ref_data
    end
    def post_ref_data
      Rails.application.load_seed
    end


    # transfer anything
    def get_transfer_descr
    end
    def post_transfer_descr
      render json: {
        status: "ok"
      }
    end


  end
end
