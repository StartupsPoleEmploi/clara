
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

    def new_aid_stage_2
      resource = Aid.find_by(slug: params[:slug])
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
            notice: "L'aide a bien été enregistrée. Vous pouvez continuer."
          )
        else
          redirect_to(
            admin_aid_creation_new_aid_stage_2_path(slug: resource.slug),
          )
        end
      else
        render :new_aid_stage_1, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end     
    end

  end
end
