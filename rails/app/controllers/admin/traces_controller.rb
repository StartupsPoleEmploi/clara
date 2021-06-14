module Admin
  class TracesController < Admin::ApplicationController
    include AdministrateExportable::Exporter
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Trace.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Trace.find_by!(slug: param)
    # end

    before_action :require_superadmin
  
    
    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    
    def valid_action?(name, resource = resource_class)
      %w[new edit].exclude?(name.to_s) && super
    end

    def show_search_bar?
      false
    end

  end
end
