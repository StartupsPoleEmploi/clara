module Admin
  class UsersController < Admin::ApplicationController
    # To customize the behavior of this controller,
    # you can overwrite any of the RESTful actions. For example:
    #
    # def index
    #   super
    #   @resources = User.
    #     page(params[:page]).
    #     per(10)
    # end

    # Define a custom finder by overriding the `find_resource` method:
    # def find_resource(param)
    #   User.find_by!(slug: param)
    # end

    before_action :require_superadmin_or_relecteur


    def valid_action?(name, resource = resource_class)
      if current_user.role != "superadmin"
        %w[edit destroy new].exclude?(name.to_s) && super
      else
        %w[new].exclude?(name.to_s) && super
      end
    end

    def update
      if requested_resource.update(resource_params)
        redirect_to admin_root_path
      else
        render :edit, locals: {
          page: Administrate::Page::Form.new(dashboard, requested_resource),
        }
      end
    end

  end
end
