module Admin
  class UsersController < Admin::ApplicationController


    before_action :require_superadmin_or_relecteur, only: [:update]
    before_action :require_superadmin, only: [:update, :destroy, :edit, :show]


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
