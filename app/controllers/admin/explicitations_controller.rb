module Admin
  class ExplicitationsController < Admin::ApplicationController

    before_action :require_superadmin

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      Explicitation.find_by!(slug: param)
    end

  end
end
