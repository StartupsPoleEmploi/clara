module Admin
  class FiltersController < Admin::ApplicationController

    before_action :require_superadmin
    

    def index
      search_term = params[:search].to_s.strip
      resources = Administrate::Search.new(scoped_resource,
                                           dashboard_class,
                                           search_term).run
      @actual_search_size = resources.size
      super
    end

    def destroy_attachment
      attachment = requested_resource.attachment
      attachment.purge
      redirect_back(fallback_location: requested_resource)
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Variable.find_by!(slug: param)
    # end
    def find_resource(param)
      result = Filter.find_by(slug: param)
      result.blank? ? Filter.find_by(id: param) : result
    end
    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    # disable 'edit' and 'destroy' links
    # def valid_action?(name, resource = resource_class)
    #   %w[new edit destroy].exclude?(name.to_s) && super
    # end
  end
end
