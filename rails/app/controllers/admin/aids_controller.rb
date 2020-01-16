module Admin
  class AidsController < Admin::ApplicationController
    include AdministrateExportable::Exporter

    def valid_action?(name, resource = resource_class)
      if current_user.role != "superadmin" && current_user.role != "relecteur"
        %w[destroy].exclude?(name.to_s) && super
      else
        true
      end
    end

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

    def show
      @asker = Asker.new
      super
    end

    def new
      raise SecurityError, "Not Allowed"
    end

    def find_filters_params
      params.permit(:ids => []).to_h
    end

    def scoped_resource
      resource_class.for_admin.last_updated
    end
  end
end
