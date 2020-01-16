module Admin
  class CustomParentFiltersController < Admin::ApplicationController
    before_action :require_superadmin
  
    def find_resource(param)
      result = CustomParentFilter.find_by(slug: param)
      result.blank? ? CustomParentFilter.find_by(id: param) : result
    end

  end
end
