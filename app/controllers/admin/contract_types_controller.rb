module Admin
  class ContractTypesController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = ContractType.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      result = ContractType.find_by(slug: param)
      result.blank? ? ContractType.find_by(id: param) : result
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
    def scoped_resource
      resource_class.for_admin
    end
  end
end
