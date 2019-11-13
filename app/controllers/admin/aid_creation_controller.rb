
module Admin
  class AidCreationController < Admin::ApplicationController

    def dashboard
      @dashboard ||= AidDashboard.new
    end

    def new_aid_stage_1
      resource = params[:slug] ? Aid.find_by(slug: params[:slug]) : Aid.new
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }      
    end

    def create_stage_1
      new_attributes = params.require(:aid).permit(:source, :name, :contract_type_id, :ordre_affichage).to_h
      slug = params.require(:slug).permit(:value).to_h[:value]
      if !slug.blank?
        resource = Aid.find_by(slug: slug)
        resource.assign_attributes(new_attributes)
      else
        resource = Aid.new(new_attributes)
      end

      if resource.save
        if slug.blank?
          redirect_to(
            admin_aid_creation_new_aid_stage_2_path(slug: resource.slug),
            notice: "L'aide a bien été enregistrée en tant que brouillon."
          )
        else
          redirect_to(
            admin_aid_creation_new_aid_stage_2_path(slug: resource.slug),
            notice: "Les modifications ont bien été enregistrées."
          )
        end
      else
        render :new_aid_stage_1, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end     
    end

    def new_aid_stage_2
      resource = Aid.find_by(slug: params[:slug])
      authorize_resource(resource)
      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
      }      
    end

    def create_stage_2
      slug = params.require(:slug).permit(:value).to_h[:value]
      resource = Aid.find_by(slug: slug)
      old_attributes = resource.attributes.with_indifferent_access
      new_attributes = params.require(:aid).permit(:what, :additionnal_conditions, :how_much, :how_and_when, :limitations).to_h
      all_attributes = old_attributes.merge(new_attributes)
      resource.assign_attributes(new_attributes)
      resource.save
      redirect_to(
        admin_aid_creation_new_aid_stage_3_path(slug: resource.slug),
        notice: "Le contenu a été mis à jour"
      )
    end

    def new_aid_stage_3
      resource = Aid.find_by(slug: params[:slug])
      ct = resource.contract_type
      contract_type = ct.attributes.with_indifferent_access
      aids_of_contract_type = ct.aids.map { |e| e.attributes.with_indifferent_access  }

      render locals: {
        page: Administrate::Page::Form.new(dashboard, resource),
        contract_type: contract_type,
        aids_of_contract_type: aids_of_contract_type
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
      aid.save
      redirect_to(
        admin_aid_creation_new_aid_stage_4_path(slug: aid.slug),
        notice: "Le contenu a été mis à jour"
      )
    end

    def new_aid_stage_4
      aid = Aid.find_by(slug: params[:slug])
      authorize_resource(aid)

      gon.initial_scope = ExtractScopeForAid.new.call(aid)
      gon.initial_geo = ExtractGeoForAid.new.call(aid)

      render locals: {
        page: Administrate::Page::Form.new(dashboard, aid),
      }      
    end

  end
end
