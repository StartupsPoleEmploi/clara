module Admin
  class ConventionsController < Admin::ApplicationController

    def valid_action?(name, resource = resource_class)
      %w[new destroy].exclude?(name.to_s) && super
    end
    
  end
end
