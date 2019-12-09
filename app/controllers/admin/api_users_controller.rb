module Admin
  class ApiUsersController < Admin::ApplicationController
    include AdministrateExportable::Exporter
    
    before_action :require_superadmin_or_relecteur

    def valid_action?(name, resource = resource_class)
      if current_user.role != "superadmin"
        %w[edit destroy new].exclude?(name.to_s) && super
      else
        return true
      end
    end

  end
end
