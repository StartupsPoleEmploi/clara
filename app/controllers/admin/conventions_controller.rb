module Admin
  class ConventionsController < Admin::ApplicationController
    def valid_action?(name, resource = resource_class)
      %w[new destroy].exclude?(name.to_s) && super
      if current_user.role != "superadmin" && current_user.role != "relecteur"
        %w[edit].exclude?(name.to_s) && super
      else
        true
      end
    end
  end
end
