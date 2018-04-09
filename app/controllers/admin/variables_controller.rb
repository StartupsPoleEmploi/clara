module Admin
  class VariablesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = Variable.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   Variable.find_by!(slug: param)
    # end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    # disable 'edit' and 'destroy' links
    # def valid_action?(name, resource = resource_class)
    #   %w[new edit destroy].exclude?(name.to_s) && super
    # end
  end
end
