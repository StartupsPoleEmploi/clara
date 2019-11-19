
module Admin
  class AidCreationController < Admin::ApplicationController

    def dashboard
      @dashboard ||= AidDashboard.new
    end

    def new_aid_stage_1
      aid = params[:slug] ? Aid.find_by(slug: params[:slug]) : Aid.new
      authorize_resource(aid)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid)
      }
    end

    def create_stage_1
      new_attributes = params.require(:aid).permit(:source, :name, :contract_type_id, :ordre_affichage).to_h
      new_ordre_affichage = new_attributes[:ordre_affichage] || 99 
      new_attributes[:ordre_affichage] = new_ordre_affichage
      slug = params.require(:slug).permit(:value).to_h[:value]
      if !slug.blank?
        aid = Aid.find_by(slug: slug)
        aid.assign_attributes(new_attributes)
      else
        aid = Aid.new(new_attributes)
      end

      was_new = aid.id == nil

      aid._calculate_status;
      if aid.save
        # Hack to consider it as a "draft"
        if was_new
          aid.archived_at = aid.created_at
          aid._calculate_status
          aid._calculate_status;
          aid.save
        end
        # end of hack
        if slug.blank?
          redirect_to(
            admin_aid_creation_new_aid_stage_2_path(slug: aid.slug),
            notice: "L'aide a bien été enregistrée en tant que brouillon."
          )
        else
          # ExpireCache.new.call
          redirect_to(
            admin_aid_creation_new_aid_stage_2_path(slug: aid.slug),
            notice: "Les modifications ont bien été enregistrées."
          )
        end
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
      }      
    end

    def create_stage_2
      slug = params.require(:slug).permit(:value).to_h[:value]
      aid = Aid.find_by(slug: slug)
      old_attributes = aid.attributes.with_indifferent_access
      new_attributes = params.require(:aid).permit(:what, :additionnal_conditions, :how_much, :how_and_when, :limitations).to_h
      all_attributes = old_attributes.merge(new_attributes)
      aid.assign_attributes(new_attributes)
      aid._calculate_status;
      aid.save

      # ExpireCache.new.call
      redirect_to(
        admin_aid_creation_new_aid_stage_3_path(slug: aid.slug),
        notice: "Le contenu a été mis à jour"
      )
    end

    def new_aid_stage_3
      aid = Aid.find_by(slug: params[:slug])
      ct = aid.contract_type
      contract_type = ct.attributes.with_indifferent_access

      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
        contract_type: contract_type,
        aid_attributes: aid.attributes.with_indifferent_access
      }      
    end


    def create_stage_3
      slug = params.require(:slug).permit(:value).to_h[:value]
      new_attributes = params.require(:aid).permit(:short_description, filter_ids: []).to_h
      filters_ids = new_attributes[:filter_ids].reject { |f| f.blank? }.map { |f| f.to_i }
      filters = Filter.where(id: filters_ids)
      aid = Aid.find_by(slug: slug)
      aid.filters = filters
      aid.short_description = new_attributes[:short_description]
      
      aid._calculate_status;
      aid.save
      
      # ExpireCache.new.call
      redirect_to(
        admin_aid_creation_new_aid_stage_4_path(slug: aid.slug),
        notice: "Le contenu a été mis à jour"
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
        aid_attributes: aid.attributes.with_indifferent_access
      }      
    end

    def create_stage_4
      aid_slug = params["aid"]
      # Need to parse JSON in order to preserve arrays as correct arrays
      trundle = JSON.parse(params["trundle"], symbolize_names: true)
      geo = JSON.parse(params["geo"], symbolize_names: true)
      
      error_message = FindScopeAndGeoErrorsToo.new.call(trundle, geo)

      is_void = error_message == "Étape non renseignée."

      if (error_message.blank? || is_void)
        url = admin_aid_creation_new_aid_stage_5_path(slug: aid_slug)
        aid = Aid.find_by(slug: aid_slug)
        
        CreateScopeAndGeoForAidToo.new.call(trundle: trundle, aid: aid, geo: geo.with_indifferent_access)


        msg = is_void ? "Mise à jour du champ d'application effectué, celui-ci est vide." : "Mise à jour du champ d'application effectué."
        flash[:notice] = msg
        flash.keep(:notice)
        # ExpireCache.new.call
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
        whodunnit: aid.versions.first[:whodunnit],
        aid_status: aid.status
      }      
    end

    def create_stage_5
      slug = params.require(:slug).permit(:value).to_h[:value]
      archive_asked = params.require(:archive_asked).permit(:value).to_h[:value] == "true"
      aid = Aid.find_by(slug: slug)

      notice_message = ""
      if archive_asked
        aid.archived_at = DateTime.now
        notice_message = "L'aide a bien été archivée, elle n'apparaît plus sur le site."
      else
        aid.archived_at = nil
        notice_message = "L'aide a été publiée sur le site."
      end

      aid._calculate_status;
      aid.save
      
      # ExpireCache.new.call
      redirect_to(
        admin_root_path,
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
