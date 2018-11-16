module Admin
  class AxleFiltersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = AxleFilter.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      result = AxleFilter.find_by(slug: param)
      result.blank? ? AxleFilter.find_by(id: param) : result
    end

    # See https://administrate-prototype.herokuapp.com/customizing_controller_actions
    # for more information
  end
end
