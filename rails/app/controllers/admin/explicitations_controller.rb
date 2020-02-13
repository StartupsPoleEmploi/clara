module Admin
  class ExplicitationsController < Admin::ApplicationController

    before_action :require_superadmin

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      Explicitation.find_by!(slug: param)
    end

    def valid_action?(name, resource = resource_class)
      %w[destroy].exclude?(name.to_s) && super
    end

  end
end
