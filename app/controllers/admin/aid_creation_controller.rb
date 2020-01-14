
module Admin
  class AidCreationController < Admin::ApplicationController

    def dashboard
      @dashboard ||= AidDashboard.new
    end

    def _hidden(prop)
      params.require(prop).permit(:value).to_h[:value]
    end

    def new_aid_stage_1
      aid = params[:slug] ? Aid.find_by(slug: params[:slug]) : Aid.new
      authorize_resource(aid)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
        aid_status: aid.status
      }
    end

    def create_stage_1
      notice_msg = ""
      new_attributes = params.require(:aid).permit(:source, :name, :contract_type_id, :ordre_affichage).to_h
      new_ordre_affichage = new_attributes[:ordre_affichage] || 99 
      new_attributes[:ordre_affichage] = new_ordre_affichage
      slug = _hidden(:slug)
      if !slug.blank?
        aid = Aid.find_by(slug: slug)
        aid.assign_attributes(new_attributes)
      else
        aid = Aid.new(new_attributes)
      end

      was_new = aid.id == nil

      if aid.save
        # Hack to consider it as a "draft"
        if was_new
          aid.archived_at = aid.created_at
        end
        # end of hack
        aid.update_status;
        if slug.blank?
          notice_msg = "L'aide a bien été enregistrée en tant que brouillon."
        elsif aid.status != "Publiée"
          notice_msg = "Les modifications ont bien été enregistrées."
        elsif aid.status == "Publiée"
          notice_msg = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
        end
        redirect_to(
          admin_aid_creation_new_aid_stage_2_path(slug: aid.slug, modify: _hidden(:modify)),
          notice: notice_msg
        )
      else
        render :new_aid_stage_1, locals: {
          page: Administrate::Page::Form.new(dashboard, aid),
        }
      end     
    end

    def new_aid_stage_2
      aid = Aid.find_by(slug: params[:slug])
      authorize_resource(aid)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
        aid_status: aid.status
      }      
    end

    def create_stage_2
      notice_msg = ""
      slug = _hidden(:slug)
      aid = Aid.find_by(slug: slug)
      old_attributes = aid.attributes.with_indifferent_access
      new_attributes = params.require(:aid).permit(:what, :additionnal_conditions, :how_much, :how_and_when, :limitations).to_h
      all_attributes = old_attributes.merge(new_attributes)
      aid.assign_attributes(new_attributes)
      aid.save
      aid.update_status;

      if aid.status == "Publiée"
        notice_msg = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
      else
        notice_msg = "Le contenu a été mis à jour"
      end

      redirect_to(
        admin_aid_creation_new_aid_stage_3_path(slug: aid.slug, modify: _hidden(:modify)),
        notice: notice_msg
      )
    end

    def new_aid_stage_3
      aid = Aid.find_by(slug: params[:slug])
      ct = aid.contract_type
      contract_type = ct.attributes.with_indifferent_access

      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
        contract_type: contract_type,
        aid_attributes: aid.attributes.with_indifferent_access,
        aid_status: aid.status
      }      
    end


    def create_stage_3
      notice_msg = ""
      slug = _hidden(:slug)
      new_attributes = params.require(:aid).permit(:short_description, filter_ids: []).to_h
      filters = []
      if new_attributes[:filter_ids]
        filters_ids = new_attributes[:filter_ids].reject { |f| f.blank? }.map { |f| f.to_i }
        filters = Filter.where(id: filters_ids)
      end      
      aid = Aid.find_by(slug: slug)
      aid.filters = filters
      aid.short_description = new_attributes[:short_description]
      
      aid.save
      aid.update_status;
      
      if aid.status == "Publiée"
        notice_msg = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
      else
        notice_msg = "Le contenu a été mis à jour"
      end

      redirect_to(
        admin_aid_creation_new_aid_stage_4_path(slug: aid.slug, modify: _hidden(:modify)),
        notice: notice_msg
      )
    end

    def new_aid_stage_4
      aid = Aid.find_by(slug: params[:slug])
      authorize_resource(aid)

      gon.global_state = {
        explicitations: _all_explicitations,
        operator_kinds: _all_operator_kinds,        
        variables: _all_variables,        
      }

      gon.initial_scope = ExtractScopeForAid.new.call(aid)
      gon.initial_geo = ExtractGeoForAid.new.call(aid)

      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
        aid_attributes: aid.attributes.with_indifferent_access,
        aid_status: aid.status
      }      
    end

    def create_stage_4
      notice_msg = ""
      aid_slug = params["aid"]
      # Need to parse JSON in order to preserve arrays as correct arrays
      trundle = JSON.parse(params["trundle"], symbolize_names: true)
      modify = params["modify"]
      geo = JSON.parse(params["geo"], symbolize_names: true)
      
      error_message = FindScopeAndGeoErrorsToo.new.call(trundle, geo)

      is_void = error_message == "Étape non renseignée."

      if (error_message.blank? || is_void)
        url = admin_aid_creation_new_aid_stage_5_path(slug: aid_slug, modify: modify)
        aid = Aid.find_by(slug: aid_slug)
        
        CreateScopeAndGeoForAidToo.new.call(trundle: trundle, aid: aid, geo: geo.with_indifferent_access)
        aid.update_status;

        if aid.status == "Publiée"
          notice_msg = "Les modifications vont être publiées sur le site web ! <br> Cela peut prendre quelques secondes."
        else
          notice_msg = "Mise à jour du champ d'application effectué."
        end
        flash[:notice] = notice_msg
        flash.keep(:notice)
        render js: "document.location = '#{url}'"        
      else
        render :json => error_message, :status => 422
      end
    end

    def new_aid_stage_5
      aid = params[:slug] ? Aid.find_by(slug: params[:slug]) : Aid.new
      authorize_resource(aid)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
        filters_size: aid.filters.size,
        whodunnit: !aid.versions.blank? ? aid.versions.first[:whodunnit] : "",
        aid_status: aid.status
      }      
    end

    def create_stage_5
      slug = _hidden(:slug)
      action_asked = _hidden(:action_asked)
      aid = Aid.find_by(slug: slug)

      please_save_aid = true

      notice_message = ""
      if action_asked == "archive"
        aid.archived_at = DateTime.now
        notice_message = "L'aide a bien été archivée, elle n'apparaîtra plus sur le site d'ici quelques secondes."
      elsif action_asked == "publish"
        aid.archived_at = nil
        notice_message = "L'aide a été publiée sur le site, elle apparaîtra dans quelques secondes."
      elsif action_asked == "reread"
        aid.is_rereadable = true
        notice_message = "L'aide a été demandée pour relecture."
      elsif action_asked == "keep"
        notice_message = "L'aide a été conservée en tant que brouillon."
      elsif action_asked == "discard"
        please_save_aid = false
        notice_message = "Le brouillon a été supprimé."
      end

      if please_save_aid
        aid.save
        aid.update_status
      else
        aid.destroy
      end
  
      redirect_to(
        admin_root_path("aid[direction]" => "desc", "aid[order]" => "updated_at"),
        notice: notice_message
      )
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

  end
end
