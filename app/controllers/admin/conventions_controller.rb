module Admin
  class ConventionsController < Admin::ApplicationController
    def valid_action?(name, resource = resource_class)
      if current_user.role != "superadmin" && current_user.role != "relecteur"
        %w[new destroy edit].exclude?(name.to_s) && super
      else
        %w[new destroy].exclude?(name.to_s) && super
      end
    end
  end
end
