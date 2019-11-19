require 'google/apis/analyticsreporting_v4'
require 'csv'    

module Admin
  class PagesController < Admin::ApplicationController

    def rule_creation

      aid = Aid.find_by(slug: params[:aid])

      is_new_aid = IsNewAid.new.call(aid)

      gon.global_state = {
        explicitations: _all_explicitations,
        operator_kinds: _all_operator_kinds,        
        variables: _all_variables,        
      }

      gon.initial_scope = ExtractScopeForAid.new.call(aid)
      gon.initial_geo = ExtractGeoForAid.new.call(aid)

      render locals: {
        aid: aid ? aid.attributes.with_indifferent_access : nil,
        is_new_aid: is_new_aid
      }
    end
    def post_rule_creation
      aid_slug = params["aid"]
      # Need to parse JSON in order to preserve arrays as correct arrays
      trundle = JSON.parse(params["trundle"], symbolize_names: true)
      geo = JSON.parse(params["geo"], symbolize_names: true)
      
      error_message = FindScopeAndGeoErrors.new.call(trundle, geo)


      if error_message.blank?
        url = admin_aid_path(aid_slug)
        aid = Aid.find_by(slug: aid_slug)

        is_new_aid = IsNewAid.new.call(aid)
        
        CreateScopeAndGeoForAid.new.call(trundle: trundle, aid: aid, geo: geo.with_indifferent_access)

        msg = "Mise à jour du champ d'application effectué."
        if is_new_aid
          msg += " L'aide sera publiée sur le site après relecture par l'équipe de modération."
        end
        flash[:notice] = msg
        flash.keep(:notice)
        render js: "document.location = '#{url}'"        
      else
        render :json => error_message, :status => 422
      end

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

    # load reinit
    def get_reinit
    end
    def post_reinit
      slug = _slug_data
      a = Aid.find_by(slug: slug)
      if a
        a.rule = nil
        a.save
        message = "👍👍👍Le champ d'application de l'aide \"#{a.name}\" a été réinitialisé" 
      else
        message = "⚠️⚠️⚠️échec : aucune aide pour le slug #{slug}" 
      end
      render json: {
        message: message,
        status: "ok"
      }
    end
    def _slug_data
      params.extract!(:slug_data).permit(:slug_data).to_h["slug_data"]
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
    def _csv_data
      params.extract!(:csv_data).permit(:csv_data).to_h["csv_data"]
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
      # Calculate status on every single field
      Aid.all.each { |aid| aid.save }
      render json: {
        status: "ok"
      }
    end


  end
end
