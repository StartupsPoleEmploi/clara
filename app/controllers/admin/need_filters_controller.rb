module Admin
  class NeedFiltersController < Admin::ApplicationController

    before_action :require_superadmin

    # Define a custom finder by overriding the `find_resource` method:
    def find_resource(param)
      result = NeedFilter.find_by(slug: param)
      result.blank? ? NeedFilter.find_by(id: param) : result
    end

  end
end
