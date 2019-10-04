module Admin
  class AidsController < Admin::ApplicationController
    include AdministrateExportable::Exporter
    
    def find_resource(param)
      Aid.find_by!(slug: param)
    end

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           search_term).run
      @actual_search_size = resources.size
      super
    end

    def create
      resource = resource_class.new(resource_params)
      authorize_resource(resource)

      if resource.save
        redirect_to new_admin_aid_path(stage: 2)
        # redirect_to admin_rule_creation_path(aid: resource.slug)
      else
        render :new, locals: {
          page: Administrate::Page::Form.new(dashboard, resource),
        }
      end
    end


    def show 
      @asker = Asker.new
      super
    end

    def find_filters_params
      params.permit(:ids => []).to_h
    end

    def scoped_resource
       resource_class.for_admin
    end

  end
end
