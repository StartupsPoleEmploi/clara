module Admin
  class ConventionsController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Convention.
    #     page(params[:page]).
    #     per(10)
    # end

    def convention_history
      render json: {
        status: "ok",
      }
    end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Convention.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    # disable 'new' and 'destroy' links
    def valid_action?(name, resource = resource_class)
      %w[new destroy].exclude?(name.to_s) && super
    end
  end
end
